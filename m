Return-Path: <linux-kernel+bounces-58193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE1084E290
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C48229118B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCE77869D;
	Thu,  8 Feb 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHhLjtj2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7157D41F;
	Thu,  8 Feb 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400389; cv=none; b=P6K098ZoVSr0XQLjik6csn1magBG0Fls3LEwl2rsXOMvoCb+L94ZbQz42OAF+BHt02IN4mDRj5/yj6EtOhmsIQRfBwqsRVh7aIq4prn+Nvn70KemY07duq7GhvHg5K9ef9SVXsJX2PPu7UCAmAqUun1zGDSbKYrjSiSsHGxBUtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400389; c=relaxed/simple;
	bh=hmXHpXwIBBF6KpV1XzdkD8LH/WZiO4oxEaDM9Yg5alg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IkpBbHASU/cgz0IZps6G6jsK5OdDKFOkbdRPlDRH5mF5SzEasv4L899D7x9IM3VsSyuKGnVeWfiFFu70Zs1AkDrGcYtLozRmZLIVs6dADO6+wVgO2PPOMudfqZuzDlCltQt5jgcAgLwq6mJWdo8hS69p5jUNkLTFvLjnbRKAf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHhLjtj2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707400388; x=1738936388;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hmXHpXwIBBF6KpV1XzdkD8LH/WZiO4oxEaDM9Yg5alg=;
  b=PHhLjtj2nMishLFevut7xp1SYLxKjY51YgPJ+MXqDUQpi6BNa/GTM/V0
   w0xpq5OUBl3RqEb0zGw0CGujsTxtTUeEYYYuzlus47Jw2egjdBoCfp8/3
   94bQLNR6eChaB9t3QwCaRRMtmSNp2h28nqpmTP1eAJufZZikgh0u5+cBq
   HOD+IUzpi3gFLzMg9H2GbK/SFjBWGiAfn5JsC4je7yd6HZmMXpq706lGr
   NTRsEmY5HDu2hnFhGR6mS+dnRL+RZSoY7pTWCg7xTFYy6HMHv3l7TSsBG
   UHx+ko82WBmiyLOQYRpNM1ePFRxe9ymUwn8+U/cosopYaaHTREeBRo84r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="26662698"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="26662698"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1694872"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:53:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Feb 2024 15:52:59 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Netdev <netdev@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 5/8] platform/x86/intel/sdsi: Add in-band BIOS lock
 support
In-Reply-To: <20240201010747.471141-6-david.e.box@linux.intel.com>
Message-ID: <4135a390-22c9-f483-2aca-b89439dc682c@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com> <20240201010747.471141-6-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 31 Jan 2024, David E. Box wrote:

> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per SDSi in-band interface specification, sec titled "BIOS lock for
> in-band provisioning", when IB_LOCK bit is set in control qword, the
> SDSI agent is only allowed to perform the read flow, but not allowed to
> provision license blob or license key. So add check for it in
> sdsi_provision().
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/sdsi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
> index 14821fee249c..287780fe65bb 100644
> --- a/drivers/platform/x86/intel/sdsi.c
> +++ b/drivers/platform/x86/intel/sdsi.c
> @@ -61,6 +61,7 @@
>  #define CTRL_OWNER			GENMASK(5, 4)
>  #define CTRL_COMPLETE			BIT(6)
>  #define CTRL_READY			BIT(7)
> +#define CTRL_INBAND_LOCK		BIT(32)
>  #define CTRL_STATUS			GENMASK(15, 8)
>  #define CTRL_PACKET_SIZE		GENMASK(31, 16)
>  #define CTRL_MSG_SIZE			GENMASK(63, 48)
> @@ -331,12 +332,21 @@ static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, s
>  	return sdsi_mbox_cmd_read(priv, info, data_size);
>  }
>  
> +static bool sdsi_ib_locked(struct sdsi_priv *priv)
> +{
> +	return !!FIELD_GET(CTRL_INBAND_LOCK, readq(priv->control_addr));
> +}
> +
>  static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
>  			      enum sdsi_command command)
>  {
>  	struct sdsi_mbox_info info = {};
>  	int ret;
>  
> +	/* Make sure In-band lock is not set */
> +	if (sdsi_ib_locked(priv))
> +		return -EPERM;
> +
>  	if (count > (SDSI_SIZE_WRITE_MSG - SDSI_SIZE_CMD))
>  		return -EOVERFLOW;

Any reason why this order was chosen? I'd prefer these checks be other way 
around (a stupid caller providing too long count gets notified of its 
stupidity regardless of the locked state).

-- 
 i.


