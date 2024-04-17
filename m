Return-Path: <linux-kernel+bounces-148342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503B8A812E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469141C2103E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665F213C685;
	Wed, 17 Apr 2024 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="fIV9eGxx"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B1139CEF;
	Wed, 17 Apr 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350514; cv=none; b=oS689U9hCT+9SkazJGSsZXcbOV74HUvOsLfLbFKybTDjjuSCsyIEtAZWHJKdsgW167KlhQ8cXjaoo0mks0nX63OZanDqKd+O84lI4pOODSWQw2xQdbpcwSh8f7ndORTiz++FApMymZybnahspTqeqFFybVxbJ12ermSa7dNHiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350514; c=relaxed/simple;
	bh=jiUQC9f6aE+Vb6PbKu4KZPNhyLa362aFnQMu6aS7pJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeGmVlflICCojDT6qiqzzRyWyVTUX9eXHL2ESWEVycDnWWjrBID0lgZTt9tlcvpGIi1o1tZTJ92s5i16JzSzeNrqUnV8JzVRgO9GyLkc5383Aki9J5OQgV6cxz5tl61zv6Pf1gTzXFTg6fC+99Wmo7DfvgGfw5h0yfa7rniLoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=fIV9eGxx; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713350514; x=1744886514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OQs2TuFyhr25H2XNFD87PPOOite8tWLmBG6QHfrCeCg=;
  b=fIV9eGxx9Gdot2iE/NoY98hO2g2/UAfNbxb7IMacqo18hFFpZWO1PIUh
   CjLmF/Hpj8zQfdSjhZ2Q7expP6H77OZlX+yAPxDTCRNYlqaPv3tCuzSNl
   d/QPzhf4qrhq3z0vhPiYaJ18paazju8sJ82t7wC54UJzG70UtNRBAnXoK
   0=;
X-IronPort-AV: E=Sophos;i="6.07,209,1708387200"; 
   d="scan'208";a="289417972"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:41:52 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:52151]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.68:2525] with esmtp (Farcaster)
 id bd9a89d3-3c43-41da-8e4d-ef989f754393; Wed, 17 Apr 2024 10:41:49 +0000 (UTC)
X-Farcaster-Flow-ID: bd9a89d3-3c43-41da-8e4d-ef989f754393
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 10:41:45 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.106.83.20) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 10:41:39 +0000
From: Babis Chalios <bchalios@amazon.es>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <olivia@selenic.com>,
	<herbert@gondor.apana.org.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <bchalios@amazon.es>, <graf@amazon.de>,
	<xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>, Alexander Graf
	<graf@amazon.com>
Subject: [PATCH v6 1/5] virt: vmgenid: re-arrange code to make review easier
Date: Wed, 17 Apr 2024 12:40:42 +0200
Message-ID: <20240417104046.27253-2-bchalios@amazon.es>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240417104046.27253-1-bchalios@amazon.es>
References: <20240417104046.27253-1-bchalios@amazon.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

Re-arrange the functions of vmgenid to make the next commit,
which re-implements vmgenid as a platform driver, easier to review.

Co-authored-by: Sudan Landge <sudanl@amazon.com>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
Reviewed-by: Alexander Graf <graf@amazon.com>
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


