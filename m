Return-Path: <linux-kernel+bounces-5490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F8818B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7A9B22B2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3B1CA8A;
	Tue, 19 Dec 2023 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SQb2s3ai"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD21CA82
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D889C433CB;
	Tue, 19 Dec 2023 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703000115;
	bh=VQdJED1b/NVo+u44VQrG/0nsxcY5pA0NStWSLWGhQ/4=;
	h=From:To:Cc:Subject:Date:From;
	b=SQb2s3aiuJQFqu6A9r3uacHBLEChhjPJ1zyi7QABAWg3yqAzT5F0erz2jTtr4+LN+
	 olJJg1UCCTLzPupzeeZTdl5pTdpcGyY/lYdyJGXVTw9cNydN26OIgbsiHYmsMshuoY
	 HzxfSq5kx4FAbzik2fJfbV/e/OB678nDugo58USA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: rafael@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	William Breathitt Gray <william.gray@linaro.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Kevin Hilman <khilman@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH] driver core: mark remaining local bus_type variables as const
Date: Tue, 19 Dec 2023 16:35:09 +0100
Message-ID: <2023121908-paver-follow-cc21@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 104
X-Developer-Signature: v=1; a=openpgp-sha256; l=3517; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=VQdJED1b/NVo+u44VQrG/0nsxcY5pA0NStWSLWGhQ/4=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNO3R4fydWHduft3mD5ZQ5nloeM7nnrOwo0RaKmWigs HLKQs2lHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRdlGGBR2cJ9f/eav+Z2q1 5e1bd9/e19dy2cKw4FjufMsJFdNfXreeNlND683h/asL1QA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
change the local driver core bus_type variables to be a constant
structure as well, placing them into read-only memory which can not be
modified at runtime.

Cc: Dave Ertman <david.m.ertman@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: William Breathitt Gray <william.gray@linaro.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/auxiliary.c    | 2 +-
 drivers/base/isa.c          | 2 +-
 drivers/base/memory.c       | 2 +-
 drivers/base/node.c         | 2 +-
 drivers/base/power/domain.c | 2 +-
 drivers/base/soc.c          | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 4d4c2c8d26c4..d3a2c40c2f12 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -244,7 +244,7 @@ static void auxiliary_bus_shutdown(struct device *dev)
 		auxdrv->shutdown(auxdev);
 }
 
-static struct bus_type auxiliary_bus_type = {
+static const struct bus_type auxiliary_bus_type = {
 	.name = "auxiliary",
 	.probe = auxiliary_bus_probe,
 	.remove = auxiliary_bus_remove,
diff --git a/drivers/base/isa.c b/drivers/base/isa.c
index 675ad3139224..e23d0b49a793 100644
--- a/drivers/base/isa.c
+++ b/drivers/base/isa.c
@@ -82,7 +82,7 @@ static int isa_bus_resume(struct device *dev)
 	return 0;
 }
 
-static struct bus_type isa_bus_type = {
+static const struct bus_type isa_bus_type = {
 	.name		= "isa",
 	.match		= isa_bus_match,
 	.probe		= isa_bus_probe,
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f3b9a4d0fa3b..4ac3266da6b5 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -68,7 +68,7 @@ static inline unsigned long phys_to_block_id(unsigned long phys)
 static int memory_subsys_online(struct device *dev);
 static int memory_subsys_offline(struct device *dev);
 
-static struct bus_type memory_subsys = {
+static const struct bus_type memory_subsys = {
 	.name = MEMORY_CLASS_NAME,
 	.dev_name = MEMORY_CLASS_NAME,
 	.online = memory_subsys_online,
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 4d588f4658c8..433897eecbdc 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -21,7 +21,7 @@
 #include <linux/swap.h>
 #include <linux/slab.h>
 
-static struct bus_type node_subsys = {
+static const struct bus_type node_subsys = {
 	.name = "node",
 	.dev_name = "node",
 };
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index da1777e39eaa..096871334cc7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2670,7 +2670,7 @@ static void genpd_release_dev(struct device *dev)
 	kfree(dev);
 }
 
-static struct bus_type genpd_bus_type = {
+static const struct bus_type genpd_bus_type = {
 	.name		= "genpd",
 };
 
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index c741d0845852..282c38aece0d 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -28,7 +28,7 @@ struct soc_device {
 	int soc_dev_num;
 };
 
-static struct bus_type soc_bus_type = {
+static const struct bus_type soc_bus_type = {
 	.name  = "soc",
 };
 static bool soc_bus_registered;
-- 
2.43.0


