Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6889E759ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGSTfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjGSTfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:35:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63652111
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5633fd47763so1492676a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689795275; x=1690400075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/UAMiG1bQ6endV/IctuiWSddw0eWce+t6nTi33PhHs=;
        b=uvzyT/t99XEHRT8eL7RJR0m76yg5f9RxGZ/C6x+D7eM4Ic/Aab/9jt080pS0Yg6Swd
         pD+EdJ9OzlqBLs3SI2UABL/9GJd17J1YbhEYvxTLoEOJvRQF3VXnnPJ/k3imRAqummcB
         P6dBsDv0DZ9RtShHrRSULl/u5jmXh4EwY5GThy6qZPvYdG2Lp9bobsd1XejSRPETm3VC
         FUXK1WxWwh7F/h1cYYs/6bZ/Dg5/DlEJ7iUNEabWeVWRQLaRjT9snM98ZuQLE3urOh/U
         op0WKqGfVvQzAeGXfywvLHRsP4X2bwO+gddbNcGthPqwQShFsr0KqXj7fHJOx+sxJDus
         BLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795275; x=1690400075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/UAMiG1bQ6endV/IctuiWSddw0eWce+t6nTi33PhHs=;
        b=BTIhI2/34QjUv865G2l7U4MsbE8G4rTjVe4nqzBz4iT5o6YGgqocUBYhtNL8FMy3yy
         B6IBVDLdx/xECUI842rAmUbQThNEfEpCt5QPQkU+bmAvNJ2eW3ad1MzcwTUG81WFX8li
         kyml8JumxoLbmEw0QexRjQeIwekOAeq4cWGIiM481ypLFiHwiz3yxflbznYQ2+65COuD
         KcooeFabV8/KDnxl6dJ6FB+izprK+iEYt39/goxK09WJHg1/cOAsobgSIt5b0yb2ewBN
         oBdHHi3u1HUouZz/6FMO1ZWXEqqgTwnJZsDwfHtask2U0vde9PvXXKMx/tGXR47B43Gh
         Ck8g==
X-Gm-Message-State: ABy/qLYx4q0wngKAWYV9acID5EaDSxS4HehC9mQml1+dgJ1DWZLKcziZ
        MvCG0P/ZYDB2BTNUmDPcYt14Bw==
X-Google-Smtp-Source: APBJJlFdt1FEf1/IDn+Rsj6fa98EP/ATDEE3K8y66XqfzBdbBtpcJRUA58KvCvm3DFI5GVbWBlioeQ==
X-Received: by 2002:a17:90a:a58f:b0:263:e814:5d0f with SMTP id b15-20020a17090aa58f00b00263e8145d0fmr16914579pjq.41.1689795275018;
        Wed, 19 Jul 2023 12:34:35 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b00264040322desm1591053pje.40.2023.07.19.12.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:34:34 -0700 (PDT)
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH 09/11] RISC-V: drivers/iommu/riscv: Add SVA with PASID/ATS/PRI support.
Date:   Wed, 19 Jul 2023 12:33:53 -0700
Message-Id: <aa28455e21f606e6ba7e63268b538d558bcac9a9.1689792825.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689792825.git.tjeznach@rivosinc.com>
References: <cover.1689792825.git.tjeznach@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces SVA (Shared Virtual Address) for RISC-V IOMMU, with
ATS/PRI services for capable devices.

Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 601 +++++++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.h |  14 +
 2 files changed, 610 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 2ef6952a2109..6042c35be3ca 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -384,6 +384,89 @@ static inline void riscv_iommu_cmd_iodir_set_did(struct riscv_iommu_command *cmd
 	    FIELD_PREP(RISCV_IOMMU_CMD_IODIR_DID, devid) | RISCV_IOMMU_CMD_IODIR_DV;
 }
 
