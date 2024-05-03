Return-Path: <linux-kernel+bounces-167884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A488BB0AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBEE3B227B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95212156C5A;
	Fri,  3 May 2024 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fJc/x41P"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D457156987
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752784; cv=none; b=isLYE+rQfZ2t03oYpDW1TvnJtfV0d6qdrBhmpSBmfhKvZVwmAiOBdWuNJwFn+lrRqxEufOTOwg98Qhe33RCvVzfd69YrLeU2ZySS1db4gERFJ4Fo6NCfjkr9pn8dI+TE6uH1EXGiGBYoXebkv8FscMz8MpibreWPFFxHjQas0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752784; c=relaxed/simple;
	bh=7/8J+1KtszTdrcL9TeIRduxfavrt5nmni8YqUnJGivI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0xFyFN74wyG3qtKev7sA6oXF14Ppa0zJ5cC3DAXczAhI0HwzRtn1R0uS3/xu06VjQoCGAj2Nl3RRZOybhijgOwRmNBkY5R0VCJ69leJVfBD/xBLa+dExvtAQpZR0s7/5EEL24SLdOI+lPt7OsR8tEA37V8l6xe2YHxrRCY12dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fJc/x41P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eab16c8d83so77014205ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714752780; x=1715357580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68WH/mDXC+SKl8OGPN9Xpdruay3Jne7z83y1PH53Kx0=;
        b=fJc/x41PLvbfgoYg7REvwAiX9OtWRvzd6E5xQlc7dJeF+DlWqFCMbdGsrQvk66w891
         gy+O30rViFDqrPljpXOLiAX6D15UYqkdQegrTvuNUp9HYcmHodbE9My9OxV80F56SWUV
         r6LVEGsUYDcY4GIl/mPibWGTe4N5+RIStmNcBfcm6fvXkq/DxDduL2Cm63Cb+PkkO/tj
         FFX+BAcNu9fZXWSXJykQN3M54l7+qQL6Z7c0bBqvukB4vsHxxOTKQ/t5niecrTS0Q5Pe
         Sl0KikDgLsVIN2tTXeos0ea+LeO0QFCbtSxRi3kPFc11MmubuwAOJ0/YE3uieOJtfLFA
         ZqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714752780; x=1715357580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68WH/mDXC+SKl8OGPN9Xpdruay3Jne7z83y1PH53Kx0=;
        b=FDjOqCJri6sTnXR6tG2GIPXUCjIWKziz1/3aLgX+UQ5cshnGoAXedktGUxvb1+KxM1
         iZAZBTCjU5aaepSTVKGNvFOqiaVTXaSGH+cCxvu2vRqOQKupkeDGG5XhGIJdZlVagJ0o
         G8nD4STAdDv4JhxVm4Rf74RsI44uo17z/B+z8QNtHnkaTBikahkaLg53mGPLdmlbFOIT
         jXKQKDRhsQKCCjExEt5N3pu2ja0Kvj38m6a9Bgg3nPxVbX4DXygG7Yamc8Y8zQKllA0O
         ApINEP/ixCKrX+V8gYcd6+LwtlPBv3NwgSZ+VgVitwMefAXnX0UnMHigbhT3Du629d+5
         KNTA==
X-Forwarded-Encrypted: i=1; AJvYcCX6ompKOxca0+QVvtPGP+7QXI3T/OJyZEi4N9oiPU6pv0K3i1VO/nDzs1oh4WxkZU9oLymh3iOhxnUuPYSoYPoYfSU7jQnVOyerM/mC
X-Gm-Message-State: AOJu0Yy9zV9EcIJAV/m+b62WAmGPML/u2Om2ogfThoiVWSOnRvh0tN11
	bZYAJ3gSWaoVJ6PQnZj0A29HAKv95Vj8Zc4fbyOB1R3uKtF10G5vCOaQYO1X2TU=
X-Google-Smtp-Source: AGHT+IEGymTnwbSvbt9i/xVK7iCP9HrsYq8ifmSMG1QlxyNDu+73Kdx9hnEOmZ1fsWDD1Y8J3y72Bw==
X-Received: by 2002:a17:903:1c9:b0:1e3:e081:e7f5 with SMTP id e9-20020a17090301c900b001e3e081e7f5mr2632736plh.66.1714752780234;
        Fri, 03 May 2024 09:13:00 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ec8300b001e2086fddecsm3424746plg.139.2024.05.03.09.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:12:59 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 6/7] iommu/riscv: Command and fault queue support
