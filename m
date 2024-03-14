Return-Path: <linux-kernel+bounces-103469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729B687BFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54181C22003
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6F71B2F;
	Thu, 14 Mar 2024 15:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cKqm6Dlt"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7F71756;
	Thu, 14 Mar 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429539; cv=none; b=iNZyAdodlEY4q0dG3tOZOOCfXTOi/Oh3jqnvhfgr1LtWMk5UGztqB7g4XCCuiT5MQmdPzP+gkwUmq0RtskdKCXIw5aOljBFofJ/97lUsMWIARdHJHH6sG032x4NqFng2TMRkzq1bdUwJYnEKfDzDu5Hpiez/yFnF0vF23rwyUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429539; c=relaxed/simple;
	bh=2gPuGuSwHEgxxlhC0HKPR+AsCZzffsRJG9HPOwmtpwk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyA8Pdh6ejw7G9+5YUs85EhA+Z+07QtNADU3QzgU2o8itGJkzIg3+oVOVVILmJvF19v+wjLYAJbWhSMsHZYVQpDdDpoJtDIGw0T5kCYTMIvsPAgl8LCMaYyWMmatKHcidzt3EZgAptuPFAhVdG5lSN7Tl7ouB26WohdooEzQQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cKqm6Dlt; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42EFIloZ080670;
	Thu, 14 Mar 2024 10:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710429527;
	bh=dZtjpTkxFeJ4o3KgsKAHW2BQ1L5sEaAioYu3UbO/7gk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=cKqm6Dlt8pbTZajws9LTUK3j7QF5+YSZwJBTvnkPE1wqtB7zTAERaGgmOSZEQxFxV
	 38x6GiCN0C+XqqR15qn2vVZ5YLWuWmcHTU1hbvNuDBRKlr3GdL/WwnRLEiLJU9uPvv
	 363G2QWvXwexikc6vsILlyzfYVjp4aPKYLv7EpTw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42EFIlIC053234
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Mar 2024 10:18:47 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Mar 2024 10:18:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Mar 2024 10:18:47 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42EFIk4a044918;
	Thu, 14 Mar 2024 10:18:47 -0500
Date: Thu, 14 Mar 2024 20:48:46 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Tony Lindgren <tony@atomide.com>, <theo.lebrun@bootlin.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM: wakeup: Add a missing return case in init_wakeup
Message-ID: <20240314151846.u3r3eaklrl3hf7pi@dhruva>
References: <20240314075429.1164810-1-d-gole@ti.com>
 <CAJZ5v0iUt+tudMV-rJ80GR6iNQVv06+054h0UyNgpEOUF6QLRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iUt+tudMV-rJ80GR6iNQVv06+054h0UyNgpEOUF6QLRQ@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Mar 14, 2024 at 15:01:36 +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 14, 2024 at 8:55 AM Dhruva Gole <d-gole@ti.com> wrote:
> >
> > The device_wakeup_disable call can return an error if no dev exists
> > however this was being ignored. Catch this return value and propagate it
> > onward in device_init_wakeup.
> 
> Why does this matter to the callers of device_init_wakeup()?

If atall !dev->power.can_wakeup then the caller should know something is
funny right?

> 
> >
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >  include/linux/pm_wakeup.h | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> > index 6eb9adaef52b..64c7db35e693 100644
> > --- a/include/linux/pm_wakeup.h
> > +++ b/include/linux/pm_wakeup.h
> > @@ -232,14 +232,15 @@ static inline void pm_wakeup_hard_event(struct device *dev)
> >   */
> >  static inline int device_init_wakeup(struct device *dev, bool enable)
> >  {
> > +       int ret;
> >         if (enable) {
> >                 device_set_wakeup_capable(dev, true);
> > -               return device_wakeup_enable(dev);
> > +               ret = device_wakeup_enable(dev);
> >         } else {
> > -               device_wakeup_disable(dev);
> > +               ret = device_wakeup_disable(dev);
> >                 device_set_wakeup_capable(dev, false);
> > -               return 0;
> >         }
> > +       return ret;
> >  }
> >
> >  #endif /* _LINUX_PM_WAKEUP_H */
> >
> > base-commit: 9bb9b28d0568991b1d63e66fe75afa5f97ad1156
> > --
> > 2.34.1
> >

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

