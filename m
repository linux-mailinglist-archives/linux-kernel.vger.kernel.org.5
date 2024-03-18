Return-Path: <linux-kernel+bounces-106286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD6687EBF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CCD283FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06E54F200;
	Mon, 18 Mar 2024 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DDpHEA37"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F04F1E3;
	Mon, 18 Mar 2024 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775181; cv=none; b=HzBMgg2iww/XVw2Mt7PpNf9Y+EfV7ixXlS4Gjf1zXRf7g0BPh6A4Cv9VJUfpZzhzfviRNwptIc4rAyDJsntlBK+MyYkbw74c+a/CHGTB4aC+1lXLYFwDPwl+puethenMSQrz96q95s5e5h+SFAoK/XSnQdLIj5bXN0Q9vC2/tfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775181; c=relaxed/simple;
	bh=T+1c5Voa9wbuk82qx7Y34egGfh1pJlqoVUfmJFJTlGU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5zWT0lzHqgR3LU94w5NtEx4sR1gbjn3+akObPyWc9xN6y9J2pUXMbzgJPkdghEhKllFB3hYBm/Qwq0Cy2P8+XWkOmP9UBjRYd8pvc4xCXSd7dvGdmZJ4/uVpzfW1cHXwNIxBMjfGj5lV56IUpvpTJ7IunNUaejkjRnUw8gwmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DDpHEA37; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42IFJRTe095056;
	Mon, 18 Mar 2024 10:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710775167;
	bh=toWyhbxvvkbbZKZQvW5MzxVDodxPwYT4N7QorbVGF+U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=DDpHEA371pnTqG2oaKZbQ1VKxjNWFU71Km/Z9ML+iKzJ1kch7LDr+/0C1KXF45daf
	 NuswVTs5mW8Z57Dsry/wOJcpc6dfeWl5P9MqwiL6IWU6HKCyqL3l8KL659K+MSXWRJ
	 Fu5xCJBX7MehXAPVkyfJJF9Cx2IptBQzbVEKv5Vs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42IFJRqk111282
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 10:19:27 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 10:19:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 10:19:26 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42IFJQQK098058;
	Mon, 18 Mar 2024 10:19:26 -0500
Date: Mon, 18 Mar 2024 20:49:25 +0530
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
Subject: Re: [PATCH 1/3] PM: wakeup: make device_wakeup_disable return void
Message-ID: <20240318151925.l5fcnbr7qcww7diw@dhruva>
References: <20240318055054.1564696-1-d-gole@ti.com>
 <20240318055054.1564696-2-d-gole@ti.com>
 <CAJZ5v0giafbnGFHgT7pZm+o6KzKznxVDJvc04K6XvP1ShG2YKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0giafbnGFHgT7pZm+o6KzKznxVDJvc04K6XvP1ShG2YKw@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 18, 2024 at 14:47:45 +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 18, 2024 at 6:55 AM Dhruva Gole <d-gole@ti.com> wrote:
> >
> > The device_wakeup_disable call only returns an error if no dev exists
> > however there's not much a user can do at that point.
> > Rather make this function return void.
> >
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >  drivers/base/power/wakeup.c | 11 +++++++----
> >  include/linux/pm_wakeup.h   |  5 ++---
> >  2 files changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> > index a917219feea6..752b417e8129 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -451,16 +451,15 @@ static struct wakeup_source *device_wakeup_detach(struct device *dev)
> >   * Detach the @dev's wakeup source object from it, unregister this wakeup source
> >   * object and destroy it.
> >   */
> > -int device_wakeup_disable(struct device *dev)
> > +void device_wakeup_disable(struct device *dev)
> >  {
> >         struct wakeup_source *ws;
> >
> >         if (!dev || !dev->power.can_wakeup)
> > -               return -EINVAL;
> > +               return;
> >
> >         ws = device_wakeup_detach(dev);
> >         wakeup_source_unregister(ws);
> > -       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(device_wakeup_disable);
> >
> > @@ -502,7 +501,11 @@ EXPORT_SYMBOL_GPL(device_set_wakeup_capable);
> >   */
> >  int device_set_wakeup_enable(struct device *dev, bool enable)
> >  {
> > -       return enable ? device_wakeup_enable(dev) : device_wakeup_disable(dev);
> > +       if (enable)
> > +               return device_wakeup_enable(dev);
> > +
> > +       device_wakeup_disable(dev);
> > +       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
> >
> > diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> > index 6eb9adaef52b..428803eed798 100644
> > --- a/include/linux/pm_wakeup.h
> > +++ b/include/linux/pm_wakeup.h
> > @@ -107,7 +107,7 @@ extern void wakeup_sources_read_unlock(int idx);
> >  extern struct wakeup_source *wakeup_sources_walk_start(void);
> >  extern struct wakeup_source *wakeup_sources_walk_next(struct wakeup_source *ws);
> >  extern int device_wakeup_enable(struct device *dev);
> > -extern int device_wakeup_disable(struct device *dev);
> > +extern void device_wakeup_disable(struct device *dev);
> 
> This change will introduce a build error in sdhci-pci-core.c AFAICS,
> so you need to modify this file in the same patch to avoid bisection
> breakage.

Alright, I have respinned the series and fixed up the first patch
itself.

Thanks!


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