Date: Fri,  3 May 2024 09:12:39 -0700
Message-Id: <f63635cd72fd0d1b0026a6839dbfeaa2cd154eaa.1714752293.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714752293.git.tjeznach@rivosinc.com>
References: <cover.1714752293.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce device command submission and fault reporting queues,
as described in Chapter 3.1 and 3.2 of the RISC-V IOMMU Architecture
Specification.

Command and fault queues are instantiated in contiguous system memory
local to IOMMU device domain, or mapped from fixed I/O space provided
by the hardware implementation. Detection of the location and maximum
allowed size of the queue utilize WARL properties of queue base control
register. Driver implementation will try to allocate up to 128KB of
system memory, while respecting hardware supported maximum queue size.

Interrupts allocation is based on interrupt vectors availability and
distributed to all queues in simple round-robin fashion. For hardware
Implementation with fixed event type to interrupt vector assignment
IVEC WARL property is used to discover such mappings.

Address translation, command and queue fault handling in this change
is limited to simple fault reporting without taking any action.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu-bits.h |  75 +++++
 drivers/iommu/riscv/iommu.c      | 496 ++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.h      |  21 ++
 3 files changed, 590 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index ba093c29de9f..40c379222821 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -704,4 +704,79 @@ struct riscv_iommu_msi_pte {
 #define RISCV_IOMMU_MSI_MRIF_NPPN	RISCV_IOMMU_PPN_FIELD
 #define RISCV_IOMMU_MSI_MRIF_NID_MSB	BIT_ULL(60)
 
+/* Helper functions: command structure builders. */
+
+static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
+{
+	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IOTINVAL_OPCODE) |
+		      FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA);
+	cmd->dword1 = 0;
+}
+
+static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
+						  u64 addr)
+{
+	cmd->dword1 = FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_ADDR, phys_to_pfn(addr));
+	cmd->dword0 |= RISCV_IOMMU_CMD_IOTINVAL_AV;
+}
+
+static inline void riscv_iommu_cmd_inval_set_pscid(struct riscv_iommu_command *cmd,
+						   int pscid)
+{
+	cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_PSCID, pscid) |
+		       RISCV_IOMMU_CMD_IOTINVAL_PSCV;
+}
+
+static inline void riscv_iommu_cmd_inval_set_gscid(struct riscv_iommu_command *cmd,
+						   int gscid)
+{
+	cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_GSCID, gscid) |
+		       RISCV_IOMMU_CMD_IOTINVAL_GV;
+}
+
+static inline void riscv_iommu_cmd_iofence(struct riscv_iommu_command *cmd)
+{
+	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IOFENCE_OPCODE) |
+		      FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOFENCE_FUNC_C) |
+		      RISCV_IOMMU_CMD_IOFENCE_PR | RISCV_IOMMU_CMD_IOFENCE_PW;
+	cmd->dword1 = 0;
+}
+
+static inline void riscv_iommu_cmd_iofence_set_av(struct riscv_iommu_command *cmd,
+						  u64 addr, u32 data)
+{
+	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IOFENCE_OPCODE) |
+		      FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOFENCE_FUNC_C) |
+		      FIELD_PREP(RISCV_IOMMU_CMD_IOFENCE_DATA, data) |
+		      RISCV_IOMMU_CMD_IOFENCE_AV;
+	cmd->dword1 = addr >> 2;
+}
+
+static inline void riscv_iommu_cmd_iodir_inval_ddt(struct riscv_iommu_command *cmd)
+{
+	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IODIR_OPCODE) |
+		      FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT);
+	cmd->dword1 = 0;
+}
+
+static inline void riscv_iommu_cmd_iodir_inval_pdt(struct riscv_iommu_command *cmd)
+{
+	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IODIR_OPCODE) |
+		      FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_PDT);
+	cmd->dword1 = 0;
+}
+
+static inline void riscv_iommu_cmd_iodir_set_did(struct riscv_iommu_command *cmd,
+						 unsigned int devid)
+{
+	cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_IODIR_DID, devid) |
+		       RISCV_IOMMU_CMD_IODIR_DV;
+}
+
+static inline void riscv_iommu_cmd_iodir_set_pid(struct riscv_iommu_command *cmd,
+						 unsigned int pasid)
+{
+	cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_IODIR_PID, pasid);
+}
+
 #endif /* _RISCV_IOMMU_BITS_H_ */
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 71b7903d83d4..4349ac8a3990 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -25,7 +25,14 @@
 #include "iommu.h"
 
 /* Timeouts in [us] */
