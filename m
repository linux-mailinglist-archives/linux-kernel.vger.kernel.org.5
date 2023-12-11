Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF7E80C8E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjLKMCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjLKMB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C8110CF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702296108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bqzvj1BVA/xUscvTFwnIQ16B6kfl78jXgo5T95qDUwM=;
        b=E9/Dxd9mvCgfL6uQPEBenTc/UVLMOwN9ELCCQncTNzwTLih1ISskxe67l5tE4f4mo7cNab
        yA0Fm//Aq/cc+1Pt+UHsHiuWmqoOMCqG3RGr1eTcj79W5AbVRGv8qK2OCQUPDRiDnKW/s4
        pUx8phtqjOmFbIlD1E9jh5yjQjVjvd8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-dgLy8EthM6exGlm4gNJA5A-1; Mon, 11 Dec 2023 07:01:47 -0500
X-MC-Unique: dgLy8EthM6exGlm4gNJA5A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67ab1ce51b7so60005196d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702296106; x=1702900906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqzvj1BVA/xUscvTFwnIQ16B6kfl78jXgo5T95qDUwM=;
        b=qTNsMRYRK2ihDzAsKp1YoomRfq60D32utQvERdwbg/D3OKwCZ07Mqq/gtMGN0YT/FK
         zka08iRZ+PnTrt3cmVw/jw4a2t0A5Yfo6/NPprttPGWKawRLoVvrGhGqtLjyJ3DEYFJ9
         2hUhAcbX351zzSJaK/wUt0dmmERCK84Qwk7Uj/7xtxsx1ggFf7DniXf6gMdHRK15Xr6X
         bMCvXi3IH/BWCZ9Z+gkQXiV4ZdaLtlV7izypFrkJ6BUTLUSxwGt7ye0cQlanocVSy7j9
         PFapnuYpOIbryxYKkncyzr8BSLNO8uc4ZlQY9BKY9HppvAzKCLtLewEKac2nrjblZe4x
         hoiA==
X-Gm-Message-State: AOJu0YxmgnITklAOfz9bK2MfegbnJjH5OHuWxbO2R9Sulg9iPYArJF8Z
        yY2C09ZqJrBRkHpL8AUnV8fg/suwBLv3UDYGSNpPKgvJEMbRJQMuEJgD+lXwHnwfjbB+tKrGBmU
        XzjWjgU7TVTI6a1TrLpR76R8S
X-Received: by 2002:a05:6214:f66:b0:67a:b963:5ae with SMTP id iy6-20020a0562140f6600b0067ab96305aemr9074352qvb.45.1702296106726;
        Mon, 11 Dec 2023 04:01:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJe0L6QdS4nGwvEb9tjBx33wTgJG4fosHSmbpSVi1Tq8yvZi8qUQYj5rcbM7XZsEBl/CmTNw==
X-Received: by 2002:a05:6214:f66:b0:67a:b963:5ae with SMTP id iy6-20020a0562140f6600b0067ab96305aemr9074332qvb.45.1702296106415;
        Mon, 11 Dec 2023 04:01:46 -0800 (PST)
Received: from sgarzare-redhat ([95.131.45.143])
        by smtp.gmail.com with ESMTPSA id v16-20020a0cf910000000b0067a53aa6df2sm3232285qvn.46.2023.12.11.04.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:01:46 -0800 (PST)
Date:   Mon, 11 Dec 2023 13:01:16 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v7 3/4] virtio/vsock: fix logic which reduces
 credit update messages
Message-ID: <s5v5hbr2memhwoqm3fxbkq6qsocs43qgyhx432zzy6ugbqhuu2@rsnm3kiwfwjm>
References: <20231206211849.2707151-1-avkrasnov@salutedevices.com>
 <20231206211849.2707151-4-avkrasnov@salutedevices.com>
 <20231206165045-mutt-send-email-mst@kernel.org>
 <d9d1ec6a-dd9b-61d9-9211-52e9437cbb1f@salutedevices.com>
 <20231206170640-mutt-send-email-mst@kernel.org>
 <d30a1df7-ecda-652d-8c98-853308a560c9@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d30a1df7-ecda-652d-8c98-853308a560c9@salutedevices.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 01:50:05AM +0300, Arseniy Krasnov wrote:
