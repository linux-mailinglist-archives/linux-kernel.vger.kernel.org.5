Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166D47EC646
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbjKOOt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjKOOtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:49:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C837187
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700059761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zHkzs+ps70Z5GXuD30h9mGNv1mAJncdsZa6jleaf8rI=;
        b=DqcJbqlHOv7fQMPXSqR0DD/V2YMU1KSW2R4zrrJbTI+k1IWjaSvx0BmPo1W0gmco7eLgHg
        xGnlBZSiloq0nJwPlY8bZfkOSrA/figl9lYZasvVtEKU4uVTWgXk7K94uCS6Z7rCDF04Eh
        KdxF+h+eChQF4GOSwxx5YbIyvx6l2kI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-AeBtmgJZPqup2gnubeQMhg-1; Wed, 15 Nov 2023 09:49:19 -0500
X-MC-Unique: AeBtmgJZPqup2gnubeQMhg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9c39f53775fso52345866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700059758; x=1700664558;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zHkzs+ps70Z5GXuD30h9mGNv1mAJncdsZa6jleaf8rI=;
        b=uGC0WH8FtmLnMVF7NpClUPQ5jBAgWB8lDwE/av378yMBw1ghRl2YGgrSdvLJa2bXL0
         1OQDRLt/nmSoNwHy0SMTIlwM/8g6wHaHUWyWzc5FTa5APHCtewoOKwjUOVYNUpbioOpo
         M/APVNsixhR0I8jLTjyuDAatkkZMSSPMeZbJnPAzltybcnajAD0xCC44bDj8Pntb8upL
         VI2ycwJTads5jGBQkQxvQv/7MsT5JZ64ifma/NSxX6VO0VbuO6JJh3qmTX/fBrU8vA+1
         hmlYFfLTzAxP3/Fef7EDFYmindlMOaTyFOqaFE3pJy3q8QbS5w8q8dQsY07FuMfSzAIx
         5vLg==
X-Gm-Message-State: AOJu0YxLAhtT2hcsuALNuSyk0AjpzgzjUUlqbaWQWZyL1PJiQ/nnwJPg
        IL9wLtlYW1yI+Qux/3qe+jxGTCDAe6uGiMOfcVnwbLrVOQb5KJ5OnNenq+h3aM7g9zUBNN5lq7G
        wZoiBFeNd8y+oyfvnOSLj2l87
X-Received: by 2002:a17:906:74c7:b0:9c4:4b20:44a5 with SMTP id z7-20020a17090674c700b009c44b2044a5mr3818322ejl.4.1700059758554;
        Wed, 15 Nov 2023 06:49:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvgKtKBhigODP4vMAdyOAfLJaUmOSX75yR/hH8B496MgTOteUFPLgPY9ZiDpnInT3OHyNX5w==
X-Received: by 2002:a17:906:74c7:b0:9c4:4b20:44a5 with SMTP id z7-20020a17090674c700b009c44b2044a5mr3818307ejl.4.1700059758184;
        Wed, 15 Nov 2023 06:49:18 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-35.dyn.eolo.it. [146.241.232.35])
        by smtp.gmail.com with ESMTPSA id y10-20020a1709064b0a00b009dd7bc622fbsm7149455eju.113.2023.11.15.06.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:49:17 -0800 (PST)
Message-ID: <d599922fd89b3e61c7cf531a03ea8b81cbcb003e.camel@redhat.com>
Subject: Re: [PATCH net-next v2] netlink: introduce netlink poll to resolve
 fast return issue
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jong eon Park <jongeon.park@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dongha7.kang@samsung.com
Date:   Wed, 15 Nov 2023 15:49:16 +0100
In-Reply-To: <20231114090748.694646-1-jongeon.park@samsung.com>
References: <CGME20231114090804epcas1p35fde5f79e9ad1419b3199e6cdc45bc0b@epcas1p3.samsung.com>
         <20231114090748.694646-1-jongeon.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry for the delayed feedback.

On Tue, 2023-11-14 at 18:07 +0900, Jong eon Park wrote:
> In very rare cases, there was an issue where a user's 'poll' function
> waiting for a uevent would continuously return very quickly, causing
> excessive CPU usage due to the following scenario.
>=20
> When sk_rmem_alloc exceeds sk_rcvbuf, netlink_broadcast_deliver returns a=
n
> error and netlink_overrun is called. However, if netlink_overrun was
> called in a context just before a another context returns from the 'poll'
> and 'recv' is invoked, emptying the rcv queue, sk->sk_err =3D ENOBUF is
> written to the netlink socket belatedly and it enters the
> NETLINK_S_CONGESTED state. If the user does not check for POLLERR, they
> cannot consume and clean sk_err and repeatedly enter the situation where
> they call 'poll' again but return immediately. Moreover, in this
> situation, rcv queue is already empty and NETLINK_S_CONGESTED flag
> prevents any more incoming packets. This makes it impossible for the user
> to call 'recv'.
>=20
> This "congested" situation is a bit ambiguous. The queue is empty, yet
> 'congested' remains. This means kernel can no longer deliver uevents
> despite the empty queue, and it lead to the persistent 'congested' status=
.
>=20
> ------------CPU1 (kernel)----------  --------------CPU2 (app)------------=
--
> ...
> a driver delivers uevent.            poll was waiting for schedule.
> a driver delivers uevent.
> a driver delivers uevent.
> ...
> 1) netlink_broadcast_deliver fails.
> (sk_rmem_alloc > sk_rcvbuf)
>                                       getting schedule and poll returns,
>                                       and the app calls recv.
>                                       (rcv queue is empied)
>                                       2)
>=20
> netlink_overrun is called.
> (NETLINK_S_CONGESTED flag is set,
> ENOBUF is written in sk_err and,
> wake up poll.)
>                                       finishing its job and call poll.
>                                       poll returns POLLERR.
>=20
>                                       (the app doesn't have POLLERR handl=
er)
>                                       it calls poll, but getting POLLERR.
>                                       it calls poll, but getting POLLERR.
>                                       it calls poll, but getting POLLERR.
>                                       ...
>=20
> To address this issue, I would like to introduce the following netlink
> poll.

IMHO the above is an application bug, and should not be addressed in
the kernel.

If you want to limit the amount of CPU time your application could use,
you have to resort to process scheduler setting and/or container
limits: nothing could prevent a [buggy?] application from doing:

# in shell script
while true; do :; done

The above condition is IMHO not very different from the above: the
application is requesting POLLERR event and not processing them.

To more accurate is like looping on poll() getting read event without
reading any data. Nothing we should address in the kernel.

Cheers,

Paolo

