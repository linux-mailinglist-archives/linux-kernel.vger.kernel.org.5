Return-Path: <linux-kernel+bounces-81199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8974D8671E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7441C28383
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF8A53E07;
	Mon, 26 Feb 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DDrCoXDe"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E353818;
	Mon, 26 Feb 2024 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944286; cv=none; b=Yuhk3T2IkNq4dHYnrk0555dqaROmEVBKTNSWtS6Ww53X94bMaDeJ7wQVnoZ37LAxuAO10yN1GKmiR4fRBSOacMkwalKDESn0ME1NszEs1i685kkexesZ+roxJBrGKPfviQjw+XrrqTqJjBdjqNxk5shBbdhNpRAq4XxQYf277Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944286; c=relaxed/simple;
	bh=Yh4uJmsOYrQwN5g3SD4LmyI3xt/tWe1trAaD+pHWlx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f5jAXpNCyg8/98Nv/sDq9rcsR8QjeZDePLM5tKtbToG8EucUiR0dtfR4LGaVDa3WfZ/Xjz4z9JpGcrsgcbS6nsfg5gaXra7e0LOrKIkfA9YFqaUNx/qlSVUYM65cdYkeMHu2HQg5XLOIovf2QCQzVWZBGH1HIf1qnGjbTKhhBS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DDrCoXDe; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32E2D24000A;
	Mon, 26 Feb 2024 10:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/jayUSRVjpybZD3WxWT1q4xekLKiFI7st5oYv5V+jg=;
	b=DDrCoXDe3eXuMjrtasnZepDNu5tAKDw6NduQOARdFQTp/RU2aOKzoJrkm5DDaOLzLYanzf
	uGtLN7yJtowil+EvApOjaxjqROfc9OKN7G8V3frxG2TeGjnvD0G1cY2h3jjN0XttEfcvXV
	jjlied8vSz68+prRMHlV2ep86a2sFFuAtDQ9CHIVM5A86YFyr64uYCGcrpBAIAZAzBlsR1
	PGpcFtLQs/Gy2jLp8vMfQRSmg0F5t5kpi5jMeNVfFkUs3zgeM8N+Yr/6sbho+3pSgi9SSC
	qYYO8cT6s1ThAvUOaRKdoG6Pnjp67LkLvU+JnFyLlbtccmRyc9phIUvcJsZMlA==
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
Subject: Re: [PATCH v2 3/3] mtd: rawnand: stm32_fmc2: add MP25 support
Date: Mon, 26 Feb 2024 11:44:41 +0100
Message-Id: <20240226104441.489887-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219140505.85794-4-christophe.kerello@foss.st.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'0bfad3b3561d6f219b768d2a4265642ee9d31b1d'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-02-19 at 14:05:05 UTC, Christophe Kerello wrote:
> FMC2 IP supports up to 4 chip select. On MP1 SoC, only 2 of them are
> available when on MP25 SoC, the 4 chip select are available.
> 
> Let's use a platform data structure for parameters that will differ.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