+static inline void riscv_iommu_cmd_iodir_set_pid(struct riscv_iommu_command *cmd,
+						 unsigned pasid)
+{
+	cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_IODIR_PID, pasid);
+}
+
+static void riscv_iommu_cmd_ats_inval(struct riscv_iommu_command *cmd)
+{
+	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_ATS_OPCODE) |
+	    FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_ATS_FUNC_INVAL);
+	cmd->dword1 = 0;
+}
+
+static inline void riscv_iommu_cmd_ats_prgr(struct riscv_iommu_command *cmd)
+{
+	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_ATS_OPCODE) |
+	    FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_ATS_FUNC_PRGR);
+	cmd->dword1 = 0;
+}
+
+static void riscv_iommu_cmd_ats_set_rid(struct riscv_iommu_command *cmd, u32 rid)
+{
+	cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_ATS_RID, rid);
+}
+
+static void riscv_iommu_cmd_ats_set_pid(struct riscv_iommu_command *cmd, u32 pid)
+{
+	cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_ATS_PID, pid) | RISCV_IOMMU_CMD_ATS_PV;
+}
+
+static void riscv_iommu_cmd_ats_set_dseg(struct riscv_iommu_command *cmd, u8 seg)
+{
+	cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_ATS_DSEG, seg) | RISCV_IOMMU_CMD_ATS_DSV;
+}
+
+static void riscv_iommu_cmd_ats_set_payload(struct riscv_iommu_command *cmd, u64 payload)
+{
+	cmd->dword1 = payload;
+}
+
+/* Prepare the ATS invalidation payload */
+static unsigned long riscv_iommu_ats_inval_payload(unsigned long start,
+						   unsigned long end, bool global_inv)
+{
+	size_t len = end - start + 1;
+	unsigned long payload = 0;
+
+	/*
+	 * PCI Express specification
+	 * Section 10.2.3.2 Translation Range Size (S) Field
+	 */
+	if (len < PAGE_SIZE)
+		len = PAGE_SIZE;
+	else
+		len = __roundup_pow_of_two(len);
+
+	payload = (start & ~(len - 1)) | (((len - 1) >> 12) << 11);
+
+	if (global_inv)
+		payload |= RISCV_IOMMU_CMD_ATS_INVAL_G;
+
+	return payload;
+}
+
+/* Prepare the ATS invalidation payload for all translations to be invalidated. */
+static unsigned long riscv_iommu_ats_inval_all_payload(bool global_inv)
+{
+	unsigned long payload = GENMASK_ULL(62, 11);
+
+	if (global_inv)
+		payload |= RISCV_IOMMU_CMD_ATS_INVAL_G;
+
+	return payload;
+}
+
+/* Prepare the ATS "Page Request Group Response" payload */
+static unsigned long riscv_iommu_ats_prgr_payload(u16 dest_id, u8 resp_code, u16 grp_idx)
+{
+	return FIELD_PREP(RISCV_IOMMU_CMD_ATS_PRGR_DST_ID, dest_id) |
+	    FIELD_PREP(RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE, resp_code) |
+	    FIELD_PREP(RISCV_IOMMU_CMD_ATS_PRGR_PRG_INDEX, grp_idx);
+}
+
 /* TODO: Convert into lock-less MPSC implementation. */
 static bool riscv_iommu_post_sync(struct riscv_iommu_device *iommu,
 				  struct riscv_iommu_command *cmd, bool sync)
@@ -460,6 +543,16 @@ static bool riscv_iommu_iodir_inv_devid(struct riscv_iommu_device *iommu, unsign
 	return riscv_iommu_post(iommu, &cmd);
 }
 
+static bool riscv_iommu_iodir_inv_pasid(struct riscv_iommu_device *iommu,
+					unsigned devid, unsigned pasid)
+{
+	struct riscv_iommu_command cmd;
+	riscv_iommu_cmd_iodir_inval_pdt(&cmd);
+	riscv_iommu_cmd_iodir_set_did(&cmd, devid);
+	riscv_iommu_cmd_iodir_set_pid(&cmd, pasid);
+	return riscv_iommu_post(iommu, &cmd);
+}
+
 static bool riscv_iommu_iofence_sync(struct riscv_iommu_device *iommu)
 {
 	struct riscv_iommu_command cmd;
@@ -467,6 +560,62 @@ static bool riscv_iommu_iofence_sync(struct riscv_iommu_device *iommu)
 	return riscv_iommu_post_sync(iommu, &cmd, true);
 }
 
