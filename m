Return-Path: <linux-kernel+bounces-109602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21686881B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D391E282912
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C725883D;
	Thu, 21 Mar 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eRxvE4r8"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785379D8;
	Thu, 21 Mar 2024 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710989488; cv=none; b=AENJh5aAlMk0nug5Lr0HJ9YLF8vHssDynoEn02dsYLPcZw9bL58ThguBptemv3QTKULx6Cftc/wnCPhWkux9cw/m8U9TNYgfGWjyWcfwL7BppK5nC2txR5EIL+12EWcLZgZkxHq/SID4/XqHYTcpcBPdk2s8Y1C8fuNl+emNxyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710989488; c=relaxed/simple;
	bh=V5QfoxDhwAJ0q0BlEtFIGB+N4NV5UoeStGXWV9Li+qA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/ABRZs8NdzXORvkf2MkKS6mp/OCFm3ma5ytto6NLEoYh41rJ7UEjDZsWPMYt5x5pYh7t2K6mh3DkaoqITS3x8Rl76QCcPyR1bmE1HrIKib0iWHHDWbGuogt1s11gRjLw9kQAGr6NL30thRiGhx8R8KD/0oM7Et12zHGRk3TNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eRxvE4r8; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710989486; x=1742525486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=780CzWQuS3gw5Y/2WbB9iB+XzN5JGzKplO7LP7fR96Q=;
  b=eRxvE4r8cucGZq5N1LT3pnOWbPai2R0UgXy5a/BnsZGNf51T0QwHFsae
   di8Kpvo84k2L6oqxiFcQkgZhoQOk+1dQQx6tYfeSn5WDR59rwYUfh/fF8
   2KTnyabFke6KnetG25x9PeWO/S8C2RlyQLR/R7nT0CoMbOFdW07QX1A0x
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,141,1708387200"; 
   d="scan'208";a="389303551"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 02:51:22 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:55052]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.6.197:2525] with esmtp (Farcaster)
 id 5cc6084e-03c4-492e-875e-b4cc0c2a6394; Thu, 21 Mar 2024 02:51:22 +0000 (UTC)
X-Farcaster-Flow-ID: 5cc6084e-03c4-492e-875e-b4cc0c2a6394
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 02:51:21 +0000
Received: from bcd074994f7f.amazon.com (10.106.82.23) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 02:51:17 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v2 1/4] virt: vmgenid: rearrange code to make review easier
Date: Thu, 21 Mar 2024 02:51:02 +0000
Message-ID: <20240321025105.53210-2-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240321025105.53210-1-sudanl@amazon.com>
References: <20240321025105.53210-1-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)

Rearrage the functions of vmgenid to make the next commit,
which re-implements vmgenid as a platform driver, easier to review.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
---
 drivers/virt/vmgenid.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index b67a28da4702..ea956df02874 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -21,6 +21,20 @@ struct vmgenid_state {
 	u8 this_id[VMGENID_SIZE];
 };
 
+static void vmgenid_notify(struct acpi_device *device, u32 event)
+{
+	struct vmgenid_state *state = acpi_driver_data(device);
+	char *envp[] = { "NEW_VMGENID=1", NULL };
+	u8 old_id[VMGENID_SIZE];
+
+	memcpy(old_id, state->this_id, sizeof(old_id));
+	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
+	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
+		return;
+	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
+	kobject_uevent_env(&device->dev.kobj, KOBJ_CHANGE, envp);
+}
+
 static int vmgenid_add(struct acpi_device *device)
 {
 	struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
@@ -65,20 +79,6 @@ static int vmgenid_add(struct acpi_device *device)
 	return ret;
 }
 
-static void vmgenid_notify(struct acpi_device *device, u32 event)
-{
-	struct vmgenid_state *state = acpi_driver_data(device);
-	char *envp[] = { "NEW_VMGENID=1", NULL };
-	u8 old_id[VMGENID_SIZE];
-
-	memcpy(old_id, state->this_id, sizeof(old_id));
-	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
-	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
-		return;
-	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
-	kobject_uevent_env(&device->dev.kobj, KOBJ_CHANGE, envp);
-}
-
 static const struct acpi_device_id vmgenid_ids[] = {
 	{ "VMGENCTR", 0 },
 	{ "VM_GEN_COUNTER", 0 },
-- 
2.40.1



