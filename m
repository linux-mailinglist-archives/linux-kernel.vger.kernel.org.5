Return-Path: <linux-kernel+bounces-107131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB73587F7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19D91F21EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20CD51028;
	Tue, 19 Mar 2024 07:00:56 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D664F5EC;
	Tue, 19 Mar 2024 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831656; cv=none; b=gnPUPTjbyq90Ih3QjZs2CeDb15cr7vnkg3V+OteRqY8J6IgL30NU3G9u3tCtMmU+brfmTkyYJcoz99wkhI5dt5NbP+70JfX0ohASQxbxvjR99tLY7GtxsaVVZJECSFvZvNm8T2zZHCdgq+XVMYK3M9Ntk+86FUQVpO+SLFxx/YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831656; c=relaxed/simple;
	bh=tUqugGhnzmKLC5uc/exByF6cTzqCXWZ72NMJkUYyDxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MSB8KVyCulSvmzHleRECkZuiofvRv5AajnjLC5TgKXONodIfvQWiunQ3WGpDo+Y/V7AqKc6q/zqDj6U9NW046QVmATbkv1A4OvLtl1GyCiMZBLSHdxCOaoJ5r7Bv7W8syE/3+qpx3jPM0ae3uGbAvOHqgY+P92l9R11O3mChDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d594a38d692e451d94d343be03155d9f-20240319
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:beb606c7-d216-4ac0-baea-d8109f633bf2,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.37,REQID:beb606c7-d216-4ac0-baea-d8109f633bf2,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:6f543d0,CLOUDID:a7aa9190-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240319150042DHVTFL00,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: d594a38d692e451d94d343be03155d9f-20240319
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1500074276; Tue, 19 Mar 2024 15:00:40 +0800
From: Ai Chao <aichao@kylinos.cn>
To: justin.ernst@hpe.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ai Chao <aichao@kylinos.cn>
Subject: [PATCH v1] platform/x86: uv_sysfs: use sysfs_emit() instead of sprintf()
Date: Tue, 19 Mar 2024 15:00:38 +0800
Message-Id: <20240319070038.309683-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/platform/x86/uv_sysfs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/uv_sysfs.c b/drivers/platform/x86/uv_sysfs.c
index 38d1b692d3c0..3f6d52dea5c9 100644
--- a/drivers/platform/x86/uv_sysfs.c
+++ b/drivers/platform/x86/uv_sysfs.c
@@ -129,22 +129,22 @@ static ssize_t hub_location_show(struct uv_bios_hub_info *hub_info, char *buf)
 
 static ssize_t hub_partition_show(struct uv_bios_hub_info *hub_info, char *buf)
 {
-	return sprintf(buf, "%d\n", hub_info->f.fields.this_part);
+	return sysfs_emit(buf, "%d\n", hub_info->f.fields.this_part);
 }
 
 static ssize_t hub_shared_show(struct uv_bios_hub_info *hub_info, char *buf)
 {
-	return sprintf(buf, "%d\n", hub_info->f.fields.is_shared);
+	return sysfs_emit(buf, "%d\n", hub_info->f.fields.is_shared);
 }
 static ssize_t hub_nasid_show(struct uv_bios_hub_info *hub_info, char *buf)
 {
 	int cnode = get_obj_to_cnode(hub_info->id);
 
-	return sprintf(buf, "%d\n", ordinal_to_nasid(cnode));
+	return sysfs_emit(buf, "%d\n", ordinal_to_nasid(cnode));
 }
 static ssize_t hub_cnode_show(struct uv_bios_hub_info *hub_info, char *buf)
 {
-	return sprintf(buf, "%d\n", get_obj_to_cnode(hub_info->id));
+	return sysfs_emit(buf, "%d\n", get_obj_to_cnode(hub_info->id));
 }
 
 struct hub_sysfs_entry {
@@ -304,12 +304,12 @@ struct uv_port {
 
 static ssize_t uv_port_conn_hub_show(struct uv_bios_port_info *port, char *buf)
 {
-	return sprintf(buf, "%d\n", port->conn_id);
+	return sysfs_emit(buf, "%d\n", port->conn_id);
 }
 
 static ssize_t uv_port_conn_port_show(struct uv_bios_port_info *port, char *buf)
 {
-	return sprintf(buf, "%d\n", port->conn_port);
+	return sysfs_emit(buf, "%d\n", port->conn_port);
 }
 
 struct uv_port_sysfs_entry {
@@ -470,7 +470,7 @@ static ssize_t uv_pci_location_show(struct uv_pci_top_obj *top_obj, char *buf)
 
 static ssize_t uv_pci_iio_stack_show(struct uv_pci_top_obj *top_obj, char *buf)
 {
-	return sprintf(buf, "%d\n", top_obj->iio_stack);
+	return sysfs_emit(buf, "%d\n", top_obj->iio_stack);
 }
 
 static ssize_t uv_pci_ppb_addr_show(struct uv_pci_top_obj *top_obj, char *buf)
@@ -480,7 +480,7 @@ static ssize_t uv_pci_ppb_addr_show(struct uv_pci_top_obj *top_obj, char *buf)
 
 static ssize_t uv_pci_slot_show(struct uv_pci_top_obj *top_obj, char *buf)
 {
-	return sprintf(buf, "%d\n", top_obj->slot);
+	return sysfs_emit(buf, "%d\n", top_obj->slot);
 }
 
 struct uv_pci_top_sysfs_entry {
@@ -725,13 +725,13 @@ static void pci_topology_exit(void)
 static ssize_t partition_id_show(struct kobject *kobj,
 			struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%ld\n", sn_partition_id);
+	return sysfs_emit(buf, "%ld\n", sn_partition_id);
 }
 
 static ssize_t coherence_id_show(struct kobject *kobj,
 			struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%ld\n", sn_coherency_id);
+	return sysfs_emit(buf, "%ld\n", sn_coherency_id);
 }
 
 static ssize_t uv_type_show(struct kobject *kobj,
-- 
2.25.1


