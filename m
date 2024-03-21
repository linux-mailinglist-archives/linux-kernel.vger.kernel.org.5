Return-Path: <linux-kernel+bounces-110490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B4E885FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4031F21F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3D3762EB;
	Thu, 21 Mar 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyx78quD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD39E57B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041858; cv=none; b=WfDDIqwyGd1M2uC4/48R1usH8/ajSg4sJGop5eUIdDiYpNtosyNjWHg/uH+4m1fTlWoNEEqvK/eE/SaI8eH3MTGnRDY15Y2WZHcyiI1C48khEsfaCAWQ0UpTPDjHO7DPswbpOINggCFBM6UixRGIULCVV+ZRmIkCSF5n6jnHjwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041858; c=relaxed/simple;
	bh=UqWgiXpTx+g3y/yTRlgvUwo2ElHiGNZIewuCU+UdZnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twuaCHGj2TkPGBg4hYdJsdRvsH2AWG8Z1BTbBTTwCzBs9VHRHyuFuNwGIdxisa0cnSisY74RqKVIqEmct5Vp+2kdQg0yYQwRXPjgmSZ9AXMo/Pgn0jhW86dUZPhr4iMCZOMggiwUJEXKfs2P2UvmSpFC/i17EyDfb8P3QuTK3gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyx78quD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711041854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nx/csSlPOluSCIW0mpv5oVPqUBgi5HWFro0Q1XSjqX8=;
	b=hyx78quDSSaMfPqqggWq0VWUMvlmXvGV7ULXRm+9Y1gO6HgDG+O1byH5hOy9y8jpNxA71S
	2p3TbGQZUBIVXObNeK+6nkbQ64tLWumoiMqlKa3DVmrxiqv6oe8HXViIhQ6pvdkp3HXT8f
	rS/wB7UzmTVUvMWmIGFzV7fDl/c7SL8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-BIZles-tO0q0bkr2sYcD1w-1; Thu,
 21 Mar 2024 13:24:11 -0400
X-MC-Unique: BIZles-tO0q0bkr2sYcD1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAB8638009FB;
	Thu, 21 Mar 2024 17:24:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.172])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 373F18173;
	Thu, 21 Mar 2024 17:24:09 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: quic_bqiang@quicinc.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH] wifi: ath11k: workaround to use VMs
Date: Thu, 21 Mar 2024 18:23:53 +0100
Message-ID: <20240321172402.346191-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Currently, this driver is not working when the device is handled in a
Virtual Machine (PCI pass-through), as it was already reported here:
https://lore.kernel.org/all/fc6bd06f-d52b-4dee-ab1b-4bb845cc0b95@quicinc.com/T/
Baochen Qiang focused the problem and described how to have it working
for a specific real MSI vector from host that needs to be used in VM too.
And this value, as it was commented, can change.

The problem seems complex to me and I don't know if there is any easy way
to solve it. Meanwhile and using the information from Baochen Qiang,
since the use of VMs is very interesting for testing procedures,
I would like to just add this workaround that consists on adding a
parameter to pass the real MSI vector from host to the VM. In that way,
checking the 'lscpi' command output from host, it could be handled manually
or with some user tool in order to have the VM with the driver working.
Of course, if this parameter is not configured (zero value and default),
we will have the same behavior as always.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/wireless/ath/ath11k/pci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index be9d2c69cc41..0e322956b10f 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -31,6 +31,11 @@
 
 #define TCSR_SOC_HW_SUB_VER	0x1910010
 
+static ulong ath11k_host_msi_addr = 0;
+module_param_named(host_msi_addr, ath11k_host_msi_addr, ulong, 0644);
+MODULE_PARM_DESC(host_msi_addr,
+		 "Workaround to configure the MSI address that is used from host in order to be used in VM");
+
 static const struct pci_device_id ath11k_pci_id_table[] = {
 	{ PCI_VDEVICE(QCOM, QCA6390_DEVICE_ID) },
 	{ PCI_VDEVICE(QCOM, WCN6855_DEVICE_ID) },
@@ -443,6 +448,18 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 
 	ath11k_pci_msi_disable(ab_pci);
 
+	if (ath11k_host_msi_addr) {
+		ab_pci->ab->pci.msi.ep_base_data = 0;
+		ab->pci.msi.addr_hi = (u32)(ath11k_host_msi_addr >> 32);
+		ab->pci.msi.addr_lo = (u32)(ath11k_host_msi_addr & 0xffffffff);
+
+		ath11k_dbg(ab, ATH11K_DBG_PCI, "msi addr hi 0x%x lo 0x%x base data is %d\n",
+			   ab->pci.msi.addr_hi,
+			   ab->pci.msi.addr_lo,
+			   ab->pci.msi.ep_base_data);
+		return 0;
+	}
+
 	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
 	if (!msi_desc) {
 		ath11k_err(ab, "msi_desc is NULL!\n");
@@ -482,6 +499,9 @@ static int ath11k_pci_config_msi_data(struct ath11k_pci *ab_pci)
 {
 	struct msi_desc *msi_desc;
 
+	if (ath11k_host_msi_addr)
+		return 0;
+
 	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
 	if (!msi_desc) {
 		ath11k_err(ab_pci->ab, "msi_desc is NULL!\n");
-- 
2.44.0


