Return-Path: <linux-kernel+bounces-80690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18F0866B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBDB285FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7F01C280;
	Mon, 26 Feb 2024 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etGaf4uA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5151BF37;
	Mon, 26 Feb 2024 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933700; cv=none; b=dTlY5cu7bfqzTgFKrH3IeJp1eUjufMQ1oI6BANz4vgHG106TNokpXjlyVso8O7u25OlLWYbeqgIybLtCry9X7uhW137ZHcMz5pyRKGxB3DJ3UAdb+MNioGJ8VufXfFCj2bQqpNyr8+B+gDi4ctjPDg99tJ/f/rW13iOr6QAoS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933700; c=relaxed/simple;
	bh=YskQDqRYulrxgcJz1QYPkqijA0rMI2I1ULyE9kL6McA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG3H7e8Hs8RiRDWJwOufkyIwhpg2op6DRnUfrbGFddEmYw2i7OW0vWzh4tgMMzjF3WIdpbZ/YKdE3tA5p/80s6eM2TH8mSEFtDySHWMb8TObO2K/z8/epYBO7Jpi76+6TD+KDgefJr1fSlYFRs/dEe/qsicdplQkCrHCR+8rmgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etGaf4uA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708933699; x=1740469699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YskQDqRYulrxgcJz1QYPkqijA0rMI2I1ULyE9kL6McA=;
  b=etGaf4uAMSLe/4XWXzJAfhiyDeuriP6QZdb5G2mnXaW7VuECEVUxMVku
   /f6O4rWrp+EYhdBMTlccZl6H5VK882gLklLl64Gf1jnqoffvA3UggSj58
   ZWPXwm2rbZgqTpvFJE07CR6sK4KBixKW5PCgtIfwtEqkkBZkKE95ns34p
   4KQR+XprjMTTMkVu0EkYtIOSRXvidilX/SKhjukFSUbw30leUSHk3ahB+
   qiyZ5v3wFaqs6qfa6yQCvP9Q8yAHa3wMnh8Ey7CIfSgU163m9UK67yOdQ
   BIfNJ2jaLeu/ubOyky5z4rybjImDYalpPliCEOCB/r3OUaRuFKNowsPR+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14334338"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14334338"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 23:48:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029441"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029441"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 25 Feb 2024 23:48:14 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 09:48:14 +0200
Date: Mon, 26 Feb 2024 09:48:14 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	"open list:USB TYPEC PORT CONTROLLER DRIVERS" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] Revert "usb: typec: tcpm: reset counter when enter into
 unattached state after try role"
Message-ID: <ZdxCPn6ulER0OjC1@kuha.fi.intel.com>
References: <20240217162023.1719738-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240217162023.1719738-1-megi@xff.cz>

On Sat, Feb 17, 2024 at 05:20:21PM +0100, Ondřej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
> 
> The reverted commit makes the state machine only ever go from SRC_ATTACH_WAIT
> to SNK_TRY in endless loop when toggling. After revert it goes to SRC_ATTACHED
> after initially trying SNK_TRY earlier, as it should for toggling to ever detect
> the power source mode and the port is again able to provide power to attached
> power sinks.
> 
> This reverts commit 2d6d80127006ae3da26b1f21a65eccf957f2d1e5.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2d6d80127006 ("usb: typec: tcpm: reset counter when enter into unattached state after try role")
> Signed-of-by: Ondrej Jirman <megi@xff.cz>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> See https://lore.kernel.org/all/odggrbbgjpardze76qiv57mw6tllisyu5sbrta37iadjzwamcv@qr3ubwnlzqqt/
> for more.
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index f7d7daa60c8d..295ae7eb912c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3743,9 +3743,6 @@ static void tcpm_detach(struct tcpm_port *port)
>  	if (tcpm_port_is_disconnected(port))
>  		port->hard_reset_count = 0;
>  
> -	port->try_src_count = 0;
> -	port->try_snk_count = 0;
> -
>  	if (!port->attached)
>  		return;
>  
> -- 
> 2.43.0

-- 
heikki

