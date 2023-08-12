Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5441B779D01
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 05:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjHLDfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 23:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLDfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 23:35:41 -0400
Received: from out-87.mta0.migadu.com (out-87.mta0.migadu.com [IPv6:2001:41d0:1004:224b::57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B194E52
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 20:35:40 -0700 (PDT)
Message-ID: <7e5ac25e-846e-65e6-4398-e125c3d879ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691811338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAXYqhkH94NpjZtXkSjDVfUvFBXTPA6v1zJVdiQu3pI=;
        b=NT1IqBAIBAk5oJquJFJ53AGvlWGGI0GY5cEJ1uAkVnPzfvYcrTFRgRWLx+6jU20qu4H0Wc
        QHtCgkIj9HDd6VjX6yR5kieOQzpUOFWP1n2T/hmpn9iPNKzhzsMieEMMexSotD+tpxRO6K
        QE/mK0KyM1tb0EZGhxrCZGAPyJAeZdo=
Date:   Fri, 11 Aug 2023 20:35:35 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] net: Fix slab-out-of-bounds in
 inet[6]_steal_sock
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     lmb@isovalent.com
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@kernel.org, memxor@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com, Kuniyuki Iwashima <kuniyu@amazon.com>
References: <CAN+4W8hMpL3+vNOrBBRw01tD6OxQ-Yy8OWpq9nRtiyjm0GgE4g@mail.gmail.com>
 <20230809155538.67000-1-kuniyu@amazon.com>
 <7899f188-763a-662e-c725-4d89f17b2972@linux.dev>
In-Reply-To: <7899f188-763a-662e-c725-4d89f17b2972@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 10:12 AM, Martin KaFai Lau wrote:
> On 8/9/23 8:55 AM, Kuniyuki Iwashima wrote:
>> From: Lorenz Bauer <lmb@isovalent.com>
>> Date: Wed, 9 Aug 2023 16:08:31 +0100
>>> On Wed, Aug 9, 2023 at 3:39 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 8/9/23 1:33 AM, Lorenz Bauer wrote:
>>>>> Kumar reported a KASAN splat in tcp_v6_rcv:
>>>>>
>>>>>     bash-5.2# ./test_progs -t btf_skc_cls_ingress
>>>>>     ...
>>>>>     [   51.810085] BUG: KASAN: slab-out-of-bounds in tcp_v6_rcv+0x2d7d/0x3440
>>>>>     [   51.810458] Read of size 2 at addr ffff8881053f038c by task 
>>>>> test_progs/226
>>>>>
>>>>> The problem is that inet[6]_steal_sock accesses sk->sk_protocol without
>>>>> accounting for request sockets. I added the check to ensure that we only
>>>>> every try to perform a reuseport lookup on a supported socket.
>>>>>
>>>>> It turns out that this isn't necessary at all. struct sock_common contains
>>>>> a skc_reuseport flag which indicates whether a socket is part of a
>>>>
>>>> Does it go back to the earlier discussion
>>>> (https://lore.kernel.org/bpf/7188429a-c380-14c8-57bb-9d05d3ba4e5e@linux.dev/)
>>>> that the sk->sk_reuseport is 1 from sk_clone for TCP_ESTABLISHED? It works
>>>> because there is sk->sk_reuseport"_cb" check going deeper into
>>>> reuseport_select_sock() but there is an extra inet6_ehashfn for all 
>>>> TCP_ESTABLISHED.
>>>
>>> Sigh, I'd forgotten about this...
>>>
>>> For the TPROXY TCP replacement use case we sk_assign the SYN to the
>>> listener, which creates the reqsk. We can let follow up packets pass
>>> without sk_assign since they will match the reqsk and convert to a
>>> fullsock via the usual route. At least that is what the test does. I'm
>>> not even sure what it means to redirect a random packet into an
>>> established TCP socket TBH. It'd probably be dropped?
> 
> It could act like an earlier early-demux for established sk? If the bpf prog has 
> already looked up an established sk for other needs (eg. reading the sk local 
> storage), it may as well bpf_sk_assign it to the skb. I don't have a use case 
> for that but I also don't see why it won't work also.
> 
>>>
>>> For UDP, I'm not sure whether we even get into this situation? Doesn't
>>> seem like UDP sockets are cloned from each other, so we also shouldn't
>>> end up with a reuseport flag set erroneously.
>>>
>>> Things we could do if necessary:
>>> 1. Reset the flag in inet_csk_clone_lock like we do for SOCK_RCU_FREE
>>
>> I think we can't do this as sk_reuseport is inherited to twsk and used
>> in inet_bind_conflict().
>>
>>
>>> 2. Duplicate the cb check into inet[6]_steal_sock
>>
>> or 3. Add sk_fullsock() test ?
> 
> yeah, probably adding sk_fullsock() is needed, may be something like(?):
> 
>      if (!prefetched || !sk_fullsock(sk))
>                  return sk;

Friendly ping. Thanks.

