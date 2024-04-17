Return-Path: <linux-kernel+bounces-148350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9778A8147
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6A0285619
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5A613C69C;
	Wed, 17 Apr 2024 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnZKAL8b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07913C679
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350925; cv=none; b=ERpVMnzEwgcyWAStm+s+lqYLG8laEHnXLDrh8v7uLboLjjhDOgzZPvvkflyyyRdMx76xYu7GJUgpwgD98xXX1Q+lmnZBy4oiyN7obS0VIE0xRFkwXjvlwQnFxYx27y0RLzqhY3gXK3CwI7hsEFTSiiruRRfBr052nyLDAjsjB1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350925; c=relaxed/simple;
	bh=SquCiX3Dv4lo5LlU2xjv06Wsc1FTLOSnChvjK8DZwcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpBYecOV3U25JVcmlgix9oDtcLFKJp4xXkGI7NblPxOSiOtlUCn6EfSBzOM7Q+QZuYz9EV1+nkYY/dbE/YpLunFXa5ilEHOXeZoNQHQcZtXFytPHIobkd7esN3iDmPksQjbHVMH16nX34hv7nriG7totQFImeRSrg59QXJNRs2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnZKAL8b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713350922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYluOacb3+MvYyKPg9bar2w5dpGIvsi2lGfXJgNZvHM=;
	b=hnZKAL8bvxplyA0GzuPKdD9+EN95ZO1ncCo8FjX4BsmoGIc24/NjbMb8kVJtX4Bv1k8pwE
	paHsguSDNO0GbpxKmQgdAzU/Y3kDZzUxBWQFIe+UyJyzyfTwbjEVYsA2xHAfewwD6zRFDS
	TaC5o7GdEWCGAvdG+gQiJ9IKA8iSmDY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-c3YJGEWwPQyUQJzUhVdA1w-1; Wed, 17 Apr 2024 06:48:41 -0400
X-MC-Unique: c3YJGEWwPQyUQJzUhVdA1w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56c1b105949so4898147a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 03:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713350919; x=1713955719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYluOacb3+MvYyKPg9bar2w5dpGIvsi2lGfXJgNZvHM=;
        b=fz8ksdWDI/b+H2x6eQemJBwJh+9Dv5TSqdFIaLPHlfW3lt5mHqwdsxGU/jr8lzqyel
         hpelPXyUt5dqlRHdievyiIMRsibiCGic0VMgEt0hflT6hQoa9Ay+Pa5kYM/MFOC0a+kn
         BCfoYLF3BwjuaObXz9JscbkH8vAuOJgUqeEXR1qFKFFRHT/7SFESzLaIpXlPN7h5rb7m
         bA0mB9MfcSfswuotLF5+qWWmJWO3p9ixjSJ8cS1teflBMVJwjQDTcuYJx0qgN4aZTmzi
         vB1Pg1WFu8F7cPcIjTyaAPLhhuaXs2NrpPsPmba2WmnseesYLEGae61ZCkPWYGzpj97f
         0E5w==
X-Forwarded-Encrypted: i=1; AJvYcCW3tpfjiMq1hubTuofC259UZCOJYP8YVEBjxAZ2eicFBgK7dgs5M5Z4IeDDk8ahJHIgSA+3IAhzTxJ662wgx0XIRKc56kbrNmlC6kCQ
X-Gm-Message-State: AOJu0YzQeeTEF1DkbRcK96a5RV27OTXeYir6McSu/INQ2JsdMfGCBkcS
	X/4/07G6d51JYl+dmcbFtL2ryi+olTc5ccmGjjiadTDKYDisyCBtvdsH8Tf9Q+/WdUlI4zHFTyf
	C+OCntBfU4Q9ET9FIXLdx0az2+s05lKnLT0HY0bSSEUK/U2pX2gWfUun4eaGib3sX9UezFg==
X-Received: by 2002:a50:9e4e:0:b0:566:2f24:b063 with SMTP id z72-20020a509e4e000000b005662f24b063mr11672620ede.23.1713350919679;
        Wed, 17 Apr 2024 03:48:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYZ+PnJB7bTJV8KGPjiCePvh7S5sX01X38McIkHA+N217wFbrLGzI3FRHZRH+vH2qi+RfTuw==
X-Received: by 2002:a50:9e4e:0:b0:566:2f24:b063 with SMTP id z72-20020a509e4e000000b005662f24b063mr11672609ede.23.1713350919328;
        Wed, 17 Apr 2024 03:48:39 -0700 (PDT)
Received: from [172.16.1.27] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id t31-20020a056402241f00b005704751808asm1659133eda.63.2024.04.17.03.48.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2024 03:48:38 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: "jun.gu" <jun.gu@easystack.cn>
Cc: dev@openvswitch.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: openvswitch: Check vport net device name
Date: Wed, 17 Apr 2024 12:48:38 +0200
X-Mailer: MailMate (1.14r6029)
Message-ID: <811765EC-AD27-4210-9AFC-034129F24BFA@redhat.com>
In-Reply-To: <20240417042031.157008-1-jun.gu@easystack.cn>
References: <27644212-924C-4AB2-88F6-D209E2586E82@redhat.com>
 <20240417042031.157008-1-jun.gu@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 17 Apr 2024, at 6:20, jun.gu wrote:

> Check vport net device name to ensure the provided name is not one of
> its aliases. This can avoid that ovs userspace create and destroy vport=

> repeatedly.

How about changing the text to the following?

  Ensure that the provided netdev name is not one of its aliases to preve=
nt unnecessary creation and destruction of the vport by ovs-vswitchd.

Maybe the maintainers are fine with the current text, in that case:

Acked-by: Eelco Chaudron <echaudro@redhat.com>

>
> Signed-off-by: Jun Gu <jun.gu@easystack.cn>
> ---
>  net/openvswitch/vport-netdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-net=
dev.c
> index 903537a5da22..7003e76b8172 100644
> --- a/net/openvswitch/vport-netdev.c
> +++ b/net/openvswitch/vport-netdev.c
> @@ -78,7 +78,10 @@ struct vport *ovs_netdev_link(struct vport *vport, c=
onst char *name)
>  	int err;
>
>  	vport->dev =3D dev_get_by_name(ovs_dp_get_net(vport->dp), name);
> -	if (!vport->dev) {
> +	/* Ensure that the device exists and that the provided
> +	 * name is not one of its aliases.
> +	 */
> +	if ((!vport->dev) || strcmp(name, ovs_vport_name(vport))) {
>  		err =3D -ENODEV;
>  		goto error_free_vport;
>  	}
> -- =

> 2.25.1


