Return-Path: <linux-kernel+bounces-107496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A587FD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D4D1F228ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53737F490;
	Tue, 19 Mar 2024 12:02:51 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF777F477
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849771; cv=none; b=Blu/QDgLkxAlQ0rMd/XCRuQjKoHpUxlPf4EMddv0piT5BU2X/Me9zw9GHz1iPExKJIou+8cT2qk02RJ2QFHPM08Z1me5umAxEZaYVkBxf+xcB72R5XHgbFWjh8go1f+7LDK9NUtI29WMPL78v14u2O8/tFOyTr3Eb2ZZK/u7QgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849771; c=relaxed/simple;
	bh=9qlVEEgkiofQfSTGom3u/q2TiFifUbc8dZUa3eEf6ek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QJEEVB8h+FQuR9aWgVEwUoF0UwT7Hd1g9oQI7dMbcQVk6cABBUPtfaWfP5VxO3BB8gT7ooxsMOf6EYtWE5kuVnagoluErp5krihIVpsnCug+y1WXVuDxtUP6yTQCH2euxrSo5sNbdc/xA/lAEaJqtIi0xe9I2SJtchTWgeWV6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by baptiste.telenet-ops.be with bizsmtp
	id 0c2f2C00M0SSLxL01c2fKD; Tue, 19 Mar 2024 13:02:39 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rmYAe-00456m-O0;
	Tue, 19 Mar 2024 13:02:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rmYAx-000jw4-Jm;
	Tue, 19 Mar 2024 13:02:39 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Mike Christie <michael.christie@oracle.com>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] scsi: core: Make scsi_lib KUnit tests modular for real
Date: Tue, 19 Mar 2024 13:02:29 +0100
Message-Id: <48ca5e827ca420bbdbabb1643e2179dc95c9e0b7.1710849638.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While SCSI_LIB_KUNIT_TEST is a tristate config symbol, configuring a
modular build of this test does not do anything: as the test code is
just included by the mid layer code, it only works in the built-in case.

Fix this by converting the test to a stand-alone module.  This requires
exporting scsi_check_passthrough() and adding a MODULE_LICENSE() tag.

Fixes: 25a1f7a0a1fe6fa6 ("scsi: core: Add kunit tests for scsi_check_passthrough()")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/scsi/Makefile        | 1 +
 drivers/scsi/scsi_lib.c      | 9 +++------
 drivers/scsi/scsi_lib_test.c | 4 ++++
 drivers/scsi/scsi_priv.h     | 2 ++
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index f055bfd54a6832b3..396a24aa43486678 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -149,6 +149,7 @@ obj-$(CONFIG_BLK_DEV_SR)	+= sr_mod.o
 obj-$(CONFIG_CHR_DEV_SG)	+= sg.o
 obj-$(CONFIG_CHR_DEV_SCH)	+= ch.o
 obj-$(CONFIG_SCSI_ENCLOSURE)	+= ses.o
+obj-$(CONFIG_SCSI_LIB_KUNIT_TEST) += scsi_lib_test.o
 
 obj-$(CONFIG_SCSI_HISI_SAS) += hisi_sas/
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2e28e2360c85740d..23e94e9bf85781a9 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -203,8 +203,8 @@ EXPORT_SYMBOL_GPL(scsi_failures_reset_retries);
  *
  * Returns -EAGAIN if the caller should retry else 0.
  */
-static int scsi_check_passthrough(struct scsi_cmnd *scmd,
-				  struct scsi_failures *failures)
+int scsi_check_passthrough(struct scsi_cmnd *scmd,
+			   struct scsi_failures *failures)
 {
 	struct scsi_failure *failure;
 	struct scsi_sense_hdr sshdr;
@@ -269,6 +269,7 @@ static int scsi_check_passthrough(struct scsi_cmnd *scmd,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(scsi_check_passthrough);
 
 /**
  * scsi_execute_cmd - insert request and wait for the result
@@ -3436,7 +3437,3 @@ void scsi_build_sense(struct scsi_cmnd *scmd, int desc, u8 key, u8 asc, u8 ascq)
 	scmd->result = SAM_STAT_CHECK_CONDITION;
 }
 EXPORT_SYMBOL_GPL(scsi_build_sense);
-
-#ifdef CONFIG_SCSI_LIB_KUNIT_TEST
-#include "scsi_lib_test.c"
-#endif
diff --git a/drivers/scsi/scsi_lib_test.c b/drivers/scsi/scsi_lib_test.c
index 99834426a100a754..13045ac12fa99d24 100644
--- a/drivers/scsi/scsi_lib_test.c
+++ b/drivers/scsi/scsi_lib_test.c
@@ -10,6 +10,8 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
 
+#include "scsi_priv.h"
+
 #define SCSI_LIB_TEST_MAX_ALLOWED 3
 #define SCSI_LIB_TEST_TOTAL_MAX_ALLOWED 5
 
@@ -328,3 +330,5 @@ static struct kunit_suite scsi_lib_test_suite = {
 };
 
 kunit_test_suite(scsi_lib_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 9fc397a9ce7a4f91..7f7e55341192e50e 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -113,6 +113,8 @@ extern int scsi_mq_setup_tags(struct Scsi_Host *shost);
 extern void scsi_mq_free_tags(struct kref *kref);
 extern void scsi_exit_queue(void);
 extern void scsi_evt_thread(struct work_struct *work);
+extern int scsi_check_passthrough(struct scsi_cmnd *scmd,
+				  struct scsi_failures *failures);
 
 /* scsi_proc.c */
 #ifdef CONFIG_SCSI_PROC_FS
-- 
2.34.1