>
>
>On 07.12.2023 01:08, Michael S. Tsirkin wrote:
>> On Thu, Dec 07, 2023 at 12:52:51AM +0300, Arseniy Krasnov wrote:
>>>
>>>
>>> On 07.12.2023 00:53, Michael S. Tsirkin wrote:
>>>> On Thu, Dec 07, 2023 at 12:18:48AM +0300, Arseniy Krasnov wrote:
>>>>> Add one more condition for sending credit update during dequeue from
>>>>> stream socket: when number of bytes in the rx queue is smaller than
>>>>> SO_RCVLOWAT value of the socket. This is actual for non-default value
>>>>> of SO_RCVLOWAT (e.g. not 1) - idea is to "kick" peer to continue data
>>>>> transmission, because we need at least SO_RCVLOWAT bytes in our rx
>>>>> queue to wake up user for reading data (in corner case it is also
>>>>> possible to stuck both tx and rx sides, this is why 'Fixes' is used).
>>>>> Also handle case when 'fwd_cnt' wraps, while 'last_fwd_cnt' is still
>>>>> not.
>>>>>
>>>>> Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
>>>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>>>> ---
>>>>>  Changelog:
>>>>>  v6 -> v7:
>>>>>   * Handle wrap of 'fwd_cnt'.
>>>>>   * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
>>>>>
>>>>>  net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++++---
>>>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>>> index e137d740804e..39f8660d825d 100644
>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>> @@ -558,6 +558,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>>>>  	struct virtio_vsock_sock *vvs = vsk->trans;
>>>>>  	size_t bytes, total = 0;
>>>>>  	struct sk_buff *skb;
>>>>> +	u32 fwd_cnt_delta;
>>>>> +	bool low_rx_bytes;
>>>>>  	int err = -EFAULT;
>>>>>  	u32 free_space;
>>>>>
>>>>> @@ -601,7 +603,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>>>>  		}
>>>>>  	}
>>>>>
>>>>> -	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
>>>>> +	/* Handle wrap of 'fwd_cnt'. */
>>>>> +	if (vvs->fwd_cnt < vvs->last_fwd_cnt)
>>>>> +		fwd_cnt_delta = vvs->fwd_cnt + (U32_MAX - vvs->last_fwd_cnt);
>>>>
>>>> Are you sure there's no off by one here? for example if fwd_cnt is 0
>>>> and last_fwd_cnt is 0xfffffffff then apparently delta is 0.
>>>
>>> Seems yes, I need +1 here
>>
>> And then you will get a nop, because assigning U32_MAX + 1 to u32
>> gives you 0. Adding () does nothing to change the result,
>> + and - are commutative.
>
>Ahh, unsigned here, yes.

Ooops, sorry I was confused here!

>
>@Stefano, what did You mean about wrapping here?
>
>I think Michael is right, for example

Yep, I agree!
Sorry for this wrong suggestion!

Stefano

>
>vvs->fwd_cnt wraps and now == 5
>vvs->last_fwd_cnt == 0xffffffff
>
>now delta before this patch will be 6 - correct value
>
>May be I didn't get your idea, so implement it very naive?
>
>Thanks, Arseniy
>
>>
>>
>>>>
>>>>
>>>>> +	else
>>>>> +		fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
>>>>
>>>> I actually don't see what is wrong with just
>>>> 	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt
>>>> 32 bit unsigned math will I think handle wrap around correctly.
>>>>
>>>> And given buf_alloc is also u32 - I don't see where the bug is in
>>>> the original code.
>>>
>>> I think problem is when fwd_cnt wraps, while last_fwd_cnt is not. In this
>>> case fwd_cnt_delta will be too big, so we won't send credit update which
>>> leads to stall for sender
>>>
>>> Thanks, Arseniy
>>
>> Care coming up with an example?
>>
>>
>>>>
>>>>
>>>>> +
>>>>> +	free_space = vvs->buf_alloc - fwd_cnt_delta;
>>>>> +	low_rx_bytes = (vvs->rx_bytes <
>>>>> +			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>>>>>
>>>>>  	spin_unlock_bh(&vvs->rx_lock);
>>>>>
>>>>> @@ -611,9 +621,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>>>>  	 * too high causes extra messages. Too low causes transmitter
>>>>>  	 * stalls. As stalls are in theory more expensive than extra
>>>>>  	 * messages, we set the limit to a high value. TODO: experiment
>>>>> -	 * with different values.
>>>>> +	 * with different values. Also send credit update message when
>>>>> +	 * number of bytes in rx queue is not enough to wake up reader.
>>>>>  	 */
>>>>> -	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
>>>>> +	if (fwd_cnt_delta &&
>>>>> +	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes))
>>>>>  		virtio_transport_send_credit_update(vsk);
>>>>>
>>>>>  	return total;
>>>>> --
>>>>> 2.25.1
>>>>
>>
>

