Return-Path: <linux-kernel+bounces-86638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845AD86C82A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D981F23E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB07C0AC;
	Thu, 29 Feb 2024 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c442Ll3h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E967AE42;
	Thu, 29 Feb 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206658; cv=none; b=DUt/KnXR6VuMfFkQn86pXvEKbnhBDKSH/xHhtiFSB54ZlD9bGPt2nRao0JMQSJUb+1OyG0YMq0kXAo9Q4TCvn9STxNXx7lFefd0cDEETSleUy2QS+h1O/RVfB5ZI7ys2E3dQ2TpGtXYSRw/OpMCqEOcnMlhMzPcIEOfH6C0piV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206658; c=relaxed/simple;
	bh=B/wC9Nv9xuurKleWZRbMqkITXw/FjjRt0kr5rzQsZ7U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EMvZzPDprCooGHBgg2r3x7TXvjIxzmFT75v1woVhMJSI1VKACc5zpYb4F/e6yvRKJf2CmATRxP6vgxSmswVJa8KdRxMfkKfRIjbGTEhwitJE/6xU5XeobfZJWaPIam3rRBsCBnNCR50vE2UqpGUbmBHx1q7ODKwnqekkOGIRoqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c442Ll3h; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709206657; x=1740742657;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=B/wC9Nv9xuurKleWZRbMqkITXw/FjjRt0kr5rzQsZ7U=;
  b=c442Ll3h3EkkxxtYAmeVTuBnxkbGNrQyimhq5XEMd4YuSp136O9gLY+t
   emN/1AU992VSuIZu11KDy97SNvZrFNrHVB0gA8gBIdvV2p83CE0woqMn/
   PeAEFayVO4bKKge0fPUtT0fUlXYNcr/IxQi9r74HhUnnbPUTW9z3vHo0n
   PewjlC5Lq5hCEszxotprvmwaNQE6EMKs0IivZXNfFz2VcNIBC5wGydBS+
   crq3/IEmP15akE1hm48MW9VaTqDvyFPwCZEBPLZq5o7yqjMutuiDgwc1t
   lol6cnJgKSqYshMmxVKtraXF0GWgCOSacrpi3tu3+5fV+Bx75W+OiBrJd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7497940"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7497940"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 03:37:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7752014"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.51.250])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 03:37:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Feb 2024 13:37:28 +0200 (EET)
To: Arnd Bergmann <arnd@kernel.org>
cc: Hans de Goede <hdegoede@redhat.com>, 
    Szilard Fabian <szfabian@bluemarch.art>, 
    Jonathan Woithe <jwoithe@just42.net>, Arnd Bergmann <arnd@arndb.de>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86/fujitsu-laptop: add ACPI_BATTERY
 dependency
In-Reply-To: <20240228094010.2254245-1-arnd@kernel.org>
Message-ID: <6cc402a3-0e6d-f784-b14b-09f4db60eaf2@linux.intel.com>
References: <20240228094010.2254245-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 Feb 2024, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The dependency is required to avoid a link failure after support for
> battery hooks was added:
> 
> ld.lld: error: undefined symbol: battery_hook_unregister
> >>> referenced by fujitsu-laptop.c
> >>>               drivers/platform/x86/fujitsu-laptop.o:(acpi_fujitsu_laptop_remove) in archive vmlinux.a
> 
> Fixes: 611d56d76dee ("platform/x86/fujitsu-laptop: Add battery charge control support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 6dbd40e2aeda..d9851b79bfe5 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -371,6 +371,7 @@ config FUJITSU_LAPTOP
>  	depends on INPUT
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	depends on ACPI_VIDEO || ACPI_VIDEO = n
> +	depends on ACPI_BATTERY
>  	select INPUT_SPARSEKMAP
>  	select NEW_LEDS
>  	select LEDS_CLASS

Thanks. We already fixed this in the originating commit (and now the 
fixed version of the commit has also propaged to the for-next branch).

-- 
 i.


