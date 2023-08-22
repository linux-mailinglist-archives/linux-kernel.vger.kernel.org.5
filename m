Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2290783A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjHVGvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjHVGvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:51:35 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B967418B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 23:51:32 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id F25B6240027
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1692687090; bh=9gSot5+C79zBUl6f76vZvNLXBj76p9oFMnaUy3jG5CQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:
         Content-Transfer-Encoding:From;
        b=gxrKnLE3TAB0vVp7EepYNfBP6Dkm5M6Ph0UC7hfWS2UHNhfTnwN0DeV5v3El34s3C
         /hssR2jZnvp1XlclSphUVDVFFg7BzTz7t9flnyNvYCyKhqB46KSlZ5PLZNtJQIpfF7
         TkkXSe7Sr1+gGJ5mK5Mw1dr5gXnsaz0JS/WNf3hfNJvUXiFAOqlxr0sBYJ3C8Wrjvh
         TBBcVLb45pivAj34Mypjwc6PCzkpwTD3RgqE+Z/FWKSK2zNyKaVFk6Vs40kpdJeZSl
         LoiLBsURsPh+hAN0CH2A9bR6lehb0WUbDV61reHD/r5+AYN9fZsdP7Pt0PziNqIqRA
         Gr1kLA4pjRyag==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4RVKkm2t1zz9rxF;
        Tue, 22 Aug 2023 08:51:28 +0200 (CEST)
Message-ID: <f4221e5e-8fee-4ed6-af54-46b8ac0e5c03@posteo.net>
Date:   Tue, 22 Aug 2023 06:51:29 +0000
MIME-Version: 1.0
Subject: Re: can: isotp: epoll breaks isotp_sendmsg
Content-Language: en-US
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Michal Sojka <michal.sojka@cvut.cz>,
        Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Dae R. Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
References: <11328958-453f-447f-9af8-3b5824dfb041@munic.io>
 <87cz1czihl.fsf@steelpick.2x.cz>
 <2d8a4d46-f1e4-4e2a-819d-6c28ad37273f@posteo.net>
 <577b6372-47b0-4009-b83c-706f9bc7abe7@posteo.net>
 <f39ae7f2-6216-e5b4-1f4d-e01bdee7cf7c@hartkopp.net>
