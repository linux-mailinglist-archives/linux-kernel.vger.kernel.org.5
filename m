Return-Path: <linux-kernel+bounces-108843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846868810CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E36228580C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185883CF65;
	Wed, 20 Mar 2024 11:21:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E73B2A6;
	Wed, 20 Mar 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933702; cv=none; b=lbG3eESKZROyE87xWxda2CKulqQfWioJmSvLCANT80PQhRYYJ/Orfu/cpIv18ZnN6jE3pxh4JlEJ4iSAzVTpDV72Nr2kReueD8Ge5HC41N9ExJISFAwp3VCIO7ZghDemcNQ6fgr1C+G4kfkOu5Pt8iBqtfiA/012yNe1RIXt5FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933702; c=relaxed/simple;
	bh=d94B03yVZ+7ZpgAa8VcsQjegn90mzDMwSO9/ITIwLNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUXT+ycHCltA2MEiWy3TcVnK5fK2toIH+e5sUYtv70fJiEsygVKUu3/rdlkOoTZpY7FQVUutaBohCTXLhv/8jSKeP9MBnVzJqBC0kCndcvQoyzKDmCpRpEoMl7zoUo4LO6AmqZmt0kInoKmiJKhNMVEHO8rlCvRc/QtgxdX5qFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17296592"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="17296592"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914663636"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="914663636"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:21:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rmu0m-0000000EYMs-0m9b;
	Wed, 20 Mar 2024 13:21:36 +0200
Date: Wed, 20 Mar 2024 13:21:35 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] gpiolib: use dev_err() when gpiod_configure_flags
 failed
Message-ID: <ZfrGvwV92a9Zzrg_@smile.fi.intel.com>
References: <20240320073344.1563102-1-peng.fan@oss.nxp.com>
 <CAHp75Vf1K8c+7O5Cga3t+WiiSkk-yk_gATGJrMZ8rnPPtWLkWQ@mail.gmail.com>
 <DU0PR04MB9417FEFA3DB02082D02A963F88332@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB9417FEFA3DB02082D02A963F88332@DU0PR04MB9417.eurprd04.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 20, 2024 at 11:07:40AM +0000, Peng Fan wrote:
> > On Wed, Mar 20, 2024 at 9:25 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:

..

> > > When gpio-ranges property was missed to be added in the gpio node,
> > > using dev_err() to show an error message will helping to locate issues
> > > easier.
> > 
> > I'm not convinced, so not my call to approve / reject, but see a remark below.
> 
> You mean dev_err not help or else?

Moving it to error level.
Usually developers enable CONFIG_DEBUG_GPIO for these messages to appear.

..

> > >         ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
> > >         if (ret < 0) {
> > > -               dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
> > > +               dev_err(consumer, "setup of GPIO %s failed: %d\n",
> > > + con_id, ret);
> > >                 gpiod_put(desc);
> > >                 return ERR_PTR(ret);
> > 
> > While at it, can you move it to be after the gpiod_put()?
> 
> Does it matter?

Yes, the system gives resource back as soon as possible.

-- 
With Best Regards,
Andy Shevchenko



