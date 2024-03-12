Return-Path: <linux-kernel+bounces-100127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BEA87923C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F001C21299
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1A669D09;
	Tue, 12 Mar 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJkPSNeC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAFD41C89;
	Tue, 12 Mar 2024 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239747; cv=none; b=HqJGFvWQYSqhpZajF4LsgC1W3+jxEiMqQcn8ONLnDox4VUdcVdJoyKW1JITI/tE0YKGf/mryxCf/vuDvWZwmq3d/jUZ7Ou9xXFZ6JwwQKtTUDZaz83VRSjYpdC3tFFjAiT3vXSj4lfCH++Il7C8AWKDLmurZq997t0PzP0MMgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239747; c=relaxed/simple;
	bh=QDB+v8Xy4M7nLhPofhtwM2OqHObbpVpZmD9JZ7L7PmI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hP+kw8cfQKz7JogaBaWn2tzwUnxROFmWYNxS+3P7h8mk99uNlL1DuV9ZrQt4LeGS/qOM9nH2u2DyrbRdouwGvhSzB1/Dw743/llaxvTAhANVghb42M6A83+x5M2ig4Xe9MAbHrT9j2VNI5zJd68XVGVvE7WrJq/bNmTQhgPse5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJkPSNeC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710239747; x=1741775747;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QDB+v8Xy4M7nLhPofhtwM2OqHObbpVpZmD9JZ7L7PmI=;
  b=OJkPSNeCJD8umcFOAfubxRY8TfXNdAWd0yCdsSqf2xP62Y79OVrydINB
   Dc7PMdiOnrtyEKGdWLfKRjOFhBVv3/y2OTn8GxKR36gRwacMyRQMi7Q4P
   rvomFnlFfZRsqH8BDvqsx4vrOA25QJbFwsF9Nq6XB/AAIAMGlmW9q67UK
   3zqXuQncxzeXWGikhmdzCUwlJVdDzLHwNSJB9ANrR5h6KGS85uIdG7Rzf
   iZ7tIRey/L9/LE4+GJqA93UcGjMt1vUcHxt7/jjQYpcf9kapQvQ6UJ2lM
   TN1k7A9YqWcAjF0jt1Qou43mWtMdzZ1wzNaGzedtFM2sHJFyUgXK24Urx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4798576"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4798576"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 03:35:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11412344"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.6])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 03:35:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Mar 2024 12:35:38 +0200 (EET)
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Kate Hsuan <hpa@redhat.com>, Pavel Machek <pavel@ucw.cz>, 
    Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
    platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    =?ISO-8859-15?Q?Andr=E9_Apitzsch?= <git@apitzsch.eu>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] platform: x86-android-tablets: other: Add swnode
 for Xiaomi pad2 indicator LED
In-Reply-To: <Ze-I63bNzaMkHfgg@surfacebook.localdomain>
Message-ID: <18ef7e97-db6e-2dc4-5728-5a539ae4c9bb@linux.intel.com>
References: <20240306025801.8814-1-hpa@redhat.com> <20240306025801.8814-2-hpa@redhat.com> <Ze-I63bNzaMkHfgg@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 Mar 2024, Andy Shevchenko wrote:

> Wed, Mar 06, 2024 at 10:58:00AM +0800, Kate Hsuan kirjoitti:
> > There is a KTD2026 LED controller to manage the indicator LED for Xiaomi
> > pad2. The ACPI for it is not properly made so the kernel can't get
> > a correct description of it.
> > 
> > This work add a description for this RGB LED controller and also set a
> > trigger to indicate the chaging event (bq27520-0-charging). When it is
> > charging, the indicator LED will be turn on.
> 
> Ilpo, Kate, please consider the following remarks.
> 
> ...
> 
> >  #include <linux/gpio/machine.h>
> >  #include <linux/input.h>
> >  #include <linux/platform_device.h>
> 
> + Blank line?
> 
> > +#include <dt-bindings/leds/common.h>
> 
> Not sure where to place this, some drivers put it the first, some after linux/*.
> 
> ...
> 
> > +/* main fwnode for ktd2026 */
> > +static const struct software_node ktd2026_node = {
> 
> No name?
> 
> > +};
> > +
> > +static const struct property_entry ktd2026_rgb_led_props[] = {
> > +	PROPERTY_ENTRY_U32("reg", 0),
> > +	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_RGB),
> > +	PROPERTY_ENTRY_STRING("function", "indicator"),
> 
> > +	PROPERTY_ENTRY_STRING("linux,default-trigger",
> > +			      "bq27520-0-charging"),
> 
> It's less than 80, why not on a single line?
> 
> > +
> 
> Redundant blank line.
> 
> > +	{ }
> > +};
> 
> ...
> 
> > +/* B */
> 
> B for red?!
> 
> > +static const struct property_entry ktd2026_red_led_props[] = {
> > +	PROPERTY_ENTRY_U32("reg", 0),
> > +	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_BLUE),
> > +	{ }
> > +};

The name with "red" and LED_COLOR_ID_BLUE are also inconsistent.

> ...
> 
> > +/* R */
> 
> R for blue?!
> 
> > +static const struct property_entry ktd2026_blue_led_props[] = {
> > +	PROPERTY_ENTRY_U32("reg", 2),
> > +	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_RED),
> > +	{ }
> > +};

Here as well.

I think it's better I drop this patch (it's only in review-ilpo) and wait 
for v5 version as there's some much still to correct.


-- 
 i.


