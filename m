Return-Path: <linux-kernel+bounces-132020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF14898ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4D61C28EA3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A12E133426;
	Thu,  4 Apr 2024 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j8vBMj46"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C71332A0;
	Thu,  4 Apr 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258272; cv=none; b=eUK4h1s9LRr/6rv1kHIuC/Ui9ZQ4KYBmJBoqCS1h5dUa9EO7wD185uSXfM2uc/TjW5hnjWq2PrwfGDy8kMggbEIZ/C+S6jlVrG6fDOvQ0Eqo5fI7XB+IVajqpI4TYueHYxncLhFp6cFKHtiuLJW40E66gk/xTicuhgdpaialqNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258272; c=relaxed/simple;
	bh=ZDE0BTLSESKcxgyKOUlqzXNwU7bcf62wlb9XIaoOH6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbWfoHHVsWxTnC+Yljkj4LQ40NBfj3hFTaiynfLkJXeIOZ20x77Wh7MXecxE7vyrleP3Tpgte5w2eFSakRkQ2CV1KuVCD4m6+eEOuGfXlTrAboz2EhG2mXfzwLwoRln40sYQv6kY9KGsmYAfNl4YibnNqdPxnrZtJ18qXBy/6fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j8vBMj46; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712258271; x=1743794271;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZDE0BTLSESKcxgyKOUlqzXNwU7bcf62wlb9XIaoOH6Q=;
  b=j8vBMj46W1tuO0B/M7QriBDUhNgJU7Ca8Ka8TzAzA5NtuYogt10UAByr
   0o30nfXRFo7/xbOASvDoLUWntSUzkEFHy37UqEu9BzE7CC+gsj+HnsCC/
   Og4SelBhk4Pw/mlp2hdjW0KlxB2AYrRi1Vb8OnbTAeQrez7ntcB6RkrIl
   mD8R80Vp2/rTkcrYUsndiRe6WPC/qPpARyZy8wQ4FX8LzMY6ZTT/kNe/q
   5JVytCeN5PhcWPdfvJ5jV+f3NPepkrIsbEeOCbei81WsxdsHTWBOIlmz9
   Vq8C7OsKZL2Wk1hP5j3XjkpMgSEQtR9i3PF2nvji3LTHWSwn/lAxd50cr
   g==;
X-CSE-ConnectionGUID: qHRNc0eJSYmFnS8Z8K0APw==
X-CSE-MsgGUID: jMs2xcnMRpqWU5RH8HVztw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7803604"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7803604"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:17:50 -0700
X-CSE-ConnectionGUID: 7CGnqvEiQ0miCALFgp3Veg==
X-CSE-MsgGUID: 6iv13SG5TrCjF+NC2My+yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="42058021"
Received: from ypottimu-mobl.amr.corp.intel.com (HELO [10.209.51.123]) ([10.209.51.123])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:17:49 -0700
Message-ID: <4e1589c8-114c-4f42-a04f-318a32a60bb4@linux.intel.com>
Date: Thu, 4 Apr 2024 12:17:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: quickstart: fix Kconfig selects
To: Arnd Bergmann <arnd@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Henning Schild
 <henning.schild@siemens.com>, SungHwan Jung <onenowy@gmail.com>,
 Ai Chao <aichao@kylinos.cn>, Robert Joslyn <robert.joslyn@redrectangle.org>,
 Henry Shi <henryshi2018@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404123435.2684819-1-arnd@kernel.org>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240404123435.2684819-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/4/24 5:34 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The new driver Kconfig entry has a typo that causes a link failure
> when CONFIG_INPUT_SPARSEKMAP is disabled:
>
> x86_64-linux-ld: drivers/platform/x86/quickstart.o: in function `quickstart_notify':
> quickstart.c:(.text+0x96): undefined reference to `sparse_keymap_report_event'
> x86_64-linux-ld: drivers/platform/x86/quickstart.o: in function `quickstart_probe':
> quickstart.c:(.text+0x1da): undefined reference to `sparse_keymap_setup'
>
> Select this symbol instead of the incorrect INPUT_SPARSE_KEYMAP.
>
> Fixes: afd66f2a739e ("platform/x86: Add ACPI quickstart button (PNP0C32) driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
LGTM

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>  drivers/platform/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ba88a7f259f1..21a37f1b73ab 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -647,7 +647,7 @@ config ACPI_QUICKSTART
>  	tristate "ACPI Quickstart button driver"
>  	depends on ACPI
>  	depends on INPUT
> -	select INPUT_SPARSE_KEYMAP
> +	select INPUT_SPARSEKMAP
>  	help
>  	  This driver adds support for ACPI quickstart button (PNP0C32) devices.
>  	  The button emits a manufacturer-specific key value when pressed, so

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


