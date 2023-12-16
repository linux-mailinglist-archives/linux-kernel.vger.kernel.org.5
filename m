Return-Path: <linux-kernel+bounces-1882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91984815533
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F29283D63
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6EA18E03;
	Sat, 16 Dec 2023 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mNiKvPnu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F111181;
	Sat, 16 Dec 2023 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFNuDjm011568;
	Sat, 16 Dec 2023 00:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=bqGXiy7rJWgunfcS0swUq9wvN7P/no+5hve3TGGiwYk
	=; b=mNiKvPnuTFnWo0uoPUtkubYQuzZwN1hgYe/ZypSkUFonIWf0xazZ79/qMNR
	pVztBO3WZWk7CJ3QbSbpVn3n86lVhUNo5KGGwUjccFCJ5HAHrI96j2LQDuNcbIr1
	XKwc1euqacMtNysA9AtVVcT2J1H26/sAs0lBtzrbiKqp2SSxMOe5h+8Lt5zzwRsB
	cJEUVjI0SDlmnLVT0OKd5KPak6CDfpQOVmMCBmP1vJOquiKKitgsb5zrOPAXjDHw
	DbL3OWeDgbv3zZ4kMEDGu9dYh0PlReHV6NRPcM3Vo6cOHKPbCKelKSQv3lN/EN9L
	ZdFJwgoTUIHyoRBh1UWorOZYpTA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0k90t5ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0L8DH014659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:08 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:07 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:20:53 -0800
Subject: [PATCH RFC v15 12/30] virt: gunyah: Translate gh_rm_hyp_resource
 into gunyah_resource
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-12-192a5d872a30@quicinc.com>
References: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
In-Reply-To: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
To: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu
	<quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T7ZeyOadqgP4Q6zbC8RuW7Sozwk6ZNoa
X-Proofpoint-GUID: T7ZeyOadqgP4Q6zbC8RuW7Sozwk6ZNoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=948 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160001

When booting a Gunyah virtual machine, the host VM may gain capabilities
to interact with resources for the guest virtual machine. Examples of
such resources are vCPUs or message queues. To use those resources, we
need to translate the RM response into a gunyah_resource structure which
are useful to Linux drivers. Presently, Linux drivers need only to know
the type of resource, the capability ID, and an interrupt.

On ARM64 systems, the interrupt reported by Gunyah is the GIC interrupt
ID number and always a SPI.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/include/asm/gunyah.h |  36 +++++++++
 drivers/virt/gunyah/rsc_mgr.c   | 174 +++++++++++++++++++++++++++++++++++++++-
 include/linux/gunyah.h          |   3 +
 include/linux/gunyah_rsc_mgr.h  |   5 ++
 4 files changed, 217 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/gunyah.h b/arch/arm64/include/asm/gunyah.h