+static void riscv_iommu_mm_invalidate(struct mmu_notifier *mn,
+				      struct mm_struct *mm, unsigned long start,
+				      unsigned long end)
+{
+	struct riscv_iommu_command cmd;
+	struct riscv_iommu_endpoint *endpoint;
+	struct riscv_iommu_domain *domain =
+	    container_of(mn, struct riscv_iommu_domain, mn);
+	unsigned long iova;
+	/*
+	 * The mm_types defines vm_end as the first byte after the end address,
+	 * different from IOMMU subsystem using the last address of an address
+	 * range. So do a simple translation here by updating what end means.
+	 */
+	unsigned long payload = riscv_iommu_ats_inval_payload(start, end - 1, true);
+
+	riscv_iommu_cmd_inval_vma(&cmd);
+	riscv_iommu_cmd_inval_set_gscid(&cmd, 0);
+	riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+	if (end > start) {
+		/* Cover only the range that is needed */
+		for (iova = start; iova < end; iova += PAGE_SIZE) {
+			riscv_iommu_cmd_inval_set_addr(&cmd, iova);
+			riscv_iommu_post(domain->iommu, &cmd);
+		}
+	} else {
+		riscv_iommu_post(domain->iommu, &cmd);
+	}
+
+	riscv_iommu_iofence_sync(domain->iommu);
+
+	/* ATS invalidation for every device and for specific translation range. */
+	list_for_each_entry(endpoint, &domain->endpoints, domain) {
+		if (!endpoint->pasid_enabled)
+			continue;
+
+		riscv_iommu_cmd_ats_inval(&cmd);
+		riscv_iommu_cmd_ats_set_dseg(&cmd, endpoint->domid);
+		riscv_iommu_cmd_ats_set_rid(&cmd, endpoint->devid);
+		riscv_iommu_cmd_ats_set_pid(&cmd, domain->pasid);
+		riscv_iommu_cmd_ats_set_payload(&cmd, payload);
+		riscv_iommu_post(domain->iommu, &cmd);
+	}
+	riscv_iommu_iofence_sync(domain->iommu);
+}
+
+static void riscv_iommu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	/* TODO: removed from notifier, cleanup PSCID mapping, flush IOTLB */
+}
+
+static const struct mmu_notifier_ops riscv_iommu_mmuops = {
+	.release = riscv_iommu_mm_release,
+	.invalidate_range = riscv_iommu_mm_invalidate,
+};
+
 /* Command queue primary interrupt handler */
 static irqreturn_t riscv_iommu_cmdq_irq_check(int irq, void *data)
 {
@@ -608,6 +757,128 @@ static void riscv_iommu_add_device(struct riscv_iommu_device *iommu, struct devi
 	mutex_unlock(&iommu->eps_mutex);
 }
 
+/*
+ * Get device reference based on device identifier (requester id).
+ * Decrement reference count with put_device() call.
+ */
+static struct device *riscv_iommu_get_device(struct riscv_iommu_device *iommu,
+					     unsigned devid)
+{
+	struct rb_node *node;
+	struct riscv_iommu_endpoint *ep;
+	struct device *dev = NULL;
+
+	mutex_lock(&iommu->eps_mutex);
+
+	node = iommu->eps.rb_node;
+	while (node && !dev) {
+		ep = rb_entry(node, struct riscv_iommu_endpoint, node);
+		if (ep->devid < devid)
+			node = node->rb_right;
+		else if (ep->devid > devid)
+			node = node->rb_left;
+		else
+			dev = get_device(ep->dev);
+	}
+
+	mutex_unlock(&iommu->eps_mutex);
+
+	return dev;
+}
+
+static int riscv_iommu_ats_prgr(struct device *dev, struct iommu_page_response *msg)
+{
+	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
+	struct riscv_iommu_command cmd;
+	u8 resp_code;
+	unsigned long payload;
+
+	switch (msg->code) {
+	case IOMMU_PAGE_RESP_SUCCESS:
+		resp_code = 0b0000;
+		break;
+	case IOMMU_PAGE_RESP_INVALID:
+		resp_code = 0b0001;
+		break;
+	case IOMMU_PAGE_RESP_FAILURE:
+		resp_code = 0b1111;
+		break;
+	}
+	payload = riscv_iommu_ats_prgr_payload(ep->devid, resp_code, msg->grpid);
+
+	/* ATS Page Request Group Response */
+	riscv_iommu_cmd_ats_prgr(&cmd);
+	riscv_iommu_cmd_ats_set_dseg(&cmd, ep->domid);
+	riscv_iommu_cmd_ats_set_rid(&cmd, ep->devid);
+	if (msg->flags & IOMMU_PAGE_RESP_PASID_VALID)
+		riscv_iommu_cmd_ats_set_pid(&cmd, msg->pasid);
+	riscv_iommu_cmd_ats_set_payload(&cmd, payload);
+	riscv_iommu_post(ep->iommu, &cmd);
+
+	return 0;
+}
+
+static void riscv_iommu_page_request(struct riscv_iommu_device *iommu,
+				     struct riscv_iommu_pq_record *req)
+{
+	struct iommu_fault_event event = { 0 };
+	struct iommu_fault_page_request *prm = &event.fault.prm;
+	int ret;
+	struct device *dev;
+	unsigned devid = FIELD_GET(RISCV_IOMMU_PREQ_HDR_DID, req->hdr);
+
+	/* Ignore PGR Stop marker. */
+	if ((req->payload & RISCV_IOMMU_PREQ_PAYLOAD_M) == RISCV_IOMMU_PREQ_PAYLOAD_L)
+		return;
+
+	dev = riscv_iommu_get_device(iommu, devid);
+	if (!dev) {
+		/* TODO: Handle invalid page request */
+		return;
+	}
+
+	event.fault.type = IOMMU_FAULT_PAGE_REQ;
+
+	if (req->payload & RISCV_IOMMU_PREQ_PAYLOAD_L)
+		prm->flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (req->payload & RISCV_IOMMU_PREQ_PAYLOAD_W)
+		prm->perm |= IOMMU_FAULT_PERM_WRITE;
+	if (req->payload & RISCV_IOMMU_PREQ_PAYLOAD_R)
+		prm->perm |= IOMMU_FAULT_PERM_READ;
+
+	prm->grpid = FIELD_GET(RISCV_IOMMU_PREQ_PRG_INDEX, req->payload);
+	prm->addr = FIELD_GET(RISCV_IOMMU_PREQ_UADDR, req->payload) << PAGE_SHIFT;
+
+	if (req->hdr & RISCV_IOMMU_PREQ_HDR_PV) {
+		prm->flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+		/* TODO: where to find this bit */
+		prm->flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
+		prm->pasid = FIELD_GET(RISCV_IOMMU_PREQ_HDR_PID, req->hdr);
+	}
+
+	ret = iommu_report_device_fault(dev, &event);
+	if (ret) {
+		struct iommu_page_response resp = {
+			.grpid = prm->grpid,
+			.code = IOMMU_PAGE_RESP_FAILURE,
+		};
+		if (prm->flags & IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID) {
+			resp.flags |= IOMMU_PAGE_RESP_PASID_VALID;
+			resp.pasid = prm->pasid;
+		}
+		riscv_iommu_ats_prgr(dev, &resp);
+	}
+
+	put_device(dev);
+}
+
+static int riscv_iommu_page_response(struct device *dev,
+				     struct iommu_fault_event *evt,
+				     struct iommu_page_response *msg)
+{
+	return riscv_iommu_ats_prgr(dev, msg);
+}
+
 /* Page request interface queue primary interrupt handler */
 static irqreturn_t riscv_iommu_priq_irq_check(int irq, void *data)
 {
@@ -626,7 +897,7 @@ static irqreturn_t riscv_iommu_priq_process(int irq, void *data)
 	struct riscv_iommu_queue *q = (struct riscv_iommu_queue *)data;
 	struct riscv_iommu_device *iommu;
 	struct riscv_iommu_pq_record *requests;
-	unsigned cnt, idx, ctrl;
+	unsigned cnt, len, idx, ctrl;
 
 	iommu = container_of(q, struct riscv_iommu_device, priq);
 	requests = (struct riscv_iommu_pq_record *)q->base;
@@ -649,7 +920,8 @@ static irqreturn_t riscv_iommu_priq_process(int irq, void *data)
 		cnt = riscv_iommu_queue_consume(iommu, q, &idx);
 		if (!cnt)
 			break;
-		dev_warn(iommu->dev, "unexpected %u page requests\n", cnt);
+		for (len = 0; len < cnt; idx++, len++)
+			riscv_iommu_page_request(iommu, &requests[idx]);
 		riscv_iommu_queue_release(iommu, q, cnt);
 	} while (1);
 
@@ -660,6 +932,169 @@ static irqreturn_t riscv_iommu_priq_process(int irq, void *data)
  * Endpoint management
  */
 
+/* Endpoint features/capabilities */
+static void riscv_iommu_disable_ep(struct riscv_iommu_endpoint *ep)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(ep->dev))
+		return;
+
+	pdev = to_pci_dev(ep->dev);
+
+	if (ep->pasid_enabled) {
+		pci_disable_ats(pdev);
+		pci_disable_pri(pdev);
+		pci_disable_pasid(pdev);
+		ep->pasid_enabled = false;
+	}
+}
+
+static void riscv_iommu_enable_ep(struct riscv_iommu_endpoint *ep)
+{
+	int rc, feat, num;
+	struct pci_dev *pdev;
+	struct device *dev = ep->dev;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	if (!ep->iommu->iommu.max_pasids)
+		return;
+
+	pdev = to_pci_dev(dev);
+
+	if (!pci_ats_supported(pdev))
+		return;
+
+	if (!pci_pri_supported(pdev))
+		return;
+
+	feat = pci_pasid_features(pdev);
+	if (feat < 0)
+		return;
+
+	num = pci_max_pasids(pdev);
+	if (!num) {
+		dev_warn(dev, "Can't enable PASID (num: %d)\n", num);
+		return;
+	}
+
+	if (num > ep->iommu->iommu.max_pasids)
+		num = ep->iommu->iommu.max_pasids;
+
+	rc = pci_enable_pasid(pdev, feat);
+	if (rc) {
+		dev_warn(dev, "Can't enable PASID (rc: %d)\n", rc);
+		return;
+	}
+
+	rc = pci_reset_pri(pdev);
+	if (rc) {
+		dev_warn(dev, "Can't reset PRI (rc: %d)\n", rc);
+		pci_disable_pasid(pdev);
+		return;
+	}
+
+	/* TODO: Get supported PRI queue length, hard-code to 32 entries */
+	rc = pci_enable_pri(pdev, 32);
+	if (rc) {
+		dev_warn(dev, "Can't enable PRI (rc: %d)\n", rc);
+		pci_disable_pasid(pdev);
+		return;
+	}
+
+	rc = pci_enable_ats(pdev, PAGE_SHIFT);
+	if (rc) {
+		dev_warn(dev, "Can't enable ATS (rc: %d)\n", rc);
+		pci_disable_pri(pdev);
+		pci_disable_pasid(pdev);
+		return;
+	}
+
+	ep->pc = (struct riscv_iommu_pc *)get_zeroed_page(GFP_KERNEL);
+	if (!ep->pc) {
+		pci_disable_ats(pdev);
+		pci_disable_pri(pdev);
+		pci_disable_pasid(pdev);
+		return;
+	}
+
+	ep->pasid_enabled = true;
+	ep->pasid_feat = feat;
+	ep->pasid_bits = ilog2(num);
+
+	dev_dbg(ep->dev, "PASID/ATS support enabled, %d bits\n", ep->pasid_bits);
+}
+
+static int riscv_iommu_enable_sva(struct device *dev)
+{
+	int ret;
+	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
+
+	if (!ep || !ep->iommu || !ep->iommu->pq_work)
+		return -EINVAL;
+
+	if (!ep->pasid_enabled)
+		return -ENODEV;
+
+	ret = iopf_queue_add_device(ep->iommu->pq_work, dev);
+	if (ret)
+		return ret;
+
+	return iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+}
+
+static int riscv_iommu_disable_sva(struct device *dev)
+{
+	int ret;
+	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
+
+	ret = iommu_unregister_device_fault_handler(dev);
+	if (!ret)
+		ret = iopf_queue_remove_device(ep->iommu->pq_work, dev);
+
+	return ret;
+}
+
+static int riscv_iommu_enable_iopf(struct device *dev)
+{
+	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
+
+	if (ep && ep->pasid_enabled)
+		return 0;
+
+	return -EINVAL;
+}
+
+static int riscv_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		return riscv_iommu_enable_iopf(dev);
+
+	case IOMMU_DEV_FEAT_SVA:
+		return riscv_iommu_enable_sva(dev);
+
+	default:
+		return -ENODEV;
+	}
+}
+
+static int riscv_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
+{
+	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		return 0;
+
+	case IOMMU_DEV_FEAT_SVA:
+		return riscv_iommu_disable_sva(dev);
+
+	default:
+		return -ENODEV;
+	}
+}
+
 static int riscv_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -812,6 +1247,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 
 	dev_iommu_priv_set(dev, ep);
 	riscv_iommu_add_device(iommu, dev);
