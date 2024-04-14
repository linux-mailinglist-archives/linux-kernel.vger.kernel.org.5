Return-Path: <linux-kernel+bounces-144246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A5E8A438E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11B671C20F72
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752C91350CD;
	Sun, 14 Apr 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZPjXU7W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F95134CC7;
	Sun, 14 Apr 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713109755; cv=none; b=O1b5Uf+1BV2K2sMGs7Cx4E4XqC7/joMeATmsgf6WbkZR6bTz/guQECRaZxM6QHJd0SpurSGXmDESO1P9pzXOLM+kpD0n3FniYPQ0vqWzNAA+T3owsrd/TWPKSPLLKFgwQRzZPm4VR6KeUqwLV2TDg4eTZVkjjirHnCCsMwzrq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713109755; c=relaxed/simple;
	bh=34SiSDZmYoSCnzn+MGvb0W5lkGNJkoDDUf/EzBsQsCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O6TDhrxRs4573DLW6KxhdNQEgYjCRvnzAEHKbsTUSO9VnYCcWNW0uIk0r5nNE0R7VAw5fytivn+U7w+pnRvX9iSBBvgRkqxzCijtQFxO7uNDsJ9X2HsZ0hjAfYrPz8ksMtZEG8KVSvTdklh07bM07c/e3E2o+2fIP2A3Rnpzwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZPjXU7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AC0C072AA;
	Sun, 14 Apr 2024 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713109755;
	bh=34SiSDZmYoSCnzn+MGvb0W5lkGNJkoDDUf/EzBsQsCs=;
	h=From:To:Cc:Subject:Date:From;
	b=lZPjXU7W7oxvFN9ssZdptZzsSWQUud/aNLnYdiGz+WlmGvan+TvLFBQcM/6n0DMC8
	 dNzr3+UJ1xyvMjbu5ATYjt1OcRF94lc2TDvw0of88Z34kAOl2oeu5Qqn4K5JhhASly
	 aYz9G/611jpUOj+99PgsgeMMRb4qSPFIwWoqcZaUNjdoOsitc0k/msJ2f4uNMIE6eb
	 vht7Zmp4BxXajqewvBEw85/WbLhSIAx/Eg+4MY0NgD/181rFfs+G0WcxkkZs9miGDN
	 6daIOlRXiqzODOKe7FiLiuZwUlgcd1Ez53tKxbWKxYeTY64sNaxxsbPrn9w0KI3ODn
	 KHjV7KokLTJ3w==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] rtc: mcp795: drop unneeded MODULE_ALIAS
Date: Sun, 14 Apr 2024 17:49:10 +0200
Message-Id: <20240414154910.126991-1-krzk@kernel.org>
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
 drivers/rtc/rtc-mcp795.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 0d515b3df571..e12f0f806ec4 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -450,4 +450,3 @@ module_spi_driver(mcp795_driver);
 MODULE_DESCRIPTION("MCP795 RTC SPI Driver");
 MODULE_AUTHOR("Josef Gajdusek <atx@atx.name>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:mcp795");
-- 
2.34.1


