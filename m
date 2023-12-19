Return-Path: <linux-kernel+bounces-5270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 646048188C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B2B1F23772
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6114199AD;
	Tue, 19 Dec 2023 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ClGsWkTw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF119471;
	Tue, 19 Dec 2023 13:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508A6C433C7;
	Tue, 19 Dec 2023 13:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702993310;
	bh=F6ar0VqlrkPhdaatE1FLgFCrEDi1gq3l55wVb/ojN9w=;
	h=From:To:Cc:Subject:Date:From;
	b=ClGsWkTw0Noy5KB0LJ5GhsqpJozgFV7MSyHlFPhrh96qDaajKX8+H2kqD9Svd3IxY
	 CO+VR+Ca7wSECggtfKKf8o9u1tOErpLpw2qpgy/U7FSCVxKSseZVMhq+6dG0W6sej0
	 j0ih/zq0r/CTXT+WyY80ouDSt8T9Jak0Bz+ZTVck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: hch@lst.de,
	m.szyprowski@samsung.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: [PATCH] dma-debug: make dma_debug_add_bus take a const pointer
Date: Tue, 19 Dec 2023 14:41:42 +0100
Message-ID: <2023121941-dejected-nugget-681e@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 47
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=F6ar0VqlrkPhdaatE1FLgFCrEDi1gq3l55wVb/ojN9w=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNc6e2Hm2dtNjAb48Td1VWxdacZ2x//KI6RKMV169z+ xWxlC+hI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACby1ZFhnpb8PKZVb6RfbLzR dbF5He8WzqOFVgwLlsfOYvq1+UZnech0Y/21E1a5iT9PBAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The driver core now can handle a const struct bus_type pointer, and the
dma_debug_add_bus() call just passes on the pointer give to it to the
driver core, so make this pointer const as well to allow everyone to use
read-only struct bus_type pointers going forward.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/dma-map-ops.h | 4 ++--
 kernel/dma/debug.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index f2fc203fb8a1..e401f824a007 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -443,10 +443,10 @@ static inline void arch_teardown_dma_ops(struct device *dev)
 #endif /* CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS */
 
 #ifdef CONFIG_DMA_API_DEBUG
-void dma_debug_add_bus(struct bus_type *bus);
+void dma_debug_add_bus(const struct bus_type *bus);
 void debug_dma_dump_mappings(struct device *dev);
 #else
-static inline void dma_debug_add_bus(struct bus_type *bus)
+static inline void dma_debug_add_bus(const struct bus_type *bus)
 {
 }
 static inline void debug_dma_dump_mappings(struct device *dev)
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 3de494375b7b..1a5c86dd87d5 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -876,7 +876,7 @@ static int dma_debug_device_change(struct notifier_block *nb, unsigned long acti
 	return 0;
 }
 
-void dma_debug_add_bus(struct bus_type *bus)
+void dma_debug_add_bus(const struct bus_type *bus)
 {
 	struct notifier_block *nb;
 
-- 
2.43.0


