Return-Path: <linux-kernel+bounces-56026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67884C516
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C764A2884CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269061CF95;
	Wed,  7 Feb 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4fEAf4k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244E1CD30
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288204; cv=none; b=HabAsfnMv5wwJ6NkLyM1oElIg0wev3SCcBpEGB4Kaa7G/5i2X5q1Pwf6RJ6xC2FXQVvGClciXBZB5uwK7pllo5eDZTwGAyP9nM9RSWtmWUGP5UBfWVMWO6ilrU3ybxHIjwO1IX0gu+7+efFkS12wqNPtjUQ+F17dYyIcBe12PEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288204; c=relaxed/simple;
	bh=Q+Syr8uWq4Bq9a8aaQxkFdYoFqJmdNHkFFakLvaozYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4foKb/KAA4EaL40H1LhTNtD7HKGRQnjDirE2jtP4Eyc+qe9T+qNdWOm8MmjiJ2LLAter7b+fGcX5vDDPiTZnVWJ5GdhIMitdO8wFvzEmtkOOhgTHQoIKW2aj4By+63YPoCtrLORfhppYoxMC31gl/UqgNV1VHcBii06i79WaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4fEAf4k; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707288201; x=1738824201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q+Syr8uWq4Bq9a8aaQxkFdYoFqJmdNHkFFakLvaozYw=;
  b=M4fEAf4kyR+Pfu9ebnsxUzBJPj71qsJJuZsny8esWqFoVm4Ind1NV4t+
   Rz0hYyvJnt7XDQUY28ZG8jWhvwyZo4IAbrvUFXK7+bWZ7QUxynv9zWFQg
   iJui0u7FTrejzRDnk2Nbv404sGCIuf5x5VQ7vuLE8H24x50YgicyWCrYm
   AhjmD/CnK6rn3w8+XWxko6NW3nD+QXW4wTY/nKjq82YIQdgtEdK/bOOiQ
   3bIeAdo3DbrUWVwdTP+rFaDzisIkP7XtSdLhghdDI9/o8PNzcAvTpvius
   /X1jcfNnQjlEAOKkOyppUlGBsZaE/AFUfVqw4Wx7KbCHw/7/jg5wysYpB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4735683"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="4735683"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 22:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="824414451"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="824414451"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 22:43:18 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A52A611F89A;
	Wed,  7 Feb 2024 08:43:15 +0200 (EET)
Date: Wed, 7 Feb 2024 06:43:15 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Wentong Wu <wentong.wu@intel.com>
Cc: gregkh@linuxfoundation.org, tomas.winkler@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: Add Meteor Lake support for IVSC device
Message-ID: <ZcMmg1f8975whpno@kekkonen.localdomain>
References: <20240207004304.31862-1-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207004304.31862-1-wentong.wu@intel.com>

On Wed, Feb 07, 2024 at 08:43:04AM +0800, Wentong Wu wrote:
> Add IVSC device support on Meteor Lake platform.
> 
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
>  drivers/misc/mei/vsc-tp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
> index 6f4a4be6ccb5..55f7db490d3b 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -535,6 +535,7 @@ static const struct acpi_device_id vsc_tp_acpi_ids[] = {
>  	{ "INTC1009" }, /* Raptor Lake */
>  	{ "INTC1058" }, /* Tiger Lake */
>  	{ "INTC1094" }, /* Alder Lake */
> +	{ "INTC10D0" }, /* Meteor Lake */
>  	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, vsc_tp_acpi_ids);

-- 
Sakari Ailus

