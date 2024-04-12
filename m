Return-Path: <linux-kernel+bounces-143154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC0A8A351C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268231F23F61
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A56514E2F8;
	Fri, 12 Apr 2024 17:47:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351614D71E;
	Fri, 12 Apr 2024 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944049; cv=none; b=cLlI5YhWMFIsp1LhP2sgVtTspdsghORicDBi2yUfLOLXvO+tDnsQjcxkYyUNMhVj6LuZOL++YJD0tDojAM4UjUMtB9ULmWbs6YelManlanzOCNks+64DBApl6uWDxgVD+GnV10N0Xlwohs0PpPuI6JYfiOJ0ewWmzheZ9CGLvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944049; c=relaxed/simple;
	bh=t1aXXbfB8ZHcPTthUnC0oCaqfijgEwKm10E0BUqEQeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZqiDIDWOabaRSCVGbfniu3P1V6OsQtPHuJfpJa4Vr38jCOClnEHeZpFCCgjCvgOZgCsglepDexpCI/gFg9cG1/BZ8rcLp4Gs9WUrynhZA9hNKhz7kjmZdgrVqnRhzQYNCqdJ/xCuUtxmusZ6OZ1h2JLO1fuNXEnIdoj33wMcmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: sPu06oQ2RX2d9HL/NnVisA==
X-CSE-MsgGUID: RlZapg17RE+sZP8Y9oQ4VQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8579937"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8579937"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:47:27 -0700
X-CSE-ConnectionGUID: OjE/24eARNS32i0XRJCktw==
X-CSE-MsgGUID: dmICYwb/S2yGyyenwpAVJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21716816"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:47:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rvKzj-00000003iuH-0n16;
	Fri, 12 Apr 2024 20:47:23 +0300
Date: Fri, 12 Apr 2024 20:47:22 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: William Breathitt Gray <wbg@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: sch: Switch to memory mapped IO accessors
Message-ID: <Zhlzqgqu-A4M0cZh@smile.fi.intel.com>
References: <20240410072102.1200869-1-andy.shevchenko@gmail.com>
 <CACRpkdbOhxp1z15LE2FS36+zzhoxrqBMELt8PppnK0NXRyeqFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbOhxp1z15LE2FS36+zzhoxrqBMELt8PppnK0NXRyeqFA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 12, 2024 at 10:35:38AM +0200, Linus Walleij wrote:
> On Wed, Apr 10, 2024 at 9:21 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> 
> > Convert driver to use memory mapped IO accessors.
> >
> > Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> If this is the direction we want to go with port-mapped I/O then
> I'm in.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

> An ACK from William may be in order, he's usually keeping track
> of the port-mapped stuff.

William, are you okay to provide one?

-- 
With Best Regards,
Andy Shevchenko