From:   Lukas Magel <lukas.magel@posteo.net>
In-Reply-To: <f39ae7f2-6216-e5b4-1f4d-e01bdee7cf7c@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 20.08.23 21:51, Oliver Hartkopp wrote:
> Hi Lukas,
>
> On 18.08.23 13:53, Lukas Magel wrote:
>> On 13.08.23 13:23, Lukas Magel wrote:
>>> Hi Maxime, hi Michal,
>>>
>>> On 01.07.23 00:35, Michal Sojka wrote:
>>>> Hi Maxime,
>>>>
>>>> On Fri, Jun 30 2023, Maxime Jayat wrote:
>>>>> Hi,
>>>>>
>>>>> There is something not clear happening with the non-blocking behavior
>>>>> of ISO-TP sockets in the TX path, but more importantly, using epoll now
>>>>> completely breaks isotp_sendmsg.
>>>>> I believe it is related to
>>>>> 79e19fa79c ("can: isotp: isotp_ops: fix poll() to not report false
>>>>> EPOLLOUT events"),
>>>>> but actually is probably deeper than that.
>>>>>
>>>>> I don't completely understand what is exactly going on, so I am sharing
>>>>> the problem I face:
>>>>>
>>>>> With an ISO-TP socket in non-blocking mode, using epoll seems to make
>>>>> isotp_sendmsg always return -EAGAIN.
>>>> That's definitely not expected behavior. I tested the patch only with
>>>> poll, hoping that epoll would behave the same.
>>>>
>>>> [...]
>>> I am writing to report that we have been witnessing a behavior very similar
>>> to what you describe. ISO-TP send breaks with EAGAIN if a poll (for a read)
>>> occurs at the same time.
>>>
>>> Our Python stack uses two threads to do concurrent, blocking reads & writes
>>> from and to the ISO-TP socket. The socket has a timeout of 0.1s to facilitate
>>> shutdown when requested by the application. Notably, the blocking semantics
>>> are handled by CPython, i.e. the underlying kernel socket is non-blocking.
>>> CPython polls until the requested operation (read or write) can be executed
>>> or the timeout occurs.
>>>
>>> What happens during execution is that the socket is continuously being
>>> polled by the read thread, i.e. so->wait is always filled with one task.
>>> This process repeats until the socket receives a frame from the bus and the
>>> poll returns successsfully. The app reads the data from the socket and
>>> sends a response. Since the send occurs in a different thread, the reader
>>> thread will have already returned to its poll loop and to populating
>>> so->wait. When the send occurs, isotp_sendmsg checks so->wait for sleepers
>>> and returns EAGAIN because the socket is non-blocking although there is no
>>> concurrent send operation. This dance continues until the timeout occurs for
>>> either the read or the write operation. If the write times out first, a
>>> timeout error causes the Python app to break. If the read times out first,
>>> there is a race that the write goes through or the reader puts in
>>> another poll.
>>>
>>> This behavior can be seen rather nicely in strace:
>>> 110580 poll([{fd=5, events=POLLIN}], 1, 100) = 0 (Timeout)
>>> 110580 poll([{fd=5, events=POLLIN}], 1, 100) = 0 (Timeout)
>>> 110580 poll([{fd=5, events=POLLIN}], 1, 100) = 1 ([{fd=5, revents=POLLIN}])
>>> 110580 recvfrom(5, ">\0", 4095, 0, NULL, NULL) = 2
>>> 110580 poll([{fd=5, events=POLLIN}], 1, 100 <unfinished ...>
>>> 110569 poll([{fd=5, events=POLLOUT}], 1, 100) = 1 ([{fd=5, revents=POLLOUT}])
>>> 110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
>>> 110569 poll([{fd=5, events=POLLOUT}], 1, 100) = 1 ([{fd=5, revents=POLLOUT}])
>>> 110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
>>> 110569 poll([{fd=5, events=POLLOUT}], 1, 100) = 1 ([{fd=5, revents=POLLOUT}])
>>> 110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
>>> [....]
>>> 110569 poll([{fd=5, events=POLLOUT}], 1, 6) = 1 ([{fd=5, revents=POLLOUT}])
>>> 110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
>>> 110569 poll([{fd=5, events=POLLOUT}], 1, 6 <unfinished ...>
>>> 110580 <... poll resumed>)              = 0 (Timeout)
>>> 110569 <... poll resumed>)              = 1 ([{fd=5, revents=POLLOUT}])
>>> 110580 poll([{fd=5, events=POLLIN}], 1, 100 <unfinished ...>
>>> 110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
>>> 110569 poll([{fd=5, events=POLLOUT}], 1, 5) = 1 ([{fd=5, revents=POLLOUT}])
>>> 110569 sendto(5, "~\0", 2, 0, NULL, 0)  = -1 EAGAIN (Resource temporarily unavailable)
>>>
>>> I believe this is consistent to the behavior you're witnessing with epoll
>>> because epoll also places a sleeper in so->wait that is left in the queue
>>> until the epoll descriptor is closed.
>>>
>>>
>>>>> By reverting 79e19fa79c, I get better results but still incorrect:
>>>> [...]
>>>>
>>>>> It is then possible to write on the socket but the write is blocking,
>>>>> which is not the expected behavior for a non-blocking socket.
>>>> Yes, incorrect behavior was why we made the commit in question, however
>>>> we saw write() returning -EAGAIN when it shouldn't.
>>>>
>>>>> I don't know how to solve the problem. To me, using wq_has_sleeper seems
>>>>> weird.
>>>> Agreed. I've never tried to understand how synchronization works here.
>>>> Hopefully, Oliver knows more.
>>>>
>>>>> The implementation of isotp_poll feels weird too (calling both
>>>>> datagram_poll and
>>>>> poll_wait?). But I am not sure what would be the correct
>>>>> implementation.
>>>> I understand it as follows (which might be wrong - someone, please
>>>> correct me), isotp_poll() should register the file with all waitqueues
>>>> it can wait on. so->wait is one and sock->sq.wait (used by
>>>> datagram_poll) is another. The former is definitely used for TX, the
>>>> latter is probably used because skb_recv_datagram() is called for RX.
>>>> But so->wait is also used for RX and there might proabbly be be some
>>>> inconsistency between those.
>>> AFAIK, it is correct behavior for isotp_poll to register all wait queues
>>> with the poller.
>>>
>>> Before 79e19fa79c, I assume datagram_poll always returned
>>> EPOLLOUT because its corresponding send buffer is unused and empty. This
>>> return value can be incorrect if so->tx.state is not IDLE and a send would
>>> block. With the patch, this behavior is now suppressed. I believe that
>>> the inconsistency could have rather been introduced with:
>>> can: isotp: fix race between isotp_sendsmg() and isotp_release() 0517374
>>>
>>> With this patch, the behavior of isotp_sendmsg was changed to only check
>>> so->wait for sleepers instead of consulting so->tx.state to see if the
>>> socket is busy. Since the wait queue can also have sleepers only interested
>>> in read operations, I believe the return value is not a valid indicator
>>> of send readiness. Additionally, in this state, the behavior in isotp_sendmsg
>>> is inconsistent with isotp_poll. I will try to test next week if reverting this
>>> part of the patch could fix the race condition.
>>>
>> I submitted a patch to the mailing list and would very much
>> appreciate your feedback:
>> https://lore.kernel.org/linux-can/20230818114345.142983-1-lukas.magel@posteo.net/
>>
>> @Maxime, I tried your isotprecv / isotpsend snippet and the issue did
>> not occur with the supplied patch. The send operation went through right
>> away.
>>
>> @Oliver I adjusted the exit path for the case where the initial wait is
>> interrupted to return immediately instead of jumping to err_event_drop.
>> Could you please check if you would agree with this change?
> The code has really won with your change! Thanks!
>
> But as you already assumed I have a problem with the handling of the 
> cleanup when a signal interrupts the wait_event_interruptible() statement.
>
> I think it should still be:
>
> /* wait for complete transmission of current pdu */
> err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
> if (err)
>          goto err_event_drop;
>
> as we need to make sure that the state machine is set to defined values 
> and states for the next isotp_sendmsg() attempt.
>
> Best regards,
> Oliver


Thank you for the feedback! Can you elaborate why the state needs to be
reset here? For me, the loop is basically a "let's wait until we win
arbitration for the tx.state", which means that the task is allowed
to send. I'm imagining an application that has two threads, both sending
at the same time (because maybe they don't care about reading). So one
would always be waiting in the loop until the send operation of the other
has concluded. My motivation for not going to err_event_drop was that if
one thread was interrupted in its wait_event_interruptible, why would we
need to change tx.state that is currently being occupied by the other
thread? The thread waiting in the loop has not done any state manipulation
of the socket.

Regards,

Lukas

