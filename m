Return-Path: <linux-kernel+bounces-17752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466C82520C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011971F24E70
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECF224A13;
	Fri,  5 Jan 2024 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XvBMOKWv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77599250E7;
	Fri,  5 Jan 2024 10:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61627C433C7;
	Fri,  5 Jan 2024 10:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704450774;
	bh=tAtGPzyENe7G8V+fHZtEGeUbT9NOsNspX0RJlOE6D7g=;
	h=From:To:Cc:Subject:Date:From;
	b=XvBMOKWvx8Ihe9KWS7Xectnpfug8yO72QOOc4B2sgHXITIfWrS9HqDO1TGQltXTRf
	 vbG9e9YXxghuZYH21HDTNjZn8JTnkUhOE19GkfDHEcWD6SW2IX7uZLNehpNWdofx42
	 UuCGkto3q9uTq6EGlVX0YXEAzrzjWOfxpU22E2fs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: make spi_bus_type const
Date: Fri,  5 Jan 2024 11:32:50 +0100
Message-ID: <2024010549-erasure-swoop-1cc6@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 40
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=tAtGPzyENe7G8V+fHZtEGeUbT9NOsNspX0RJlOE6D7g=; b=owGbwMvMwCRo6H6F97bub03G02pJDKnTb13iW7v2mPKxmbuzzdd9fqhSfezLz7tp0etP1/c/c 9iypWOOfkcsC4MgE4OsmCLLl208R/dXHFL0MrQ9DTOHlQlkCAMXpwBMxKKZYQ5Pbqy9l+VZDV7z P9fvvt+yMapSSZBhweSzN++FlLXxX12a/2J32qN7HporQwE=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the spi_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi.c       | 2 +-
 include/linux/spi/spi.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8ead7acb99f3..6e962befc450 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -459,7 +459,7 @@ static void spi_shutdown(struct device *dev)
 	}
 }
 
-struct bus_type spi_bus_type = {
+const struct bus_type spi_bus_type = {
 	.name		= "spi",
 	.dev_groups	= spi_dev_groups,
 	.match		= spi_match_device,
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 255a0562aea5..f6c157dee55d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -33,7 +33,7 @@ struct spi_message;
  * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
  * and SPI infrastructure.
  */
-extern struct bus_type spi_bus_type;
+extern const struct bus_type spi_bus_type;
 
 /**
  * struct spi_statistics - statistics for spi transfers
-- 
2.43.0


