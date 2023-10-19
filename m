Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E50C7CF1E8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344924AbjJSIDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjJSIDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B439130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697702538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkgXc+bIQhSWbzeEfBW5BEA6kfzhB8N4rA+lukaPFCw=;
        b=RD/RwzYmfrNiHtgaIaEXinUDJJ8MdIA21rdBc/oZdqBljssks009uDuRk/6pcdueRNkj3F
        MDrAY2YvEf8JHIkGckq8Q4pC63HmHg8Mz4aYOpTIQ6sjcq/CjMzMEQRvhHAV/8/n1VNXjs
        Mh1HHlrI/fLDtE3cdm/LJ4//ywtJTfM=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-Asc98VRPMQaVthTbfpXIJA-1; Thu, 19 Oct 2023 04:02:17 -0400
X-MC-Unique: Asc98VRPMQaVthTbfpXIJA-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-49ab22f0e07so422918e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697702536; x=1698307336;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkgXc+bIQhSWbzeEfBW5BEA6kfzhB8N4rA+lukaPFCw=;
        b=lq8xZ6a4cKOavnGAAtkEeQhwY4LYFJIyz5NpEabZz9jnEydEvwL8ZTP39ULd15tlbc
         XjF82QmF9gJH7GhYMINqLTRoWp1NN5KJ6MKiGXjUlSjYnfbI603jxZ9BbZMcAcq6zOQ9
         YS/rgpFVMJj0tlHSrDvK9gnV45ulpwW4ASPeb46Myw5Dy/IsnYTVaSbfQGniwXh09jfz
         xjEtcmmLVmxIIK4IgThonJyhMynPkeCsrzyR91A3jv4Q1yfHCtJPdXI9gTE8saQY2HfC
         9yvrwkJp8w8bJ0ljfVejzBCikejlvVJO+J5Nb6kqzmSHYuiI00QoemZynoo6mbOKyku+
         MQWA==
X-Gm-Message-State: AOJu0YyMgCW14I1e0JWmrqhdKdMXSSVT3+B6QDP9jLHEIiEjIsAQaeeZ
        gM3JZg24O/jsSelWYCit9TkECpLAn77+ZwbBOr3V+qWF45DFcz7MURAgexh2g0LNdsDtiAB0Njy
        uoK2mfcMWg4Bf/B/fDwoct+8O
X-Received: by 2002:a05:6102:308d:b0:457:bd7e:3832 with SMTP id l13-20020a056102308d00b00457bd7e3832mr884519vsb.0.1697702536671;
        Thu, 19 Oct 2023 01:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM/XVjCo5XISBz32LDGZnbS07IzVzgTcM3mHDa8Ity94U25ZCi2Au4jP8mNGnsxBXLMjaLcg==
X-Received: by 2002:a05:6102:308d:b0:457:bd7e:3832 with SMTP id l13-20020a056102308d00b00457bd7e3832mr884494vsb.0.1697702536230;
        Thu, 19 Oct 2023 01:02:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-142.dyn.eolo.it. [146.241.237.142])
        by smtp.gmail.com with ESMTPSA id b10-20020ac86bca000000b00419c39dd28fsm565293qtt.20.2023.10.19.01.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 01:02:15 -0700 (PDT)
Message-ID: <8c6a71aaaabc0a8ea4c36ce609cb097857b68a96.camel@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] sock: Fix improper heuristic on raising
 memory
From:   Paolo Abeni <pabeni@redhat.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 Oct 2023 10:02:12 +0200
In-Reply-To: <20231016132812.63703-3-wuyun.abel@bytedance.com>
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
         <20231016132812.63703-3-wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-16 at 21:28 +0800, Abel Wu wrote:
> Before sockets became aware of net-memcg's memory pressure since
> commit e1aab161e013 ("socket: initial cgroup code."), the memory
> usage would be granted to raise if below average even when under
> protocol's pressure. This provides fairness among the sockets of
> same protocol.
>=20
> That commit changes this because the heuristic will also be
> effective when only memcg is under pressure which makes no sense.
> Fix this by reverting to the behavior before that commit.
>=20
> After this fix, __sk_mem_raise_allocated() no longer considers
> memcg's pressure. As memcgs are isolated from each other w.r.t.
> memory accounting, consuming one's budget won't affect others.
> So except the places where buffer sizes are needed to be tuned,
> allow workloads to use the memory they are provisioned.
>=20
> Fixes: e1aab161e013 ("socket: initial cgroup code.")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
> v2:
>   - Ignore memcg pressure when raising memory allocated.
> ---
>  net/core/sock.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9f969e3c2ddf..1d28e3e87970 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3035,7 +3035,13 @@ EXPORT_SYMBOL(sk_wait_data);
>   *	@amt: pages to allocate
>   *	@kind: allocation type
>   *
> - *	Similar to __sk_mem_schedule(), but does not update sk_forward_alloc
> + *	Similar to __sk_mem_schedule(), but does not update sk_forward_alloc.
> + *
> + *	Unlike the globally shared limits among the sockets under same protoc=
ol,
> + *	consuming the budget of a memcg won't have direct effect on other one=
s.
> + *	So be optimistic about memcg's tolerance, and leave the callers to de=
cide
> + *	whether or not to raise allocated through sk_under_memory_pressure() =
or
> + *	its variants.
>   */
>  int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kin=
d)
>  {
> @@ -3093,7 +3099,11 @@ int __sk_mem_raise_allocated(struct sock *sk, int =
size, int amt, int kind)
>  	if (sk_has_memory_pressure(sk)) {
>  		u64 alloc;
> =20
> -		if (!sk_under_memory_pressure(sk))
> +		/* The following 'average' heuristic is within the
> +		 * scope of global accounting, so it only makes
> +		 * sense for global memory pressure.
> +		 */
> +		if (!sk_under_global_memory_pressure(sk))
>  			return 1;

Since the whole logic is fairly non trivial I'd like to explicitly note
(for my own future memory) that I think this is the correct approach.=C2=A0

The memcg granted the current allocation via the
mem_cgroup_charge_skmem() call above, the heuristic to eventually
suppress the allocation should be outside the memcg scope.

LGTM, thanks!

Paolo

