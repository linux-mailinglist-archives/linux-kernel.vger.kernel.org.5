Return-Path: <linux-kernel+bounces-106284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C1887EBF0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6EF1F2182F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7624F888;
	Mon, 18 Mar 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N421oECZ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEBB28DD6;
	Mon, 18 Mar 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775133; cv=none; b=o2FP2nG5M6HcedGP3perUOQxDO/C7LNrjEzV8bM6Ni6jclDZmgToYMth+XyRXu6HIB+FmVkSvMaJkiMx78NFMCCdfR2iuo45kiuPAF1cd4o3W22kbtmTUAUH70LgIpNhYuumZB2UdpP2VHYXwihnt4u4K0NRsVy6JnZY5IiZmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775133; c=relaxed/simple;
	bh=F1+43udbsxxXHug94VtYk0oWwJsE746Av5TrZAY+jBI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwGcCixEPsVsS22/S6AXNRdfv+87ly7HF64+7qAWYQcmS3kUquXnTARFLCOAJotYx1cWzv0HtdjrRY9nQVMNjsnU7dpsIsLfjtegBZZ2wJmwvB177SUEH3RKmxythz++xhxxfHtGlRBfSw1Jgcgm6rODcGgZEKkQ6Sgn7FWRVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N421oECZ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42IFIftM088536;
	Mon, 18 Mar 2024 10:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710775121;
	bh=/958lDF4Ww62P95rKSyfa7pETZ74bAoFpYyiBLEZ2VY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=N421oECZFOaTPAMoAVfZQpPcEMg3rjywyRUvbRelekTW2SRQKJS8wi4CSfL628RLV
	 xO1z3o6MFl5eKw7rNa5vL70//AmE65AyUOMtqsm0JqU3ee0BXYbdq+9lMo017gHAoK
	 Yfu7IsN2sHZHzDMGROzkaq2JcTNTk/weJB2xqFMg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42IFIfeY110682
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 10:18:41 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 10:18:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 10:18:41 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42IFIeTT097051;
	Mon, 18 Mar 2024 10:18:40 -0500
Date: Mon, 18 Mar 2024 20:48:39 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>, Len Brown
	<len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <theo.lebrun@bootlin.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 2/3] PM: wakeup: Remove unnecessary else from
 device_init_wakeup
Message-ID: <20240318151839.okplnfpakp5y5lxj@dhruva>
References: <20240318055054.1564696-1-d-gole@ti.com>
 <20240318055054.1564696-3-d-gole@ti.com>
 <CAJZ5v0hP0TR1zVc1hNMw+SnqCw7hJUcFM-J5Y6Mtgh-tnrrdEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hP0TR1zVc1hNMw+SnqCw7hJUcFM-J5Y6Mtgh-tnrrdEw@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 18, 2024 at 14:52:02 +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 18, 2024 at 6:55 AM Dhruva Gole <d-gole@ti.com> wrote:
> >
> > Checkpatch warns that else is generally not necessary after a return
> > condition which exists in the if part of this function. Hence, just to
> > abide by what checkpatch recommends, follow it's guidelines.
> >
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >  include/linux/pm_wakeup.h | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> > index 428803eed798..76cd1f9f1365 100644
> > --- a/include/linux/pm_wakeup.h
> > +++ b/include/linux/pm_wakeup.h
> > @@ -234,11 +234,10 @@ static inline int device_init_wakeup(struct device *dev, bool enable)
> >         if (enable) {
> >                 device_set_wakeup_capable(dev, true);
> >                 return device_wakeup_enable(dev);
> > -       } else {
> > -               device_wakeup_disable(dev);
> > -               device_set_wakeup_capable(dev, false);
> > -               return 0;
> >         }
> > +       device_wakeup_disable(dev);
> > +       device_set_wakeup_capable(dev, false);
> > +       return 0;
> >  }
> >
> >  #endif /* _LINUX_PM_WAKEUP_H */
> > --
> 
> This one is fine with me, but not 6.9-rc material.

OK, I completely understand.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

