Return-Path: <linux-kernel+bounces-144248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F038A4392
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA521C210D8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C29134CCB;
	Sun, 14 Apr 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZVWOTpb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8680134751
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713109791; cv=none; b=HWPzjBBkUPsHx0jeQ50+EGq7At457Qc6uygL55mZB6A24by974XREnR8iwZndHwTFTJtJ7fQ/7UF3D7BsirLlOjyGDkNwLiKna0e610DWpxEWT2Ruaao+oLFgCJ3JYkEZWtAMw5kVkWVjLcpzJcIaxFI9tGyEStKkb4goGG+UZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713109791; c=relaxed/simple;
	bh=F/dkFtRddbz2rD/46WKCGJKyqSMQqrDqq6p70dPALoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sc4Z80bqKooaPwe+zaqoKm04jOxff8g7MaTFXZree5/7VB0cv9EzjL4QouOIOkSTWf2irYsra3kuljZixcqEKreljiGMKwjcgUJBQZlZZJuP+llHGb2xMaqFBYrxQ4/rC84eq1ZnwvujiY6X+a6RisHLchTOG7RoW35MSbs5sfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZVWOTpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3C1C072AA;
	Sun, 14 Apr 2024 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713109791;
	bh=F/dkFtRddbz2rD/46WKCGJKyqSMQqrDqq6p70dPALoU=;
	h=From:To:Cc:Subject:Date:From;
	b=XZVWOTpbFrQZAB85iDt61M2Qm9xqLW8Cf3CviBbVimbvg497DZ07PI8GKunHo6K8m
	 7oAYuTi5Wnz4aAnQ+pT7TADMbegRgTeCtFUIKR60QEkLMfHlAkssyZ7z3IICLZJdgF
	 cE51ExVCxUZT3LIRyN+81c1OxXwLbvQaTJtJGa29O1CQMfR2LIYS/iWAXvKYOzUc/P
	 yKK7ieyPeAFlotHYAK2Nq5vKcIdQzUrWJEvh680PTGSE9uZBBKEFNwnSOl1aHMW53S
	 yO5cPpjJdTq8Ok7Q65NK0UvdGeGqdaReE+8W6a0b4I62uYL7rRMBnQ4Zar/FG2qJQY
	 e/0qgYELZSSCw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] mtd: mchp23k256: drop unneeded MODULE_ALIAS
Date: Sun, 14 Apr 2024 17:49:43 +0200
Message-Id: <20240414154943.127079-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ID table already has respective entry and MODULE_DEVICE_TABLE and
creates proper alias for SPI driver.  Having another MODULE_ALIAS causes
the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mtd/devices/mchp23k256.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/devices/mchp23k256.c b/drivers/mtd/devices/mchp23k256.c
index d533475fda15..cef5f9677d39 100644
--- a/drivers/mtd/devices/mchp23k256.c
+++ b/drivers/mtd/devices/mchp23k256.c
@@ -257,4 +257,3 @@ module_spi_driver(mchp23k256_driver);
 MODULE_DESCRIPTION("MTD SPI driver for MCHP23K256 RAM chips");
 MODULE_AUTHOR("Andrew Lunn <andre@lunn.ch>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:mchp23k256");
-- 
2.34.1


