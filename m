Return-Path: <linux-kernel+bounces-58161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0240D84E215
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A301F2377C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932FF6F097;
	Thu,  8 Feb 2024 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ro5S3DMY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F116776418;
	Thu,  8 Feb 2024 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399489; cv=none; b=QsggaMKfDdGoT6H+Cn8ERwqHK3UQ7lgOil7ILm2zEMWvH0nm/IEjv2r3jd5edBDh11qUHmbttkAIpfmp8DN9p6bhaj3/oGkL51vLX1BnrmvNgZcHFJCEVSEkFO10L97kPUaPb3vB4jUbnr7JU0+z89/MC+TiTydAdY7yj1IA3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399489; c=relaxed/simple;
	bh=jw39fEdEP2aNbkYoy9T3GNQq4OS2fFirdRfXrG9yQG4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kmZAF7jPLguWafGyus9Dd5OrPO11Pns06b9AhJOSfsRniNcDX53LB0u6I1Zu8Sbk0fWMNZCkFS91MJ68ju7XK45l3NKz3XkDVyb0HsfNiTCKishMncl5i3Nv3kFhJtK6ELlrzLmWMQROYVmwACfWNKHatx5qor6kR0zIEldsPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ro5S3DMY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707399488; x=1738935488;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jw39fEdEP2aNbkYoy9T3GNQq4OS2fFirdRfXrG9yQG4=;
  b=Ro5S3DMYSb/NgjuenzbZKRWXpQJma8940oV4TxX0gnYj2KrX1K/0Kp70
   l1ZxYhNAygrIJ2wOYhibLR5bzE3hnFICjFyZFDSrHYIM4YTRh6Uggkm81
   vQ86Gcgc49UR+I0KbsfRrFdT9u72TxQTkxGXUV2cVBw4LANA8m1+7eVbq
   71dJ7WotiFeRL6uQzk2VTw2c8cGzOZRd8RT9gzRS39LXBHDxokblWWacq
   Dphhl1EnPBbWgy+Up8LvQRU4JLuLG4brnH5Mi0+f3GDSgtG1AfAK3CxlW
   NRWLCypiVYvM0Ua3Cddxc1tO1jjxxPtAFyi7lkPA1sr0xM4Wg9EKmumW4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="26660912"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="26660912"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:38:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1889294"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:38:05 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Feb 2024 15:38:01 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Netdev <netdev@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/8] platform/x86/intel/sdsi: Combine read and write
 mailbox flows
In-Reply-To: <20240201010747.471141-3-david.e.box@linux.intel.com>
Message-ID: <bc0fbe53-3eeb-26cb-ba91-c5fc238cb1b8@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com> <20240201010747.471141-3-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 31 Jan 2024, David E. Box wrote:

> The current mailbox commands are either read-only or write-only and the
> flow is different for each. New commands will need to send and receive
> data. In preparation for these commands, create a common polling function
> to handle sending data and receiving in the same transaction.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/sdsi.c | 79 +++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index a70c071de6e2..05a35f2f85b6 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -15,6 +15,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> @@ -156,8 +157,8 @@ static int sdsi_status_to_errno(u32 status)
>  	}
>  }
>  
> -static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
> -			      size_t *data_size)
> +static int sdsi_mbox_poll(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
> +			  size_t *data_size)
>  {
>  	struct device *dev = priv->dev;
>  	u32 total, loop, eom, status, message_size;
> @@ -166,18 +167,10 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
>  
>  	lockdep_assert_held(&priv->mb_lock);
>  
> -	/* Format and send the read command */
> -	control = FIELD_PREP(CTRL_EOM, 1) |
> -		  FIELD_PREP(CTRL_SOM, 1) |
> -		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
> -		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
> -	writeq(control, priv->control_addr);
> -
>  	/* For reads, data sizes that are larger than the mailbox size are read in packets. */
>  	total = 0;
>  	loop = 0;
>  	do {
> -		void *buf = info->buffer + (SDSI_SIZE_MAILBOX * loop);
>  		u32 packet_size;
>  
>  		/* Poll on ready bit */
> @@ -195,6 +188,11 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
>  		if (ret)
>  			break;
>  
> +		if (!packet_size) {
> +			sdsi_complete_transaction(priv);
> +			break;
> +		}
> +
>  		/* Only the last packet can be less than the mailbox size. */
>  		if (!eom && packet_size != SDSI_SIZE_MAILBOX) {
>  			dev_err(dev, "Invalid packet size\n");
> @@ -208,9 +206,13 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
>  			break;
>  		}
>  
> -		sdsi_memcpy64_fromio(buf, priv->mbox_addr, round_up(packet_size, SDSI_SIZE_CMD));
> +		if (packet_size && info->buffer) {

Why you check for packet_size here if you break earlier for !packet_size?

> +			void *buf = info->buffer + array_size(SDSI_SIZE_MAILBOX, loop);
>  
> -		total += packet_size;
> +			sdsi_memcpy64_fromio(buf, priv->mbox_addr,
> +					     round_up(packet_size, SDSI_SIZE_CMD));
> +			total += packet_size;
> +		}
>  
>  		sdsi_complete_transaction(priv);
>  	} while (!eom && ++loop < MBOX_MAX_PACKETS);
> @@ -230,16 +232,33 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
>  		dev_warn(dev, "Read count %u differs from expected count %u\n",
>  			 total, message_size);
>  
> -	*data_size = total;
> +	if (data_size)
> +		*data_size = total;
>  
>  	return 0;
>  }


-- 
 i.