+	riscv_iommu_enable_ep(ep);
 
 	return &iommu->iommu;
 }
@@ -843,6 +1279,8 @@ static void riscv_iommu_release_device(struct device *dev)
 		riscv_iommu_iodir_inv_devid(iommu, ep->devid);
 	}
 
+	riscv_iommu_disable_ep(ep);
+
 	/* Remove endpoint from IOMMU tracking structures */
 	mutex_lock(&iommu->eps_mutex);
 	rb_erase(&ep->node, &iommu->eps);
@@ -878,7 +1316,8 @@ static struct iommu_domain *riscv_iommu_domain_alloc(unsigned type)
 	    type != IOMMU_DOMAIN_DMA_FQ &&
 	    type != IOMMU_DOMAIN_UNMANAGED &&
 	    type != IOMMU_DOMAIN_IDENTITY &&
-	    type != IOMMU_DOMAIN_BLOCKED)
+	    type != IOMMU_DOMAIN_BLOCKED &&
+	    type != IOMMU_DOMAIN_SVA)
 		return NULL;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
@@ -906,6 +1345,9 @@ static void riscv_iommu_domain_free(struct iommu_domain *iommu_domain)
 		pr_warn("IOMMU domain is not empty!\n");
 	}
 
+	if (domain->mn.ops && iommu_domain->mm)
+		mmu_notifier_unregister(&domain->mn, iommu_domain->mm);
+
 	if (domain->pgtbl.cookie)
 		free_io_pgtable_ops(&domain->pgtbl.ops);
 
