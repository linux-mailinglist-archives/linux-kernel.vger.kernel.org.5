Return-Path: <linux-kernel+bounces-30775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873A783243B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A801C229B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0044F4A11;
	Fri, 19 Jan 2024 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdCuy/NV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE26FA9;
	Fri, 19 Jan 2024 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705642119; cv=none; b=bDneJu29XzFDRV5LG4nwlduP6PR6pglGdjo9FPwnVzK6T//swr/iogqEnOhxUuQreCX+oskjFsP0Ba/+LKMTuwXtDyUWnaQLQXlsmXjcsb/lPbHJtk5B0ntioPkt5CD+3VnPZZleyunLmaGiDmqJipP7e8HvoWLPBilo79NHmQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705642119; c=relaxed/simple;
	bh=ICBDeNeeXNTzIAVB33ONWU9Tr4HarrY/gXY5TVN1HRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6uQHf+bUHl+9E3LYk3oKY9uXa8DgkXdV69DHVJpyKE+tzpWQB6hW7pUTcSzJZT4wWMxeu8BZyIMFj6Q8JlDSukrxRWxK6mEf4iuWYhgCL62uv3K3+1kqIgjxgSDH+iJPongjqXcHKAGr3u1oQyOVZoat5WiarvAzt8J5Rb0HTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdCuy/NV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAA1C433F1;
	Fri, 19 Jan 2024 05:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705642118;
	bh=ICBDeNeeXNTzIAVB33ONWU9Tr4HarrY/gXY5TVN1HRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdCuy/NV2V5HOK/y8FFoitbl0UuUJLKNoVZ0BAMnEDjUwopRgM29BS+1PeT42NBoa
	 2Aw+p53Su8unxYlUjGM2otJ+X3tF3unsyVKL+yYN7LYQANw9k3JsCJE+77H9JexsLL
	 uuHehvfCd+wBhxSb92/kK66ypr7FflPZhTkpksYaykXX0QoqjMicjXfJ0j/jbozALd
	 m487oNAxPY/AI4CgI2CpntSUxW4rw4xhXOFEgJ0aIJaj8eGqDGove0cMwpN7q1zKTG
	 mkCJBYXEf30zeUH2Dq0VeXvYtdz7c5panPigeHoibGmvV6JQzJLH/o43Xefghq6VYP
	 cs6/AFFYeUehw==
Date: Fri, 19 Jan 2024 13:28:34 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lukasz Majczak <lma@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 2/3] watchdog: Add ChromeOS EC-based watchdog driver
Message-ID: <ZaoIguOBWrahSRkv@google.com>
References: <20240118195325.2964918-1-lma@chromium.org>
 <20240118195325.2964918-3-lma@chromium.org>
 <Zanvi4ih0zhC4aG7@google.com>
 <17e323d8-f8d3-4e5a-91aa-0788b8026f21@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e323d8-f8d3-4e5a-91aa-0788b8026f21@roeck-us.net>

On Thu, Jan 18, 2024 at 07:55:39PM -0800, Guenter Roeck wrote:
> On 1/18/24 19:42, Tzung-Bi Shih wrote:
> > On Thu, Jan 18, 2024 at 07:53:23PM +0000, Lukasz Majczak wrote:
> > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > index 7d22051b15a2..4700b218340f 100644
> > > --- a/drivers/watchdog/Kconfig
> > > +++ b/drivers/watchdog/Kconfig
> > > @@ -181,6 +181,17 @@ config BD957XMUF_WATCHDOG
> > >   	  watchdog. Alternatively say M to compile the driver as a module,
> > >   	  which will be called bd9576_wdt.
> > > +config CROS_EC_WATCHDOG
> > > +	tristate "ChromeOS EC-based watchdog"
> > > +	select WATCHDOG_CORE
> > > +	depends on CROS_EC
> > > +	help
> > > +	  Watchdog driver for Chromebook devices equipped with embedded controller.
> > > +	  Trigger event is recorded in EC and checked on the subsequent boot.
> > 
> > Perhaps unrelated to the patch, but I'm curious what the mechanism is.  Does
> > it use any existing paths for checking the saved events in EC?  What it does
> > if there is a saved WDT reset event?
> > 
> 
> Reporting the reason of the previous reset/restart is part of the watchdog API.

Oh, I see.  It is in cros_ec_wdt_probe(): `wdd->bootstatus`.

+static int cros_ec_wdt_probe(struct platform_device *pdev)
+{
[...]
+	arg.req.command = EC_HANG_DETECT_CMD_GET_STATUS;
+	ret = cros_ec_wdt_send_cmd(cros_ec, &arg);
[...]
+	if (arg.resp.status == EC_HANG_DETECT_AP_BOOT_EC_WDT)
+		wdd->bootstatus = WDIOF_CARDRESET;

