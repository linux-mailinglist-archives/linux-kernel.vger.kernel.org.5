Return-Path: <linux-kernel+bounces-1896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 725AF815570
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E771C211B8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD273BB3C;
	Sat, 16 Dec 2023 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LP1UYNMS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D6435889;
	Sat, 16 Dec 2023 00:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG0JIFD032069;
	Sat, 16 Dec 2023 00:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=rY5adxQfJ6KvF/u/fHnmbUJMprL8AIQb6d7Wl4O19x0
	=; b=LP1UYNMS8LlhnRHZaUcjXaHzoDy/oh9N5RrENiikcg/uPteN+pxZwMl9pnJ
	HcKt6YqFvSxOn5NJQAuHRZTfjn7jiHgQiLYacBGmxGlf92fwR1h9+nV2Q6uKFGjw
	CDLdVObTGketU4EYfrCryuT9EvxQHBTRk3jdjVx3Utm9e7OCDNhP4/RyLbOxoesT
	mkXiyR3xWosDPtcuFx/kWDsQjGyzY4ltb786k1OQxV4284Rcob+6ysqmczTqgqpm
	ZLa+zKwn7MGkEIM7TFD+Thhu4qVICBLXTHdgxcNQeZW6SGUxpiVmIVIR4H/ydchf
	bIDgYOdbC04SvCT8wxRA2ifYCFA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0m46hwe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0LIY8006403
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:18 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:17 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:21:09 -0800
Subject: [PATCH RFC v15 28/30] virt: gunyah: Add irqfd interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-28-192a5d872a30@quicinc.com>
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
X-Proofpoint-GUID: wjQpOSPX7aG6e3FizqX1--zqcHINpCnM
X-Proofpoint-ORIG-GUID: wjQpOSPX7aG6e3FizqX1--zqcHINpCnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160001

Enable support for creating irqfds which can raise an interrupt on a
Gunyah virtual machine. irqfds are exposed to userspace as a Gunyah VM
function with the name "irqfd". If the VM devicetree is not configured
to create a doorbell with the corresponding label, userspace will still
be able to assert the eventfd but no interrupt will be raised on the
guest.

Acked-by: Alex Elder <elder@linaro.org>
Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Kconfig        |   9 ++
 drivers/virt/gunyah/Makefile       |   1 +
 drivers/virt/gunyah/gunyah_irqfd.c | 191 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/gunyah.h        |  35 +++++++
 4 files changed, 236 insertions(+)

diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
index fe2823dc48ba..1685b75fb77a 100644
--- a/drivers/virt/gunyah/Kconfig
+++ b/drivers/virt/gunyah/Kconfig
@@ -27,3 +27,12 @@ config GUNYAH_QCOM_PLATFORM
 	  extra platform-specific support.
 
 	  Say Y/M here to use Gunyah on Qualcomm platforms.
+
+config GUNYAH_IRQFD
+	tristate "Gunyah irqfd interface"
+	depends on GUNYAH
+	help
+	  Enable kernel support for creating irqfds which can raise an interrupt
+	  on Gunyah virtual machine.
+
+	  Say Y/M here if unsure and you want to support Gunyah VMMs.
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index c4505fce177d..b41b02792921 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -5,3 +5,4 @@ gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mem.o guest_memfd.o
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o gunyah_vcpu.o
 obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
 obj-$(CONFIG_GUNYAH_QCOM_PLATFORM) += gunyah_qcom.o
