Return-Path: <linux-kernel+bounces-107653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DD887FFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5286628530C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA01465198;
	Tue, 19 Mar 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NhsvhxX1"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482453385;
	Tue, 19 Mar 2024 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858802; cv=none; b=fJJJtdfTtySxfZ7QH59y+cgBBcDXCdJG9ZglxoA1hyAurpzXeQODslbIzUNIUca9FgfyM7+KXMRnnMULW3gRfgg32QpnInZ9TQ7zajuMSfhh4tpZFOWkhoJR8AA/PVwoPCC6FUN6W8AOsBoy3a9BK0mRJ2Aty+7cNmFWiCYpIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858802; c=relaxed/simple;
	bh=V5QfoxDhwAJ0q0BlEtFIGB+N4NV5UoeStGXWV9Li+qA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMvEuHWUlpJgYjU8CphrevEIq+22X4iU+QEVxgIGAG0cO+wC1XKmrnOJrlOPo28K8+ZIOXf7jZiYL0r2DxO4rOzwFESL9loHPPowGV/zYx1nHun7Op3nGlBm+BvU54hhiGhBkAapjDfFMiJZy2gmy6q2C0g33gQIzbFKAkCrWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NhsvhxX1; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710858800; x=1742394800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=780CzWQuS3gw5Y/2WbB9iB+XzN5JGzKplO7LP7fR96Q=;
  b=NhsvhxX1ghq2Y+CdQFx9rtGOCmftUd7VDYjAn1sxsycg0lkgST5F1aEz
   5G3YgnbuxRlHjOX2YGTTOgx3I52iyfLvjgnW0Vhd7KZAzu8GizfohNLxx
   1nFFBafAiCvBaeNIiFZaUKD/srTOD/qH22N7Pe+LVHw3cTp0vwsMgPWvS
   E=;
X-IronPort-AV: E=Sophos;i="6.07,137,1708387200"; 
   d="scan'208";a="405001162"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 14:33:15 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:12055]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.106:2525] with esmtp (Farcaster)
 id daf94e99-709a-44a0-8ce6-892fd80da2ee; Tue, 19 Mar 2024 14:33:13 +0000 (UTC)
X-Farcaster-Flow-ID: daf94e99-709a-44a0-8ce6-892fd80da2ee
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 14:33:13 +0000
Received: from bcd074994f7f.amazon.com (10.106.83.11) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 14:33:08 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v1 1/4] virt: vmgenid: rearrange code to make review easier
Date: Tue, 19 Mar 2024 14:32:50 +0000
Message-ID: <20240319143253.22317-2-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240319143253.22317-1-sudanl@amazon.com>
References: <20240319143253.22317-1-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
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


