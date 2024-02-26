Return-Path: <linux-kernel+bounces-81182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A36A8671C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA7E1C2266F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC773F9D6;
	Mon, 26 Feb 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aY7rMA4y"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D2208A0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944210; cv=none; b=NRllh046hluGYzUX7tGMq2cnv9BuxVCls51LIZB7nM3UHKpQxTYyV0xvdYHpgSRPRyHZTdgp6roaEhAOsrDOOG+hr20F2y2/qMz1rkRenmtu3adFLol3JJU0X1mWkBOIAZyJ+ifFBhPzNomapQrEPKJXoGuIZyrvuV16Aoovxaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944210; c=relaxed/simple;
	bh=6GYdmKkrWThQ8ewNSAsBzQOqulFp3beYSDKgtUMuCtc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i9Ok5j7Zec87KeGkNP3qx27+0ikh8v9Gy4u9OtKOnKvFQKfPXOA9ERPvobkh6XtQtjifk8m24obx+yHHSd5nPo2Ferx0EjBaXjrbbFkHwlRe5f2YSmbNjqXf7kkxqx6m9FbYmjtHBmUZHK1Si6LSOJsnJG6Rh/kdFE0fJvqU7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aY7rMA4y; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C683A40023;
	Mon, 26 Feb 2024 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iiDx69rBn44PBfSXRrZ4ojskwBHY1Kqig+sdNaTzSgE=;
	b=aY7rMA4yJ9RonYLN3+KQvxeTbm7aiwjhNJc1DB4cvydcuf1ak/b7E0tAZqa2iSCJSwVc1T
	mQ/MwCVu/bfpakOHnT04dXX9MZGoqZJjPbfiyNYEbraK+oZREWD2RN/wfgqPLCdHGSd4hy
	jmdR2mbu9upeHsboD6s/GmFg8tGzUw7k+VNzDhUMwTRPG0ZPR3ZuZgzDc6m1TPH8PKas7G
	lHL7WJ+ehxqYRUNsOhdT7E6/vcfDOJcUnHLLElDxDaehvGd9Qa11fXZMcjeQ0bZ2KRt7iO
	/bPFzPJZ4PCZm4/QaCiXm3t5l3J4+LGAlz/IHrfLzvJYsrBigbr3osOPXLh5Qg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: lpc32xx: use typedef for dma_filter_fn
Date: Mon, 26 Feb 2024 11:43:26 +0100
Message-Id: <20240226104326.489058-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208202113.630190-1-krzysztof.kozlowski@linaro.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f1d00496a15bcdfe54bdb54cf1e7f207d6ad9b79'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-02-08 at 20:21:13 UTC, Krzysztof Kozlowski wrote:
> Use existing typedef for dma_filter_fn to avoid duplicating type
> definition.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Vladimir Zapolskiy <vz@mleia.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

