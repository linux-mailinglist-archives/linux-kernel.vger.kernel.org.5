Return-Path: <linux-kernel+bounces-50304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F03847737
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293DAB275F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2C514D434;
	Fri,  2 Feb 2024 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKy92vuR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9E14AD10;
	Fri,  2 Feb 2024 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897782; cv=none; b=Fzh0HrUKLMDzbRcPkSv3HY+JC6baF5GjgD0HZBlpl3KJfTdki+BbcGpD3QqTwZfENJtzdiIY1PZqqIT+FbKrc9+5O67a8SL3svCZ8ldX42HQP/Rdek88J/Wca5lbQBtZ6fPTj+FB16z7cO5ZW2A8NOcFc/zz5mD+5Eonmkhj8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897782; c=relaxed/simple;
	bh=nzaDdjcfPayXh4qIG8StvPK20F+fr27KrMWe3tHTVYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=djbz7W3F/M8RMCIZ9uJDfIsmTcLAjwO9ZnMEfeZU86tW4A+ZDIVKjpyXVKlLCJd4rZ5rnHdBef1uczFOWCZuO7usnR3g6QnIhjWAHk0BLmozogvxiwtcZaMflvc//qL4h4Ab+rg+ex8DVDv6bLKhfoHzqLDZBBn1SzZ9dPmqg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKy92vuR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706897781; x=1738433781;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=nzaDdjcfPayXh4qIG8StvPK20F+fr27KrMWe3tHTVYc=;
  b=GKy92vuRH7cZgi04sr30nvhMdDkwfqD/JLB+Skq/YCLNKid/Q/9XPAYv
   yBEdKp3tfqiqv7hFHYlgXnFhuACkTB4tby40PTR0u3vtHgs5dpV7WmoBp
   dhLDypqJcfRMJTzMNVYnhZ202LaFl7+DwSx4ayQcqSfUgIUhd3l9RiOg2
   to84bIlMlGcT6wmjiotP2ufHWOQT+PQJ/bcm4URTDNDk9LdbX39aghq70
   cyPVLXbby0BMuTQO3DMmgRmTafLcozelgq9ODBN/Ss/KGDpSHmFYp2ZMt
   A1Xsil6ZZVN2PV+0gfXIJ9IrRGB30aUkI9bXby0MuSYOwZa9xFBoLUMmw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17623706"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="17623706"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 10:16:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4747421"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.160.232])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 10:16:19 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 02 Feb 2024 10:16:19 -0800
Subject: [PATCH] acpi/ghes: Prevent sleeping with spinlock held
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-cxl-cper-smatch-v1-1-7a4103c7f5a0@intel.com>
X-B4-Tracking: v=1; b=H4sIAHIxvWUC/x2MQQqAIBAAvyJ7bkEXD9VXooPZlgtlohFB9Pckm
 MscZh4onIUL9OqBzJcUOWIV0yjwwcWVUebqQJqsJm3Q3xv6xBnL7k4fsKXJUGe7tgK1SpkXuf/
 jML7vBztUPm5hAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@Huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706897778; l=2362;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=nzaDdjcfPayXh4qIG8StvPK20F+fr27KrMWe3tHTVYc=;
 b=F9rjbrfKk6RcbUwsD27CBnFnQJvDp/y0gj0O2zXp9+uSl5dLtFILK6JSrVFraw2H71usgPOqa
 l9v/bIJngtgAECJAr/BuZYQebcbX3btEztGxiIW4oA1EpXYxT7ZCNeu
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Smatch caught that cxl_cper_post_event() is called with a spinlock held
or preemption disabled.[1]  There is no need for the callback to sleep.

Replace the RW semaphore with a RW lock.

A static call was considered but ARM does not select HAVE_STATIC_CALL
and in that case setting the function pointer uses a RW semaphore.

[1] https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/acpi/apei/ghes.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 7b7c605166e0..bdc0ec2813a3 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -39,6 +39,7 @@
 #include <linux/aer.h>
 #include <linux/nmi.h>
 #include <linux/sched/clock.h>
+#include <linux/spinlock.h>
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
@@ -677,7 +678,7 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 /*
  * Only a single callback can be registered for CXL CPER events.
  */
-static DECLARE_RWSEM(cxl_cper_rw_sem);
+static DEFINE_RWLOCK(cxl_callback_lock);
 static cxl_cper_callback cper_callback;
 
 /* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
@@ -721,14 +722,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 		return;
 	}
 
-	guard(rwsem_read)(&cxl_cper_rw_sem);
+	guard(read_lock_irqsave)(&cxl_callback_lock);
 	if (cper_callback)
 		cper_callback(event_type, rec);
 }
 
 int cxl_cper_register_callback(cxl_cper_callback callback)
 {
-	guard(rwsem_write)(&cxl_cper_rw_sem);
+	guard(write_lock_irq)(&cxl_callback_lock);
 	if (cper_callback)
 		return -EINVAL;
 	cper_callback = callback;
@@ -738,7 +739,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_register_callback, CXL);
 
 int cxl_cper_unregister_callback(cxl_cper_callback callback)
 {
-	guard(rwsem_write)(&cxl_cper_rw_sem);
+	guard(write_lock_irq)(&cxl_callback_lock);
 	if (callback != cper_callback)
 		return -EINVAL;
 	cper_callback = NULL;

---
base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
change-id: 20240201-cxl-cper-smatch-82b129498498

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


