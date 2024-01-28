Return-Path: <linux-kernel+bounces-41518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A68B83F397
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B951F226A4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926333E8;
	Sun, 28 Jan 2024 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YWE4fiJz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6456ABA;
	Sun, 28 Jan 2024 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706411425; cv=none; b=cuIu8qrybH/K0OSL3MxDN312ODO+oRAV4VFlHNwSjYgUu8+gz6iMgVsAQ2ufE3uXwB/rvbY6FQEdZAgCy2QZyXC2AVnNIeI6712z1dKD/vbFUt1e+PCHzkm4M4b69y8+YHAik+H/ZdzZKbPC5o7bkYMflsQA5DptD6XHUzknKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706411425; c=relaxed/simple;
	bh=D4gdYc7UzEVDuU1MVc5undoqnjKwSTTGN6dXiJDSFMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNNtd2VQIYps1MSuGpqifDk9gQT8aMh4V5v9/YEq+klB3Gl1BYvTIhPlch2ngJiOk2Qu7E5q90A8JEM8q+nVi5+tGY0uOrD1673TDWFwpPGzhfWHzLrJLxbJjdYuv1rZ3IQKK1fhGVQarj4uhjjWK1aRW/X8TODS/fHin2tdTHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YWE4fiJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E7AC433F1;
	Sun, 28 Jan 2024 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706411425;
	bh=D4gdYc7UzEVDuU1MVc5undoqnjKwSTTGN6dXiJDSFMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWE4fiJzKa1bvcVe9R4ZAgLPOe5ZjEsrTQEBu4Dep2d52UxNB1FwocQB0BN4kBrwM
	 TEx7/2va2xipWaPSZ15x/E0tUx5AdmZhjz4mr/qot5H5yy3mxwmcZ+XcavMPNNMXDM
	 W076qRfNp9KdPVFUro1xDPqS71GhFhXTc7N9R/bg=
Date: Sat, 27 Jan 2024 19:10:24 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
	u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
	hugo@hugovil.com, m.brock@vanmierlo.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v8 0/7] Fixes and improvements for RS485
Message-ID: <2024012705-railcar-hermit-1d3b@gregkh>
References: <20240105141153.19249-1-l.sanfilippo@kunbus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105141153.19249-1-l.sanfilippo@kunbus.com>

On Fri, Jan 05, 2024 at 03:11:46PM +0100, Lino Sanfilippo wrote:
> The following series includes some fixes and improvements around RS485 in
> the serial core and UART drivers:
> 
> Patch 1: serial: Do not hold the port lock when setting rx-during-tx GPIO
> Patch 2: serial: core: set missing supported flag for RX during TX GPIO
> Patch 3: serial: core: fix sanitizing check for RTS settings
> Patch 4: serial: core: make sure RS485 cannot be enabled when it is not
> supported
> Patch 5: serial: core, imx: do not set RS485 enabled if it is not supported
> Patch 6: serial: omap: do not override settings for RS485 support
> Patch 7: serial: 8250_exar: Set missing rs485_supported flag
> 
> Changes in v8:
> - remove wrong setting of SER_RS485_RX_DURING_TX introduced with patch
>   version 7 (pointed out by Ilpo)
> - fix commit message as pointed out by Ilpo

Aren't these already in the tree?  None of them apply, what am I doing
wrong?

confused,

greg k-h

