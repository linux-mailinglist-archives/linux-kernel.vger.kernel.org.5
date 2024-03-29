Return-Path: <linux-kernel+bounces-125377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EDC8924CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E19285838
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D7613AD38;
	Fri, 29 Mar 2024 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbU2NCl+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA725B1EE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742719; cv=none; b=egbrVHwc8Vsz2nrVskhC8s4EC3TNO4RV+Rb+grXJFUiDsKS+GmZTQvvix6o/fA5xNruYWgfYodhnx4Xds0GwQ7XdEJ5eLJCka/583AVH73gJre+XVZeHGVMkGfXvNsPC2IIFBe3d4wgZq5+tMjisotlwUkcWNcmHp8dat7reuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742719; c=relaxed/simple;
	bh=czHX/IOVEzpj6jqNphK0lBL1PvUhG7Sty6zFvUN9L7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtJVz60Zdj1fMPKnfWc3tkCCAdYuLYLnpXtyRIS+4LVYmvDy5rDxY+qsa8cAhBwmVIbjIUMwp8WDCoeBuZs5sh5daMM5JoxM7VwsXFD04aBk2Lc0EJoVHcHV9HKs5W5PD90tXXzfvDhOz982fOWqfJ048rVXGpliGEn/E/eLz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbU2NCl+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711742715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mW3VicmmCQlgVDIuthBaNsM8y8envErsUpMXQwPZu58=;
	b=NbU2NCl+wrnXF/AUV8I2esQm9wrfPOdFQQOeOu7tpJjrdepocpXKe7ct31zyCkJh16ycB/
	s4oqLogovAg6LA2OBq+NqreF896wd/Jgz6PF6pXTuFfhEpQvfQUxPA7Eyg00LnTV+GPr3/
	W2xAiI3jqSDoOz631mnGw0i7TIWBwjk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-7gIJVOyaPiebDLZ4almA4g-1; Fri, 29 Mar 2024 16:05:13 -0400
X-MC-Unique: 7gIJVOyaPiebDLZ4almA4g-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e0c5faf1d0so18383825ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742712; x=1712347512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mW3VicmmCQlgVDIuthBaNsM8y8envErsUpMXQwPZu58=;
        b=GFGHE5Z6mET1te4D6bknFH1QAn6KpQA1hKS6yHOrWJB9DiZqElp7u09fKOds16Tiz6
         rv2M9souhmPhKMC5OV6NAWQq18ie/SV9bavuhL8CBHgqrUX8uvF7gx0yyko3X6eq222T
         lTUK2mJn8bow22VOoSEpa8JuRKp1ZwAi/Xx7OlPNK9NNIGohz/rIEifrPuCmPv7V9ms4
         M+IHnzApDglIAmf1egXG7lilCw69U0XWqPp/Nry5aRMCNcK/COgr7C1/Rj2gFHKAZJHk
         FUTtSFz6E+g+cVhKGKb3dVCJUD4pabnzf4lr33jfc2twyuAqzMeQEIaFxixvBuA5kEb9
         +sSw==
X-Forwarded-Encrypted: i=1; AJvYcCUPtpcMMMj9eixZ2O/7Nq0jfBVqffQlr53NN0820yLZWq+0AbeOBvmqqqUxbdIbobgT2b7MOdnzSIVcYBscNSxN2i/rbQZUrxSTOa6Y
X-Gm-Message-State: AOJu0YxpRNGeuHRjYj4sNFPMzZjYFeoiHpHTkRDRQyNYDJBk6i6YKf+D
	tgmibwvGGmPgue4YxYExy84Bv2lAxUEhH8rJzFRrfRKWf6ozYMz98D+4lOx5BKjgHn3DmuCWtKJ
	b54ztZA+pPUKElxTuVD3djZW0GYYK3BU83+6R7W3r0KxdfFp/xxoMR8yjUSpKMg==
X-Received: by 2002:a17:903:543:b0:1dd:e114:121c with SMTP id jo3-20020a170903054300b001dde114121cmr2998101plb.56.1711742712214;
        Fri, 29 Mar 2024 13:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNymtYuM0xkGVcxr1Pl+WDa1ocpxUwuecSFjiqBHkYBwLjdIOjM2I6NsfRSwIixolaXXUyLQ==
X-Received: by 2002:a17:903:543:b0:1dd:e114:121c with SMTP id jo3-20020a170903054300b001dde114121cmr2998069plb.56.1711742711804;
        Fri, 29 Mar 2024 13:05:11 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001dd6ebd88b0sm3830017plh.198.2024.03.29.13.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:05:11 -0700 (PDT)
