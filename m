Return-Path: <linux-kernel+bounces-80910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A0866DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558071F285AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459171759E;
	Mon, 26 Feb 2024 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOGtk9ps"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2151E516
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936281; cv=none; b=Iv/x+jlZPwVxTiJJX1cmMh0WEcLjlSdWw8MSZtFdjgFnil960jNyWlPTgldomTg7K0MTvjv0Kc94OcMTNPLGa1yTVjmsGgob3d65Np9OrR2vUnwtSYPkr2pIh4PvG/NRgvTSRkdAzzrHlmQMhPO7I2H7LZDi4QoFRGoo6sEXTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936281; c=relaxed/simple;
	bh=Dygiyz1OnjTfaz+BngVouI977noQ0Hft298bDIocTX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsswAsSMa5znKONs8953bHRcWMDG9lkGmlmU4nzhDgdw5/P5gNZHH1he8GF+z4rpmyv2+apN7OHZJuVQmxbGs/13WS7gRYcgTbS1yytS+jDN7VX1hFx57n8S0WQzNRATUkvGcu+Dzieg6Cg2+dN6VMFrAQCsFisn0DTwD7yWIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOGtk9ps; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708936278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TfCEbsiS180Pzdnz3BmbeixICS+mxWP3WbokAEMsGb4=;
	b=YOGtk9psPqfjwRTvtstQ8Jvw8KUYvgopM9O01PygNulUc8MvJMtDg82YwaUdLRzte9L4HD
	eEi9D5WzQk+abMUf8rpKaxTsS3l4ftq86fh9gwunA3tbFaZCrQXxsdx+4rcfH38e1Diy5C
	0BXHnSXaRNYJ18ZvY0Kz+6EkfqcyMgM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-vc6YpDizM5692yWiS9WCpA-1; Mon, 26 Feb 2024 03:31:15 -0500
X-MC-Unique: vc6YpDizM5692yWiS9WCpA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3ec1d8b1e2so139416666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936274; x=1709541074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfCEbsiS180Pzdnz3BmbeixICS+mxWP3WbokAEMsGb4=;
        b=vkb5AzNZV58X542Q9+maR6QwyCyJp1bEeg4XgORJmRi/LC420i0LHETRkMiwn9xjFa
         QYdC0ukQ6fbpyfB3doG8kfGdGpXIL8ZTqG7nKAM11o/db7Sr6C9qwsywP0G40f/HDPFQ
         0jRhTvVL1FdNcju+vU1xJ1v3fv+6GzAChWQw1MAjw5706TL0sy9aluQ+yH54+eOiLoeg
         cwEFL95bZ56oDR+dQ/0whcGLs+YdR0pX6SHax62KVHyM6sQdXUR2stTxmg4EhnuADzM3
         4bxzfdL6zkrGo6gvaTH4hOdbwcFc7Ih1zIUg6xnmO2V93DN2rtaPtSwjm8ls5UtJVK+M
         /Orw==
X-Forwarded-Encrypted: i=1; AJvYcCX8LxoQbw5WKUx+sddN2+lXeyZk8B/jgaLN0/Gw5yxn21Je4nePKkWHjZUSrwEALLkeqlDDCY+QKrve5P5mJBQeHxZTg8RC0WaxnfgA
X-Gm-Message-State: AOJu0Yz/O/KgB/5H6SQtdB4ndLE6RV8AIcZmk31QqcSpiCO0n3ik4cpO
	ueQ2xE6IOmobl8ySc+u3SLoG1lL8IpB5d3AgnohS1/H64VfnpVuMS0iE3MSA3y1ctkO26NVrX25
	M3Ad7Z7te+D9rvS3hL0TEIkiWJexAQ+2ZcnA9U190DqSP1rQFm7jByMjpTlG1Hw==
X-Received: by 2002:a17:906:a44d:b0:a3d:9a28:52e6 with SMTP id cb13-20020a170906a44d00b00a3d9a2852e6mr4010968ejb.50.1708936274467;
        Mon, 26 Feb 2024 00:31:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkiK6ZRARULAZlIUD5UEKkd5/oLyZp7eTkoe/Z67A7OQ0GXsH51rC970dStdoLZ85YatD2eQ==
X-Received: by 2002:a17:906:a44d:b0:a3d:9a28:52e6 with SMTP id cb13-20020a170906a44d00b00a3d9a2852e6mr4010953ejb.50.1708936274154;
        Mon, 26 Feb 2024 00:31:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-148.retail.telecomitalia.it. [87.11.6.148])
        by smtp.gmail.com with ESMTPSA id vk3-20020a170907cbc300b00a42fe08081fsm1874734ejc.47.2024.02.26.00.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:31:13 -0800 (PST)
Date: Mon, 26 Feb 2024 09:31:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, 
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>
Subject: Re: [PATCH net-next 2/2] net/vsockmon: Do not set zeroed statistics
Message-ID: <rqyg27a7ukbrg7wz44jqliv3ckl6ub6fnpdcpxsutw3yyczajm@iqzvhw4rqdy6>
References: <20240223115839.3572852-1-leitao@debian.org>
 <20240223115839.3572852-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240223115839.3572852-2-leitao@debian.org>

On Fri, Feb 23, 2024 at 03:58:38AM -0800, Breno Leitao wrote:
>Do not set rtnl_link_stats64 fields to zero, since they are zeroed
>before ops->ndo_get_stats64 is called in core dev_get_stats() function.
>
>Signed-off-by: Breno Leitao <leitao@debian.org>
>---
> drivers/net/vsockmon.c | 3 ---
> 1 file changed, 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
>index a0b4dca36baf..a1ba5169ed5d 100644
>--- a/drivers/net/vsockmon.c
>+++ b/drivers/net/vsockmon.c
>@@ -46,9 +46,6 @@ static void
> vsockmon_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
> {
> 	dev_lstats_read(dev, &stats->rx_packets, &stats->rx_bytes);
>-
>-	stats->tx_packets = 0;
>-	stats->tx_bytes = 0;
> }
>
> static int vsockmon_is_valid_mtu(int new_mtu)
>-- 
>2.39.3
>


