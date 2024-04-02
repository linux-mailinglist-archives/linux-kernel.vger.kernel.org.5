Return-Path: <linux-kernel+bounces-127403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A62894ADB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EFE1C21CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0118F182D4;
	Tue,  2 Apr 2024 05:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uf8l+RuJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC7018035;
	Tue,  2 Apr 2024 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712035923; cv=none; b=IuLUtapkA/yjQvqSwIQzqbDU+9hNnk32zKFKah2Qzm3qGSYavu1QN7Y76e74o59MV7RUtNUQxGWO3VPlY9UtC6xUZHV5HLtiu1EuxOi2tjpIpKdxz2Pcz1ViqpuJAWLSn6Wt86bPWzp5q+hiGXmtxGZJ1S97uG6K97pA+cKlUfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712035923; c=relaxed/simple;
	bh=E3OxKrI8a+NNFY3dgSsS36QrEUA1nRejBd6dBSa2G4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LDXO0FQrd6jsQqSK6s8+9UvSxaA6HyK+FPWGZ+F+lpVyZ4f3IImc+Yyc6D9GfMp2KFge/FLdHohTp5vnfR2ZrLbswRoUOqkue59PCJocp1eX9Ni8y3jrwT2d/cP4UQy/87j5hqU3HwJ1skZo/outUFhATMAru7cFl8PREE6NKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uf8l+RuJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712035922; x=1743571922;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=E3OxKrI8a+NNFY3dgSsS36QrEUA1nRejBd6dBSa2G4U=;
  b=Uf8l+RuJEnok/LIk2qZbSECW+tbsX0+Uvlm3VyD85kR3axs7C+6zUNiD
   ZlVaRp8WwgKiIMaMu8nhCXX+vvwooAayV30MiCrLVi+j3Sak2tJBl/qfB
   c98ABabsN4pZDhTJBkNWy/nPBMSUF/KcjPMysChDGupuPGj/6rzqhVEL4
   8NhBSb5+UEAsCYkSYKAXusr18PaTTePUwCcIc041zUs4HfMdYcU8wxYFD
   V4Dh7zF3XkEWLVhFd3iMq8E5KdiQQhqLhgx+nn4vlTa+EYeaHcgwxHHJb
   FQu2zPlHZyuV6R75zcf/GVQqlzEsH9f/A7Jof8Y4j16CbNxyifJMIwKL6
   Q==;
X-CSE-ConnectionGUID: g/EN1RduShqnq3nUyUWVCA==
X-CSE-MsgGUID: gOsQ3bsNQ5ui2z/A7CQ72g==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7342173"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7342173"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 22:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17912241"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.69.15])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 22:31:59 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 01 Apr 2024 22:31:58 -0700
Subject: [PATCH] cxl/test: Enhance event testing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-enhance-event-test-v1-1-6669a524ed38@intel.com>
X-B4-Tracking: v=1; b=H4sIAE2YC2YC/x2MQQqAIBQFrxJ/3QcVg+oq0aLsWX9joRKBdPek5
 QzMFEqIgkRjUyjiliRnqKDbhtyxhB0sW2UyylhllWaEqh0YN0LmjJTZYYX3ne4Ht1ENrwgvzz+
 d5vf9AOLfcx5kAAAA
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kwangjin Ko <kwangjin.ko@sk.com>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712035918; l=3467;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=E3OxKrI8a+NNFY3dgSsS36QrEUA1nRejBd6dBSa2G4U=;
 b=zk2NHTRLM3/Yqo/M4+VqkKMYYbz78b9jmxqFheo9r86QZDGzlCAV5lGT96I28l2DH36ph48GN
 BhRSb8XY/BOC5GbBINhNC+CH+7Dx/rv3suLmhMdzWDl4FvTMZXbyZ7k
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

An issue was found in the processing of event logs when the output
buffer length was not reset.[1]

This bug was not caught with cxl-test for 2 reasons.  First, the test
harness mbox_send command [mock_get_event()] does not set the output
size based on the amount of data returned like the hardware command
does.  Second, the simplistic event log testing always returned the same
number of elements per-get command.

Enhance the simulation of the event log mailbox to better match the bug
found with real hardware to cover potential regressions.

NOTE: These changes will cause cxl-events.sh in ndctl to fail without
the fix from Kwangjin.  However, no changes to the user space test was
required.  Therefore ndctl itself will be compatible with old or new
kernels once both patches land in the new kernel.

[1] Link: https://lore.kernel.org/all/20240401091057.1044-1-kwangjin.ko@sk.com/

Cc: Kwangjin Ko <kwangjin.ko@sk.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tools/testing/cxl/test/mem.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 35ee41e435ab..6584443144de 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -127,7 +127,7 @@ static struct {
 #define CXL_TEST_EVENT_CNT_MAX 15
 
 /* Set a number of events to return at a time for simulation.  */
-#define CXL_TEST_EVENT_CNT 3
+#define CXL_TEST_EVENT_RET_MAX 4
 
 struct mock_event_log {
 	u16 clear_idx;
@@ -222,6 +222,12 @@ static void mes_add_event(struct mock_event_store *mes,
 	log->nr_events++;
 }
 
+/*
+ * Vary the number of events returned to simulate events occuring while the
+ * logs are being read.
+ */
+static int ret_limit = 0;
+
 static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_get_event_payload *pl;
@@ -233,14 +239,18 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 	if (cmd->size_in != sizeof(log_type))
 		return -EINVAL;
 
-	if (cmd->size_out < struct_size(pl, records, CXL_TEST_EVENT_CNT))
+	ret_limit = (ret_limit + 1) % CXL_TEST_EVENT_RET_MAX;
+	if (!ret_limit)
+		ret_limit = 1;
+
+	if (cmd->size_out < struct_size(pl, records, ret_limit))
 		return -EINVAL;
 
 	log_type = *((u8 *)cmd->payload_in);
 	if (log_type >= CXL_EVENT_TYPE_MAX)
 		return -EINVAL;
 
-	memset(cmd->payload_out, 0, cmd->size_out);
+	memset(cmd->payload_out, 0, struct_size(pl, records, 0));
 
 	log = event_find_log(dev, log_type);
 	if (!log || event_log_empty(log))
@@ -248,7 +258,7 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 
 	pl = cmd->payload_out;
 
-	for (i = 0; i < CXL_TEST_EVENT_CNT && !event_log_empty(log); i++) {
+	for (i = 0; i < ret_limit && !event_log_empty(log); i++) {
 		memcpy(&pl->records[i], event_get_current(log),
 		       sizeof(pl->records[i]));
 		pl->records[i].event.generic.hdr.handle =
@@ -256,6 +266,7 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 		log->cur_idx++;
 	}
 
+	cmd->size_out = struct_size(pl, records, i);
 	pl->record_count = cpu_to_le16(i);
 	if (!event_log_empty(log))
 		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;

---
base-commit: 8d025e2092e29bfd13e56c78e22af25fac83c8ec
change-id: 20240401-enhance-event-test-cebeff5189cd

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


