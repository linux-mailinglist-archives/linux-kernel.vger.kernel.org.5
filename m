Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7DF77A62D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 13:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjHMLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 07:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjHMLXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 07:23:42 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1534B1717
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 04:23:42 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CC3E724002A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 13:23:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1691925819; bh=+M8MabNBfA5Kys7XJ+x9X1blVITp0OaBEOIjjfS4P5Q=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:
         Content-Transfer-Encoding:From;
        b=Gm4dlOq3R2DKWeU44ycl2fnUXTb7mqgs49Ysq/5otVdSKf/E0yOgE3BcP9Q/K+rze
         rFyrTQnuhe7Su6ehUgm05+c8J7TXNDqQBLRevbIIn7KdlvfbLO7TyTXvk72jFjnPPL
         upMkQJObYyWS6a9Q8bCkh11GU9NiNYA9VNlEUHcGOAYkC4GipgSWXdXPrS4MNXgwGb
         AxdNCoXtZOK5r4tWu/LUqyYZFUJAcAD5yc9m9VK/MUGQxKveZlAZgk0uyGs5zni5Pp
         d+5ek9g20hsjTHCFGk3IR9r7q+EHcoGjCx/23gTkr3c8D71msPiZ1mVpTlTY/Emyby
         xbcoL01k6/3kA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RNwBw52jZz9rxF;
        Sun, 13 Aug 2023 13:23:36 +0200 (CEST)
Message-ID: <2d8a4d46-f1e4-4e2a-819d-6c28ad37273f@posteo.net>
Date:   Sun, 13 Aug 2023 11:23:35 +0000
MIME-Version: 1.0
Subject: Re: can: isotp: epoll breaks isotp_sendmsg
Content-Language: en-US
To:     Michal Sojka <michal.sojka@cvut.cz>,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Dae R. Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
References: <11328958-453f-447f-9af8-3b5824dfb041@munic.io>
 <87cz1czihl.fsf@steelpick.2x.cz>
From:   Lukas Magel <lukas.magel@posteo.net>
In-Reply-To: <87cz1czihl.fsf@steelpick.2x.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime, hi Michal,