From: wefu@redhat.com
To: jszhang@kernel.org,
	guoren@kernel.org,
	conor@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jic23@kernel.org,
	lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	marius.cristea@microchip.com,
	fr0st61te@gmail.com,
	okan.sahin@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	lee@kernel.org,
	mike.looijmans@topic.nl
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Wei Fu <wefu@redhat.com>
Subject: [PATCH 1/3] drivers/iio/adc: Add XuanTie TH1520 ADC driver
Date: Sat, 30 Mar 2024 04:01:24 +0800
Message-ID: <20240329200241.4122000-2-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329200241.4122000-1-wefu@redhat.com>
References: <20240329200241.4122000-1-wefu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Fu <wefu@redhat.com>

Signed-off-by: Wei Fu <wefu@redhat.com>
---
 drivers/iio/adc/Kconfig              |  13 +
 drivers/iio/adc/Makefile             |   1 +
 drivers/iio/adc/xuantie-th1520-adc.c | 572 +++++++++++++++++++++++++++
 drivers/iio/adc/xuantie-th1520-adc.h | 193 +++++++++
 4 files changed, 779 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 0d9282fa67f5..9e37ba2a877a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1515,4 +1515,17 @@ config XILINX_AMS
 	  The driver can also be built as a module. If so, the module will be called
 	  xilinx-ams.
 
+config XUANTIE_TH1520_ADC
+	tristate "XuanTie TH1520 ADC driver"
+	depends on OF
+	depends on HAS_IOMEM
+	depends on ARCH_THEAD
+	default y
+	help
+	  Say yes here to support for XuanTie TH1520 MPW analog-to-digital
+	  converter.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called xuantie-th1520-adc.
+
 endmenu
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index b3c434722364..820e2a136b33 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -135,4 +135,5 @@ obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
 xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
 obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
 obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o
+obj-$(CONFIG_XUANTIE_TH1520_ADC) += xuantie-th1520-adc.o
 obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
