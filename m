Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79FD765205
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjG0LOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjG0LOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F75F106
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690456395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIORYueR8tQwkIlZ8oUtnpd4mJbrxO/lMh2S7W9x4Wk=;
        b=BzONDiUqwLN0anNdMEtx/UTOskZo0c/1FhH5AU48EDXe2yJorRNS/aJhyTE2U3qfEPHUIL
        29oLwhvyFZZSRHsTxAd8bE68WoBc+e7udxubahi+Q/IbXnTnfYf7+GYmj3F7lBhBNBENam
        HfwFMb/k+zgqiiYBGVOcbwcFDJ5YqyQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-W-O6ACd5OdejOPIYpHFXyA-1; Thu, 27 Jul 2023 07:13:14 -0400
X-MC-Unique: W-O6ACd5OdejOPIYpHFXyA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-52227ea05a9so523790a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690456393; x=1691061193;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:cc:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIORYueR8tQwkIlZ8oUtnpd4mJbrxO/lMh2S7W9x4Wk=;
        b=NDTIJTe+xb4X9tWRZYqBAfvMnf08wNRGma2k1W09vOOnC3G2Ajeb3CWJxm56z/3+Sd
         l3Oku6H7D0oafO/pdxqE24x8bTw0ejAVMO5TZl5XIopoqaG8e2BVLhgHJRFtCfZBxJr5
         QuKn4zmB9GxzNegqdEwEiWdKzHiGix9U0BbD1k90DSjWtm1qVvJ8DO+izMCrsQIO7wHm
         3tdqRTGM7Nfx2Y2bVLkC1KXZtcAII0cmo5CFn8oHKL78SgQKFF644uh8tbooohj+iWx6
         VlBxF/ZBXua+Bc8f3LXe01WaTsmucT6IwzL5Cz5Clw5AnZ4mcIHkizUa5vNT5HS17JNI
         pzCA==
X-Gm-Message-State: ABy/qLaZzV9oP+muPZIOXd1lJRKXqCEmh0iQZUOb7yXmRhPfmKp3v9Om
        ikTAy/o636Qui9iRKMOHq6EtU6tclVSC9uA1O8gBmmoW9zoO+pLo354HFNp3rEM0BO1PVrKiz4m
        2lMw1p/gu63wKkwIDyL3jXoZZ
X-Received: by 2002:a17:906:3197:b0:98d:cd3e:c18f with SMTP id 23-20020a170906319700b0098dcd3ec18fmr1598498ejy.72.1690456393075;
        Thu, 27 Jul 2023 04:13:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFqK3O/7UO1KFVznkNq/qxTau4FDVlTt2cWwvQU0tJR/j+Id5u3sfes/xs7+rhzr3XHCaWT3A==
X-Received: by 2002:a17:906:3197:b0:98d:cd3e:c18f with SMTP id 23-20020a170906319700b0098dcd3ec18fmr1598485ejy.72.1690456392762;
        Thu, 27 Jul 2023 04:13:12 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906408700b009786ae9ed50sm634077ejj.194.2023.07.27.04.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 04:13:11 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3659ea35-8d03-aae7-53c0-09181bb1b69d@redhat.com>
Date:   Thu, 27 Jul 2023 13:13:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     brouer@redhat.com, Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Andrew Kanner <andrew.kanner@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v3] drivers: net: prevent tun_get_user() to exceed xdp
 size limits
To:     Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
        David Ahern <dsahern@gmail.com>
References: <20230725155403.796-1-andrew.kanner@gmail.com>
 <CACGkMEt=Cd8J995+0k=6MT1Pj=Fk9E_r2eZREptLt2osj_H-hA@mail.gmail.com>
 <ab722ec1-ae45-af1f-b869-e7339402c852@redhat.com>
 <179979e6-eb8a-0300-5445-999b9366250a@gmail.com>
 <0c06b067-349c-9fe2-2cc3-36c149fd5277@gmail.com>
 <CACGkMEsYzd1FphP-Ym9T9YjA9ZNBw7Mnw5xQ75dytQMJxDK3cg@mail.gmail.com>
 <220fc36ba1086c1390ba087d08561b61762c965a.camel@redhat.com>
