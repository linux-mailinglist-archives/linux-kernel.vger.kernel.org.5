Return-Path: <linux-kernel+bounces-116811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0988A429
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8A72E517B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8078612F5AB;
	Mon, 25 Mar 2024 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PU3gBbuG"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDB12FB32;
	Mon, 25 Mar 2024 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361920; cv=none; b=meS3S7+a50YufSuLIV2F17PgOYf6qEXrWTmZGYPGAJ6bAPchVANZKlannt8IbEZkiaG8GmYT9RXfPqymhWNrp2K9zW3GE6d6UeLRoKZEyg5pj7XdX+qqva6cxscILnRqWTUQqdSZYrDXxhmNNSugWmIam5FXfUi01lxcjCCqRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361920; c=relaxed/simple;
	bh=DCAnjdLm8/tipGbWNbbUh0xHQlyrHHYO4HN/R30DK88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WkI6Xl5B78tZaWBHrGzDo18nYGa7fGL9drdMbPwmrWRDX1RymmIusssXG+OJ6ES+Wi4fxQoQSfBxnsF6pGVUg7nM+lM6OXMyosrI0paOkYGbWmz4/GJoyGhO5kc4bjwZyPbsBhTvVgNvUv576ThHc1wZNfiFrTM/QaqQFUE8T/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PU3gBbuG; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9BF7C000B;
	Mon, 25 Mar 2024 10:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711361915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ+47P+RHmGvxe+WTJ+sohpvSvUI9IclV23BMTd4mZ0=;
	b=PU3gBbuG8C4gJV4/r2P6rGSYICdiI1h4uO21LKWuX9FS8pFhqRMDq9VQJTtIMAFLIS686l
	5HsSs2x0RJA7Qwuo0e1XKpamWhn1+ZGoZByFQKM5rYpKp6CEbpVKIdlM2GzanGu8XZM8V/
	+HGvVcaiMA9T0HyzkZDOePVFXFc8AlihHAfK1/IzHWNl3aqTBazNzO+vd/TqmBtJokbkFi
	MlPwB404kD9sy32p1qXKcqdpkE6ZjLSg2jdEc/lu6aNK/+Y3fdK1RXDOmNfs9DAt6RryZm
	EGWRoifHlLlIGgDg1sie1wazgVT/ghjYmMJHeiLCushsHl1IjtNSe2jDshzzyw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v3] mtd: limit OTP NVMEM Cell parse to non Nand devices
Date: Mon, 25 Mar 2024 11:18:34 +0100
Message-Id: <20240325101834.262354-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240322040951.16680-1-ansuelsmth@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b0a53dc56c145b8b2c13b43eba2c9ef0507f9840'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-03-22 at 04:09:49 UTC, Christian Marangi wrote:
> MTD OTP logic is very fragile and can be problematic with some specific
> kind of devices.
> 
> NVMEM across the years had various iteration on how Cells could be
> declared in DT and MTD OTP probably was left behind and
> add_legacy_fixed_of_cells was enabled without thinking of the consequences.
> 
> That option enables NVMEM to scan the provided of_node and treat each
> child as a NVMEM Cell, this was to support legacy NVMEM implementation
> and don't cause regression.
> 
> This is problematic if we have devices like Nand where the OTP is
> triggered by setting a special mode in the flash. In this context real
> partitions declared in the Nand node are registered as OTP Cells and
> this cause probe fail with -EINVAL error.
> 
> This was never notice due to the fact that till now, no Nand supported
> the OTP feature. With commit e87161321a40 ("mtd: rawnand: macronix: OTP
> access for MX30LFxG18AC") this changed and coincidentally this Nand is
> used on an FritzBox 7530 supported on OpenWrt.
> 
> Alternative and more robust way to declare OTP Cells are already
> prossible by using the fixed-layout node or by declaring a child node
> with the compatible set to "otp-user" or "otp-factory".
> 
> To fix this and limit any regression with other MTD that makes use of
> declaring OTP as direct child of the dev node, disable
> add_legacy_fixed_of_cells if we detect the MTD type is Nand.
> 
> With the following logic, the OTP NVMEM entry is correctly created with
> no Cells and the MTD Nand is correctly probed and partitions are
> correctly exposed.
> 
> Fixes: 2cc3b37f5b6d ("nvmem: add explicit config option to read old syntax fixed OF cells")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel

