Return-Path: <linux-kernel+bounces-81200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C56AB86730A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EAFB3550B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9523839E;
	Mon, 26 Feb 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MoqjKKzW"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2792E54663;
	Mon, 26 Feb 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944290; cv=none; b=L72VvWhi7VHrl2SJiwQoRAMh/LwdTdGQjyN+taRqWRpJ8Ba+IzyYgeHomMkW2d3lGCB7811Vww67m2UHwLNTUTa7qwcO0LEind1jp7S6uL3o0vFLMCDJDxHPSzueIWVL5imz7qpEqJj6qQoueRFZsr1xEqy9yLaogTq2AuYat4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944290; c=relaxed/simple;
	bh=p4FzrSKtLqpdf2GkM0vLpgXgNXtRineCJJsAfVApjIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p2ZWcUFEr5dsHYXIbs8djEvH/VnwFtolWDIErrwHWbdHXVT5JIO7QyQACTvM5UStLijgF6EvphPxxeagiVZ7AbaPzmi1KFcz28H8zsjy09tG47SvfuXlkUPczZqYh6BYRFLsFloMd3XOmUxAulNFbNhCpjs8hMqOUN9/1HLRUQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MoqjKKzW; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA30AE0002;
	Mon, 26 Feb 2024 10:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AO4akNw+96Nu8tYAznJ+U/EWh5SkwWOrFAKal+L/WwY=;
	b=MoqjKKzWXG0b3EBe8D9j+rmKxHoUn0TlC8U+WLxwFy6KATGubMq+rkhE3TlWjpNWEYeMe5
	/xgaTNwLMeFUwEfo2IjJNWpYxMn0rJsNuuj0rcJho501SWMzUvwXijWRCii9gtN16CUCpL
	2H5sFXeWTbdSxQz2wx2Z5rGP6Ua33RC24ejaIH4Q7foyQA47I8ee+81vhjXpoUtydQHcK5
	mGnDEH3zN4nXz5gEVLOxGDKv6eXT61ewSjxeXkP4qnub/qnpGv1eHfG+r5UZ0QCZpS7oVv
	XC3768fpMK1InfB9vN5lO45qmKJcr1mPYyeAkdGbfWC4pDTuGvmGVJCvaDTCFw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christophe Kerello <christophe.kerello@foss.st.com>,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mtd: rawnand: stm32_fmc2: use dma_get_slave_caps to get DMA max burst
Date: Mon, 26 Feb 2024 11:44:45 +0100
Message-Id: <20240226104445.489926-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219140505.85794-3-christophe.kerello@foss.st.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a9ae475cc60d908dfd232d1c064fc34ec51d3228'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-02-19 at 14:05:04 UTC, Christophe Kerello wrote:
> Use dma_get_slave_caps API to get the max burst size of a DMA channel.
> 
> For MP1 SoCs, MDMA is used and the max burst size is 128.
> For MP25 SoC, DMA3 is used and the max burst size is 64.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