@@ -1023,14 +1465,29 @@ static int riscv_iommu_attach_dev(struct iommu_domain *iommu_domain, struct devi
 	 */
 	val = FIELD_PREP(RISCV_IOMMU_DC_TA_PSCID, domain->pscid);
 
-	dc->ta = cpu_to_le64(val);
-	dc->fsc = cpu_to_le64(riscv_iommu_domain_atp(domain));
+	if (ep->pasid_enabled) {
+		ep->pc[0].ta = cpu_to_le64(val | RISCV_IOMMU_PC_TA_V);
+		ep->pc[0].fsc = cpu_to_le64(riscv_iommu_domain_atp(domain));
+		dc->ta = 0;
+		dc->fsc = cpu_to_le64(virt_to_pfn(ep->pc) |
+		    FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8));
+	} else {
+		dc->ta = cpu_to_le64(val);
+		dc->fsc = cpu_to_le64(riscv_iommu_domain_atp(domain));
+	}
 
 	wmb();
 
 	/* Mark device context as valid, synchronise device context cache. */
 	val = RISCV_IOMMU_DC_TC_V;
 
+	if (ep->pasid_enabled) {
+		val |= RISCV_IOMMU_DC_TC_EN_ATS |
+		       RISCV_IOMMU_DC_TC_EN_PRI |
+		       RISCV_IOMMU_DC_TC_DPE |
+		       RISCV_IOMMU_DC_TC_PDTV;
+	}
+
 	if (ep->iommu->cap & RISCV_IOMMU_CAP_AMO) {
 		val |= RISCV_IOMMU_DC_TC_GADE |
 		       RISCV_IOMMU_DC_TC_SADE;
@@ -1051,13 +1508,107 @@ static int riscv_iommu_attach_dev(struct iommu_domain *iommu_domain, struct devi
 	return 0;
 }
 
+static int riscv_iommu_set_dev_pasid(struct iommu_domain *iommu_domain,
+				     struct device *dev, ioasid_t pasid)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
+	u64 ta, fsc;
+
+	if (!iommu_domain || !iommu_domain->mm)
+		return -EINVAL;
+
+	/* Driver uses TC.DPE mode, PASID #0 is incorrect. */
+	if (pasid == 0)
+		return -EINVAL;
+
+	/* Incorrect domain identifier */
+	if ((int)domain->pscid < 0)
+		return -ENOMEM;
+
+	/* Process Context table should be set for pasid enabled endpoints. */
+	if (!ep || !ep->pasid_enabled || !ep->dc || !ep->pc)
+		return -ENODEV;
+
+	domain->pasid = pasid;
+	domain->iommu = ep->iommu;
+	domain->mn.ops = &riscv_iommu_mmuops;
+
+	/* register mm notifier */
+	if (mmu_notifier_register(&domain->mn, iommu_domain->mm))
+		return -ENODEV;
+
+	/* TODO: get SXL value for the process, use 32 bit or SATP mode */
+	fsc = virt_to_pfn(iommu_domain->mm->pgd) | satp_mode;
+	ta = RISCV_IOMMU_PC_TA_V | FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid);
+
+	fsc = le64_to_cpu(xchg_relaxed(&(ep->pc[pasid].fsc), cpu_to_le64(fsc)));
+	ta = le64_to_cpu(xchg_relaxed(&(ep->pc[pasid].ta), cpu_to_le64(ta)));
+
+	wmb();
+
+	if (ta & RISCV_IOMMU_PC_TA_V) {
+		riscv_iommu_iodir_inv_pasid(ep->iommu, ep->devid, pasid);
+		riscv_iommu_iofence_sync(ep->iommu);
+	}
+
+	dev_info(dev, "domain type %d attached w/ PSCID %u PASID %u\n",
+	    domain->domain.type, domain->pscid, domain->pasid);
+
+	return 0;
+}
+
+static void riscv_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct riscv_iommu_endpoint *ep = dev_iommu_priv_get(dev);
+	struct riscv_iommu_command cmd;
+	unsigned long payload = riscv_iommu_ats_inval_all_payload(false);
+	u64 ta;
+
+	/* invalidate TA.V */
+	ta = le64_to_cpu(xchg_relaxed(&(ep->pc[pasid].ta), 0));
+
+	wmb();
+
+	dev_info(dev, "domain removed w/ PSCID %u PASID %u\n",
+	    (unsigned)FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, ta), pasid);
+
+	/* 1. invalidate PDT entry */
+	riscv_iommu_iodir_inv_pasid(ep->iommu, ep->devid, pasid);
+
+	/* 2. invalidate all matching IOATC entries (if PASID was valid) */
+	if (ta & RISCV_IOMMU_PC_TA_V) {
+		riscv_iommu_cmd_inval_vma(&cmd);
+		riscv_iommu_cmd_inval_set_gscid(&cmd, 0);
+		riscv_iommu_cmd_inval_set_pscid(&cmd,
+		    FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, ta));
+		riscv_iommu_post(ep->iommu, &cmd);
+	}
+
+	/* 3. Wait IOATC flush to happen */
+	riscv_iommu_iofence_sync(ep->iommu);
+
+	/* 4. ATS invalidation */
+	riscv_iommu_cmd_ats_inval(&cmd);
+	riscv_iommu_cmd_ats_set_dseg(&cmd, ep->domid);
+	riscv_iommu_cmd_ats_set_rid(&cmd, ep->devid);
+	riscv_iommu_cmd_ats_set_pid(&cmd, pasid);
+	riscv_iommu_cmd_ats_set_payload(&cmd, payload);
+	riscv_iommu_post(ep->iommu, &cmd);
+
+	/* 5. Wait DevATC flush to happen */
+	riscv_iommu_iofence_sync(ep->iommu);
+}
+
 static void riscv_iommu_flush_iotlb_range(struct iommu_domain *iommu_domain,
 					  unsigned long *start, unsigned long *end,
 					  size_t *pgsize)
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_command cmd;
+	struct riscv_iommu_endpoint *endpoint;
 	unsigned long iova;
