Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93450759EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGSTfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjGSTfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:35:04 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0DD1FFE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55b1238cab4so4211384a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689795270; x=1690400070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kazktXpEq6ieqwYBLKPipn4wLh0FPr3HRxxmkK9WPZw=;
        b=UveCNGN/BmDS/dpiK9E9WFCdSGeEIQLJPq+TntSzb0OVJUKw8457QVlJpeuQBkGvPA
         RRHvJ5DPD+YjGNmWNyhCdSuuVl3VMSI9ofTQbKQwSNcK0e0Vg9o0L2GIs2aMxrWtZOox
         kU5On+QttGg8berHD3o13+eKyaPVp79IJuAcTNbIymf/uJKx8aPzDCZvoII2/6G6/+ck
         D1BftMOLEl51OKc99Xxz5oRFJQFX2KzO62i0MeapKueO7YOgnefuGlVIlaTcZHcaIQfM
         gmdcVwEUQKTJx3z1JyyRfqHKURuY6kO2Aj2t4Tqhfy7BXNJZtPpPHZ3GxSNpwxmRozHd
         nqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795270; x=1690400070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kazktXpEq6ieqwYBLKPipn4wLh0FPr3HRxxmkK9WPZw=;
        b=eA/wUBIwMNjgXfJVku1VtPJzaGck3rc7gMG5n2J84KCi1mh1iv7IgcEhNGuPSkRLhA
         Tl/544aEsMWrHEauSjdo0eI7/53+Oxd5u+qFB/aNEUXO6gFlMhJMSQL25WXw3v3ShEAX
         iilnDrHL7CfCQoK93HYs+4wIkAYA+sPgouvWprvUpIkWtt63PpSczEsBPX79Y6QE6eMd
         lI/lYpQWiGlK0dQae70TQrPeCeaqk4c7++P0TjKISBxLSWAmvyL8wOQSpXcd+kVPuu16
         gWBztM9fpKYXbRGURIOmAG+4Ga5ab8PDHUHGac5/AKzfmQb3lI4UGNM6cAu07rsAaSmK
         x05Q==
X-Gm-Message-State: ABy/qLZRl4woaWJRBtTcQ23wj/NP17DjNn0lIwmItI8W62D/6q/ioKHc
        nxFvr3waqE35vFn0i7mwEfHAdg==
X-Google-Smtp-Source: APBJJlE778Ah24ZWQjDXEFU6ITYD0j+QG6da7Iiv5Pd0d2PSojZrjWDn9oS4U2WcdSjIz8eWHa04MA==
X-Received: by 2002:a17:90a:901:b0:263:fc43:5f39 with SMTP id n1-20020a17090a090100b00263fc435f39mr169347pjn.13.1689795269929;
        Wed, 19 Jul 2023 12:34:29 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a031700b00264040322desm1591053pje.40.2023.07.19.12.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:34:29 -0700 (PDT)
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
Subject: [PATCH 05/11] RISC-V: drivers/iommu/riscv: Add sysfs interface
Date:   Wed, 19 Jul 2023 12:33:49 -0700
Message-Id: <610abe685f90870be52bc7c2ca45ab5235bd8eb4.1689792825.git.tjeznach@rivosinc.com>
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

Enable sysfs debug / visibility interface providing restricted
access to hardware registers.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/Makefile      |   2 +-
 drivers/iommu/riscv/iommu-sysfs.c | 183 ++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c       |   7 ++
 drivers/iommu/riscv/iommu.h       |   2 +
 4 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/riscv/iommu-sysfs.c

diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
index 38730c11e4a8..9523eb053cfc 100644
--- a/drivers/iommu/riscv/Makefile
+++ b/drivers/iommu/riscv/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-pci.o iommu-platform.o
\ No newline at end of file
+obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-pci.o iommu-platform.o iommu-sysfs.o
\ No newline at end of file
diff --git a/drivers/iommu/riscv/iommu-sysfs.c b/drivers/iommu/riscv/iommu-sysfs.c
new file mode 100644
index 000000000000..f038ea8445c5
--- /dev/null
+++ b/drivers/iommu/riscv/iommu-sysfs.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IOMMU API for RISC-V architected Ziommu implementations.
+ *
+ * Copyright © 2022-2023 Rivos Inc.
+ *
+ * Author: Tomasz Jeznach <tjeznach@rivosinc.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/compiler.h>
+#include <linux/iommu.h>
+#include <linux/platform_device.h>
+#include <asm/page.h>
+
+#include "iommu.h"
+
+#define sysfs_dev_to_iommu(dev) \
+	container_of(dev_get_drvdata(dev), struct riscv_iommu_device, iommu)
+
+static ssize_t address_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct riscv_iommu_device *iommu = sysfs_dev_to_iommu(dev);
+	return sprintf(buf, "%llx\n", iommu->reg_phys);
+}
+
+static DEVICE_ATTR_RO(address);
+
+#define ATTR_RD_REG32(name, offset)					\
+	ssize_t reg_ ## name ## _show(struct device *dev,		\
+			struct device_attribute *attr, char *buf)	\
+{									\
+	struct riscv_iommu_device *iommu = sysfs_dev_to_iommu(dev);	\
+	return sprintf(buf, "0x%x\n",					\
+			riscv_iommu_readl(iommu, offset));		\
+}
+
+#define ATTR_RD_REG64(name, offset)					\
+	ssize_t reg_ ## name ## _show(struct device *dev,		\
+			struct device_attribute *attr, char *buf)	\
+{									\
+	struct riscv_iommu_device *iommu = sysfs_dev_to_iommu(dev);	\
+	return sprintf(buf, "0x%llx\n",					\
+			riscv_iommu_readq(iommu, offset));		\
+}
+
+#define ATTR_WR_REG32(name, offset)					\
+	ssize_t reg_ ## name ## _store(struct device *dev,		\
+			struct device_attribute *attr,			\
+			const char *buf, size_t len)			\
+{									\
+	struct riscv_iommu_device *iommu = sysfs_dev_to_iommu(dev);	\
+	unsigned long val;						\
+	int ret;							\
+	ret = kstrtoul(buf, 0, &val);					\
+	if (ret)							\
+		return ret;						\
+	riscv_iommu_writel(iommu, offset, val);				\
+	return len;							\
+}
+
+#define ATTR_WR_REG64(name, offset)					\
+	ssize_t reg_ ## name ## _store(struct device *dev,		\
+			struct device_attribute *attr,			\
+			const char *buf, size_t len)			\
+{									\
+	struct riscv_iommu_device *iommu = sysfs_dev_to_iommu(dev);	\
+	unsigned long long val;						\
+	int ret;							\
+	ret = kstrtoull(buf, 0, &val);					\
+	if (ret)							\
+		return ret;						\
+	riscv_iommu_writeq(iommu, offset, val);				\
+	return len;							\
+}
+
+#define ATTR_RO_REG32(name, offset)					\
+static ATTR_RD_REG32(name, offset);					\
+static DEVICE_ATTR_RO(reg_ ## name)
+
+#define ATTR_RW_REG32(name, offset)					\
+static ATTR_RD_REG32(name, offset);					\
+static ATTR_WR_REG32(name, offset);					\
+static DEVICE_ATTR_RW(reg_ ## name)
+
+#define ATTR_RO_REG64(name, offset)					\
+static ATTR_RD_REG64(name, offset);					\
+static DEVICE_ATTR_RO(reg_ ## name)
+
+#define ATTR_RW_REG64(name, offset)					\
+static ATTR_RD_REG64(name, offset);					\
+static ATTR_WR_REG64(name, offset);					\
+static DEVICE_ATTR_RW(reg_ ## name)
+
+ATTR_RO_REG64(cap, RISCV_IOMMU_REG_CAP);
+ATTR_RO_REG64(fctl, RISCV_IOMMU_REG_FCTL);
+ATTR_RO_REG32(cqh, RISCV_IOMMU_REG_CQH);
+ATTR_RO_REG32(cqt, RISCV_IOMMU_REG_CQT);
+ATTR_RO_REG32(cqcsr, RISCV_IOMMU_REG_CQCSR);
+ATTR_RO_REG32(fqh, RISCV_IOMMU_REG_FQH);
+ATTR_RO_REG32(fqt, RISCV_IOMMU_REG_FQT);
+ATTR_RO_REG32(fqcsr, RISCV_IOMMU_REG_FQCSR);
+ATTR_RO_REG32(pqh, RISCV_IOMMU_REG_PQH);
+ATTR_RO_REG32(pqt, RISCV_IOMMU_REG_PQT);
+ATTR_RO_REG32(pqcsr, RISCV_IOMMU_REG_PQCSR);
+ATTR_RO_REG32(ipsr, RISCV_IOMMU_REG_IPSR);
+ATTR_RO_REG32(ivec, RISCV_IOMMU_REG_IVEC);
+ATTR_RW_REG64(tr_iova, RISCV_IOMMU_REG_TR_REQ_IOVA);
+ATTR_RW_REG64(tr_ctrl, RISCV_IOMMU_REG_TR_REQ_CTL);
+ATTR_RW_REG64(tr_response, RISCV_IOMMU_REG_TR_RESPONSE);
+ATTR_RW_REG32(iocntovf, RISCV_IOMMU_REG_IOCOUNTOVF);
+ATTR_RW_REG32(iocntinh, RISCV_IOMMU_REG_IOCOUNTINH);
+ATTR_RW_REG64(iohpmcycles, RISCV_IOMMU_REG_IOHPMCYCLES);
+ATTR_RW_REG64(iohpmevt_1, RISCV_IOMMU_REG_IOHPMEVT(0));
+ATTR_RW_REG64(iohpmevt_2, RISCV_IOMMU_REG_IOHPMEVT(1));
+ATTR_RW_REG64(iohpmevt_3, RISCV_IOMMU_REG_IOHPMEVT(2));
+ATTR_RW_REG64(iohpmevt_4, RISCV_IOMMU_REG_IOHPMEVT(3));
+ATTR_RW_REG64(iohpmevt_5, RISCV_IOMMU_REG_IOHPMEVT(4));
+ATTR_RW_REG64(iohpmevt_6, RISCV_IOMMU_REG_IOHPMEVT(5));
+ATTR_RW_REG64(iohpmevt_7, RISCV_IOMMU_REG_IOHPMEVT(6));
+ATTR_RW_REG64(iohpmctr_1, RISCV_IOMMU_REG_IOHPMCTR(0));
+ATTR_RW_REG64(iohpmctr_2, RISCV_IOMMU_REG_IOHPMCTR(1));
+ATTR_RW_REG64(iohpmctr_3, RISCV_IOMMU_REG_IOHPMCTR(2));
+ATTR_RW_REG64(iohpmctr_4, RISCV_IOMMU_REG_IOHPMCTR(3));
+ATTR_RW_REG64(iohpmctr_5, RISCV_IOMMU_REG_IOHPMCTR(4));
+ATTR_RW_REG64(iohpmctr_6, RISCV_IOMMU_REG_IOHPMCTR(5));
+ATTR_RW_REG64(iohpmctr_7, RISCV_IOMMU_REG_IOHPMCTR(6));
+
+static struct attribute *riscv_iommu_attrs[] = {
+	&dev_attr_address.attr,
+	&dev_attr_reg_cap.attr,
+	&dev_attr_reg_fctl.attr,
+	&dev_attr_reg_cqh.attr,
+	&dev_attr_reg_cqt.attr,
+	&dev_attr_reg_cqcsr.attr,
+	&dev_attr_reg_fqh.attr,
+	&dev_attr_reg_fqt.attr,
+	&dev_attr_reg_fqcsr.attr,
+	&dev_attr_reg_pqh.attr,
+	&dev_attr_reg_pqt.attr,
+	&dev_attr_reg_pqcsr.attr,
+	&dev_attr_reg_ipsr.attr,
+	&dev_attr_reg_ivec.attr,
+	&dev_attr_reg_tr_iova.attr,
+	&dev_attr_reg_tr_ctrl.attr,
+	&dev_attr_reg_tr_response.attr,
+	&dev_attr_reg_iocntovf.attr,
+	&dev_attr_reg_iocntinh.attr,
+	&dev_attr_reg_iohpmcycles.attr,
+	&dev_attr_reg_iohpmctr_1.attr,
+	&dev_attr_reg_iohpmevt_1.attr,
+	&dev_attr_reg_iohpmctr_2.attr,
+	&dev_attr_reg_iohpmevt_2.attr,
+	&dev_attr_reg_iohpmctr_3.attr,
+	&dev_attr_reg_iohpmevt_3.attr,
+	&dev_attr_reg_iohpmctr_4.attr,
+	&dev_attr_reg_iohpmevt_4.attr,
+	&dev_attr_reg_iohpmctr_5.attr,
+	&dev_attr_reg_iohpmevt_5.attr,
+	&dev_attr_reg_iohpmctr_6.attr,
+	&dev_attr_reg_iohpmevt_6.attr,
+	&dev_attr_reg_iohpmctr_7.attr,
+	&dev_attr_reg_iohpmevt_7.attr,
+	NULL,
+};
+
+static struct attribute_group riscv_iommu_group = {
+	.name = "riscv-iommu",
+	.attrs = riscv_iommu_attrs,
+};
+
+const struct attribute_group *riscv_iommu_groups[] = {
+	&riscv_iommu_group,
+	NULL,
+};
+
+int riscv_iommu_sysfs_add(struct riscv_iommu_device *iommu) {
+	return iommu_device_sysfs_add(&iommu->iommu, NULL,
+		riscv_iommu_groups, "riscv-iommu@%llx", iommu->reg_phys);
+}
+
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8c236242e2cc..31dc3c458e13 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -608,6 +608,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
 	iommu_device_unregister(&iommu->iommu);
+	iommu_device_sysfs_remove(&iommu->iommu);
 	riscv_iommu_enable(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
 }
 
@@ -646,6 +647,12 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto fail;
 	}
 
+	ret = riscv_iommu_sysfs_add(iommu);
+	if (ret) {
+		dev_err(dev, "cannot register sysfs interface (%d)\n", ret);
+		goto fail;
+	}
+
 	ret = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, dev);
 	if (ret) {
 		dev_err(dev, "cannot register iommu interface (%d)\n", ret);
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 7baefd3630b3..7dc9baa59a50 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -112,4 +112,6 @@ static inline void riscv_iommu_writeq(struct riscv_iommu_device *iommu,
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 
+int riscv_iommu_sysfs_add(struct riscv_iommu_device *iommu);
+
 #endif
-- 
2.34.1

