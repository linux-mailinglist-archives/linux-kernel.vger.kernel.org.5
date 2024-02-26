Return-Path: <linux-kernel+bounces-80757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 056DA866C25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708E81F21D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA751CD3A;
	Mon, 26 Feb 2024 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/3QGtvt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982E61CAB7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936035; cv=none; b=S7vr6GSJyf79aLgsX8Z2rjTV1LwmdCklC8G1AFwj+IqlNe9RJK5zQ5XWUAbbELCWX7VwwRrfqPfehONS6rIYx8fZ2d8tRYx1eb0bJBus4F+aSK5y6DCQNwEqxSiGgqSPkfisC2ygTPfYxfsxSZSrOzDcmV7fgt2I63+UC+tFE6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936035; c=relaxed/simple;
	bh=REK+VNCXI3WjyjsuKl+HSXiJRNqvxmX5KAPsA/J1Roo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc/bC5u2RoF6V3MZM3UmA37dQBkXGlGHXMiElroLXW2yGsMGzngpU0xsH6OaOYz4KKb7Iga7xgkRE90/+F4ijtxphSo09Hv+H+Uc2u1YKsfZOfAuOiLL8lf/pV/yyZBKNevIw+N4WGGHT+uHJPDcoXfZba56xIhULR1+9kC4YSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/3QGtvt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708936031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGkEjPkjWA9B4Ml20UNQYktxGpIUURUmKif/cYqIu08=;
	b=F/3QGtvtM1I2iFggDWwHePEnpi8MX4ZOtDb040D5cI7zMeZ2v1X/MClnAdidp0L7Q9iiL3
	rDqkvRJSor4cNtBHyhfl5tB4QuBXkHWglqtd5p++b9c75ZDMpBSmd/EyJSHqS0WJ6Gez5y
	x/48822dX1tiUY1GI9e27dEC14q1aww=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-hUMJ_eIpOwShCEc_53iP4g-1; Mon, 26 Feb 2024 03:27:09 -0500
X-MC-Unique: hUMJ_eIpOwShCEc_53iP4g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-559391de41bso2459174a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936028; x=1709540828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGkEjPkjWA9B4Ml20UNQYktxGpIUURUmKif/cYqIu08=;
        b=lrbagD1LApxWZ/RE2CB/V2qRFZbMX043628a6JbwEafyslBdfrO/G3jX53yh9KH7E+
         Q4W7UtxRlIbr1mPUnj3sCYQeZrj+y9UBkAlxT7nE7YIucfHadBOnFjoxjA2y1M7fplgG
         yPcVy+5ifBEPztTNXbwnK+bH6bNrhJV98HzI12VWTI1K/LczgEx82MGiafpfA5B2y6uV
         LuSkDHNnwFd5TynDc6NNYSLFodt5X2AHaOHRaSFA2dzZHWgxHSOLvgzxzlXbOyAis5iy
         FtBFAlBoTFX45nqWoE348yXgpX84+F4ujJ2tTEp4aGtifSkFrFCnkN71OFcWsI4xnPdy
         FTFg==
X-Forwarded-Encrypted: i=1; AJvYcCURFaT7+kszZSDHaY5T/OMw32m5PIQ73PO3Un4AKJXSpEN94nfsYgrVYk9o7Nas/YFKX+yOhR8CfQ+io7x4MM6j2IlAcYTrGzSX5CH5
X-Gm-Message-State: AOJu0Yxmza3Iwktsya3bMG9UpPKoq+UzOOsPiEZZxVDxNjcKPzkReH4o
	Fkq3kZyqoAQ/9ltQdO/UCHy0EYvsWkizAwygZOwzYVpit7eAPZHLFus61oSWRqWbffjoTbiBbX/
	BRWHWKPQOxDMD88r86iuYlf/pzCRH1h0zc86N2fOTAsQL3PBHt0AD143IJE9A9g==
X-Received: by 2002:a05:6402:1487:b0:565:7ce5:abd5 with SMTP id e7-20020a056402148700b005657ce5abd5mr3814990edv.18.1708936027997;
        Mon, 26 Feb 2024 00:27:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs8Tjqo0VpOsvxWN6d4PjBqkrrs6LEUpm+NGUAUsWf2FRaOQEeC4y6T0kpK+5Rwd2wg9QwJA==
X-Received: by 2002:a05:6402:1487:b0:565:7ce5:abd5 with SMTP id e7-20020a056402148700b005657ce5abd5mr3814973edv.18.1708936027632;
        Mon, 26 Feb 2024 00:27:07 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-148.retail.telecomitalia.it. [87.11.6.148])
        by smtp.gmail.com with ESMTPSA id k1-20020a05640212c100b005653fe3f180sm2105105edx.70.2024.02.26.00.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:27:06 -0800 (PST)
Date: Mon, 26 Feb 2024 09:27:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, 
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>
Subject: Re: [PATCH net-next 1/2] net/vsockmon: Leverage core stats allocator
Message-ID: <nrphi5hjfgpzhkfjsvskxhis6uqc3ham6u5x3c5imw2slkombb@phutaqxg23io>
References: <20240223115839.3572852-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240223115839.3572852-1-leitao@debian.org>

On Fri, Feb 23, 2024 at 03:58:37AM -0800, Breno Leitao wrote:
>With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
>convert veth & vrf"), stats allocation could be done on net core
>instead of this driver.
>
>With this new approach, the driver doesn't have to bother with error
>handling (allocation failure checking, making sure free happens in the
>right spot, etc). This is core responsibility now.
>
>Remove the allocation in the vsockmon driver and leverage the network
>core allocation instead.
>
>Signed-off-by: Breno Leitao <leitao@debian.org>
>---
> drivers/net/vsockmon.c | 16 +---------------
> 1 file changed, 1 insertion(+), 15 deletions(-)

Thanks for this patch!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
>index b1bb1b04b664..a0b4dca36baf 100644
>--- a/drivers/net/vsockmon.c
>+++ b/drivers/net/vsockmon.c
>@@ -13,19 +13,6 @@
> #define DEFAULT_MTU (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + \
> 		     sizeof(struct af_vsockmon_hdr))
>
>-static int vsockmon_dev_init(struct net_device *dev)
>-{
>-	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
>-	if (!dev->lstats)
>-		return -ENOMEM;
>-	return 0;
>-}
>-
>-static void vsockmon_dev_uninit(struct net_device *dev)
>-{
>-	free_percpu(dev->lstats);
>-}
>-
> struct vsockmon {
> 	struct vsock_tap vt;
> };
>@@ -79,8 +66,6 @@ static int vsockmon_change_mtu(struct net_device *dev, int new_mtu)
> }
>
> static const struct net_device_ops vsockmon_ops = {
>-	.ndo_init = vsockmon_dev_init,
>-	.ndo_uninit = vsockmon_dev_uninit,
> 	.ndo_open = vsockmon_open,
> 	.ndo_stop = vsockmon_close,
> 	.ndo_start_xmit = vsockmon_xmit,
>@@ -112,6 +97,7 @@ static void vsockmon_setup(struct net_device *dev)
> 	dev->flags = IFF_NOARP;
>
> 	dev->mtu = DEFAULT_MTU;
>+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
> }
>
> static struct rtnl_link_ops vsockmon_link_ops __read_mostly = {
>-- 
>2.39.3
>


