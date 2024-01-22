Return-Path: <linux-kernel+bounces-33048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC6F8363AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27121C26402
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA5C3BB4F;
	Mon, 22 Jan 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WyuARt0X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40973A8D5;
	Mon, 22 Jan 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927679; cv=none; b=fie/vuYefHlT7QSHy8IFPMVZYmYN3bju+Vcx+h91WznL0z4eGTzHZi2VOsW5TGFO5RuzMNy3cmIxZlfDrwz1r2ioluq9JdK+GiwPI69ly1wsahYDO2N4hjF7m9CK1k6aQ9yrIGtwOcXJxmaUQWhkXFaL3EwMQPyxY4CdFR2qAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927679; c=relaxed/simple;
	bh=kH2BOO2IN3Vsx+BcqgWW4N0g3Af3C7pA8j9tRuvf2BQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tC0DGp+zas7lsD7cPLDMNvfYgdJtfwOaWBa5uztIcbA+t96S7EUww4/z3I/BA5as0fgcGFjFwxr8dtyAcQjKa7XN4S4xm8zWLT6e8sqAB2qJdTZMZYfXF97y0RgruEfPysjOx9EStVl/Mf0y7T0avmGAP3OIgNuHy9A8jAt8qkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WyuARt0X; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705927678; x=1737463678;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kH2BOO2IN3Vsx+BcqgWW4N0g3Af3C7pA8j9tRuvf2BQ=;
  b=WyuARt0XDoQ+x4dzJNc2xuluiI21er+0RB5qjcog8ok6UeXnCa04nKZC
   glJsj/EumOUwEek2Cpgd+KBYG2uNJcbVImumzy8CTNKWW7X8y/k2n+0fi
   vuw5zTe+NEwtgCfzfn19tdtvCTIZz5bn37ZUrr49NJcDFkhXvGJ6YI8f3
   Q/ZZD0imlyBmOfif760uUz8/zegDBDte/m1ffdpON3ZRmdZPCeFI1vvk5
   fQ6D5IuYgob8wy0r4ooBCKqQNLjMMw4c6HWxZtJWrlG7iXNLa/ON3fzaN
   KmBz+H5Du+elitU1IBn9WQd/0/M3mEwprix1hQa1tPOuC1Yu5KSa+L7IL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="7947145"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="7947145"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:47:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="875973402"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="875973402"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.150])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:47:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 22 Jan 2024 14:47:49 +0200 (EET)
To: Hans de Goede <hdegoede@redhat.com>
cc: Armin Wolf <W_Armin@gmx.de>, Andy Shevchenko <andy@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] platform/x86: wmi: Use ACPI device name in netlink
 event
In-Reply-To: <1862d74a-7b15-48e3-896b-30dda835f28f@redhat.com>
Message-ID: <61d23b7d-8e47-acf8-f3b7-bea1544ca8fa@linux.intel.com>
References: <20240121200824.2778-1-W_Armin@gmx.de> <1862d74a-7b15-48e3-896b-30dda835f28f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 22 Jan 2024, Hans de Goede wrote:
> On 1/21/24 21:08, Armin Wolf wrote:
> > The device name inside the ACPI netlink event is limited to
> > 15 characters, so the WMI device name will get truncated.
> > 
> > This can be observed with kacpimon when receiving an event
> > from WMI device "9DBB5994-A997-11DA-B012-B622A1EF5492":
> > 
> > 	netlink:  9DBB5994-A997- 000000d0 00000000
> > 
> > Fix this by using the shorter device name from the ACPI
> > bus device instead. This still allows users to uniquely
> > identify the WMI device by using the notify id (0xd0).
> > 
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > ---
> > Changes since v1:
> > - use acpi_dev_name() helper function
> 
> I'm a bit divided on this patch. I agree the new way of doing
> things is better, but technically this is a bit of a userspace API
> break.
> 
> I guess we could hope that nothing depends on the old netlink API
> format / name but I'm not sure we can rely on that ...
> 
> Ilpo, Andy do you have any opinion on this ?

Hi Armin,

Have you tried to conduct debian code search to find the code using this?

-- 
 i.

> > ---
> >  drivers/platform/x86/wmi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> > index a7cfcbf92432..c61860db66ed 100644
> > --- a/drivers/platform/x86/wmi.c
> > +++ b/drivers/platform/x86/wmi.c
> > @@ -1202,7 +1202,7 @@ static int wmi_notify_device(struct device *dev, void *data)
> >  	}
> > 
> >  	acpi_bus_generate_netlink_event(wblock->acpi_device->pnp.device_class,
> > -					dev_name(&wblock->dev.dev), *event, 0);
> > +					acpi_dev_name(wblock->acpi_device), *event, 0);
> > 
> >  	return -EBUSY;
> >  }
> > --
> > 2.39.2
> > 
> 