-#define RISCV_IOMMU_DDTP_TIMEOUT	50000
+#define RISCV_IOMMU_QCSR_TIMEOUT	150000
+#define RISCV_IOMMU_QUEUE_TIMEOUT	150000
+#define RISCV_IOMMU_DDTP_TIMEOUT	10000000
+#define RISCV_IOMMU_IOTINVAL_TIMEOUT	90000000
+
+/* Number of entries per CMD/FLT queue, should be <= INT_MAX */
+#define RISCV_IOMMU_DEF_CQ_COUNT	8192
+#define RISCV_IOMMU_DEF_FQ_COUNT	4096
 
 /* RISC-V IOMMU PPN <> PHYS address conversions, PHYS <=> PPN[53:10] */
 #define phys_to_ppn(va)  (((va) >> 2) & (((1ULL << 44) - 1) << 10))
@@ -89,6 +96,432 @@ static void riscv_iommu_free_pages(struct riscv_iommu_device *iommu, void *addr)
 		       riscv_iommu_devres_pages_match, &devres);
 }
 
+/*
+ * Hardware queue allocation and management.
+ */
+
+/* Setup queue base, control registers and default queue length */
+#define RISCV_IOMMU_QUEUE_INIT(q, name) do {				\
+	struct riscv_iommu_queue *_q = q;				\
+	_q->qid = RISCV_IOMMU_INTR_ ## name;				\
+	_q->qbr = RISCV_IOMMU_REG_ ## name ## B;			\
+	_q->qcr = RISCV_IOMMU_REG_ ## name ## CSR;			\
+	_q->mask = _q->mask ?: (RISCV_IOMMU_DEF_ ## name ## _COUNT) - 1;\
+} while (0)
+
+/* Note: offsets are the same for all queues */
+#define Q_HEAD(q) ((q)->qbr + (RISCV_IOMMU_REG_CQH - RISCV_IOMMU_REG_CQB))
+#define Q_TAIL(q) ((q)->qbr + (RISCV_IOMMU_REG_CQT - RISCV_IOMMU_REG_CQB))
+#define Q_ITEM(q, index) ((q)->mask & (index))
+#define Q_IPSR(q) BIT((q)->qid)
+
+/*
+ * Discover queue ring buffer hardware configuration, allocate in-memory
+ * ring buffer or use fixed I/O memory location, configure queue base register.
+ * Must be called before hardware queue is enabled.
+ *
+ * @queue - data structure, configured with RISCV_IOMMU_QUEUE_INIT()
+ * @entry_size - queue single element size in bytes.
+ */
+static int riscv_iommu_queue_alloc(struct riscv_iommu_device *iommu,
+				   struct riscv_iommu_queue *queue,
+				   size_t entry_size)
+{
+	unsigned int logsz;
+	u64 qb, rb;
+
+	/*
+	 * Use WARL base register property to discover maximum allowed
+	 * number of entries and optional fixed IO address for queue location.
+	 */
+	riscv_iommu_writeq(iommu, queue->qbr, RISCV_IOMMU_QUEUE_LOGSZ_FIELD);
+	qb = riscv_iommu_readq(iommu, queue->qbr);
+
+	/*
+	 * Calculate and verify hardware supported queue length, as reported
+	 * by the field LOGSZ, where max queue length is equal to 2^(LOGSZ + 1).
+	 * Update queue size based on hardware supported value.
+	 */
+	logsz = ilog2(queue->mask);
+	if (logsz > FIELD_GET(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, qb))
+		logsz = FIELD_GET(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, qb);
+
+	/*
+	 * Use WARL base register property to discover an optional fixed IO
+	 * address for queue ring buffer location. Otherwise allocate contigus
+	 * system memory.
+	 */
+	if (FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb)) {
+		const size_t queue_size = entry_size << (logsz + 1);
+
+		queue->phys = ppn_to_phys(FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb));
+		queue->base = devm_ioremap(iommu->dev, queue->phys, queue_size);
+	} else {
+		do {
+			const size_t queue_size = entry_size << (logsz + 1);
+			const int order = get_order(queue_size);
+
+			queue->base = riscv_iommu_get_pages(iommu, order);
+			queue->phys = __pa(queue->base);
+		} while (!queue->base && logsz-- > 0);
+	}
+
+	if (!queue->base)
+		return -ENOMEM;
+
+	qb = phys_to_ppn(queue->phys) |
+	     FIELD_PREP(RISCV_IOMMU_QUEUE_LOGSZ_FIELD, logsz);
+
+	/* Update base register and read back to verify hw accepted our write */
+	riscv_iommu_writeq(iommu, queue->qbr, qb);
+	rb = riscv_iommu_readq(iommu, queue->qbr);
+	if (rb != qb) {
+		dev_err(iommu->dev, "queue #%u allocation failed\n", queue->qid);
+		return -ENODEV;
+	}
+
+	/* Update actual queue mask */
+	queue->mask = (2U << logsz) - 1;
+
+	dev_dbg(iommu->dev, "queue #%u allocated 2^%u entries",
+		queue->qid, logsz + 1);
+
+	return 0;
+}
+
+/* Check interrupt queue status, IPSR */
+static irqreturn_t riscv_iommu_queue_ipsr(int irq, void *data)
+{
+	struct riscv_iommu_queue *queue = (struct riscv_iommu_queue *)data;
+
+	if (riscv_iommu_readl(queue->iommu, RISCV_IOMMU_REG_IPSR) & Q_IPSR(queue))
+		return IRQ_WAKE_THREAD;
+
+	return IRQ_NONE;
+}
+
+static int riscv_iommu_queue_vec(struct riscv_iommu_device *iommu, int n)
+{
+	/* Reuse IVEC.CIV mask for all interrupt vectors mapping. */
+	return (iommu->ivec >> (n * 4)) & RISCV_IOMMU_IVEC_CIV;
+}
+
+/*
+ * Enable queue processing in the hardware, register interrupt handler.
+ *
+ * @queue - data structure, already allocated with riscv_iommu_queue_alloc()
+ * @irq_handler - threaded interrupt handler.
+ */
+static int riscv_iommu_queue_enable(struct riscv_iommu_device *iommu,
+				    struct riscv_iommu_queue *queue,
+				    irq_handler_t irq_handler)
+{
+	const unsigned int irq = iommu->irqs[riscv_iommu_queue_vec(iommu, queue->qid)];
+	u32 csr;
+	int rc;
+
+	if (queue->iommu)
+		return -EBUSY;
+
+	/* Polling not implemented */
+	if (!irq)
+		return -ENODEV;
+
+	queue->iommu = iommu;
+	rc = request_threaded_irq(irq, riscv_iommu_queue_ipsr, irq_handler,
+				  IRQF_ONESHOT | IRQF_SHARED,
+				  dev_name(iommu->dev), queue);
+	if (rc) {
+		queue->iommu = NULL;
+		return rc;
+	}
+
+	/*
+	 * Enable queue with interrupts, clear any memory fault if any.
+	 * Wait for the hardware to acknowledge request and activate queue
+	 * processing.
+	 * Note: All CSR bitfields are in the same offsets for all queues.
+	 */
+	riscv_iommu_writel(iommu, queue->qcr,
+			   RISCV_IOMMU_QUEUE_ENABLE |
+			   RISCV_IOMMU_QUEUE_INTR_ENABLE |
+			   RISCV_IOMMU_QUEUE_MEM_FAULT);
+
+	riscv_iommu_readl_timeout(iommu, queue->qcr,
+				  csr, !(csr & RISCV_IOMMU_QUEUE_BUSY),
+				  10, RISCV_IOMMU_QCSR_TIMEOUT);
+
+	if (RISCV_IOMMU_QUEUE_ACTIVE != (csr & (RISCV_IOMMU_QUEUE_ACTIVE |
+						RISCV_IOMMU_QUEUE_BUSY |
+						RISCV_IOMMU_QUEUE_MEM_FAULT))) {
+		/* Best effort to stop and disable failing hardware queue. */
+		riscv_iommu_writel(iommu, queue->qcr, 0);
+		free_irq(irq, queue);
+		queue->iommu = NULL;
+		dev_err(iommu->dev, "queue #%u failed to start\n", queue->qid);
+		return -EBUSY;
+	}
+
+	/* Clear any pending interrupt flag. */
+	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, Q_IPSR(queue));
+
+	return 0;
+}
+
+/*
+ * Disable queue. Wait for the hardware to acknowledge request and
+ * stop processing enqueued requests. Report errors but continue.
+ */
+static void riscv_iommu_queue_disable(struct riscv_iommu_queue *queue)
+{
+	struct riscv_iommu_device *iommu = queue->iommu;
+	u32 csr;
+
+	if (!iommu)
+		return;
+
+	free_irq(iommu->irqs[riscv_iommu_queue_vec(iommu, queue->qid)], queue);
+	riscv_iommu_writel(iommu, queue->qcr, 0);
+	riscv_iommu_readl_timeout(iommu, queue->qcr,
+				  csr, !(csr & RISCV_IOMMU_QUEUE_BUSY),
+				  10, RISCV_IOMMU_QCSR_TIMEOUT);
+
+	if (csr & (RISCV_IOMMU_QUEUE_ACTIVE | RISCV_IOMMU_QUEUE_BUSY))
+		dev_err(iommu->dev, "fail to disable hardware queue #%u, csr 0x%x\n",
+			queue->qid, csr);
+
+	queue->iommu = NULL;
+}
+
+/*
+ * Returns number of available valid queue entries and the first item index.
+ * Update shadow producer index if necessary.
+ */
+static int riscv_iommu_queue_consume(struct riscv_iommu_queue *queue,
+				     unsigned int *index)
+{
+	unsigned int head = atomic_read(&queue->head);
+	unsigned int tail = atomic_read(&queue->tail);
+	unsigned int last = Q_ITEM(queue, tail);
+	int available = (int)(tail - head);
+
+	*index = head;
+
+	if (available > 0)
+		return available;
+
+	/* read hardware producer index, check reserved register bits are not set. */
+	if (riscv_iommu_readl_timeout(queue->iommu, Q_TAIL(queue),
+				      tail, (tail & ~queue->mask) == 0,
+				      0, RISCV_IOMMU_QUEUE_TIMEOUT)) {
+		dev_err_once(queue->iommu->dev,
+			     "Hardware error: queue access timeout\n");
+		return 0;
+	}
+
+	if (tail == last)
+		return 0;
+
+	/* update shadow producer index */
+	return (int)(atomic_add_return((tail - last) & queue->mask, &queue->tail) - head);
+}
+
+/*
+ * Release processed queue entries, should match riscv_iommu_queue_consume() calls.
+ */
+static void riscv_iommu_queue_release(struct riscv_iommu_queue *queue, int count)
+{
+	const unsigned int head = atomic_add_return(count, &queue->head);
+
+	riscv_iommu_writel(queue->iommu, Q_HEAD(queue), Q_ITEM(queue, head));
+}
+
+/* Return actual consumer index based on hardware reported queue head index. */
+static unsigned int riscv_iommu_queue_cons(struct riscv_iommu_queue *queue)
+{
+	const unsigned int cons = atomic_read(&queue->head);
+	const unsigned int last = Q_ITEM(queue, cons);
+	unsigned int head;
+
+	if (riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), head,
+				      !(head & ~queue->mask),
+				      0, RISCV_IOMMU_QUEUE_TIMEOUT))
+		return cons;
+
+	return cons + ((head - last) & queue->mask);
+}
+
+/* Wait for submitted item to be processed. */
+static int riscv_iommu_queue_wait(struct riscv_iommu_queue *queue,
+				  unsigned int index,
+				  unsigned int timeout_us)
+{
+	unsigned int cons = atomic_read(&queue->head);
+
+	/* Already processed by the consumer */
+	if ((int)(cons - index) > 0)
+		return 0;
+
+	/* Monitor consumer index */
+	return readx_poll_timeout(riscv_iommu_queue_cons, queue, cons,
+				 (int)(cons - index) > 0, 0, timeout_us);
+}
+
+/* Enqueue an entry and wait to be processed if timeout_us > 0
+ *
+ * Error handling for IOMMU hardware not responding in reasonable time
+ * will be added as separate patch series along with other RAS features.
+ * For now, only report hardware failure and continue.
+ */
+static void riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
+				   void *entry, size_t entry_size,
+				   unsigned int timeout_us)
+{
+	unsigned int prod;
+	unsigned int head;
+	unsigned int tail;
+	unsigned long flags;
+
+	/* Do not preempt submission flow. */
+	local_irq_save(flags);
+
+	/* 1. Allocate some space in the queue */
+	prod = atomic_inc_return(&queue->prod) - 1;
+	head = atomic_read(&queue->head);
+
+	/* 2. Wait for space availability. */
+	if ((prod - head) > queue->mask) {
+		if (readx_poll_timeout(atomic_read, &queue->head,
+				       head, (prod - head) < queue->mask,
+				       0, RISCV_IOMMU_QUEUE_TIMEOUT))
+			goto err_busy;
+	} else if ((prod - head) == queue->mask) {
+		const unsigned int last = Q_ITEM(queue, head);
+
+		if (riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), head,
+					      !(head & ~queue->mask) && head != last,
+					      0, RISCV_IOMMU_QUEUE_TIMEOUT))
+			goto err_busy;
+		atomic_add((head - last) & queue->mask, &queue->head);
+	}
+
+	/* 3. Store entry in the ring buffer. */
+	memcpy(queue->base + Q_ITEM(queue, prod) * entry_size, entry, entry_size);
+
+	/* 4. Wait for all previous entries to be ready */
+	if (readx_poll_timeout(atomic_read, &queue->tail, tail, prod == tail,
+			       0, RISCV_IOMMU_QUEUE_TIMEOUT))
+		goto err_busy;
+
+	/* 5. Complete submission and restore local interrupts */
+	dma_wmb();
+	riscv_iommu_writel(queue->iommu, Q_TAIL(queue), Q_ITEM(queue, prod + 1));
+	atomic_inc(&queue->tail);
+	local_irq_restore(flags);
+
+	if (timeout_us && riscv_iommu_queue_wait(queue, prod, timeout_us))
+		dev_err_once(queue->iommu->dev,
+			     "Hardware error: command execution timeout\n");
+
+	return;
+
+err_busy:
+	local_irq_restore(flags);
+	dev_err_once(queue->iommu->dev, "Hardware error: command enqueue failed\n");
+}
+
+/*
+ * IOMMU Command queue chapter 3.1
+ */
+
+/* Command queue interrupt handler thread function */
+static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
+{
+	const struct riscv_iommu_queue *queue = (struct riscv_iommu_queue *)data;
+	unsigned int ctrl;
+
+	/* Clear MF/CQ errors, complete error recovery to be implemented. */
+	ctrl = riscv_iommu_readl(queue->iommu, queue->qcr);
+	if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
+		    RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_FENCE_W_IP)) {
+		riscv_iommu_writel(queue->iommu, queue->qcr, ctrl);
+		dev_warn(queue->iommu->dev,
+			 "Queue #%u error; fault:%d timeout:%d illegal:%d fence_w_ip:%d\n",
+			 queue->qid,
+			 !!(ctrl & RISCV_IOMMU_CQCSR_CQMF),
+			 !!(ctrl & RISCV_IOMMU_CQCSR_CMD_TO),
+			 !!(ctrl & RISCV_IOMMU_CQCSR_CMD_ILL),
+			 !!(ctrl & RISCV_IOMMU_CQCSR_FENCE_W_IP));
+	}
+
+	/* Placeholder for command queue interrupt notifiers */
+
+	/* Clear command interrupt pending. */
+	riscv_iommu_writel(queue->iommu, RISCV_IOMMU_REG_IPSR, Q_IPSR(queue));
+
+	return IRQ_HANDLED;
+}
+
+/* Send command to the IOMMU command queue */
+static void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
+				 struct riscv_iommu_command *cmd,
+				 unsigned int timeout_us)
+{
+	riscv_iommu_queue_send(&iommu->cmdq, cmd, sizeof(*cmd), timeout_us);
+}
+
+/*
+ * IOMMU Fault/Event queue chapter 3.2
+ */
+
+static void riscv_iommu_fault(struct riscv_iommu_device *iommu,
+			      struct riscv_iommu_fq_record *event)
+{
+	unsigned int err = FIELD_GET(RISCV_IOMMU_FQ_HDR_CAUSE, event->hdr);
+	unsigned int devid = FIELD_GET(RISCV_IOMMU_FQ_HDR_DID, event->hdr);
+
+	/* Placeholder for future fault handling implementation, report only. */
+	if (err)
+		dev_warn_ratelimited(iommu->dev,
+				     "Fault %d devid: 0x%x iotval: %llx iotval2: %llx\n",
+				     err, devid, event->iotval, event->iotval2);
+}
+
+/* Fault queue interrupt handler thread function */
+static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
+{
+	struct riscv_iommu_queue *queue = (struct riscv_iommu_queue *)data;
+	struct riscv_iommu_device *iommu = queue->iommu;
+	struct riscv_iommu_fq_record *events;
+	unsigned int ctrl, idx;
+	int cnt, len;
+
+	events = (struct riscv_iommu_fq_record *)queue->base;
+
+	/* Clear fault interrupt pending and process all received fault events. */
+	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, Q_IPSR(queue));
+
+	do {
+		cnt = riscv_iommu_queue_consume(queue, &idx);
+		for (len = 0; len < cnt; idx++, len++)
+			riscv_iommu_fault(iommu, &events[Q_ITEM(queue, idx)]);
+		riscv_iommu_queue_release(queue, cnt);
+	} while (cnt > 0);
+
+	/* Clear MF/OF errors, complete error recovery to be implemented. */
+	ctrl = riscv_iommu_readl(iommu, queue->qcr);
+	if (ctrl & (RISCV_IOMMU_FQCSR_FQMF | RISCV_IOMMU_FQCSR_FQOF)) {
+		riscv_iommu_writel(iommu, queue->qcr, ctrl);
+		dev_warn(iommu->dev,
+			 "Queue #%u error; memory fault:%d overflow:%d\n",
+			 queue->qid,
+			 !!(ctrl & RISCV_IOMMU_FQCSR_FQMF),
+			 !!(ctrl & RISCV_IOMMU_FQCSR_FQOF));
+	}
+
+	return IRQ_HANDLED;
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -250,6 +683,7 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 	struct device *dev = iommu->dev;
 	u64 ddtp, rq_ddtp;
 	unsigned int mode, rq_mode = ddtp_mode;
