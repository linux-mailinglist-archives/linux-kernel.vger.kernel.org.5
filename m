Return-Path: <linux-kernel+bounces-72680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31185B72A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25B71C239ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B795F55D;
	Tue, 20 Feb 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6DDn2AL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454F5F475;
	Tue, 20 Feb 2024 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420794; cv=none; b=EzybEhdXoqUuag1ICc8B17nM2A4+aaBnQ3PQi5QkvjnetYZjzGjotMlrTBZ2P87QiH/oSdQrENNdE/Q4YRwoDx0s2bqun+fbsMN88t1nXzOSDdKwBkPFzsWyREY1+k9wSCk9s0kArGafINVAMQJSWL2R5cqwIzoiWT+UMfwX0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420794; c=relaxed/simple;
	bh=d8WOTCkwaJsZ5K1w3UM9/CSindAuhapffgUY4/QPevk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cu9dmZtNIaD7yf2aYF6G09KI9bSObFNvX+vswPKQxJQC3kcH/h1NoIHC0s4q52ZMheyLP9IC9C+8DWrDdrHvJuR/jHiq/z38KLM3tYu7Y24LwhHFtY7Wv4xHdol2iXVc4bckY48SbrIKmY3/pjCwfGBcUypA01VBn7rpQwqycuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6DDn2AL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708420793; x=1739956793;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=d8WOTCkwaJsZ5K1w3UM9/CSindAuhapffgUY4/QPevk=;
  b=A6DDn2ALVzEVFqUlQ167YI2JNNJke1ddFqkG6zUDR0m9GBw4/8OokGXe
   1ybDUgfpYmbHBG2qbh1szmvZ2LJ94PpL/lGmLQD4CxvEIYe7i/I6+/dIq
   iYBOY4gltp43PVERT6w29UzaChp6SjMDyBkdZR+XwyLJ9frdFlm+eFg34
   bXkuTcvsHglsI2I5PsODW+dpE1K1VV2NjKKX+T3UIW1rLBmN0GcA8Vn3G
   LQyI7BN2blNovm1iyCSOJtZFlB++05RTomkQWaeWRcLAsE5ZyskAKGnqG
   +AiN+i6FWM3ZQI/LyN0wAYuihYuNoLZ8lVxnCoy0GX13RAjAxdgaCvlDs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2640277"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2640277"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 01:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="913041935"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="913041935"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.21])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 01:19:50 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 Feb 2024 11:19:44 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: corentin.chary@gmail.com, luke@ljones.dev, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] platform/x86: wmi: Check if event data is not
 NULL
In-Reply-To: <dcb7c031-b920-4774-a1a9-fed8813390d0@gmx.de>
Message-ID: <954e9d5e-4800-aba9-4678-44584baaea05@linux.intel.com>
References: <20240219115919.16526-1-W_Armin@gmx.de> <20240219115919.16526-3-W_Armin@gmx.de> <dcb7c031-b920-4774-a1a9-fed8813390d0@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 20 Feb 2024, Armin Wolf wrote:

> Am 19.02.24 um 12:59 schrieb Armin Wolf:
> 
> > WMI event drivers which do not have no_notify_data set expect
> > that each WMI event contains valid data. Evaluating _WED however
> > might return no data, which can cause issues with such drivers.
> > 
> > Fix this by validating that evaluating _WED did return data.
> > 
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > ---
> >   drivers/platform/x86/wmi.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> > index 8fb90b726f50..d0fe8153f803 100644
> > --- a/drivers/platform/x86/wmi.c
> > +++ b/drivers/platform/x86/wmi.c
> > @@ -1210,6 +1210,7 @@ static void wmi_notify_driver(struct wmi_block
> > *wblock)
> >   {
> >   	struct wmi_driver *driver = drv_to_wdrv(wblock->dev.dev.driver);
> >   	struct acpi_buffer data = { ACPI_ALLOCATE_BUFFER, NULL };
> > +	union acpi_object *obj = NULL;
> >   	acpi_status status;
> > 
> >   	if (!driver->no_notify_data) {
> > @@ -1218,12 +1219,18 @@ static void wmi_notify_driver(struct wmi_block
> > *wblock)
> >   			dev_warn(&wblock->dev.dev, "Failed to get event
> > data\n");
> >   			return;
> >   		}
> > +
> > +		obj = data.pointer;
> > +		if (!obj) {
> > +			dev_warn(&wblock->dev.dev, "Event contains not event
> > data\n");
> 
> I just noticed that this should have been "Event contains no event data\n".
> Should i send
> another patch?

Hi Armin,

As I was doing some history manipulation anyway as is, I tweaked it 
directly in the history. While doing the conflict resolution because of 
that small change I realized the wording got corrected in the latter patch 
anyway so it was quite harmless but it's now correct in both commits in 
review-ilpo branch.

-- 
 i.


