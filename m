Return-Path: <linux-kernel+bounces-138923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB36589FC09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B7AB2886E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6D17277C;
	Wed, 10 Apr 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYIsoepc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46662171654;
	Wed, 10 Apr 2024 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764430; cv=none; b=fDKD77pq42Q0bH3UDaEYEG3A1mGdTA1k2GsAKl1p7JQvLGJ2XgIV69LqoVgarOOoNIHcp8QezPtfNmLmX61HKhartHcVImbYj26Tbh9lg2BOcb6PwOPGlPs7k9EWcX3QplOxUCZFFEgDMWLpRQqxfYGk4s9NQYWLhini85HKn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764430; c=relaxed/simple;
	bh=SqPe3DfzT/ltHcfMna2d1NH1tRD4LDibXZWmRZyVL5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZWxqRwH/aauH6TL20Tdz631RYFiNQtV120bNi02j9+vwkACT7yc0J8jHBHc9d+qX9SzT2oYm+0e2dSFZif6IbSHIJBBOvw9lzXevpVhD8o43dvjiC9aZn/rkCP7MORd1IqCmHpJGdbCkGjGJq9bffxEqLqv4b1F4wiIz3LjSi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYIsoepc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0E0C433C7;
	Wed, 10 Apr 2024 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712764429;
	bh=SqPe3DfzT/ltHcfMna2d1NH1tRD4LDibXZWmRZyVL5M=;
	h=From:To:Cc:Subject:Date:From;
	b=AYIsoepcYFkCZZq3EohWBeJd6LXBDaGTUpupVmhLuy1ajqgKPH7whwY/7a01lO2lq
	 HnmQwa2/vD5YObh9yDPklhFHaVk3b/1C7+CQUkHueHcA79O2M95sB6oKzc63CjLpby
	 uUmyvpe1VdyKfiD9MjMDiwN5qxRKb7leyUysWMtvDxlmvBUILreKwYxMtwuL7oeIli
	 Hu4vTmGHZqfg3IR5NL2ZHQ0OaSVO9JxpnCoGoRrIzvuOaxQTncI2eOZaUVLWueqmU5
	 KGEjyaaSZ9CdIuYvM0Rz3Gu+AB0Jr0bonCHbmEXkLawTc0rLJS95/aUTI39/GjV8ry
	 pBRCsUdlIaazw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] clk: sifive: prci: fix module autoloading
Date: Wed, 10 Apr 2024 17:53:42 +0200
Message-Id: <20240410155342.224061-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.  Clocks are considered core
components, so usually they are built-in, however these can be built and
used as modules on some generic kernel.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/sifive/sifive-prci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index 25b8e1a80ddc..700a1be9ec47 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -611,6 +611,7 @@ static const struct of_device_id sifive_prci_of_match[] = {
 	{.compatible = "sifive,fu740-c000-prci", .data = &prci_clk_fu740},
 	{}
 };
+MODULE_DEVICE_TABLE(of, sifive_prci_of_match);
 
 static struct platform_driver sifive_prci_driver = {
 	.driver = {
-- 
2.34.1