+	unsigned long payload;
 
 	if (domain->mode == RISCV_IOMMU_DC_FSC_MODE_BARE)
 		return;
@@ -1065,6 +1616,12 @@ static void riscv_iommu_flush_iotlb_range(struct iommu_domain *iommu_domain,
 	/* Domain not attached to an IOMMU! */
 	BUG_ON(!domain->iommu);
 
+	if (start && end) {
+		payload = riscv_iommu_ats_inval_payload(*start, *end, true);
+	} else {
+		payload = riscv_iommu_ats_inval_all_payload(true);
+	}
+
 	riscv_iommu_cmd_inval_vma(&cmd);
 	riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
 
@@ -1078,6 +1635,20 @@ static void riscv_iommu_flush_iotlb_range(struct iommu_domain *iommu_domain,
 		riscv_iommu_post(domain->iommu, &cmd);
 	}
 	riscv_iommu_iofence_sync(domain->iommu);
+
+	/* ATS invalidation for every device and for every translation */
+	list_for_each_entry(endpoint, &domain->endpoints, domain) {
+		if (!endpoint->pasid_enabled)
+			continue;
+
+		riscv_iommu_cmd_ats_inval(&cmd);
+		riscv_iommu_cmd_ats_set_dseg(&cmd, endpoint->domid);
+		riscv_iommu_cmd_ats_set_rid(&cmd, endpoint->devid);
+		riscv_iommu_cmd_ats_set_pid(&cmd, domain->pasid);
+		riscv_iommu_cmd_ats_set_payload(&cmd, payload);
+		riscv_iommu_post(domain->iommu, &cmd);
+	}
+	riscv_iommu_iofence_sync(domain->iommu);
 }
 
 static void riscv_iommu_flush_iotlb_all(struct iommu_domain *iommu_domain)
