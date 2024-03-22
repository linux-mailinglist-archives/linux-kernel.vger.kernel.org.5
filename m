Return-Path: <linux-kernel+bounces-111325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9970886AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319E1B21202
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1943D3A4;
	Fri, 22 Mar 2024 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NboM/IlE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A2D7E6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104576; cv=none; b=uzyBmB283xNg/Rf1rPh6agbKg0L19yod1+hldcPfWe1LI+wSVO7ToHEYVSwBpjSjVc0qVnCvsbGvKqnc8FLFQHWBXEKU6eH6AJi+rObVMLtv47Htbg2rJ13HrFYIS6NawFQkUjFFE+arc08eoJ+XEuYZqdoefII9CTBVWN6gvJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104576; c=relaxed/simple;
	bh=RdSS02s72D4eY2/gXrflggceGXsqtbDf/oNhoeFM0oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVszmZW5spMIL/vslkInc6pSIGZ5wGzA+fRBLkmlcZAhTumRILXclIsbux6CSO1XyRT9qOELIUoyPHsd7wg36MmTn4G1oAlsp0JfWk1XfTWEgbr87IxUf1xeObWTtrxWcH+cclVeTHlCR9s1JAaKiVTQJbkYBJwZqSC4kwQ2+ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NboM/IlE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711104573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QdoXDPkirjhYNpXA2MhOMT7OeLESzKe1cciF8iSzK0=;
	b=NboM/IlEfErFfT31R6yHf03Z7AuFTE6fvjUM6aVNPfmQXqz3ddIbYNzkAbEHIInMxW60Ib
	ETcnHfPcwzRq79ryNGwhVkUhHSfLiSVeqqV0IXncXyucKN7Ym3pnc9Df02ew1LnXPdCa0h
	fvpAfqy1hKhG3UAt4LwgiXCYeBA9WZk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-CRPaDkl7NPSo9yKN7u25hg-1; Fri, 22 Mar 2024 06:49:31 -0400
X-MC-Unique: CRPaDkl7NPSo9yKN7u25hg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC43385A58B;
	Fri, 22 Mar 2024 10:49:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.83])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CB34B2022C1D;
	Fri, 22 Mar 2024 10:49:28 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: quic_bqiang@quicinc.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	jtornosm@redhat.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH V2] wifi: ath11k: workaround to use VMs
Date: Fri, 22 Mar 2024 11:49:12 +0100
Message-ID: <20240322104912.94811-1-jtornosm@redhat.com>
In-Reply-To: <87f0c6c9-43e5-4ea3-8f4c-9425e6a74b10@quicinc.com>
References: <87f0c6c9-43e5-4ea3-8f4c-9425e6a74b10@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Currently, this driver is not working when the device is handled in a
Virtual Machine (PCI pass-through), as it was already reported here:
https://lore.kernel.org/all/fc6bd06f-d52b-4dee-ab1b-4bb845cc0b95@quicinc.com/T/
Baochen Qiang focused the problem and described how to have it working
for a specific real MSI vector from host that needs to be used in VM too.
And this value, as it was commented, can change.

The problem seems complex to me and I don't know if there is any easy way
to solve it (with no more information, not hardware/firmware related help
or VMM action).
Meanwhile and using the information from Baochen Qiang, since the use of
VMs is very interesting for testing procedures, I would like to include
this workaround that consists on adding two parameters to pass the real MSI
vector address and data from host to the VM.
In that way, checking the 'lscpi' command output from host, it could be
handled manually or with some user tool in order to have the VM with the
driver working.
Of course, if the workaround is not used, that is if MSI vector address
parameter is not configured (zero value and default), we will have the same
behavior as always.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Add parameter for msi vector data as Baochen Qiang suggests.

 drivers/net/wireless/ath/ath11k/pci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index be9d2c69cc41..4c84208dcf5d 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -31,6 +31,15 @@
 
 #define TCSR_SOC_HW_SUB_VER	0x1910010
 
+static ulong ath11k_host_msi_vector_addr = 0;
+module_param_named(host_msi_vector_addr, ath11k_host_msi_vector_addr, ulong, 0644);
+MODULE_PARM_DESC(host_msi_vector_addr,
+		 "Workaround to configure the MSI vector address that is used from host in order to be used in VM");
+static uint ath11k_host_msi_vector_data = 0;
+module_param_named(host_msi_vector_data, ath11k_host_msi_vector_data, uint, 0644);
+MODULE_PARM_DESC(host_msi_vector_data,
+		 "Workaround to configure the MSI vector data that is used from host in order to be used in VM");
+
 static const struct pci_device_id ath11k_pci_id_table[] = {
 	{ PCI_VDEVICE(QCOM, QCA6390_DEVICE_ID) },
 	{ PCI_VDEVICE(QCOM, WCN6855_DEVICE_ID) },
@@ -443,6 +452,18 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 
 	ath11k_pci_msi_disable(ab_pci);
 
+	if (ath11k_host_msi_vector_addr) {
+		ab_pci->ab->pci.msi.ep_base_data = ath11k_host_msi_vector_data;
+		ab->pci.msi.addr_hi = (u32)(ath11k_host_msi_vector_addr >> 32);
+		ab->pci.msi.addr_lo = (u32)(ath11k_host_msi_vector_addr & 0xffffffff);
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
@@ -482,6 +503,9 @@ static int ath11k_pci_config_msi_data(struct ath11k_pci *ab_pci)
 {
 	struct msi_desc *msi_desc;
 
+	if (ath11k_host_msi_vector_addr)
+		return 0;
+
 	msi_desc = irq_get_msi_desc(ab_pci->pdev->irq);
 	if (!msi_desc) {
 		ath11k_err(ab_pci->ab, "msi_desc is NULL!\n");
-- 
2.44.0


