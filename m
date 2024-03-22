Return-Path: <linux-kernel+bounces-111244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9BB88699F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354251F23113
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B6922071;
	Fri, 22 Mar 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEOnLOmo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1C199AD;
	Fri, 22 Mar 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100823; cv=none; b=uuyKCktrVGYLZQ8u42inrNiI7iWpX6WZQ4W4lDuT/NM1no8SGm34CPUmsc6JvDLH88cLDo9zWAuuzstS+5X0XanR0+JR7/5daiFWgBY5YMnfrDKf0N6iIt11Y8YunQwCiq9WNdh0uWFcq7xEttuH4gyrN9h2vU1+/x0SM1DksxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100823; c=relaxed/simple;
	bh=zabJxPlninDt65Iq+ECJg2VKmpOfXONRQOUs6RgBIhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnsA7wq0SSzplD6TImNAbODqpla7dTwINHe5XCpPWamiCMfF8cKhDaUVoCS739ZI/N2/34fmfh2pPjWCQXTEdqMtlC/x0OuXgBkf2nenE3Tzmu2uHeBW891iT3evHdpwDgO+mus5e/3ENHocX8Kn4Tg4dvSZXV6VChczWV08+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEOnLOmo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711100821; x=1742636821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zabJxPlninDt65Iq+ECJg2VKmpOfXONRQOUs6RgBIhk=;
  b=MEOnLOmoARSe0ysprwcM4UzBCV2u6aK3HYgKdtLgTL10VNNtxD5ACASE
   gdICyM/90RlfKIJOa0G4/5MyRXtpNvCiIH1W0ctsJo+OCOChPXqYaTk+O
   TsivNBpRWz6HpBhbP0csK5Xy0qrNulAfzta9p4NRNldXXJ5TiO6F8kNRA
   0RspYVXtyr4FPutFeEI/Lpln4+QB0UxCcZ8FFvtjR8vVJXjBLXrBNtjij
   gHBDtNDcFOpRbL2xUDH0UIbA3pUyM9NBNCHG7XUYbXxddD6+gZ80cbz6A
   y4NlMP9xwfhdCS2vxNQv2/NPkDRqP3AImYX7mO8L2JUoQrUzhHy2Pmeex
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="16868940"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="16868940"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 02:47:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="937066502"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="937066502"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Mar 2024 02:46:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 22 Mar 2024 11:46:57 +0200
Date: Fri, 22 Mar 2024 11:46:57 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Grigory Bazilevich <bazilevich@sicamp.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xin Ji <xji@analogixsemi.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: typec: anx7411: Fix possible buffer overflow in
 anx7411_send_msg()
Message-ID: <Zf1TkQVipUYhstRZ@kuha.fi.intel.com>
References: <20240316203354.81591-1-bazilevich@sicamp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240316203354.81591-1-bazilevich@sicamp.ru>

On Sat, Mar 16, 2024 at 11:33:53PM +0300, Grigory Bazilevich wrote:
> Passing a size argument greater than or equal to MAX_BUF_LEN causes
> a buffer overflow when the checksum is written.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
> Signed-off-by: Grigory Bazilevich <bazilevich@sicamp.ru>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/anx7411.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index b12a07edc71b..70ba56dfb22b 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -733,7 +733,7 @@ static int anx7411_send_msg(struct anx7411_data *ctx, u8 type, u8 *buf, u8 size)
>  	u8 crc;
>  	int ret;
>  
> -	size = min_t(u8, size, (u8)MAX_BUF_LEN);
> +	size = min_t(u8, size, (u8)(MAX_BUF_LEN - 1));
>  	memcpy(msg->buf, buf, size);
>  	msg->msg_type = type;
>  	/* msg len equals buffer length + msg_type */
> -- 
> 2.39.2

-- 
heikki