+	struct riscv_iommu_command cmd;
 
 	ddtp = riscv_iommu_read_ddtp(iommu);
 	if (ddtp & RISCV_IOMMU_DDTP_BUSY)
@@ -317,6 +751,18 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 	if (mode != ddtp_mode)
 		dev_dbg(dev, "DDTP hw mode %u, requested %u\n", mode, ddtp_mode);
 
+	/* Invalidate device context cache */
+	riscv_iommu_cmd_iodir_inval_ddt(&cmd);
+	riscv_iommu_cmd_send(iommu, &cmd, 0);
+
+	/* Invalidate address translation cache */
+	riscv_iommu_cmd_inval_vma(&cmd);
+	riscv_iommu_cmd_send(iommu, &cmd, 0);
+
+	/* IOFENCE.C */
+	riscv_iommu_cmd_iofence(&cmd);
+	riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+
 	return 0;
 }
 
@@ -492,6 +938,26 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 			return -EINVAL;
 	}
 
+	/*
+	 * Distribute interrupt vectors, always use first vector for CIV.
+	 * At least one interrupt is required. Read back and verify.
+	 */
+	if (!iommu->irqs_count)
+		return -EINVAL;
+
+	iommu->ivec = 0;
+	iommu->ivec |= FIELD_PREP(RISCV_IOMMU_IVEC_FIV, 1 % iommu->irqs_count);
+	iommu->ivec |= FIELD_PREP(RISCV_IOMMU_IVEC_PIV, 2 % iommu->irqs_count);
+	iommu->ivec |= FIELD_PREP(RISCV_IOMMU_IVEC_PMIV, 3 % iommu->irqs_count);
+	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_IVEC, iommu->ivec);
+
+	iommu->ivec = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_IVEC);
+	if (riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IVEC_CIV) >= RISCV_IOMMU_INTR_COUNT ||
+	    riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IVEC_FIV) >= RISCV_IOMMU_INTR_COUNT ||
+	    riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IVEC_PIV) >= RISCV_IOMMU_INTR_COUNT ||
+	    riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IVEC_PMIV) >= RISCV_IOMMU_INTR_COUNT)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -500,12 +966,17 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
+	riscv_iommu_queue_disable(&iommu->cmdq);
+	riscv_iommu_queue_disable(&iommu->fltq);
 }
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
 {
 	int rc;
 
+	RISCV_IOMMU_QUEUE_INIT(&iommu->cmdq, CQ);
+	RISCV_IOMMU_QUEUE_INIT(&iommu->fltq, FQ);
+
 	rc = riscv_iommu_init_check(iommu);
 	if (rc)
 		return dev_err_probe(iommu->dev, rc, "unexpected device state\n");
@@ -514,10 +985,28 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	if (rc)
 		return rc;
 
-	rc = riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_MAX);
+	rc = riscv_iommu_queue_alloc(iommu, &iommu->cmdq,
+				     sizeof(struct riscv_iommu_command));
+	if (rc)
+		return rc;
+
+	rc = riscv_iommu_queue_alloc(iommu, &iommu->fltq,
+				     sizeof(struct riscv_iommu_fq_record));
+	if (rc)
+		return rc;
+
+	rc = riscv_iommu_queue_enable(iommu, &iommu->cmdq, riscv_iommu_cmdq_process);
 	if (rc)
 		return rc;
 