On 01.07.23 00:35, Michal Sojka wrote:
> Hi Maxime,
>
> On Fri, Jun 30 2023, Maxime Jayat wrote:
>> Hi,
>>
>> There is something not clear happening with the non-blocking behavior
>> of ISO-TP sockets in the TX path, but more importantly, using epoll now
>> completely breaks isotp_sendmsg.
>> I believe it is related to
>> 79e19fa79c ("can: isotp: isotp_ops: fix poll() to not report false 
>> EPOLLOUT events"),
>> but actually is probably deeper than that.
>>
>> I don't completely understand what is exactly going on, so I am sharing
>> the problem I face:
>>
>> With an ISO-TP socket in non-blocking mode, using epoll seems to make
>> isotp_sendmsg always return -EAGAIN.
> That's definitely not expected behavior. I tested the patch only with
> poll, hoping that epoll would behave the same.
>
> [...]


I am writing to report that we have been witnessing a behavior very similar
to what you describe. ISO-TP send breaks with EAGAIN if a poll (for a read)
occurs at the same time.

Our Python stack uses two threads to do concurrent, blocking reads & writes
from and to the ISO-TP socket. The socket has a timeout of 0.1s to facilitate
shutdown when requested by the application. Notably, the blocking semantics
are handled by CPython, i.e. the underlying kernel socket is non-blocking.
CPython polls until the requested operation (read or write) can be executed
or the timeout occurs.

What happens during execution is that the socket is continuously being
polled by the read thread, i.e. so->wait is always filled with one task.
This process repeats until the socket receives a frame from the bus and the
poll returns successsfully. The app reads the data from the socket and
sends a response. Since the send occurs in a different thread, the reader
thread will have already returned to its poll loop and to populating
so->wait. When the send occurs, isotp_sendmsg checks so->wait for sleepers
and returns EAGAIN because the socket is non-blocking although there is no
concurrent send operation. This dance continues until the timeout occurs for
either the read or the write operation. If the write times out first, a
timeout error causes the Python app to break. If the read times out first,
there is a race that the write goes through or the reader puts in
another poll.

This behavior can be seen rather nicely in strace:
110580 poll([{fd=5, events=POLLIN}], 1, 100) = 0 (Timeout)
110580 poll([{fd=5, events=POLLIN}], 1, 100) = 0 (Timeout)
110580 poll([{fd=5, events=POLLIN}], 1, 100) = 1 ([{fd=5, revents=POLLIN}])
110580 recvfrom(5, ">\0", 4095, 0, NULL, NULL) = 2
110580 poll([{fd=5, events=POLLIN}], 1, 100 <unfinished ...>
110569 poll([{fd=5, events=POLLOUT}], 1, 100) = 1 ([{fd=5, revents=POLLOUT}])
110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
110569 poll([{fd=5, events=POLLOUT}], 1, 100) = 1 ([{fd=5, revents=POLLOUT}])
110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
110569 poll([{fd=5, events=POLLOUT}], 1, 100) = 1 ([{fd=5, revents=POLLOUT}])
110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
[....]
110569 poll([{fd=5, events=POLLOUT}], 1, 6) = 1 ([{fd=5, revents=POLLOUT}])
110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
110569 poll([{fd=5, events=POLLOUT}], 1, 6 <unfinished ...>
110580 <... poll resumed>)              = 0 (Timeout)
110569 <... poll resumed>)              = 1 ([{fd=5, revents=POLLOUT}])
110580 poll([{fd=5, events=POLLIN}], 1, 100 <unfinished ...>
110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
110569 poll([{fd=5, events=POLLOUT}], 1, 5) = 1 ([{fd=5, revents=POLLOUT}])
110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)

I believe this is consistent to the behavior you're witnessing with epoll
because epoll also places a sleeper in so->wait that is left in the queue
until the epoll descriptor is closed.


>
>> By reverting 79e19fa79c, I get better results but still incorrect:
> [...]
>
>> It is then possible to write on the socket but the write is blocking,
>> which is not the expected behavior for a non-blocking socket.
> Yes, incorrect behavior was why we made the commit in question, however
> we saw write() returning -EAGAIN when it shouldn't.
>
>> I don't know how to solve the problem. To me, using wq_has_sleeper seems 
>> weird.
> Agreed. I've never tried to understand how synchronization works here.
> Hopefully, Oliver knows more.
>
>> The implementation of isotp_poll feels weird too (calling both 
>> datagram_poll and
>> poll_wait?). But I am not sure what would be the correct
>> implementation.
> I understand it as follows (which might be wrong - someone, please
> correct me), isotp_poll() should register the file with all waitqueues
> it can wait on. so->wait is one and sock->sq.wait (used by
> datagram_poll) is another. The former is definitely used for TX, the
> latter is probably used because skb_recv_datagram() is called for RX.
> But so->wait is also used for RX and there might proabbly be be some
> inconsistency between those.


AFAIK, it is correct behavior for isotp_poll to register all wait queues
with the poller.

Before 79e19fa79c, I assume datagram_poll always returned
EPOLLOUT because its corresponding send buffer is unused and empty. This
return value can be incorrect if so->tx.state is not IDLE and a send would
block. With the patch, this behavior is now suppressed. I believe that
the inconsistency could have rather been introduced with:
can: isotp: fix race between isotp_sendsmg() and isotp_release() 0517374

With this patch, the behavior of isotp_sendmsg was changed to only check
so->wait for sleepers instead of consulting so->tx.state to see if the
socket is busy. Since the wait queue can also have sleepers only interested
in read operations, I believe the return value is not a valid indicator
of send readiness. Additionally, in this state, the behavior in isotp_sendmsg
is inconsistent with isotp_poll. I will try to test next week if reverting this
part of the patch could fix the race condition.


>
>> My actual use-case is in Async Rust using tokio.
> Our initial motivation was also Rust and tokio however than I did
> testing only with simple C programs. I'm definitely interested in having
> this working.
>
> I'll try to look at this in more detail during the weekend. It's too
> late for me today.
>
> Best regards,
> -Michal
>
Regards,
Lukas

