Return-Path: <linux-kernel+bounces-98797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2182877F94
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7E3283632
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05703C082;
	Mon, 11 Mar 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EiLNERKX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F183B7AC;
	Mon, 11 Mar 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158738; cv=none; b=pWLwCfenJErBdbn8Sv5dsCZSOL/xhmpUQrMLgqbI/6qp07QMEKrSrGTiOKZuN1MYBbyaa8wrUW3RDhuML7pG/7pDkFC7jMPBVuoPmNSaXtsc4QsZFqXbM8Fh4ppy8NDps6DIUO2FKSAvuSDY8HSkBWBfb9Vba+yrvGjc05FkiVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158738; c=relaxed/simple;
	bh=uSTCg+F+kw498x2HNia8q+5D0uqMlyFbtWRaerhDL/w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LYBfh6nQ/lInGziR6DHXjj7rTqEwOJlwkw8NS/4kTnyaK/fzzVIqRDYsQVcKs68jzfVZ8GNLGhUs12yC2jyVI+iWXkFh6JHnQJMc+RIPDuqnGlAeI2FulPWk8efqtvZEKt0pjJ5o5+CGm06JtfIJH76Dnysr1wz4wvcrN4j0L2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EiLNERKX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710158738; x=1741694738;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uSTCg+F+kw498x2HNia8q+5D0uqMlyFbtWRaerhDL/w=;
  b=EiLNERKXltHQZnbVXng9aQkk0LPnyVX3fBDmh307bsL7qLuwWE9ZoMbh
   v5cpNOXHda121wgmsJ1KwpXPlO/ka9PdzIQwtJHlNV87GeAj/lBFRkUS1
   lJIy5HlyGMFCU5tH4kV2trURDibbQeU90P1R17WEF1EXu8AbHl+fjMNDN
   ZGXSQrzLUG5jL+wJFp5FN+Czuu/Vy1M6S3PbFjBl7d+djB01v48g+Ukn+
   g/r4yvOpFGUjzrGXz27GmhkBUwjaXiPzBkPy9zsVWNfg+SByc01ZmEXY7
   5Qw9VP6yf95Lfj/EGXfqoO7EkTElF1quXfpUJZCbCHr9fFVT9ZHW31S0H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4659508"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4659508"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:05:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11719654"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:05:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 Mar 2024 14:05:29 +0200 (EET)
To: Kate Hsuan <hpa@redhat.com>
cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
    linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, 
    =?ISO-8859-15?Q?Andr=E9_Apitzsch?= <git@apitzsch.eu>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] KTD2026 indicator LED for X86 Xiaomi Pad2
In-Reply-To: <20240306025801.8814-1-hpa@redhat.com>
Message-ID: <fc522d02-d1e9-22e8-6cbd-8a8d66e3ba77@linux.intel.com>
References: <20240306025801.8814-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 6 Mar 2024, Kate Hsuan wrote:

> This patch added the support for Xiaomi Pad2 indicator LED. This work
> included two parts.
> 1. Added the KTD2026 swnode description to describe the LED controller.
> 2. Migrated the original driver to fwnode to support x86 platform.
> 
> Moreover, the LED trigger is set to bq27520-0-charging for Xiaomi Pad2
> so the LED will be turned on when charging.
> 
> --
> Changes in v4:
> 1. Fix double casting.
> 2. Since force casting a pointer value to int will trigger a compiler
>    warning, the type of num_leds was changed to unsigned long. 
> 
> Changes in v3:
> 1. Drop the patch "leds-ktd202x: Skip regulator settings for Xiaomi
>    pad2"
> 
> Changes in v2:
> 1. Typo and style fixes.
> 2. The patch 0003 skips all the regulator setup for Xiaomi pad2 since
>    KTD2026 on Xiaomi pad2 is already powered by BP25890RTWR. So, the
>    sleep can be removed when removing the module.
> 
> Kate Hsuan (2):
>   platform: x86-android-tablets: other: Add swnode for Xiaomi pad2
>     indicator LED
>   leds: rgb: leds-ktd202x: Get device properties through fwnode to
>     support ACPI

Hi,

I took the patch 1/2 now into pdx86/review-ilpo where it will propagate 
into pdx86/for-next.

-- 
 i.


