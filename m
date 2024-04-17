Return-Path: <linux-kernel+bounces-148108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1938A7DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB841C2166B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEACE7D3F6;
	Wed, 17 Apr 2024 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="B5wpV3WO"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5229CEB;
	Wed, 17 Apr 2024 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341580; cv=none; b=V6VmeNBNPb21B8SXJKL2qhpDuVONZp6aMcXAt/w1k+l3DMTLyN824V3maeRI5d5pq4IYpAa03bmELBcfasmPyLEdPTCQYVi/CDfM1Acm7z1lwqhx3mc8JMzkmdZjF7eSn8r5L6GblaTOY487ToFD6617gXTEN+TecGnFE3hfJoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341580; c=relaxed/simple;
	bh=6Vtc0S6pcAAOt0snVGfkzhcpg4TQmCVPNySgyns61iU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQ4vAHmgU5gwADqxglBF2gaiNEIZlz9r1BlNWkmRHo+W/JF8fu7OJuG/codH7te5+dRC+rzO/O9LXx4ZtC/qV+DksgCw4VsIQYgwDkJZs4jQNKL+VIBMDRxXPSfZIFQOeRSpIc4p5kxPmvh9O3KNWSp4IGaHnYSlC44IzFM3T3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=B5wpV3WO; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713341579; x=1744877579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQlzORIZG3WhWuh/iKbvpmVehbyTyskLtwJKJ1qurkE=;
  b=B5wpV3WO/K1qJXfEPuuZAt9ZnwV5FpNDlgksFQJm4vfcpmo82s0cdod6
   1CABfxwUpgzw8FUfLvYjD95lf87iJo4DPMivrAOjJjl4fi0x8wbN5qHuR
   sw8UGozTqaEKXewWKDZUq9N2Et7gzFqXKmTMdSh3BiJr/V9UHlyqo6TsP
   E=;
X-IronPort-AV: E=Sophos;i="6.07,208,1708387200"; 
   d="scan'208";a="719177114"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 08:12:53 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:26698]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.77:2525] with esmtp (Farcaster)
 id 6b509806-931b-4a4a-925f-32ab1c9e691b; Wed, 17 Apr 2024 08:12:51 +0000 (UTC)
X-Farcaster-Flow-ID: 6b509806-931b-4a4a-925f-32ab1c9e691b
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:12:51 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.1.212.48) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:12:45 +0000
From: Babis Chalios <bchalios@amazon.es>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <olivia@selenic.com>,
	<herbert@gondor.apana.org.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <bchalios@amazon.es>, <graf@amazon.de>,
	<xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>
Subject: [PATCH v5 1/5] virt: vmgenid: rearrange code to make review easier
Date: Wed, 17 Apr 2024 10:12:08 +0200
Message-ID: <20240417081212.99657-2-bchalios@amazon.es>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240417081212.99657-1-bchalios@amazon.es>
References: <20240417081212.99657-1-bchalios@amazon.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

From: Sudan Landge <sudanl@amazon.com>

Rearrage the functions of vmgenid to make the next commit,
which re-implements vmgenid as a platform driver, easier to review.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
---
 drivers/virt/vmgenid.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index b67a28da4702..a167ccfad299 100644
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
@@ -65,25 +79,12 @@ static int vmgenid_add(struct acpi_device *device)
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
 	{ }
 };
+MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
 
 static struct acpi_driver vmgenid_driver = {
 	.name = "vmgenid",
@@ -97,7 +98,6 @@ static struct acpi_driver vmgenid_driver = {
 
 module_acpi_driver(vmgenid_driver);
 
-MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
 MODULE_DESCRIPTION("Virtual Machine Generation ID");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
-- 
2.40.1