@@ -1310,6 +1881,7 @@ static int riscv_iommu_enable(struct riscv_iommu_device *iommu, unsigned request
 static const struct iommu_domain_ops riscv_iommu_domain_ops = {
 	.free = riscv_iommu_domain_free,
 	.attach_dev = riscv_iommu_attach_dev,
+	.set_dev_pasid = riscv_iommu_set_dev_pasid,
 	.map_pages = riscv_iommu_map_pages,
 	.unmap_pages = riscv_iommu_unmap_pages,
 	.iova_to_phys = riscv_iommu_iova_to_phys,
@@ -1326,9 +1898,13 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.probe_device = riscv_iommu_probe_device,
 	.probe_finalize = riscv_iommu_probe_finalize,
 	.release_device = riscv_iommu_release_device,
+	.remove_dev_pasid = riscv_iommu_remove_dev_pasid,
 	.device_group = riscv_iommu_device_group,
 	.get_resv_regions = riscv_iommu_get_resv_regions,
 	.of_xlate = riscv_iommu_of_xlate,
+	.dev_enable_feat = riscv_iommu_dev_enable_feat,
+	.dev_disable_feat = riscv_iommu_dev_disable_feat,
+	.page_response = riscv_iommu_page_response,
 	.default_domain_ops = &riscv_iommu_domain_ops,
 };
 
@@ -1340,6 +1916,7 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 	riscv_iommu_queue_free(iommu, &iommu->cmdq);
 	riscv_iommu_queue_free(iommu, &iommu->fltq);
 	riscv_iommu_queue_free(iommu, &iommu->priq);
+	iopf_queue_free(iommu->pq_work);
 }
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
@@ -1362,6 +1939,12 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	}
 #endif
 