new file mode 100644
index 000000000000..0cd3debe22b6
--- /dev/null
+++ b/arch/arm64/include/asm/gunyah.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _ASM_GUNYAH_H
+#define _ASM_GUNYAH_H
+
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+
+static inline int arch_gunyah_fill_irq_fwspec_params(u32 virq,
+						 struct irq_fwspec *fwspec)
+{
+	/* Assume that Gunyah gave us an SPI or ESPI; defensively check it */
+	if (WARN(virq < 32, "Unexpected virq: %d\n", virq)) {
+		return -EINVAL;
+	} else if (virq <= 1019) {
+		fwspec->param_count = 3;
+		fwspec->param[0] = 0; /* GIC_SPI */
+		fwspec->param[1] = virq - 32; /* virq 32 -> SPI 0 */
+		fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
+	} else if (WARN(virq < 4096, "Unexpected virq: %d\n", virq)) {
+		return -EINVAL;
+	} else if (virq < 5120) {
+		fwspec->param_count = 3;
+		fwspec->param[0] = 2; /* GIC_ESPI */
+		fwspec->param[1] = virq - 4096; /* virq 4096 -> ESPI 0 */
+		fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
+	} else {
+		WARN(1, "Unexpected virq: %d\n", virq);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+#endif
diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
index 052b3f072a85..acd772deb950 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -17,6 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/miscdevice.h>
 
+#include <asm/gunyah.h>
+
 #include "rsc_mgr.h"
 #include "vm_mgr.h"
 
@@ -129,6 +131,7 @@ struct gunyah_rm_message {
  * @send_ready: completion to send messages again
  * @nh: notifier chain for clients interested in RM notification messages
  * @miscdev: /dev/gunyah
+ * @irq_domain: Domain to translate Gunyah hwirqs to Linux irqs
  */
 struct gunyah_rm {
 	struct device *dev;
@@ -147,6 +150,7 @@ struct gunyah_rm {
 	struct blocking_notifier_head nh;
 
 	struct miscdevice miscdev;
+	struct irq_domain *irq_domain;
 };
 
 /**
@@ -187,6 +191,143 @@ static inline int gunyah_rm_error_remap(enum gunyah_rm_error rm_error)
 	}
 }
 
+struct gunyah_irq_chip_data {
+	u32 gunyah_virq;
+};
+
+static struct irq_chip gunyah_rm_irq_chip = {
+	/* clang-format off */
+	.name			= "Gunyah",
+	.irq_enable		= irq_chip_enable_parent,
+	.irq_disable		= irq_chip_disable_parent,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_mask_ack		= irq_chip_mask_ack_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_wake		= irq_chip_set_wake_parent,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+	/* clang-format on */
+};
+
+static int gunyah_rm_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
+				      unsigned int nr_irqs, void *arg)
+{
+	struct gunyah_irq_chip_data *chip_data, *spec = arg;
+	struct irq_fwspec parent_fwspec = {};
+	struct gunyah_rm *rm = d->host_data;
+	u32 gunyah_virq = spec->gunyah_virq;
+	int ret;
+
+	if (nr_irqs != 1)
+		return -EINVAL;
+
+	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
+	if (!chip_data)
+		return -ENOMEM;
+
+	chip_data->gunyah_virq = gunyah_virq;
+
+	ret = irq_domain_set_hwirq_and_chip(d, virq, chip_data->gunyah_virq,
+					    &gunyah_rm_irq_chip, chip_data);
+	if (ret)
+		goto err_free_irq_data;
+
+	parent_fwspec.fwnode = d->parent->fwnode;
+	ret = arch_gunyah_fill_irq_fwspec_params(chip_data->gunyah_virq,
+						 &parent_fwspec);
+	if (ret) {
+		dev_err(rm->dev, "virq translation failed %u: %d\n",
+			chip_data->gunyah_virq, ret);
+		goto err_free_irq_data;
+	}
+
+	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &parent_fwspec);
+	if (ret)
+		goto err_free_irq_data;
+
+	return ret;
+err_free_irq_data:
+	kfree(chip_data);
+	return ret;
+}
+
+static void gunyah_rm_irq_domain_free_single(struct irq_domain *d,
+					     unsigned int virq)
+{
+	struct irq_data *irq_data;
+
+	irq_data = irq_domain_get_irq_data(d, virq);
+	if (!irq_data)
+		return;
+
+	kfree(irq_data->chip_data);
+	irq_data->chip_data = NULL;
+}
+
+static void gunyah_rm_irq_domain_free(struct irq_domain *d, unsigned int virq,
+				      unsigned int nr_irqs)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_irqs; i++)
+		gunyah_rm_irq_domain_free_single(d, virq);
+}
+
+static const struct irq_domain_ops gunyah_rm_irq_domain_ops = {
+	.alloc = gunyah_rm_irq_domain_alloc,
+	.free = gunyah_rm_irq_domain_free,
+};
+
+struct gunyah_resource *
+gunyah_rm_alloc_resource(struct gunyah_rm *rm,
+			 struct gunyah_rm_hyp_resource *hyp_resource)
+{
+	struct gunyah_resource *ghrsc;
+	int ret;
+
+	ghrsc = kzalloc(sizeof(*ghrsc), GFP_KERNEL);
+	if (!ghrsc)
+		return NULL;
+
+	ghrsc->type = hyp_resource->type;
+	ghrsc->capid = le64_to_cpu(hyp_resource->cap_id);
+	ghrsc->irq = IRQ_NOTCONNECTED;
+	ghrsc->rm_label = le32_to_cpu(hyp_resource->resource_label);
+	if (hyp_resource->virq) {
+		struct gunyah_irq_chip_data irq_data = {
+			.gunyah_virq = le32_to_cpu(hyp_resource->virq),
+		};
+
+		ret = irq_domain_alloc_irqs(rm->irq_domain, 1, NUMA_NO_NODE,
+					    &irq_data);
+		if (ret < 0) {
+			dev_err(rm->dev,
+				"Failed to allocate interrupt for resource %d label: %d: %d\n",
+				ghrsc->type, ghrsc->rm_label, ret);
+			kfree(ghrsc);
+			return NULL;
+		}
+		ghrsc->irq = ret;
+	}
+
+	return ghrsc;
+}
+
+void gunyah_rm_free_resource(struct gunyah_resource *ghrsc)
+{
+	irq_dispose_mapping(ghrsc->irq);
+	kfree(ghrsc);
+}
+
 static int gunyah_rm_init_message_payload(struct gunyah_rm_message *message,
 					  const void *msg, size_t hdr_size,
 					  size_t msg_size)
