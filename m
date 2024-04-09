Return-Path: <linux-kernel+bounces-136842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFB789D8DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132E2284ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9321E12D219;
	Tue,  9 Apr 2024 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeOQL3cE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32864129E9E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664428; cv=none; b=q5/6z0WDzcCJ3/xDaCA/GzFT0LlHvb2TpGM/YlEMVcs7450IMDiskT8KtQVeTJhBUFTMjaXXhBeGgN70siMByOMbeZ+BP/0Cvni1ILET7on/ZX+LbUWh31IgcAOb4txfThO46W0CyvY1H6+kJtIprAS56uQRl/XfLzOLSufy3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664428; c=relaxed/simple;
	bh=dEqzAVisY4aRigVueLVKUe0ncxS5i6fSVpRxQ6Ued50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BkOEbP8Yblv/mRx48mccxkIB07F1Qy12n6ltIt/jW+URC8JC4KDDFMvHD0fGXcwvIX7von+HqJ3oS78bKf6kfUdAFUgtiqfBU7oZ4iP17fuyHJZjRIFvNSOE6M3du3iUIQvCKn8R9MaAP6L3zD2So76EOP4/N0w1sdEHLtriBR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeOQL3cE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712664425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HkFcR2uVpCjKDxBhnTR7ZuYMiqqDHFNAcHHxyhfV8EE=;
	b=SeOQL3cE78t4xiBys2EM2UKlkFAryym4M54utUClwJxeH4sg6xLlcqhK3KBYPw4Q123R15
	SocP4SI8arME4ySvoA3L5Ks1LNAC7z4+KNlXZb2jF/PuikbqK2d6KwNhY2od+En9eFOJWo
	SiQHiCNMu4Y787bw8Pzmdtgvf+E5/D0=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-BN0629diNv6I3SIevcaRsQ-1; Tue, 09 Apr 2024 08:07:04 -0400
X-MC-Unique: BN0629diNv6I3SIevcaRsQ-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5aa1b6f6c0fso836924eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 05:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712664423; x=1713269223;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HkFcR2uVpCjKDxBhnTR7ZuYMiqqDHFNAcHHxyhfV8EE=;
        b=H83euj7hL+cqmmkmpOxoNMkEVo0dG+v4pp4DpiMXXd3M7jGrUf3cUmZgFQBJejKCmI
         LjNFHU+iKqaTVDao77HXbk3fe6vcvLJHy7tUcw8ce6mqb0Vpx5lfODGB62FeSlcM3Fav
         PFbY+KaeaJqUdfookucaBaHwksTZZjSXKxPZAFa8PrlopDqaO+JJxVFKNiSWCe9IU3Fn
         6htpi9u9nXW68GBfAlsD2w9UJdaJJ1wziDSvUUgT6qdqs7TRrQMWHBflRv0nT2icxrlw
         d6Axo8Q9RyX6FzuD+uS7rn7m4r/RsQkosDESfR00fDJZhw0Bs0JC0x+/5GShpycCk0Iv
         pqQA==
X-Forwarded-Encrypted: i=1; AJvYcCWSz0BPA9YUg6lnNSWOcYqV0WqnfQOupFen1tFg9R04m9YPXKcmCPVj3oN+JXG7LWY3rAmaX/S0NgB5nQwbQ7kIf0AGlM5G5jYBc+UR
X-Gm-Message-State: AOJu0Yxb/svDCXP84DTj5DgZcEoemQ6gZ6GZLi1Ki2GOahDjCRJDcEyr
	kBzim+v8OJlbG5M3SNhTvubUuQBFabXC+TqApBaXVOel/ZA0SKC4sbVe0PdrFESLB6oYCXZ+wF9
	zJHnnQsiiAj5AAxbV8wwkdipy5jH9gSrYJWtXi10iIey82IRmeMxAXKxeSLHDDw==
X-Received: by 2002:a05:6870:1651:b0:220:bd4d:674d with SMTP id c17-20020a056870165100b00220bd4d674dmr12011962oae.5.1712664423602;
        Tue, 09 Apr 2024 05:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrN5ENLVbSZMW4W4CJ9xO7Y0P9AkyPe6V8i2fZEJ34nveaznGa9nVEA0vvlaoe76fryf7Fmw==
X-Received: by 2002:a05:6870:1651:b0:220:bd4d:674d with SMTP id c17-20020a056870165100b00220bd4d674dmr12011947oae.5.1712664423318;
        Tue, 09 Apr 2024 05:07:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-144.dyn.eolo.it. [146.241.244.144])
        by smtp.gmail.com with ESMTPSA id po27-20020a05620a385b00b0078d5e60b52esm2787845qkn.114.2024.04.09.05.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:07:02 -0700 (PDT)
Message-ID: <d9fde608268413dda70bb6ef328b8d823d568f74.camel@redhat.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Add support for offload tc with
 skbedit mark action
From: Paolo Abeni <pabeni@redhat.com>
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Date: Tue, 09 Apr 2024 14:06:59 +0200
In-Reply-To: <20240408072638.26674-1-gakula@marvell.com>
References: <20240408072638.26674-1-gakula@marvell.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 12:56 +0530, Geetha sowjanya wrote:
> Support offloading of skbedit mark action.
>=20
> For example, to mark with 0x0008, with dest ip 60.60.60.2 on eth2
> interface:
>=20
>  # tc qdisc add dev eth2 ingress
>  # tc filter add dev eth2 ingress protocol ip flower \
>       dst_ip 60.60.60.2 action skbedit mark 0x0008 skip_sw
>=20
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c  |  2 ++
>  .../ethernet/marvell/octeontx2/nic/otx2_common.h    |  2 ++
>  .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c    | 13 +++++++++++++
>  .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c  |  3 +++
>  .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h  |  3 +++
>  5 files changed, 23 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/dri=
vers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> index c75669c8fde7..6188921e9a20 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
> @@ -1183,6 +1183,8 @@ static int npc_update_rx_entry(struct rvu *rvu, str=
uct rvu_pfvf *pfvf,
>  			action.pf_func =3D target;
>  			action.op =3D NIX_RX_ACTIONOP_UCAST;
>  		}
> +		if (req->match_id)
> +			action.match_id =3D req->match_id;
>  	}
> =20
>  	entry->action =3D *(u64 *)&action;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 06910307085e..815ae13c371c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -363,6 +363,7 @@ struct otx2_flow_config {
>  	struct list_head	flow_list;
>  	u32			dmacflt_max_flows;
>  	u16                     max_flows;
> +	u16			mark_flows;

Since the above fields is used as (reference) counter for the
OTX2_FLAG_TC_MARK_ENABLED bit, what about using a refcount_t, so you
gain sanity checks for free?

Thanks!

Paolo


