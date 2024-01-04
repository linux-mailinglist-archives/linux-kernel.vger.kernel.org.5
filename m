Return-Path: <linux-kernel+bounces-16854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7528244F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEF91F2337C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64BB24209;
	Thu,  4 Jan 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nu1g4vhY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6342233B;
	Thu,  4 Jan 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704382089; x=1735918089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VRf3reILjU1dadO0ad0fDQYzknoLukV/96lMq1a8yjE=;
  b=Nu1g4vhYnZ+zM62zgXHeg6gMYHy3ETGqwZEOe+TwwNW8P5Wse7YSyvip
   NRXKTzh/ccIOyETvScyvalWpPFo0zGMIXjtgHiGl4VjwvMRNrwIFjutBn
   KLltRlhCZdW/43b+qEiwIuPuAugrWZ/mwwELAMZ5sqhvtOE+uDFgu5Xx8
   +KbVM/OVtxqw2KxcsTciWk2roKOpQAYPJvsk0npY89k7fyF6IHtqaO3RN
   5ItP2OV/qemipAN+G2bVSjljPue39Pv6ixjQfGIZX/DKfcqrF2aVxI+43
   O455fOaBM8bxB83gQTcAe4/ZCjN1Pgk281DpUF96Gri2vt7fw4vbw4LyF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="428440877"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="428440877"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 07:27:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1111795355"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="1111795355"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga005.fm.intel.com with SMTP; 04 Jan 2024 07:27:35 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 04 Jan 2024 17:27:34 +0200
Date: Thu, 4 Jan 2024 17:27:34 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: lk@c--e.de, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: typec: class: fix typec_altmode_put_partner to
 put plugs
Message-ID: <ZZbGXa0mVAlmy1Ix@kuha.fi.intel.com>
References: <20240103181754.2492492-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103181754.2492492-2-rdbabiera@google.com>

On Wed, Jan 03, 2024 at 06:17:55PM +0000, RD Babiera wrote:
> When typec_altmode_put_partner is called by a plug altmode upon release,
> the port altmode the plug belongs to will not remove its reference to the
> plug. The check to see if the altmode being released is a plug evaluates
> against the released altmode's partner instead of the calling altmode, so
> change adev in typec_altmode_put_partner to properly refer to the altmode
> being released.
> 
> Because typec_altmode_set_partner calls get_device() on the port altmode,
> add partner_adev that points to the port altmode in typec_put_partner to
> call put_device() on. typec_altmode_set_partner is not called for port
> altmodes, so add a check in typec_altmode_release to prevent
> typec_altmode_put_partner() calls on port altmode release.
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> Cc: stable@vger.kernel.org
> Co-developed-by: Christian A. Ehrhardt <lk@c--e.de>
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v3:
> * added partner_adev to properly put_device() on port altmode.
> ---
>  drivers/usb/typec/class.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 4d11f2b536fa..015aa9253353 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -263,11 +263,13 @@ static void typec_altmode_put_partner(struct altmode *altmode)
>  {
>  	struct altmode *partner = altmode->partner;
>  	struct typec_altmode *adev;
> +	struct typec_altmode *partner_adev;
>  
>  	if (!partner)
>  		return;
>  
> -	adev = &partner->adev;
> +	adev = &altmode->adev;
> +	partner_adev = &partner->adev;
>  
>  	if (is_typec_plug(adev->dev.parent)) {
>  		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
> @@ -276,7 +278,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
>  	} else {
>  		partner->partner = NULL;
>  	}
> -	put_device(&adev->dev);
> +	put_device(&partner_adev->dev);
>  }
>  
>  /**
> @@ -497,7 +499,8 @@ static void typec_altmode_release(struct device *dev)
>  {
>  	struct altmode *alt = to_altmode(to_typec_altmode(dev));
>  
> -	typec_altmode_put_partner(alt);
> +	if (!is_typec_port(dev->parent))
> +		typec_altmode_put_partner(alt);
>  
>  	altmode_id_remove(alt->adev.dev.parent, alt->id);
>  	kfree(alt);
> 
> base-commit: e7d3b9f28654dbfce7e09f8028210489adaf6a33
> -- 
> 2.43.0.472.g3155946c3a-goog

-- 
heikki