@@ -713,6 +854,8 @@ static int gunyah_rm_probe_rx_msgq(struct gunyah_rm *rm,
 
 static int gunyah_rm_probe(struct platform_device *pdev)
 {
+	struct irq_domain *parent_irq_domain;
+	struct device_node *parent_irq_node;
 	struct gunyah_rm *rm;
 	int ret;
 
@@ -738,15 +881,43 @@ static int gunyah_rm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	parent_irq_node = of_irq_find_parent(pdev->dev.of_node);
+	if (!parent_irq_node) {
+		dev_err(&pdev->dev,
+			"Failed to find interrupt parent of resource manager\n");
+		return -ENODEV;
+	}
+
+	parent_irq_domain = irq_find_host(parent_irq_node);
+	if (!parent_irq_domain) {
+		dev_err(&pdev->dev,
+			"Failed to find interrupt parent domain of resource manager\n");
+		return -ENODEV;
+	}
+
+	rm->irq_domain = irq_domain_add_hierarchy(parent_irq_domain, 0, 0,
+						  pdev->dev.of_node,
+						  &gunyah_rm_irq_domain_ops,
+						  NULL);
+	if (!rm->irq_domain) {
+		dev_err(&pdev->dev, "Failed to add irq domain\n");
+		return -ENODEV;
+	}
+	rm->irq_domain->host_data = rm;
+
+	rm->miscdev.parent = &pdev->dev;
 	rm->miscdev.name = "gunyah";
 	rm->miscdev.minor = MISC_DYNAMIC_MINOR;
 	rm->miscdev.fops = &gunyah_dev_fops;
 
 	ret = misc_register(&rm->miscdev);
 	if (ret)
-		return ret;
+		goto err_irq_domain;
 
 	return 0;
+err_irq_domain:
+	irq_domain_remove(rm->irq_domain);
+	return ret;
 }
 
 static void gunyah_rm_remove(struct platform_device *pdev)
@@ -754,6 +925,7 @@ static void gunyah_rm_remove(struct platform_device *pdev)
 	struct gunyah_rm *rm = platform_get_drvdata(pdev);
 
 	misc_deregister(&rm->miscdev);
+	irq_domain_remove(rm->irq_domain);
 }
 
 static const struct of_device_id gunyah_rm_of_match[] = {
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index ea2c9eecce0e..ecd62d0e36ad 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -29,6 +29,9 @@ struct gunyah_resource {
 	enum gunyah_resource_type type;
 	u64 capid;
 	unsigned int irq;
+
+	struct list_head list;
+	u32 rm_label;
 };
 
 /******************************************************************************/
diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
index 7bd2bee91f3e..0f61c2b10817 100644
--- a/include/linux/gunyah_rsc_mgr.h
+++ b/include/linux/gunyah_rsc_mgr.h
@@ -163,4 +163,9 @@ int gunyah_rm_vm_set_address_layout(struct gunyah_rm *rm, u16 vmid,
 				    enum gunyah_rm_range_id range_id,
 				    u64 base_address, u64 size);
 
+struct gunyah_resource *
+gunyah_rm_alloc_resource(struct gunyah_rm *rm,
+			 struct gunyah_rm_hyp_resource *hyp_resource);
+void gunyah_rm_free_resource(struct gunyah_resource *ghrsc);
+
 #endif

-- 
2.43.0