diff --git a/drivers/iio/adc/xuantie-th1520-adc.c b/drivers/iio/adc/xuantie-th1520-adc.c
new file mode 100644
index 000000000000..df0452c2abe7
--- /dev/null
+++ b/drivers/iio/adc/xuantie-th1520-adc.c
@@ -0,0 +1,572 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * XuanTie TH1520 ADC driver
+ *
+ * Copyright (C) 2021-2024 Alibaba Group Holding Limited.
+ * Fugang Duan <duanfugang.dfg@linux.alibaba.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/regulator/consumer.h>
+#include <linux/of_platform.h>
+#include <linux/err.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
+
+#include "xuantie-th1520-adc.h"
+
+static inline void th1520_adc_cfg_init(struct th1520_adc *info)
+{
+	struct th1520_adc_feature *adc_feature = &info->adc_feature;
+
+	/* set default Configuration for ADC controller */
+	adc_feature->selres_sel = TH1520_ADC_SELRES_12BIT;
+	adc_feature->input_mode = TH1520_ADC_SINGLE_ENDED_INPUTS;
+	adc_feature->vol_ref = TH1520_ADC_VOL_VREF;
+	adc_feature->offset_mode = TH1520_ADC_OFFSET_DIS;
+	adc_feature->conv_mode = TH1520_ADC_MODE_SINGLE;
+	adc_feature->clk_sel = TH1520_ADC_FCLK_TYP_1M;
+
+	adc_feature->int_actual = TH1520_ADC_ACTUAL_ALL;
+	adc_feature->int_detal = TH1520_ADC_DETAL_ALL;
+
+	info->ch0_offmeas = 0;
+	info->ch1_offmeas = 0;
+}
+
+static void th1520_adc_reg_set(struct th1520_adc *info)
+{
+	u32 phy_cfg = 0;
+	u32 op_ctrl = 0;
+	struct th1520_adc_feature *adc_feature = &info->adc_feature;
+
+	/* phy_cfg */
+	switch (adc_feature->selres_sel) {
+	case TH1520_ADC_SELRES_6BIT:
+		phy_cfg |= TH1520_ADC_PHY_CFG_SELRES_6BIT;
+		break;
+	case TH1520_ADC_SELRES_8BIT:
+		phy_cfg |= TH1520_ADC_PHY_CFG_SELRES_8BIT;
+		break;
+	case TH1520_ADC_SELRES_10BIT:
+		phy_cfg |= TH1520_ADC_PHY_CFG_SELRES_10BIT;
+		break;
+	case TH1520_ADC_SELRES_12BIT:
+		phy_cfg |= TH1520_ADC_PHY_CFG_SELRES_12BIT;
+		break;
+	default:
+		break;
+	}
+
+	switch (adc_feature->input_mode) {
+	case TH1520_ADC_SINGLE_ENDED_INPUTS:
+		phy_cfg |= TH1520_ADC_PHY_CFG_SELDIFF_SINGLE_ENDED_INPUTS;
+		break;
+	case TH1520_ADC_DIFFERENTIAL_INPUTS:
+		phy_cfg |= TH1520_ADC_PHY_CFG_SELDIFF_DIFFERENTIAL_INPUTS;
+		break;
+	default:
+		break;
+	}
+
+	switch (adc_feature->vol_ref) {
+	case TH1520_ADC_VOL_VREF:
+		phy_cfg |= TH1520_ADC_PHY_CFG_SELBG_EXTERNAL |
+			   TH1520_ADC_PHY_CFG_SELREF_EXT;
+		break;
+	case TH1520_ADC_VOL_INTE:
+		phy_cfg |= TH1520_ADC_PHY_CFG_SELBG_INTERNAL |
+			   TH1520_ADC_PHY_CFG_SELREF_INTERNAL;
+		break;
+	default:
+		break;
+	}
+
+	/* op_ctrl */
+	switch (adc_feature->conv_mode) {
+	case TH1520_ADC_MODE_SINGLE:
+		op_ctrl |= TH1520_ADC_OP_CTRL_MODE_SINGLE;
+		break;
+	case TH1520_ADC_MODE_CONTINOUS:
+		op_ctrl |= TH1520_ADC_OP_CTRL_MODE_CONTINOUS;
+		break;
+	default:
+		break;
+	}
+
+	writel(phy_cfg, info->regs + TH1520_ADC_PHY_CFG);
+	writel(op_ctrl, info->regs + TH1520_ADC_OP_CTRL);
+
+	writel(TH1520_ADC_PHY_ENCTR, info->regs + TH1520_ADC_PHY_TEST);
+
+	/* disable the irq */
+	writel(0xff, info->regs + TH1520_ADC_INT_CTRL1);
+	writel(0xff, info->regs + TH1520_ADC_INT_CTRL2);
+
+	if (adc_feature->conv_mode == TH1520_ADC_MODE_CONTINOUS)
+		writel(TH1520_ADC_PHY_CTRL_ENADC_EN,
+		       info->regs + TH1520_ADC_PHY_CTRL);
+}
+
+static void th1520_adc_fclk_set(struct th1520_adc *info)
+{
+	int fclk_ctrl = 0;
+	int start_time = 0;
+	int sample_time = 0;
+	struct th1520_adc_feature *adc_feature = &info->adc_feature;
+
+	switch (adc_feature->clk_sel) {
+	case TH1520_ADC_FCLK_TYP_1M:
+		fclk_ctrl = TH1520_ADC_FCLK_CTRL_TYP_1M;
+		start_time = TH1520_ADC_START_TIME_TYP_1M;
+		if (adc_feature->selres_sel == TH1520_ADC_SELRES_6BIT)
+			sample_time = TH1520_ADC_SAMPLE_TIME_TYP_6BIT;
+		else if (adc_feature->selres_sel == TH1520_ADC_SELRES_8BIT)
+			sample_time = TH1520_ADC_SAMPLE_TIME_TYP_8BIT;
+		else if (adc_feature->selres_sel == TH1520_ADC_SELRES_10BIT)
+			sample_time = TH1520_ADC_SAMPLE_TIME_TYP_10BIT;
+		else if (adc_feature->selres_sel == TH1520_ADC_SELRES_12BIT)
+			sample_time = TH1520_ADC_SAMPLE_TIME_TYP_12BIT;
+		else {
+			pr_err("[%s,%d]invalid selres select\n",
+			       __func__, __LINE__);
+			return;
+		}
+		break;
+	default:
+		break;
+	}
+	writel(fclk_ctrl, info->regs + TH1520_ADC_FCLK_CTRL);
+	writel(start_time, info->regs + TH1520_ADC_START_TIME);
+	writel(sample_time, info->regs + TH1520_ADC_SAMPLE_TIME);
+}
+
+static void th1520_adc_hw_init(struct th1520_adc *info)
+{
+	th1520_adc_reg_set(info);
+	th1520_adc_fclk_set(info);
+}
+
+static const struct iio_chan_spec th1520_adc_iio_channels[] = {
+	TH1520_ADC_CHAN(0, IIO_VOLTAGE),
+	TH1520_ADC_CHAN(1, IIO_VOLTAGE),
+	TH1520_ADC_CHAN(2, IIO_VOLTAGE),
+	TH1520_ADC_CHAN(3, IIO_VOLTAGE),
+	TH1520_ADC_CHAN(4, IIO_VOLTAGE),
+	TH1520_ADC_CHAN(5, IIO_VOLTAGE),
+	TH1520_ADC_CHAN(6, IIO_VOLTAGE),
+	TH1520_ADC_CHAN(7, IIO_VOLTAGE),
+	/* sentinel */
+};
+
+static irqreturn_t th1520_adc_isr(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct th1520_adc *info = iio_priv(indio_dev);
+	/* TBD */
+	complete(&info->completion);
+	return IRQ_HANDLED;
+}
+
+static int th1520_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	int tmp;
+	long ret;
+	struct th1520_adc *info = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&info->mlock);
+
+		if (info->adc_feature.conv_mode == TH1520_ADC_MODE_SINGLE) {
+			uint ievent;
+			uint vld_flag;
+			uint phy_ctrl;
+			uint real_chan;
+			uint op_ctrl = 0;
+			uint single_retry = TH1520_ADC_FIFO_DATA_SIZE;
+
+			op_ctrl = readl(info->regs + TH1520_ADC_OP_CTRL);
+			op_ctrl &= ~TH1520_ADC_OP_CTRL_CH_EN_ALL;
+			op_ctrl |= (BIT(chan->channel +	TH1520_ADC_OP_CTRL_CH_EN_0) &
+					TH1520_ADC_OP_CTRL_CH_EN_ALL);
+			writel(op_ctrl, info->regs + TH1520_ADC_OP_CTRL);
+
+			writel(TH1520_ADC_PHY_CTRL_ENADC_EN,
+			       info->regs + TH1520_ADC_PHY_CTRL);
+
+			vld_flag = TH1520_ADC_SAMPLE_DATA_CH0_VLD;
+
+			while (single_retry--) {
+				writel(TH1520_ADC_OP_SINGLE_START_EN,
+				       info->regs + TH1520_ADC_OP_SINGLE_START);
+				/* wait the sampling result */
+				ret = readl_poll_timeout(info->regs +
+							 TH1520_ADC_SAMPLE_DATA,
+							 ievent,
+							 ievent & vld_flag, 100,
+							 TH1520_ADC_TIMEOUT);
+				if (ret)
+					pr_err("wait the sampling timeout\n");
+
+				real_chan =
+				(ievent & TH1520_ADC_SAMPLE_DATA_CH0_NUMBER) >>
+				TH1520_ADC_SAMPLE_DATA_CH0_NUMBER_OFF;
+				if (real_chan == chan->channel)
+					break;
+			}
+
+			phy_ctrl = readl(info->regs + TH1520_ADC_PHY_CTRL);
+			phy_ctrl &= ~TH1520_ADC_PHY_CTRL_ENADC_EN;
+			writel(phy_ctrl, info->regs + TH1520_ADC_PHY_CTRL);
+
+			/* read the sampling data */
+			*val = (ievent & TH1520_ADC_SAMPLE_DATA_CH0) >>
+			       TH1520_ADC_SAMPLE_DATA_CH0_OFF;
+		} else {
+			uint ievent;
+			uint vld_flag;
+			uint op_single;
+			uint op_ctrl = 0;
+
+			op_ctrl = readl(info->regs + TH1520_ADC_OP_CTRL);
+			op_ctrl &= ~TH1520_ADC_OP_CTRL_CH_EN_ALL;
+			op_ctrl |= (BIT(chan->channel + TH1520_ADC_OP_CTRL_CH_EN_0) &
+				   TH1520_ADC_OP_CTRL_CH_EN_ALL);
+			writel(op_ctrl, info->regs + TH1520_ADC_OP_CTRL);
+
+			op_single = readl(info->regs +
+					  TH1520_ADC_OP_SINGLE_START);
+			op_single &= ~TH1520_ADC_OP_SINGLE_START_EN;
+			writel(op_single,
+			       info->regs + TH1520_ADC_OP_SINGLE_START);
+
+			vld_flag = TH1520_ADC_SAMPLE_DATA_CH0_VLD |
+				   TH1520_ADC_SAMPLE_DATA_CH1_VLD;
+
+			/* wait the sampling result */
+			ret  = readl_poll_timeout(info->regs +
+							TH1520_ADC_SAMPLE_DATA,
+						  ievent, ievent & vld_flag, 10,
+						  TH1520_ADC_TIMEOUT);
+			if (ret)
+				pr_err("wait the sampling timeout\n");
+
+			/* read the sampling data */
+			tmp = readl(info->regs + TH1520_ADC_SAMPLE_DATA);
+			if (tmp & TH1520_ADC_SAMPLE_DATA_CH0_VLD)
+				*val = (tmp & TH1520_ADC_SAMPLE_DATA_CH0) >>
+				       TH1520_ADC_SAMPLE_DATA_CH0_OFF;
+			else
+				*val = (tmp & TH1520_ADC_SAMPLE_DATA_CH1) >>
+				       TH1520_ADC_SAMPLE_DATA_CH1_OFF;
+		}
+
+		mutex_unlock(&info->mlock);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = info->vref_uv / 1000;
+		*val2 = info->adc_feature.selres_sel;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = info->current_clk;
+		*val2 = 0;
+		return IIO_VAL_INT;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static void th1520_adc_reset(struct th1520_adc *info)
+{
+	u32 tmp = readl(info->regs + TH1520_ADC_PHY_CTRL);
+
+	tmp |= TH1520_ADC_PHY_CTRL_RST_EN;
+	writel(tmp, info->regs + TH1520_ADC_PHY_CTRL);
+
+	usleep_range(10, 15);
+
+	tmp &= ~TH1520_ADC_PHY_CTRL_RST_EN;
+	writel(tmp, info->regs + TH1520_ADC_PHY_CTRL);
+}
+
+static void th1520_adc_set_clk(struct th1520_adc *info, int val)
+{
+	u32 count;
+	u32 apb_clk;
+	int fclk_ctrl;
+
+	apb_clk = clk_get_rate(info->clk);
+	count = DIV_ROUND_UP(apb_clk, val);
+	info->current_clk = apb_clk / count;
+
+	fclk_ctrl = readl(info->regs + TH1520_ADC_FCLK_CTRL);
+	fclk_ctrl &= ~TH1520_ADC_FCLK_CTRL_FCLLK_DIV;
+	fclk_ctrl |= count;
+	writel(fclk_ctrl, info->regs + TH1520_ADC_FCLK_CTRL);
+}
+
+static int th1520_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct th1520_adc *info = iio_priv(indio_dev);
+
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	mutex_lock(&info->mlock);
+	th1520_adc_set_clk(info, val);
+	mutex_unlock(&info->mlock);
+
+	return 0;
+}
+
+static const struct iio_info th1520_adc_iio_info = {
+	.read_raw = &th1520_read_raw,
+	.write_raw = &th1520_write_raw,
+};
+
+static const struct of_device_id th1520_adc_match[] = {
+	{ .compatible = "thead,th1520-adc", },
+	{ /* end */ }
+};
+MODULE_DEVICE_TABLE(of, th1520_adc_match);
+
+static ssize_t th1520_adc_res_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	size_t bufpos = 0, count = 5;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct th1520_adc *info = iio_priv(indio_dev);
+
+	snprintf(buf + bufpos, count - bufpos, "%.*x: ", 4,
+		 info->adc_feature.selres_sel);
+	bufpos += 4;
+	buf[bufpos++] = '\n';
+
+	return bufpos;
+}
+
+static ssize_t th1520_adc_res_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	unsigned long res;
+	char *start = (char *)buf;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct th1520_adc *info = iio_priv(indio_dev);
+
+	if (kstrtoul(start, 0, &res))
+		return -EINVAL;
+
+	switch (res) {
+	case TH1520_ADC_SELRES_6BIT:
+	case TH1520_ADC_SELRES_8BIT:
+	case TH1520_ADC_SELRES_10BIT:
+	case TH1520_ADC_SELRES_12BIT:
+		info->adc_feature.selres_sel = res;
+		th1520_adc_reset(info);
+		th1520_adc_hw_init(info);
+		break;
+	default:
+		dev_err(dev, "not support res\n");
+		return -EINVAL;
+	}
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(th1520_adc_res);
+
+static int th1520_adc_probe(struct platform_device *pdev)
+{
+	int irq;
+	int ret;
+	struct resource *mem;
+	struct th1520_adc *info;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev,
+					  sizeof(struct th1520_adc));
+	if (!indio_dev) {
+		dev_err(&pdev->dev, "Failed allocating iio device\n");
+		return -ENOMEM;
+	}
+
+	info = iio_priv(indio_dev);
+	info->dev = &pdev->dev;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(info->dev, irq, th1520_adc_isr, 0,
+			       dev_name(&pdev->dev), indio_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
+		return ret;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	info->regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(info->regs))
+		return PTR_ERR(info->regs);
+
+	info->clk = devm_clk_get(&pdev->dev, "adc");
+	if (IS_ERR(info->clk)) {
+		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
+			PTR_ERR(info->clk));
+		return PTR_ERR(info->clk);
+	}
+
+	info->vref = devm_regulator_get(&pdev->dev, "vref");
+	if (IS_ERR(info->vref))
+		return PTR_ERR(info->vref);
+
+	ret = regulator_enable(info->vref);
+	if (ret)
+		return ret;
+
+	info->vref_uv = regulator_get_voltage(info->vref);
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	mutex_init(&info->mlock);
+	init_completion(&info->completion);
+
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->info = &th1520_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = th1520_adc_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(th1520_adc_iio_channels);
+
+	ret = clk_prepare_enable(info->clk);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Could not prepare or enable the clock.\n");
+		goto error_adc_clk_enable;
+	}
+
+	th1520_adc_cfg_init(info);
+	th1520_adc_reset(info);
+	th1520_adc_hw_init(info);
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Couldn't register the device.\n");
+		goto error_iio_device_register;
+	}
+
+	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_th1520_adc_res.attr);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to create adc debug sysfs.\n");
+		goto error_iio_device_register;
+	}
+
+	dev_info(&pdev->dev, "XuanTie TH1520 adc registered.\n");
+	return 0;
+
+error_iio_device_register:
+	clk_disable_unprepare(info->clk);
+error_adc_clk_enable:
+	regulator_disable(info->vref);
+
+	return ret;
+}
+
+static int th1520_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct th1520_adc *info = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	regulator_disable(info->vref);
+	clk_disable_unprepare(info->clk);
+
+	return 0;
+}
+
+static int __maybe_unused th1520_adc_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct th1520_adc *info = iio_priv(indio_dev);
+	int phy_ctrl;
+
+	phy_ctrl = readl(info->regs + TH1520_ADC_PHY_CTRL);
+	phy_ctrl &= ~TH1520_ADC_PHY_CTRL_ENADC_EN;
+	writel(phy_ctrl, info->regs + TH1520_ADC_PHY_CTRL);
+
+	clk_disable_unprepare(info->clk);
+	regulator_disable(info->vref);
+
+	return 0;
+}
+
+static int __maybe_unused th1520_adc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct th1520_adc *info = iio_priv(indio_dev);
+	int ret;
+
+	ret = regulator_enable(info->vref);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(info->clk);
+	if (ret)
+		goto disable_reg;
+
+	th1520_adc_reset(info);
+	th1520_adc_set_clk(info, info->current_clk);
+	th1520_adc_hw_init(info);
+
+	return 0;
+
+disable_reg:
+	regulator_disable(info->vref);
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(th1520_adc_pm_ops,
+			 th1520_adc_suspend, th1520_adc_resume);
+
+static struct platform_driver th1520_adc_driver = {
+	.probe          = th1520_adc_probe,
+	.remove         = th1520_adc_remove,
+	.driver         = {
+		.name   = DRIVER_NAME,
+		.of_match_table = th1520_adc_match,
+		.pm     = &th1520_adc_pm_ops,
+	},
+};
+module_platform_driver(th1520_adc_driver);
+
+MODULE_AUTHOR("fugang.duan <duanfugang.dfg@linux.alibaba.com>");
+MODULE_DESCRIPTION("XuanTie TH1520 ADC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/xuantie-th1520-adc.h b/drivers/iio/adc/xuantie-th1520-adc.h
new file mode 100644
index 000000000000..c38d17fc6bbe
--- /dev/null
+++ b/drivers/iio/adc/xuantie-th1520-adc.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * XuanTie TH1520 ADC driver
+ *
+ * Copyright (C) 2021-2024 Alibaba Group Holding Limited.
+ * Fugang Duan <duanfugang.dfg@linux.alibaba.com>
+ *
+ */
+
+#include <linux/bitops.h>
+
+/* This will be the driver name the kernel reports */
+#define DRIVER_NAME "xuantie-th1520-adc"
+
+/* ADC registers */
+#define TH1520_ADC_PHY_CFG			0x00
+#define TH1520_ADC_PHY_CTRL			0x04
+#define TH1520_ADC_PHY_TEST			0x08
+#define TH1520_ADC_OP_CTRL			0x0C
+#define TH1520_ADC_OP_SINGLE_START		0x10
+#define TH1520_ADC_FCLK_CTRL			0x14
+#define TH1520_ADC_START_TIME			0x18
+#define TH1520_ADC_SAMPLE_TIME			0x1C
+#define TH1520_ADC_SAMPLE_DATA			0x20
+#define TH1520_ADC_INT_CTRL1			0x50
+#define TH1520_ADC_INT_CTRL2			0x54
+#define TH1520_ADC_INT_STATUS			0x58
+#define TH1520_ADC_INT_ACTUAL_VALUE_CH0		0x60
+#define TH1520_ADC_INT_ACTUAL_VALUE_CH1		0x64
+#define TH1520_ADC_INT_DELTA_VALUE_CH0		0x90
+#define TH1520_ADC_INT_DELTA_VALUE_CH1		0x94
+
+/* Configuration register field define */
+#define TH1520_ADC_PHY_CFG_SELRES_6BIT			(0x0)
+#define TH1520_ADC_PHY_CFG_SELRES_8BIT			(0x1)
+#define TH1520_ADC_PHY_CFG_SELRES_10BIT			(0x2)
+#define TH1520_ADC_PHY_CFG_SELRES_12BIT			(0x3)
+#define TH1520_ADC_PHY_CFG_SELDIFF_SINGLE_ENDED_INPUTS	(0x0 << 4)
+#define TH1520_ADC_PHY_CFG_SELDIFF_DIFFERENTIAL_INPUTS	(0x1 << 4)
+#define TH1520_ADC_PHY_CFG_SELBG_INTERNAL		(0x1 << 8)
+#define TH1520_ADC_PHY_CFG_SELBG_EXTERNAL		(0x0 << 8)
+#define TH1520_ADC_PHY_CFG_SELREF_INTERNAL		(0x1 << 12)
+#define TH1520_ADC_PHY_CFG_SELREF_EXT			(0x0 << 12)
+
+/* PHY CTRL register field define */
+#define TH1520_ADC_PHY_CTRL_ENOFFSET_EN			(0x1 << 12)
+#define TH1520_ADC_PHY_CTRL_ENOFFMEAS_EN		(0x1 << 8)
+#define TH1520_ADC_PHY_CTRL_RST_EN			(0x1 << 4)
+#define TH1520_ADC_PHY_CTRL_ENADC_EN			(0x1 << 0)
+
+/* ADC OP ctrl field define  */
+#define TH1520_ADC_OP_CTRL_CH_EN_ALL			GENMASK(19, 12)
+#define TH1520_ADC_OP_CTRL_CH_EN_0			(12)
+#define TH1520_ADC_OP_CTRL_MODE_SINGLE			(0x1 << 0)
+#define TH1520_ADC_OP_CTRL_MODE_CONTINOUS		(0x0 << 0)
+
+/* ADC OP single start */
+#define TH1520_ADC_OP_SINGLE_START_EN			BIT(0)
+
+/* ADC fclk ctrl */
+#define TH1520_ADC_FCLK_CTRL_FCLLK_DIV			GENMASK(6, 0)
+#define TH1520_ADC_FCLK_CTRL_TYP_1M			(0x10004)
+#define TH1520_ADC_START_TIME_TYP_1M			(0x160)
+#define TH1520_ADC_SAMPLE_TIME_TYP_1M			(0x10)
+#define TH1520_ADC_SAMPLE_TIME_TYP_6BIT			(8)
+#define TH1520_ADC_SAMPLE_TIME_TYP_8BIT			(10)
+#define TH1520_ADC_SAMPLE_TIME_TYP_10BIT		(12)
+#define TH1520_ADC_SAMPLE_TIME_TYP_12BIT		(14)
+
+/* ADC sample data */
+#define TH1520_ADC_SAMPLE_DATA_CH1			GENMASK(27, 16)
+#define TH1520_ADC_SAMPLE_DATA_CH1_OFF			(16)
+#define TH1520_ADC_SAMPLE_DATA_CH1_VLD			BIT(31)
+#define TH1520_ADC_SAMPLE_DATA_CH1_NUMBER		GENMASK(30, 28)
+#define TH1520_ADC_SAMPLE_DATA_CH1_NUMBER_OFF		(28)
+#define TH1520_ADC_SAMPLE_DATA_CH0			GENMASK(11, 0)
+#define TH1520_ADC_SAMPLE_DATA_CH0_VLD			BIT(15)
+#define TH1520_ADC_SAMPLE_DATA_CH0_OFF			(0)
+#define TH1520_ADC_SAMPLE_DATA_CH0_NUMBER		GENMASK(14, 12)
+#define TH1520_ADC_SAMPLE_DATA_CH0_NUMBER_OFF		(12)
+
+/* ADC INT Ctrl */
+#define TH1520_ADC_INT_CTRL1_CH1_INT_MODE		BIT(1)
+#define TH1520_ADC_INT_CTRL1_CH0_INT_MODE		BIT(0)
+#define TH1520_ADC_INT_CTRL2_CH1_INT_MASK		BIT(1)
+#define TH1520_ADC_INT_CTRL2_CH0_INT_MASK		BIT(0)
+#define TH1520_ADC_INT_STS_CH1_INT_STS			BIT(1)
+#define TH1520_ADC_INT_STS_CH0_INT_STS			BIT(0)
+
+#define TH1520_ADC_ACTUAL_VALUE_CH0_HVAL		GENMASK(27, 16)
+#define TH1520_ADC_ACTUAL_VALUE_CH0_HVAL_OFF		(16)
+#define TH1520_ADC_ACTUAL_VALUE_CH0_LVAL		GENMASK(11, 0)
+#define TH1520_ADC_ACTUAL_VALUE_CH0_LVAL_OFF		(0)
+#define TH1520_ADC_ACTUAL_VALUE_CH1_HVAL		GENMASK(27, 16)
+#define TH1520_ADC_ACTUAL_VALUE_CH1_HVAL_OFF		(16)
+#define TH1520_ADC_ACTUAL_VALUE_CH1_LVAL		GENMASK(11, 0)
+#define TH1520_ADC_ACTUAL_VALUE_CH1_LVAL_OFF		(0)
+
+#define TH1520_ADC_DLT_VALUE_CH0_HVAL			GENMASK(27, 16)
+#define TH1520_ADC_DLT_VALUE_CH0_HVAL_OFF		(16)
+#define TH1520_ADC_DLT_VALUE_CH0_LVAL			GENMASK(11, 0)
+#define TH1520_ADC_DLT_VALUE_CH0_LVAL_OFF		(0)
+#define TH1520_ADC_DLT_VALUE_CH1_HVAL			GENMASK(27, 16)
+#define TH1520_ADC_DLT_VALUE_CH1_HVAL_OFF		(16)
+#define TH1520_ADC_DLT_VALUE_CH1_LVAL			GENMASK(11, 0)
+#define TH1520_ADC_DLT_VALUE_CH1_LVAL_OFF		(0)
+
+#define TH1520_ADC_FIFO_DATA_SIZE			32
+#define TH1520_ADC_PHY_ENCTR				0x8e0
+#define TH1520_ADC_TIMEOUT				500000
+
+#define TH1520_ADC_CHAN(_idx, _chan_type) {			\
+	.type = (_chan_type),					\
+	.indexed = 1,						\
+	.channel = (_idx),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+}
+
+enum vol_ref {
+	TH1520_ADC_VOL_VREF,
+	TH1520_ADC_VOL_INTE,
+};
+
+enum input_mode_sel {
+	TH1520_ADC_SINGLE_ENDED_INPUTS,
+	TH1520_ADC_DIFFERENTIAL_INPUTS,
+};
+
+enum selres_sel {
+	TH1520_ADC_SELRES_6BIT = 6,
+	TH1520_ADC_SELRES_8BIT = 8,
+	TH1520_ADC_SELRES_10BIT = 10,
+	TH1520_ADC_SELRES_12BIT = 12,
+};
+
+enum offset_mode_sel {
+	TH1520_ADC_OFFSET_DIS = 0,
+	TH1520_ADC_OFFSET_EN,
+};
+
+enum conversion_mode_sel {
+	TH1520_ADC_MODE_SINGLE,
+	TH1520_ADC_MODE_CONTINOUS,
+};
+
+enum clk_sel {
+	TH1520_ADC_FCLK_TYP_1M,
+};
+
+enum int_actual_mask {
+	TH1520_ADC_ACTUAL_CH0,
+	TH1520_ADC_ACTUAL_CH1,
+	TH1520_ADC_ACTUAL_ALL,
+
+};
+
+enum int_delta_mask {
+	TH1520_ADC_DETAL_CH0,
+	TH1520_ADC_DETAL_CH1,
+	TH1520_ADC_DETAL_ALL,
+};
+
+struct th1520_adc_feature {
+	enum selres_sel			selres_sel;
+	enum input_mode_sel		input_mode;
+	enum vol_ref			vol_ref;
+	enum offset_mode_sel		offset_mode;
+	enum conversion_mode_sel	conv_mode;
+	enum clk_sel			clk_sel;
+	enum int_actual_mask		int_actual;
+	enum int_delta_mask		int_detal;
+};
+
+struct th1520_adc {
+	struct device			*dev;
+	void __iomem			*regs;
+	struct clk			*clk;
+
+	u32				vref_uv;
+	u32				value;
+	struct regulator		*vref;
+	struct th1520_adc_feature	adc_feature;
+	u32				current_clk;
+	u32				ch0_offmeas;
+	u32				ch1_offmeas;
+
+	struct completion		completion;
+	/* lock to protect against multiple access to the device */
+	struct mutex			mlock;
+};
+
-- 
2.44.0