+obj-$(CONFIG_GUNYAH_IRQFD) += gunyah_irqfd.o
diff --git a/drivers/virt/gunyah/gunyah_irqfd.c b/drivers/virt/gunyah/gunyah_irqfd.c
new file mode 100644
index 000000000000..0e377ead3213
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_irqfd.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/eventfd.h>
+#include <linux/device/driver.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/gunyah.h>
+#include <linux/gunyah_vm_mgr.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/printk.h>
+
+#include <uapi/linux/gunyah.h>
+
+struct gunyah_irqfd {
+	struct gunyah_resource *ghrsc;
+	struct gunyah_vm_resource_ticket ticket;
+	struct gunyah_vm_function_instance *f;
+
+	bool level;
+
+	struct eventfd_ctx *ctx;
+	wait_queue_entry_t wait;
+	poll_table pt;
+};
+
+static int irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, int sync,
+			void *key)
+{
+	struct gunyah_irqfd *irqfd =
+		container_of(wait, struct gunyah_irqfd, wait);
+	__poll_t flags = key_to_poll(key);
+	int ret = 0;
+
+	if (flags & EPOLLIN) {
+		if (irqfd->ghrsc) {
+			ret = gunyah_hypercall_bell_send(irqfd->ghrsc->capid, 1,
+							 NULL);
+			if (ret)
+				pr_err_ratelimited(
+					"Failed to inject interrupt %d: %d\n",
+					irqfd->ticket.label, ret);
+		} else
+			pr_err_ratelimited(
+				"Premature injection of interrupt\n");
+	}
+
+	return 0;
+}
+
+static void irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh,
+				    poll_table *pt)
+{
+	struct gunyah_irqfd *irq_ctx =
+		container_of(pt, struct gunyah_irqfd, pt);
+
+	add_wait_queue(wqh, &irq_ctx->wait);
+}
+
+static bool gunyah_irqfd_populate(struct gunyah_vm_resource_ticket *ticket,
+				  struct gunyah_resource *ghrsc)
+{
+	struct gunyah_irqfd *irqfd =
+		container_of(ticket, struct gunyah_irqfd, ticket);
+	int ret;
+
+	if (irqfd->ghrsc) {
+		pr_warn("irqfd%d already got a Gunyah resource. Check if multiple resources with same label were configured.\n",
+			irqfd->ticket.label);
+		return false;
+	}
+
+	irqfd->ghrsc = ghrsc;
+	if (irqfd->level) {
+		/* Configure the bell to trigger when bit 0 is asserted (see
+		 * irq_wakeup) and for bell to automatically clear bit 0 once
+		 * received by the VM (ack_mask).  need to make sure bit 0 is cleared right away,
+		 * otherwise the line will never be deasserted. Emulating edge
+		 * trigger interrupt does not need to set either mask
+		 * because irq is listed only once per gunyah_hypercall_bell_send
+		 */
+		ret = gunyah_hypercall_bell_set_mask(irqfd->ghrsc->capid, 1, 1);
+		if (ret)
+			pr_warn("irq %d couldn't be set as level triggered. Might cause IRQ storm if asserted\n",
+				irqfd->ticket.label);
+	}
+
+	return true;
+}
+
+static void gunyah_irqfd_unpopulate(struct gunyah_vm_resource_ticket *ticket,
+				    struct gunyah_resource *ghrsc)
+{
+	struct gunyah_irqfd *irqfd =
+		container_of(ticket, struct gunyah_irqfd, ticket);
+	u64 cnt;
+
+	eventfd_ctx_remove_wait_queue(irqfd->ctx, &irqfd->wait, &cnt);
+}
+
+static long gunyah_irqfd_bind(struct gunyah_vm_function_instance *f)
+{
+	struct gunyah_fn_irqfd_arg *args = f->argp;
+	struct gunyah_irqfd *irqfd;
+	__poll_t events;
+	struct fd fd;
+	long r;
+
+	if (f->arg_size != sizeof(*args))
+		return -EINVAL;
+
+	/* All other flag bits are reserved for future use */
+	if (args->flags & ~GUNYAH_IRQFD_FLAGS_LEVEL)
+		return -EINVAL;
+
+	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
+	if (!irqfd)
+		return -ENOMEM;
+
+	irqfd->f = f;
+	f->data = irqfd;
+
+	fd = fdget(args->fd);
+	if (!fd.file) {
+		kfree(irqfd);
+		return -EBADF;
+	}
+
+	irqfd->ctx = eventfd_ctx_fileget(fd.file);
+	if (IS_ERR(irqfd->ctx)) {
+		r = PTR_ERR(irqfd->ctx);
+		goto err_fdput;
+	}
+
+	if (args->flags & GUNYAH_IRQFD_FLAGS_LEVEL)
+		irqfd->level = true;
+
+	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
+	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
+
+	irqfd->ticket.resource_type = GUNYAH_RESOURCE_TYPE_BELL_TX;
+	irqfd->ticket.label = args->label;
+	irqfd->ticket.owner = THIS_MODULE;
+	irqfd->ticket.populate = gunyah_irqfd_populate;
+	irqfd->ticket.unpopulate = gunyah_irqfd_unpopulate;
+
+	r = gunyah_vm_add_resource_ticket(f->ghvm, &irqfd->ticket);
+	if (r)
+		goto err_ctx;
+
+	events = vfs_poll(fd.file, &irqfd->pt);
+	if (events & EPOLLIN)
+		pr_warn("Premature injection of interrupt\n");
+	fdput(fd);
+
+	return 0;
+err_ctx:
+	eventfd_ctx_put(irqfd->ctx);
+err_fdput:
+	fdput(fd);
+	kfree(irqfd);
+	return r;
+}
+
+static void gunyah_irqfd_unbind(struct gunyah_vm_function_instance *f)
+{
+	struct gunyah_irqfd *irqfd = f->data;
+
+	gunyah_vm_remove_resource_ticket(irqfd->f->ghvm, &irqfd->ticket);
+	eventfd_ctx_put(irqfd->ctx);
+	kfree(irqfd);
+}
+
+static bool gunyah_irqfd_compare(const struct gunyah_vm_function_instance *f,
+				 const void *arg, size_t size)
+{
+	const struct gunyah_fn_irqfd_arg *instance = f->argp, *other = arg;
+
+	if (sizeof(*other) != size)
+		return false;
+
+	return instance->label == other->label;
+}
+
+DECLARE_GUNYAH_VM_FUNCTION_INIT(irqfd, GUNYAH_FN_IRQFD, 2, gunyah_irqfd_bind,
+				gunyah_irqfd_unbind, gunyah_irqfd_compare);
+MODULE_DESCRIPTION("Gunyah irqfd VM Function");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 574116f54472..cb7b0bb9bef3 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -63,9 +63,12 @@ struct gunyah_vm_dtb_config {
  * @GUNYAH_FN_VCPU: create a vCPU instance to control a vCPU
  *              &struct gunyah_fn_desc.arg is a pointer to &struct gunyah_fn_vcpu_arg
  *              Return: file descriptor to manipulate the vcpu.
+ * @GUNYAH_FN_IRQFD: register eventfd to assert a Gunyah doorbell
+ *               &struct gunyah_fn_desc.arg is a pointer to &struct gunyah_fn_irqfd_arg
  */
 enum gunyah_fn_type {
 	GUNYAH_FN_VCPU = 1,
+	GUNYAH_FN_IRQFD,
 };
 
 #define GUNYAH_FN_MAX_ARG_SIZE		256
@@ -85,6 +88,38 @@ struct gunyah_fn_vcpu_arg {
 	__u32 id;
 };
 
+/**
+ * enum gunyah_irqfd_flags - flags for use in gunyah_fn_irqfd_arg
+ * @GUNYAH_IRQFD_FLAGS_LEVEL: make the interrupt operate like a level triggered
+ *                        interrupt on guest side. Triggering IRQFD before
+ *                        guest handles the interrupt causes interrupt to
+ *                        stay asserted.
+ */
+enum gunyah_irqfd_flags {
+	GUNYAH_IRQFD_FLAGS_LEVEL		= 1UL << 0,
+};
+
+/**
+ * struct gunyah_fn_irqfd_arg - Arguments to create an irqfd function.
+ *
+ * Create this function with &GUNYAH_VM_ADD_FUNCTION using type &GUNYAH_FN_IRQFD.
+ *
+ * Allows setting an eventfd to directly trigger a guest interrupt.
+ * irqfd.fd specifies the file descriptor to use as the eventfd.
+ * irqfd.label corresponds to the doorbell label used in the guest VM's devicetree.
+ *
+ * @fd: an eventfd which when written to will raise a doorbell
+ * @label: Label of the doorbell created on the guest VM
+ * @flags: see &enum gunyah_irqfd_flags
+ * @padding: padding bytes
+ */
+struct gunyah_fn_irqfd_arg {
+	__u32 fd;
+	__u32 label;
+	__u32 flags;
+	__u32 padding;
+};
+
 /**
  * struct gunyah_fn_desc - Arguments to create a VM function
  * @type: Type of the function. See &enum gunyah_fn_type.

-- 
2.43.0