+	if (iommu->cap & RISCV_IOMMU_CAP_PD20)
+		iommu->iommu.max_pasids = 1u << 20;
+	else if (iommu->cap & RISCV_IOMMU_CAP_PD17)
+		iommu->iommu.max_pasids = 1u << 17;
+	else if (iommu->cap & RISCV_IOMMU_CAP_PD8)
+		iommu->iommu.max_pasids = 1u << 8;
 	/*
 	 * Assign queue lengths from module parameters if not already
 	 * set on the device tree.
@@ -1387,6 +1970,13 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto fail;
 	if (!(iommu->cap & RISCV_IOMMU_CAP_ATS))
 		goto no_ats;
+	/* PRI functionally depends on ATS’s capabilities. */
+	iommu->pq_work = iopf_queue_alloc(dev_name(dev));
+	if (!iommu->pq_work) {
+		dev_err(dev, "failed to allocate iopf queue\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
 
 	ret = riscv_iommu_queue_init(iommu, RISCV_IOMMU_PAGE_REQUEST_QUEUE);
 	if (ret)
@@ -1424,5 +2014,6 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	riscv_iommu_queue_free(iommu, &iommu->priq);
 	riscv_iommu_queue_free(iommu, &iommu->fltq);
 	riscv_iommu_queue_free(iommu, &iommu->cmdq);
+	iopf_queue_free(iommu->pq_work);
 	return ret;
 }
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index fe32a4eff14e..83e8d00fd0f8 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -17,9 +17,11 @@
 #include <linux/iova.h>
 #include <linux/io.h>
 #include <linux/idr.h>
+#include <linux/mmu_notifier.h>
 #include <linux/list.h>
 #include <linux/iommu.h>
 #include <linux/io-pgtable.h>
+#include <linux/mmu_notifier.h>
 
 #include "iommu-bits.h"
 
@@ -76,6 +78,9 @@ struct riscv_iommu_device {
 	unsigned ddt_mode;
 	bool ddtp_in_iomem;
 
+	/* I/O page fault queue */
+	struct iopf_queue *pq_work;
+
 	/* hardware queues */
 	struct riscv_iommu_queue cmdq;
 	struct riscv_iommu_queue fltq;
@@ -91,11 +96,14 @@ struct riscv_iommu_domain {
 	struct io_pgtable pgtbl;
 
 	struct list_head endpoints;
+	struct list_head notifiers;
 	struct mutex lock;
+	struct mmu_notifier mn;
 	struct riscv_iommu_device *iommu;
 
 	unsigned mode;		/* RIO_ATP_MODE_* enum */
 	unsigned pscid;		/* RISC-V IOMMU PSCID */
+	ioasid_t pasid;		/* IOMMU_DOMAIN_SVA: Cached PASID */
 
 	pgd_t *pgd_root;	/* page table root pointer */
 };
@@ -107,10 +115,16 @@ struct riscv_iommu_endpoint {
 	unsigned domid;    			/* PCI domain number, segment */
 	struct rb_node node;    		/* device tracking node (lookup by devid) */
 	struct riscv_iommu_dc *dc;		/* device context pointer */
+	struct riscv_iommu_pc *pc;		/* process context root, valid if pasid_enabled is true */
 	struct riscv_iommu_device *iommu;	/* parent iommu device */
 
 	struct mutex lock;
 	struct list_head domain;		/* endpoint attached managed domain */
+
+	/* end point info bits */
+	unsigned pasid_bits;
+	unsigned pasid_feat;
+	bool pasid_enabled;
 };
 
 /* Helper functions and macros */
-- 
2.34.1