+	rc = riscv_iommu_queue_enable(iommu, &iommu->fltq, riscv_iommu_fltq_process);
+	if (rc)
+		goto err_queue_disable;
+
+	rc = riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_MAX);
+	if (rc)
+		goto err_queue_disable;
+
 	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
 				    dev_name(iommu->dev));
 	if (rc) {
@@ -537,5 +1026,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_iodir_off:
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
+err_queue_disable:
+	riscv_iommu_queue_disable(&iommu->fltq);
+	riscv_iommu_queue_disable(&iommu->cmdq);
 	return rc;
 }
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index f1696926582c..03e0c45bc7e1 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -17,6 +17,22 @@
 
 #include "iommu-bits.h"
 
+struct riscv_iommu_device;
+
+struct riscv_iommu_queue {
+	atomic_t prod;				/* unbounded producer allocation index */
+	atomic_t head;				/* unbounded shadow ring buffer consumer index */
+	atomic_t tail;				/* unbounded shadow ring buffer producer index */
+	unsigned int mask;			/* index mask, queue length - 1 */
+	unsigned int irq;			/* allocated interrupt number */
+	struct riscv_iommu_device *iommu;	/* iommu device handling the queue when active */
+	void *base;				/* ring buffer kernel pointer */
+	dma_addr_t phys;			/* ring buffer physical address */
+	u16 qbr;				/* base register offset, head and tail reference */
+	u16 qcr;				/* control and status register offset */
+	u8 qid;					/* queue identifier, same as RISCV_IOMMU_INTR_XX */
+};
+
 struct riscv_iommu_device {
 	/* iommu core interface */
 	struct iommu_device iommu;
@@ -34,6 +50,11 @@ struct riscv_iommu_device {
 	/* available interrupt numbers, MSI or WSI */
 	unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
 	unsigned int irqs_count;
+	unsigned int ivec;
+
+	/* hardware queues */
+	struct riscv_iommu_queue cmdq;
+	struct riscv_iommu_queue fltq;
 
 	/* device directory */
 	unsigned int ddt_mode;
-- 
2.34.1


