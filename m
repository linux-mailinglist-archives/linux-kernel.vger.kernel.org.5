Return-Path: <linux-kernel+bounces-81183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581FA8671C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE9C1F27932
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041E81DA53;
	Mon, 26 Feb 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S8PzLHDW"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3B4D110;
	Mon, 26 Feb 2024 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944216; cv=none; b=AyWGX/Kx8tU+X55b/A03suq7zx9KhOBzzBqLgsGu9sVO9bHB3akO0sXQZGclvgBwq3l30EgipWDjyI0iIAiW441AStYNbN8ilRV5Nqwlu4dsJDmX5QmBAxT9uHndDqfmOZAe3gDKuobrID1/kbXUWK3O1kpiHdyDWeOSWUB+tFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944216; c=relaxed/simple;
	bh=xZZaRwo+VE+JdIuDLOxMgKt7d4lhYqHZZw3SmZSBi1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ieQZ2t23LvyiqxrUxRxS0G7qyxusRHN6O7qdVJ3bhOAVY2fk8VfsX9F2RIh//T8i9XtJy6jicWdyOTeJfNePzV29T2x6T96BCyrH4AqPMddgyiL6z5u22wPi3KziWzO8vh29BUNVHPaq32lhHfPAnIaNjNR2ITHnLGXTxzIfb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S8PzLHDW; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 366601BF209;
	Mon, 26 Feb 2024 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Im0dd+xV/6aatIfuvAgE4yr1Ev4gmz/X+TFs9Fz1xS0=;
	b=S8PzLHDWRECMzBtDc2peHSLxHlwYDZ1H8GfPZYWaujpl4a6nSbjTDS/WmOKC+xJTVC6RKU
	yn4s1Gh5EKOzzoxSuxaI6RjjbuXbF0Imh7Tg1V3pm7b9Oq7O0krAlEPFyEtTW5oZ/+JMfo
	aB/M7/cbw1WkCjXyyc6SPOhACpWV0bQvIrxcZKerJb75XZhKmeo1N0PDrcy8bSGiD1/aH7
	gmWAAzRvCTDDcjGWNjrqGY45VKu9lmmp8UQoX9mfs5pNwmGmoirOGZpG/l/Cm5aZnL5wbu
	epHBBqapYoQ6r5OgTo0umgITEkK1GEe0lK3Uf78RFjEEEVC3dCr4uasJWLwrZA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Nayab Sayed <nayabbasha.sayed@microchip.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Agner <stefan@agner.ch>,
	Lucas Stach <dev@lynxeye.de>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Han Xu <han.xu@nxp.com>
Cc: linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: update references from partition.txt to mtd.yaml
Date: Mon, 26 Feb 2024 11:43:29 +0100
Message-Id: <20240226104329.489122-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208-partition-txt-v1-1-4398af3b7bb2@microchip.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'8709aa3e9d7ed8aadf0ba193821c8a2b692092a1'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Thu, 2024-02-08 at 11:42:12 UTC, Nayab Sayed wrote:
> Commit f902baa917b6 ("dt-bindings: mtd: Remove useless file about
> partitions") removed the file partition.txt. Hence, in this commit, the
> lines mentioning this file are updated to reference mtd.yaml, which now
> includes partition{,s}.yaml.
> 
> Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