Content-Language: en-US
In-Reply-To: <220fc36ba1086c1390ba087d08561b61762c965a.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/07/2023 11.30, Paolo Abeni wrote:
> On Thu, 2023-07-27 at 14:07 +0800, Jason Wang wrote:
>> On Thu, Jul 27, 2023 at 8:27 AM David Ahern <dsahern@gmail.com> wrote:
>>>
>>> On 7/26/23 1:37 PM, David Ahern wrote:
>>>> On 7/26/23 3:02 AM, Jesper Dangaard Brouer wrote:
>>>>> Cc. John and Ahern
>>>>>
>>>>> On 26/07/2023 04.09, Jason Wang wrote:
>>>>>> On Tue, Jul 25, 2023 at 11:54 PM Andrew Kanner
>>>>>> <andrew.kanner@gmail.com> wrote:
>>>>>>>
>>>>>>> Syzkaller reported the following issue:
>>>>>>> =======================================
>>>>>>> Too BIG xdp->frame_sz = 131072
>>>>>
>>>>> Is this a contiguous physical memory allocation?
>>>>>
>>>>> 131072 bytes equal order 5 page.
>>>>>
>>>>> Looking at tun.c code I cannot find a code path that could create
>>>>> order-5 skb->data, but only SKB with order-0 fragments.  But I guess it
>>>>> is the netif_receive_generic_xdp() what will realloc to make this linear
>>>>> (via skb_linearize())
>>>>
>>>>
>>>> get_tun_user is passed an iov_iter with a single segment of 65007
>>>> total_len. The alloc_skb path is hit with an align size of only 64. That
>>>> is insufficient for XDP so the netif_receive_generic_xdp hits the
>>>> pskb_expand_head path. Something is off in the math in
>>>> netif_receive_generic_xdp resulting in the skb markers being off. That
>>>> causes bpf_prog_run_generic_xdp to compute the wrong frame_sz.
>>>
>>>
>>> BTW, it is pskb_expand_head that turns it from a 64kB to a 128 kB
>>> allocation. But the 128kB part is not relevant to the "bug" here really.
>>>

True, it is another "bug"/unexpected-behavior that SKB gets reallocated
to be 128KiB. We should likely solve this in another patch.

>>> The warn on getting tripped in bpf_xdp_adjust_tail is because xdp
>>> generic path is skb based and can have a frame_sz > 4kB. That's what the
>>> splat is about.

Agree, that the warn condition should be changed, even removed.
It is interesting that this warn caught this unexpected-behavior of
expanding to 128KiB.

>>
>> Other possibility:
>>
>> tun_can_build_skb() doesn't count XDP_PACKET_HEADROOM this may end up
>> with producing a frame_sz which is greater than PAGE_SIZE as well in
>> tun_build_skb().

True, and the way I read the tun_build_skb() code, via 
skb_page_frag_refill(),
it can produce an SKB with data size (buflen) upto order-3 = 32KiB 
(SKB_FRAG_PAGE_ORDER).

Thus, the existing check in tun_can_build_skb() for PAGE_SIZE can/should 
be relaxed?
(Please correct me as I don't fully understand tun_get_user() code)

>>
>> And rethink this patch, it looks wrong since it basically drops all
>> packets whose buflen is greater than PAGE_SIZE since it can't fall
>> back to tun_alloc_skb().
>>

I agree, this is why I reacted, as this version of the patch could
potentially cause issues and packet drops.

>>>
>>> Perhaps the solution is to remove the WARN_ON.
>>
>> Yes, that is what I'm asking if this warning still makes sense in V1.
> 
> I understand the consensus is solving the issue by changing/removing
> the WARN_ON() in XDP. I think it makes sense, I guess the same warn can
> be reached via packet socket xmit on veth or similar topology.
> 

Yes, we can completely remove this check.  The original intend was to
catch cases where XDP drivers have not been updated to use xdp.frame_sz,
but that is not longer a concern (since xdp_init_buff).

It was added (by me) in commit:
  - c8741e2bfe87 ("xdp: Allow bpf_xdp_adjust_tail() to grow packet size")
    - v5.8-rc1
  - as part of merge 5cc5924d8315

I'm sure it is safe to remove since commit:
  - 43b5169d8355 ("net, xdp: Introduce xdp_init_buff utility routine")
    - v5.12-rc1

where we introduced xdp_init_buff() helper, which all XDP driver use today.
Question is what "Fixes:" tag should the patch have?

To Andrew, will you
  (1) send a new patch that removes this check instead?
  (2) have cycles to investigate why the unexpected-behavior of
expanding to 128KiB happens?

--Jesper

