Return-Path: <linux-kernel+bounces-96947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E087637C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2B52827BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C865646E;
	Fri,  8 Mar 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIGjsZ1G"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F10A56456;
	Fri,  8 Mar 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898215; cv=none; b=VeWjlU27QlWYtX0gG6ytCiY9EoElEoDqytIC/i/n7/RFs6rfEtNq1JWPjxwbaEdTzdlFFrXFDQHg7gVT81IS1JsZ8J8yPUEGHebFy/vMvU454cDwqm1CxgU+lNPCq8YYqKKrLzxTDZD1d+CQ1viS3Z8W03ziTXZCqmkvFTYR/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898215; c=relaxed/simple;
	bh=BLq4lE0ORuBLkjW/aMxstNNMbjhuSScW2T/odBK1an8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=exfK3B6ArnlnQjk3zy84lhFXK1tpWJOFUU8LTy8bjRY5u/343VPoKmJPFpokLu44nzlxo6Rq0ngIpwMKx2CfjyekxIAcgkRvgR7080lARnZcTZqatsd313dAPAPtsa4Zgud5ovU6+j7+2cQ1zJppYP2dEAiCVe62K8n3wZ3IuKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIGjsZ1G; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78810ba2ff1so38570885a.3;
        Fri, 08 Mar 2024 03:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709898212; x=1710503012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=964gVKcSuC5DAvgCgp/Gwi4YKzK2yMuQXH05ybowodM=;
        b=PIGjsZ1G3KL/USsCQYH09g7Iw2EFGlH2twvIs8X/qANiXOQHpyoWepXpc/6VifH2DO
         3nmQdBoHiPR8tzgouFHHw05kW3BBQXGvDFGifhfsJ7jCZfcMISaPkphKpk9M5hFNaS2W
         5lugZi5Cuq8My/zSE6WCslxbcKCy/hdiNP/9C68193AhrpTHVbjBnyvONtJjlaJH2ZRD
         0AKdgo2zo73onRVIimpZP83nMyE0fnSGHKtuLx1/QbRWokyQN/tgfzuJER07Qma3gCan
         NxwHQzdNc14R2gPmTwn3hyhFn5zZHIxozU2hrQLE7r8q1u5c5Kw3bmCcdX3mlz1o1MVW
         cw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709898212; x=1710503012;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=964gVKcSuC5DAvgCgp/Gwi4YKzK2yMuQXH05ybowodM=;
        b=nqJ62rG46ZzqbqktDmsolwzviHM44CVyokPjQ4n+7qpMEimMWMYPap8vmULmh/yOAr
         fxVinLVa5lRrlDcozVXbGabitDegP+y718w8Bt1x9Jc2dzhUijfjD/cnxItU45po2NKJ
         mgVw86jG8o8Ifi1f99F2gLaxKp/zXO/7r4HTRzLjjANCLVXmBVG8CQllRqD6Rm/HM0lq
         3KL2ThTnDPNKAG+/dwoK+CupnyEcXOeJkJMyUnC2agB62KUA+xDNh0P2UiGXVoeLzOsX
         uL5CCehHk0hIxImGpXTC+BaFpoZbmTfN8Fvk78+/ecdia/AuPEWJpC+Ik1PtXCKxDNsJ
         RJQA==
X-Forwarded-Encrypted: i=1; AJvYcCU/kXhKRaP4fibk9u15Zfdr4u2lhwH7iO2EByp0IZ6ImOeZJ7Hdrp9fz10tdplEWqK3S6XleMB3ubWU1jFrBZ0Iu17PNmNd8aDZe8uU
X-Gm-Message-State: AOJu0Yw4OeVAWdrPlCL7VrOAimLxaE6b9ml30Z9+/ffbcraUOOv2YoE4
	K3kfHwo+v98o0preOn8/4NXD/ZUXc7HYbq28qegj4beow6x15fFX
X-Google-Smtp-Source: AGHT+IG9tNInw+XrpOoh3PlFf4hk1pHn7wcFWE3peYGy4458jYHEYVeeTreamQQu18vK0HYLrF+Dtg==
X-Received: by 2002:a05:620a:95a:b0:788:3207:bc3 with SMTP id w26-20020a05620a095a00b0078832070bc3mr11364161qkw.8.1709898212290;
        Fri, 08 Mar 2024 03:43:32 -0800 (PST)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d4-20020a37c404000000b00788253714cbsm5494285qki.58.2024.03.08.03.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 03:43:31 -0800 (PST)
Date: Fri, 08 Mar 2024 06:43:31 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Juntong Deng <juntong.deng@outlook.com>, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <65eaf9e336d07_133b25294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <AM6PR03MB5848595A20BB5D958C2D9DE299272@AM6PR03MB5848.eurprd03.prod.outlook.com>
References: <AM6PR03MB5848595A20BB5D958C2D9DE299272@AM6PR03MB5848.eurprd03.prod.outlook.com>
Subject: Re: [PATCH net-next] net/packet: Add getsockopt support for
 PACKET_COPY_THRESH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Juntong Deng wrote:
> Currently getsockopt does not support PACKET_COPY_THRESH,
> and we are unable to get the value of PACKET_COPY_THRESH
> socket option through getsockopt.
> 
> This patch adds getsockopt support for PACKET_COPY_THRESH.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  net/packet/af_packet.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 0db31ca4982d..65042edd1a97 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -4090,6 +4090,9 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
>  	case PACKET_VNET_HDR_SZ:
>  		val = READ_ONCE(po->vnet_hdr_sz);
>  		break;
> +	case PACKET_COPY_THRESH:
> +		val = pkt_sk(sk)->copy_thresh;
> +		break;

This is probably a good opportunity to use READ_ONCE/WRITE_ONCE for
this variable that can be modified and read concurrently.

Alternatively I can fix up all three locations in a follow-on patch.

No concerns with adding the getsockopt itself.

>  	case PACKET_VERSION:
>  		val = po->tp_version;
>  		break;
> -- 
> 2.39.2
> 



