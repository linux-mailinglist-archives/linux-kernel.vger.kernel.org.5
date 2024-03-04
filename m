Return-Path: <linux-kernel+bounces-90656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE28E8702CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642491F21BF0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032743E479;
	Mon,  4 Mar 2024 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNR0wkBb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23803D547;
	Mon,  4 Mar 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559156; cv=none; b=sDZol/Vg+sJhvpD9lCzP1iQCAjqpZ+2U0HE80Z1TNx0ULN7D6sMWViT2liogBfkrXoucDbXoGlQPgtQrPx/KX3ZjxnYlOZOlkKSHshA+Hga2Y8x4yUO3RV/uOGJh7aSqCX64hR+hyUImiwwGpYxiBahhjS0QvCOcVzQUi09hzWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559156; c=relaxed/simple;
	bh=c/KR/E9NfIhGK+pa7H0FWfMiLStdrf4Xzr9vO8PwAtw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dwHzLxy9MPDoxhm6KQ3h9mum8K+uooZnIvzImcZKDBFywLcAHkIzdghxwHt61K/IVvT0zOsQDISsnAfGp2fSoZtwL+ASt8gKTuN6NhkCz13OuhWP42COZGSuHwu1nIsqwBvm46lcszVhcNqSbVIZVcptnwv8prjUfy89xhfKJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNR0wkBb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709559154; x=1741095154;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=c/KR/E9NfIhGK+pa7H0FWfMiLStdrf4Xzr9vO8PwAtw=;
  b=NNR0wkBbNqxL2VOp21MDQ52bPJ0nAlr4/+EnkcG23RAChq80ruqbRJJ5
   sys+o7sDr1j6IvJYFugTRV0bmFGuMA/pQDCMiJ+NwhML7NYAsVNgkmkjg
   KhpILRoXDJnuaaNz4DcUN84Y47QpRjmS6GQlG7vfulnzegVkHZO8lnYn8
   2Uy+mMeQZntrSMjUl1UVgaVgOYeuslTFvWPFucPnumklXxvw2MBzBiiXN
   mPL19T/JgpmWT0GVIzgwG3JhEJvFHGvR7NY0d+nW3XAEDyLL0+yhXiDK4
   bYC3q9TiTX1vwTQ9k03PJ4Ekhz87oDu/rENycCFX984wL6PsL6/dQjnG/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4215132"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4215132"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:32:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13657745"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:32:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 4 Mar 2024 15:32:26 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH V2 7/9] tools/arch/x86/intel_sdsi: Fix meter_certificate
 decoding
In-Reply-To: <20240228000016.1685518-8-david.e.box@linux.intel.com>
Message-ID: <ee95700a-35ba-9601-3c2e-0e19185ef4c0@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com> <20240228000016.1685518-8-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Feb 2024, David E. Box wrote:

> Fix errors in the calculation of the start position of the counters and in
> the display loop.
> 
> Fixes: aad129780bae ("platform/x86/intel/sdsi: Add support for reading the current meter state")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> 
> V2 - Split of V1 patch 7
> 
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index def1b9a01738..2acc6be5f5d6 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -403,15 +403,16 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  		return -1;
>  	}
>  
> -	bec = (void *)(mc) + sizeof(mc);
> +	bec = (void *)(mc) + sizeof(*mc);
>  
>  	printf("Number of Feature Counters:   %d\n", mc->bundle_length / 8);
> -	while (count++ < mc->bundle_length / 8) {
> +	while (count < mc->bundle_length / 8) {

One more sizeof() case here that wasn't pointed up earlier.


-- 
 i.


