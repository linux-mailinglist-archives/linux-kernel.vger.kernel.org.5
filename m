Return-Path: <linux-kernel+bounces-30746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567648323DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074511F241AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4691C30;
	Fri, 19 Jan 2024 03:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHK76tAx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5644A08;
	Fri, 19 Jan 2024 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705635727; cv=none; b=lkgyLPQ2ylI3Bl4lrcD10i/5to9Tskenaz2gi23DK4pIQJRE3zCDJ3t9Tvuebg9rJi7JWGKiFZ91xNKcjyHcCN648tD7ZK8bJmWN5KxU63fKp8La2NxPkg2YxG8jDEbJUBMjmfxPQZRBbCpxIsniCTqcKAG9X0Bf+uiE8mo1pNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705635727; c=relaxed/simple;
	bh=YpVS4Q7IIaaSBKna4qlBv8sg0AC0Zli2m3DZyh6MjWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpYc+vdAgR6VVFWsFy99xvt9C5foFF9uXP8qb0jMPqgumHzo1Y6YrG+G9WxCef7en0FziUmPU8TNHGeGvZUhOpoK5C/21qr+LPOKWhHgoUoi7n3S4/zGfJ+alUT6uXb+oyWl3B8NPF+pmQO8LIlB/aObkGgD5tkVBN2NTN5vgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHK76tAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2E5C433F1;
	Fri, 19 Jan 2024 03:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705635726;
	bh=YpVS4Q7IIaaSBKna4qlBv8sg0AC0Zli2m3DZyh6MjWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AHK76tAxUHF1Jbc32u/YuQmPk+m36o0w8CjAbovo5A2A5A2MsJZuAQ+e2ncQmXOt6
	 X4045z19yvgTQ056Ha2LSLpWnZWgzj6pCRv9PnMddtx/jIi1qFSqZ+/5hWz7nys3Xg
	 ot9kjTm8uLowQvudvokG40q0qzIJumWjRteIQsr9OwLQZWNw1v+Z+PZwfawDi46pdK
	 SKeinYiR7W9vbJ+sQTNzBgSXvDSjph0O+Vu6C8W6d7Wt8NC7ptvMUwADHxa5e67/GK
	 NGcPhHZdTe9s6kXpfTCvlyewsIQN/FsitJb/gz6BAeO1lhdb7n7C3r0NcEW6lz8AsJ
	 iI05OAfb3bEjQ==
Date: Fri, 19 Jan 2024 11:42:03 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Lukasz Majczak <lma@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 2/3] watchdog: Add ChromeOS EC-based watchdog driver
Message-ID: <Zanvi4ih0zhC4aG7@google.com>
References: <20240118195325.2964918-1-lma@chromium.org>
 <20240118195325.2964918-3-lma@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118195325.2964918-3-lma@chromium.org>

On Thu, Jan 18, 2024 at 07:53:23PM +0000, Lukasz Majczak wrote:
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 7d22051b15a2..4700b218340f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -181,6 +181,17 @@ config BD957XMUF_WATCHDOG
>  	  watchdog. Alternatively say M to compile the driver as a module,
>  	  which will be called bd9576_wdt.
>  
> +config CROS_EC_WATCHDOG
> +	tristate "ChromeOS EC-based watchdog"
> +	select WATCHDOG_CORE
> +	depends on CROS_EC
> +	help
> +	  Watchdog driver for Chromebook devices equipped with embedded controller.
> +	  Trigger event is recorded in EC and checked on the subsequent boot.

Perhaps unrelated to the patch, but I'm curious what the mechanism is.  Does
it use any existing paths for checking the saved events in EC?  What it does
if there is a saved WDT reset event?

> diff --git a/drivers/watchdog/cros_ec_wdt.c b/drivers/watchdog/cros_ec_wdt.c
[...]
> +static int cros_ec_wdt_ping(struct watchdog_device *wdd)
> +{
[...]
> +	arg.req.command = EC_HANG_DETECT_CMD_RELOAD;
> +	ret = cros_ec_wdt_send_cmd(cros_ec, &arg);
> +	if (ret < 0)
> +		dev_dbg(wdd->parent, "Failed to ping watchdog (%d)", ret);

I think this would be worth dev_info() or dev_warn()?

> +static int cros_ec_wdt_start(struct watchdog_device *wdd)
> +{
[...]
> +	/* Prepare watchdog on EC side */
> +	arg.req.command = EC_HANG_DETECT_CMD_SET_TIMEOUT;
> +	arg.req.reboot_timeout_sec = wdd->timeout;
> +	ret = cros_ec_wdt_send_cmd(cros_ec, &arg);
> +	if (ret < 0)
> +		dev_dbg(wdd->parent, "Failed to start watchdog (%d)", ret);

Same here: dev_info() or dev_warn()?

> +static int cros_ec_wdt_stop(struct watchdog_device *wdd)
> +{
[...]
> +	arg.req.command = EC_HANG_DETECT_CMD_CANCEL;
> +	ret = cros_ec_wdt_send_cmd(cros_ec, &arg);
> +	if (ret < 0)
> +		dev_dbg(wdd->parent, "Failed to stop watchdog (%d)", ret);

Same here: dev_info() or dev_warn()?

> +static int cros_ec_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> +	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
> +	struct watchdog_device *wdd;
> +	union cros_ec_wdt_data arg;
> +	int ret = 0;

nit: `ret` doesn't need to be initialized.

