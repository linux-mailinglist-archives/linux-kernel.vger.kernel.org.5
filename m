Return-Path: <linux-kernel+bounces-21339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E27828DE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9058C288B3D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2D547796;
	Tue,  9 Jan 2024 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nmVGxi57"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE01340BE8;
	Tue,  9 Jan 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409Er235000860;
	Tue, 9 Jan 2024 19:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=4lM0JVVYQLJT2z4piUn0A5bpNItJWqp93hg1dTCIGUo
	=; b=nmVGxi57i6Hz66foressk7Npgy0RWtWPIaPisAkL9t17w7/hZ/vJT+AcTIC
	1mjxklx7iNIVxWkpBhIe7lQd3+//5JCgPBzxXYe1/XLt+HAooHTISas1kSr9iGtQ
	sGadnSnck/CX4NjQJZiJq7mJEH64a694u27OFKPY1ZivckYGRtu7CrUWW6UMAdCJ
	ELHX2uisxiYcxtR0apbZps8XOIXBV92xUdk+L6JHBCG5pFmVIUgys9An3pB7StXN
	QdydKoX3wKHvpROUyzOWo6KGO35r6A8jl6GjTBB7a2b6Bp3kg0H44nLAoCgO5U5f
	G+4MK3vdKHbDifxiZbB+EJpeTRg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh3me1851-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:38:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409JbxFE030438
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:37:59 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:37:58 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:37:53 -0800
Subject: [PATCH v16 15/34] virt: gunyah: Add proxy-scheduled vCPUs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-15-634904bf4ce9@quicinc.com>
References: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
In-Reply-To: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
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
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PxJYOU8rDFxI7KkcDCs-veyaHo31uZCZ
X-Proofpoint-GUID: PxJYOU8rDFxI7KkcDCs-veyaHo31uZCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

Gunyah allows vCPUs that are configured as proxy-scheduled to be scheduled by
another virtual machine (host) that holds capabilities to those vCPUs with
suitable rights.

Gunyah also supports configuring regions of a proxy-scheduled VM's address
space to be virtualized by the host VM. This permits a host VMM to emulate MMIO
devices in the proxy-scheduled VM.

vCPUs are presented to the host as a Gunyah resource and represented to
userspace as a Gunyah VM function.

Creating the vcpu function on the VM will create a file descriptor that:
 - can handle an ioctl to run the vCPU. When called, Gunyah will directly
   context-switch to the selected vCPU and run it until one of the following
   events occurs:
    * the host vcpu's time slice ends
    * the host vcpu receives an interrupt or would have been pre-empted
      by the hypervisor
    * a fault occurs in the proxy-scheduled vcpu
    * a power management event, such as idle or cpu-off call in the vcpu
 - can be mmap'd to share the gunyah_vcpu_run structure with userspace. This
   allows the vcpu_run result codes to be accessed, and for arguments to
   vcpu_run to be passed, e.g. for resuming the vcpu when handling certain fault
   and exit cases.

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/Makefile      |   2 +-
 drivers/virt/gunyah/gunyah_vcpu.c | 557 ++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.c      |   5 +
 drivers/virt/gunyah/vm_mgr.h      |   2 +
 include/uapi/linux/gunyah.h       | 163 +++++++++++
 5 files changed, 728 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index 47f1fae5419b..3f82af8c5ce7 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -2,4 +2,4 @@
 
 gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
 
-obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o
+obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o gunyah_vcpu.o
diff --git a/drivers/virt/gunyah/gunyah_vcpu.c b/drivers/virt/gunyah/gunyah_vcpu.c
new file mode 100644
index 000000000000..b636b54dc9a1
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah_vcpu.c
@@ -0,0 +1,557 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/gunyah.h>
+#include <linux/interrupt.h>
+#include <linux/kref.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include "vm_mgr.h"
+
+#include <uapi/linux/gunyah.h>
+
+#define MAX_VCPU_NAME 20 /* gh-vcpu:strlen(U32::MAX)+NUL */
+
+/**
+ * struct gunyah_vcpu - Track an instance of gunyah vCPU
+ * @f: Function instance (how we get associated with the main VM)
+ * @rsc: Pointer to the Gunyah vCPU resource, will be NULL until VM starts
+ * @run_lock: One userspace thread at a time should run the vCPU
+ * @ghvm: Pointer to the main VM struct; quicker look up than going through
+ *        @f->ghvm
+ * @vcpu_run: Pointer to page shared with userspace to communicate vCPU state
+ * @state: Our copy of the state of the vCPU, since userspace could trick
+ *         kernel to behave incorrectly if we relied on @vcpu_run
+ * @mmio_read_len: Our copy of @vcpu_run->mmio.len; see also @state
+ * @mmio_addr: Our copy of @vcpu_run->mmio.phys_addr; see also @state
+ * @ready: if vCPU goes to sleep, hypervisor reports to us that it's sleeping
+ *         and will signal interrupt (from @rsc) when it's time to wake up.
+ *         This completion signals that we can run vCPU again.
+ * @nb: When VM exits, the status of VM is reported via @vcpu_run->status.
+ *      We need to track overall VM status, and the nb gives us the updates from
+ *      Resource Manager.
+ * @ticket: resource ticket to claim vCPU# for the VM
+ * @kref: Reference counter
+ */
+struct gunyah_vcpu {
+	struct gunyah_vm_function_instance *f;
+	struct gunyah_resource *rsc;
+	struct mutex run_lock;
+	struct gunyah_vm *ghvm;
+
+	struct gunyah_vcpu_run *vcpu_run;
+
+	/**
+	 * Track why the vcpu_run hypercall returned. This mirrors the vcpu_run
+	 * structure shared with userspace, except is used internally to avoid
+	 * trusting userspace to not modify the vcpu_run structure.
+	 */
+	enum {
+		GUNYAH_VCPU_RUN_STATE_UNKNOWN = 0,
+		GUNYAH_VCPU_RUN_STATE_READY,
+		GUNYAH_VCPU_RUN_STATE_MMIO_READ,
+		GUNYAH_VCPU_RUN_STATE_MMIO_WRITE,
+		GUNYAH_VCPU_RUN_STATE_SYSTEM_DOWN,
+	} state;
+	u8 mmio_read_len;
+	u64 mmio_addr;
+
+	struct completion ready;
+
+	struct notifier_block nb;
+	struct gunyah_vm_resource_ticket ticket;
+	struct kref kref;
+};
+
+static void vcpu_release(struct kref *kref)
+{
+	struct gunyah_vcpu *vcpu = container_of(kref, struct gunyah_vcpu, kref);
+
+	free_page((unsigned long)vcpu->vcpu_run);
+	kfree(vcpu);
+}
+
+/*
+ * When hypervisor allows us to schedule vCPU again, it gives us an interrupt
+ */
+static irqreturn_t gunyah_vcpu_irq_handler(int irq, void *data)
+{
+	struct gunyah_vcpu *vcpu = data;
+
+	complete(&vcpu->ready);
+	return IRQ_HANDLED;
+}
+
+static void gunyah_handle_page_fault(
+	struct gunyah_vcpu *vcpu,
+	const struct gunyah_hypercall_vcpu_run_resp *vcpu_run_resp)
+{
+	u64 addr = vcpu_run_resp->state_data[0];
+
+	vcpu->vcpu_run->page_fault.resume_action = GUNYAH_VCPU_RESUME_FAULT;
+	vcpu->vcpu_run->page_fault.attempt = 0;
+	vcpu->vcpu_run->page_fault.phys_addr = addr;
+	vcpu->vcpu_run->exit_reason = GUNYAH_VCPU_EXIT_PAGE_FAULT;
+}
+
+static void
+gunyah_handle_mmio(struct gunyah_vcpu *vcpu,
+		   const struct gunyah_hypercall_vcpu_run_resp *vcpu_run_resp)
+{
+	u64 addr = vcpu_run_resp->state_data[0],
+	    len = vcpu_run_resp->state_data[1],
+	    data = vcpu_run_resp->state_data[2];
+
+	if (WARN_ON(len > sizeof(u64)))
+		len = sizeof(u64);
+
+	if (vcpu_run_resp->state == GUNYAH_VCPU_ADDRSPACE_VMMIO_READ) {
+		vcpu->vcpu_run->mmio.is_write = 0;
+		/* Record that we need to give vCPU user's supplied value next gunyah_vcpu_run() */
+		vcpu->state = GUNYAH_VCPU_RUN_STATE_MMIO_READ;
+		vcpu->mmio_read_len = len;
+	} else { /* GUNYAH_VCPU_ADDRSPACE_VMMIO_WRITE */
+		vcpu->vcpu_run->mmio.is_write = 1;
+		memcpy(vcpu->vcpu_run->mmio.data, &data, len);
+		vcpu->state = GUNYAH_VCPU_RUN_STATE_MMIO_WRITE;
+	}
+
+	vcpu->vcpu_run->mmio.resume_action = 0;
+	vcpu->mmio_addr = vcpu->vcpu_run->mmio.phys_addr = addr;
+	vcpu->vcpu_run->mmio.len = len;
+	vcpu->vcpu_run->exit_reason = GUNYAH_VCPU_EXIT_MMIO;
+}
+
+static int gunyah_handle_mmio_resume(struct gunyah_vcpu *vcpu,
+				     unsigned long resume_data[3])
+{
+	switch (vcpu->vcpu_run->mmio.resume_action) {
+	case GUNYAH_VCPU_RESUME_HANDLED:
+		if (vcpu->state == GUNYAH_VCPU_RUN_STATE_MMIO_READ) {
+			if (unlikely(vcpu->mmio_read_len >
+				     sizeof(resume_data[0])))
+				vcpu->mmio_read_len = sizeof(resume_data[0]);
+			memcpy(&resume_data[0], vcpu->vcpu_run->mmio.data,
+			       vcpu->mmio_read_len);
+		}
+		resume_data[1] = GUNYAH_ADDRSPACE_VMMIO_ACTION_EMULATE;
+		break;
+	case GUNYAH_VCPU_RESUME_FAULT:
+		resume_data[1] = GUNYAH_ADDRSPACE_VMMIO_ACTION_FAULT;
+		break;
+	case GUNYAH_VCPU_RESUME_RETRY:
+		resume_data[1] = GUNYAH_ADDRSPACE_VMMIO_ACTION_RETRY;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gunyah_vcpu_rm_notification(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct gunyah_vcpu *vcpu = container_of(nb, struct gunyah_vcpu, nb);
+	struct gunyah_rm_vm_exited_payload *exit_payload = data;
+
+	/* Wake up userspace waiting for the vCPU to be runnable again */
+	if (action == GUNYAH_RM_NOTIFICATION_VM_EXITED &&
+	    le16_to_cpu(exit_payload->vmid) == vcpu->ghvm->vmid)
+		complete(&vcpu->ready);
+
+	return NOTIFY_OK;
+}
+
+static inline enum gunyah_vm_status
+remap_vm_status(enum gunyah_rm_vm_status rm_status)
+{
+	switch (rm_status) {
+	case GUNYAH_RM_VM_STATUS_INIT_FAILED:
+		return GUNYAH_VM_STATUS_LOAD_FAILED;
+	case GUNYAH_RM_VM_STATUS_EXITED:
+		return GUNYAH_VM_STATUS_EXITED;
+	default:
+		return GUNYAH_VM_STATUS_CRASHED;
+	}
+}
+
+/**
+ * gunyah_vcpu_check_system() - Check whether VM as a whole is running
+ * @vcpu: Pointer to gunyah_vcpu
+ *
+ * Returns true if the VM is alive.
+ * Returns false if the vCPU is the VM is not alive (can only be that VM is shutting down).
+ */
+static bool gunyah_vcpu_check_system(struct gunyah_vcpu *vcpu)
+	__must_hold(&vcpu->run_lock)
+{
+	bool ret = true;
+
+	down_read(&vcpu->ghvm->status_lock);
+	if (likely(vcpu->ghvm->vm_status == GUNYAH_RM_VM_STATUS_RUNNING))
+		goto out;
+
+	vcpu->vcpu_run->status.status = remap_vm_status(vcpu->ghvm->vm_status);
+	vcpu->vcpu_run->status.exit_info = vcpu->ghvm->exit_info;
+	vcpu->vcpu_run->exit_reason = GUNYAH_VCPU_EXIT_STATUS;
+	vcpu->state = GUNYAH_VCPU_RUN_STATE_SYSTEM_DOWN;
+	ret = false;
+out:
+	up_read(&vcpu->ghvm->status_lock);
+	return ret;
+}
+
+/**
+ * gunyah_vcpu_run() - Request Gunyah to begin scheduling this vCPU.
+ * @vcpu: The client descriptor that was obtained via gunyah_vcpu_alloc()
+ */
+static int gunyah_vcpu_run(struct gunyah_vcpu *vcpu)
+{
+	struct gunyah_hypercall_vcpu_run_resp vcpu_run_resp;
+	unsigned long resume_data[3] = { 0 };
+	enum gunyah_error gunyah_error;
+	int ret = 0;
+
+	if (!vcpu->f)
+		return -ENODEV;
+
+	if (mutex_lock_interruptible(&vcpu->run_lock))
+		return -ERESTARTSYS;
+
+	if (!vcpu->rsc) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	switch (vcpu->state) {
+	case GUNYAH_VCPU_RUN_STATE_UNKNOWN:
+		if (vcpu->ghvm->vm_status != GUNYAH_RM_VM_STATUS_RUNNING) {
+			/**
+			 * Check if VM is up. If VM is starting, will block
+			 * until VM is fully up since that thread does
+			 * down_write.
+			 */
+			if (!gunyah_vcpu_check_system(vcpu))
+				goto out;
+		}
+		vcpu->state = GUNYAH_VCPU_RUN_STATE_READY;
+		break;
+	case GUNYAH_VCPU_RUN_STATE_MMIO_READ:
+	case GUNYAH_VCPU_RUN_STATE_MMIO_WRITE:
+		ret = gunyah_handle_mmio_resume(vcpu, resume_data);
+		if (ret)
+			goto out;
+		vcpu->state = GUNYAH_VCPU_RUN_STATE_READY;
+		break;
+	case GUNYAH_VCPU_RUN_STATE_SYSTEM_DOWN:
+		goto out;
+	default:
+		break;
+	}
+
+	while (!ret && !signal_pending(current)) {
+		if (vcpu->vcpu_run->immediate_exit) {
+			ret = -EINTR;
+			goto out;
+		}
+
+		gunyah_error = gunyah_hypercall_vcpu_run(
+			vcpu->rsc->capid, resume_data, &vcpu_run_resp);
+		if (gunyah_error == GUNYAH_ERROR_OK) {
+			memset(resume_data, 0, sizeof(resume_data));
+			switch (vcpu_run_resp.state) {
+			case GUNYAH_VCPU_STATE_READY:
+				if (need_resched())
+					schedule();
+				break;
+			case GUNYAH_VCPU_STATE_POWERED_OFF:
+				/**
+				 * vcpu might be off because the VM is shut down
+				 * If so, it won't ever run again
+				 */
+				if (!gunyah_vcpu_check_system(vcpu))
+					goto out;
+				/**
+				 * Otherwise, another vcpu will turn it on (e.g.
+				 * by PSCI) and hyp sends an interrupt to wake
+				 * Linux up.
+				 */
+				fallthrough;
+			case GUNYAH_VCPU_STATE_EXPECTS_WAKEUP:
+				ret = wait_for_completion_interruptible(
+					&vcpu->ready);
+				/**
+				 * reinitialize completion before next
+				 * hypercall. If we reinitialize after the
+				 * hypercall, interrupt may have already come
+				 * before re-initializing the completion and
+				 * then end up waiting for event that already
+				 * happened.
+				 */
+				reinit_completion(&vcpu->ready);
+				/**
+				 * Check VM status again. Completion
+				 * might've come from VM exiting
+				 */
+				if (!ret && !gunyah_vcpu_check_system(vcpu))
+					goto out;
+				break;
+			case GUNYAH_VCPU_STATE_BLOCKED:
+				schedule();
+				break;
+			case GUNYAH_VCPU_ADDRSPACE_VMMIO_READ:
+			case GUNYAH_VCPU_ADDRSPACE_VMMIO_WRITE:
+				gunyah_handle_mmio(vcpu, &vcpu_run_resp);
+				goto out;
+			case GUNYAH_VCPU_ADDRSPACE_PAGE_FAULT:
+				gunyah_handle_page_fault(vcpu, &vcpu_run_resp);
+				goto out;
+			default:
+				pr_warn_ratelimited(
+					"Unknown vCPU state: %llx\n",
+					vcpu_run_resp.sized_state);
+				schedule();
+				break;
+			}
+		} else if (gunyah_error == GUNYAH_ERROR_RETRY) {
+			schedule();
+		} else {
+			ret = gunyah_error_remap(gunyah_error);
+		}
+	}
+
+out:
+	mutex_unlock(&vcpu->run_lock);
+
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	return ret;
+}
+
+static long gunyah_vcpu_ioctl(struct file *filp, unsigned int cmd,
+			      unsigned long arg)
+{
+	struct gunyah_vcpu *vcpu = filp->private_data;
+	long ret = -ENOTTY;
+
+	switch (cmd) {
+	case GUNYAH_VCPU_RUN:
+		ret = gunyah_vcpu_run(vcpu);
+		break;
+	case GUNYAH_VCPU_MMAP_SIZE:
+		ret = PAGE_SIZE;
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static int gunyah_vcpu_release(struct inode *inode, struct file *filp)
+{
+	struct gunyah_vcpu *vcpu = filp->private_data;
+
+	gunyah_vm_put(vcpu->ghvm);
+	kref_put(&vcpu->kref, vcpu_release);
+	return 0;
+}
+
+static vm_fault_t gunyah_vcpu_fault(struct vm_fault *vmf)
+{
+	struct gunyah_vcpu *vcpu = vmf->vma->vm_file->private_data;
+	struct page *page = NULL;
+
+	if (vmf->pgoff == 0)
+		page = virt_to_page(vcpu->vcpu_run);
+
+	get_page(page);
+	vmf->page = page;
+	return 0;
+}
+
+static const struct vm_operations_struct gunyah_vcpu_ops = {
+	.fault = gunyah_vcpu_fault,
+};
+
+static int gunyah_vcpu_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	vma->vm_ops = &gunyah_vcpu_ops;
+	return 0;
+}
+
+static const struct file_operations gunyah_vcpu_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = gunyah_vcpu_ioctl,
+	.release = gunyah_vcpu_release,
+	.llseek = noop_llseek,
+	.mmap = gunyah_vcpu_mmap,
+};
+
+static bool gunyah_vcpu_populate(struct gunyah_vm_resource_ticket *ticket,
+				 struct gunyah_resource *ghrsc)
+{
+	struct gunyah_vcpu *vcpu =
+		container_of(ticket, struct gunyah_vcpu, ticket);
+	int ret;
+
+	mutex_lock(&vcpu->run_lock);
+	if (vcpu->rsc) {
+		pr_warn("vcpu%d already got a Gunyah resource. Check if multiple resources with same label were configured.\n",
+			vcpu->ticket.label);
+		ret = -EEXIST;
+		goto out;
+	}
+
+	vcpu->rsc = ghrsc;
+	init_completion(&vcpu->ready);
+
+	ret = request_irq(vcpu->rsc->irq, gunyah_vcpu_irq_handler,
+			  IRQF_TRIGGER_RISING, "gunyah_vcpu", vcpu);
+	if (ret)
+		pr_warn("Failed to request vcpu irq %d: %d", vcpu->rsc->irq,
+			ret);
+
+	enable_irq_wake(vcpu->rsc->irq);
+
+out:
+	mutex_unlock(&vcpu->run_lock);
+	return !ret;
+}
+
+static void gunyah_vcpu_unpopulate(struct gunyah_vm_resource_ticket *ticket,
+				   struct gunyah_resource *ghrsc)
+{
+	struct gunyah_vcpu *vcpu =
+		container_of(ticket, struct gunyah_vcpu, ticket);
+
+	vcpu->vcpu_run->immediate_exit = true;
+	complete_all(&vcpu->ready);
+	mutex_lock(&vcpu->run_lock);
+	free_irq(vcpu->rsc->irq, vcpu);
+	vcpu->rsc = NULL;
+	mutex_unlock(&vcpu->run_lock);
+}
+
+static long gunyah_vcpu_bind(struct gunyah_vm_function_instance *f)
+{
+	struct gunyah_fn_vcpu_arg *arg = f->argp;
+	struct gunyah_vcpu *vcpu;
+	char name[MAX_VCPU_NAME];
+	struct file *file;
+	struct page *page;
+	int fd;
+	long r;
+
+	if (f->arg_size != sizeof(*arg))
+		return -EINVAL;
+
+	vcpu = kzalloc(sizeof(*vcpu), GFP_KERNEL);
+	if (!vcpu)
+		return -ENOMEM;
+
+	vcpu->f = f;
+	f->data = vcpu;
+	mutex_init(&vcpu->run_lock);
+	kref_init(&vcpu->kref);
+
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page) {
+		r = -ENOMEM;
+		goto err_destroy_vcpu;
+	}
+	vcpu->vcpu_run = page_address(page);
+
+	vcpu->ticket.resource_type = GUNYAH_RESOURCE_TYPE_VCPU;
+	vcpu->ticket.label = arg->id;
+	vcpu->ticket.owner = THIS_MODULE;
+	vcpu->ticket.populate = gunyah_vcpu_populate;
+	vcpu->ticket.unpopulate = gunyah_vcpu_unpopulate;
+
+	r = gunyah_vm_add_resource_ticket(f->ghvm, &vcpu->ticket);
+	if (r)
+		goto err_destroy_page;
+
+	if (!gunyah_vm_get(f->ghvm)) {
+		r = -ENODEV;
+		goto err_remove_resource_ticket;
+	}
+	vcpu->ghvm = f->ghvm;
+
+	vcpu->nb.notifier_call = gunyah_vcpu_rm_notification;
+	/**
+	 * Ensure we run after the vm_mgr handles the notification and does
+	 * any necessary state changes.
+	 */
+	vcpu->nb.priority = -1;
+	r = gunyah_rm_notifier_register(f->rm, &vcpu->nb);
+	if (r)
+		goto err_put_gunyah_vm;
+
+	kref_get(&vcpu->kref);
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		r = fd;
+		goto err_notifier;
+	}
+
+	snprintf(name, sizeof(name), "gh-vcpu:%u", vcpu->ticket.label);
+	file = anon_inode_getfile(name, &gunyah_vcpu_fops, vcpu, O_RDWR);
+	if (IS_ERR(file)) {
+		r = PTR_ERR(file);
+		goto err_put_fd;
+	}
+
+	fd_install(fd, file);
+
+	return fd;
+err_put_fd:
+	put_unused_fd(fd);
+err_notifier:
+	gunyah_rm_notifier_unregister(f->rm, &vcpu->nb);
+err_put_gunyah_vm:
+	gunyah_vm_put(vcpu->ghvm);
+err_remove_resource_ticket:
+	gunyah_vm_remove_resource_ticket(f->ghvm, &vcpu->ticket);
+err_destroy_page:
+	free_page((unsigned long)vcpu->vcpu_run);
+err_destroy_vcpu:
+	kfree(vcpu);
+	return r;
+}
+
+static void gunyah_vcpu_unbind(struct gunyah_vm_function_instance *f)
+{
+	struct gunyah_vcpu *vcpu = f->data;
+
+	gunyah_rm_notifier_unregister(f->rm, &vcpu->nb);
+	gunyah_vm_remove_resource_ticket(vcpu->ghvm, &vcpu->ticket);
+	vcpu->f = NULL;
+
+	kref_put(&vcpu->kref, vcpu_release);
+}
+
+static bool gunyah_vcpu_compare(const struct gunyah_vm_function_instance *f,
+				const void *arg, size_t size)
+{
+	const struct gunyah_fn_vcpu_arg *instance = f->argp, *other = arg;
+
+	if (sizeof(*other) != size)
+		return false;
+
+	return instance->id == other->id;
+}
+
+DECLARE_GUNYAH_VM_FUNCTION_INIT(vcpu, GUNYAH_FN_VCPU, 1, gunyah_vcpu_bind,
+				gunyah_vcpu_unbind, gunyah_vcpu_compare);
+MODULE_DESCRIPTION("Gunyah vCPU Function");
+MODULE_LICENSE("GPL");
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 5d4f413f7a76..db3d1d18ccb8 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -302,6 +302,11 @@ static int gunyah_vm_rm_notification_exited(struct gunyah_vm *ghvm, void *data)
 
 	down_write(&ghvm->status_lock);
 	ghvm->vm_status = GUNYAH_RM_VM_STATUS_EXITED;
+	ghvm->exit_info.type = le16_to_cpu(payload->exit_type);
+	ghvm->exit_info.reason_size = le32_to_cpu(payload->exit_reason_size);
+	memcpy(&ghvm->exit_info.reason, payload->exit_reason,
+	       min(GUNYAH_VM_MAX_EXIT_REASON_SIZE,
+		   ghvm->exit_info.reason_size));
 	up_write(&ghvm->status_lock);
 	wake_up(&ghvm->vm_status_wait);
 
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 190a95ee8da6..8c5b94101b2c 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -28,6 +28,7 @@ long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
  * @vm_status: Current state of the VM, as last reported by RM
  * @vm_status_wait: Wait queue for status @vm_status changes
  * @status_lock: Serializing state transitions
+ * @exit_info: Breadcrumbs why VM is not running anymore
  * @kref: Reference counter for VM functions
  * @fn_lock: Serialization addition of functions
  * @functions: List of &struct gunyah_vm_function_instance that have been
@@ -48,6 +49,7 @@ struct gunyah_vm {
 	enum gunyah_rm_vm_status vm_status;
 	wait_queue_head_t vm_status_wait;
 	struct rw_semaphore status_lock;
+	struct gunyah_vm_exit_info exit_info;
 
 	struct kref kref;
 	struct mutex fn_lock;
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index 1b7cb5fde70a..46f7d3aa61d0 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -25,8 +25,33 @@
  */
 #define GUNYAH_VM_START		_IO(GUNYAH_IOCTL_TYPE, 0x3)
 
+/**
+ * enum gunyah_fn_type - Valid types of Gunyah VM functions
+ * @GUNYAH_FN_VCPU: create a vCPU instance to control a vCPU
+ *              &struct gunyah_fn_desc.arg is a pointer to &struct gunyah_fn_vcpu_arg
+ *              Return: file descriptor to manipulate the vcpu.
+ */
+enum gunyah_fn_type {
+	GUNYAH_FN_VCPU = 1,
+};
+
 #define GUNYAH_FN_MAX_ARG_SIZE		256
 
+/**
+ * struct gunyah_fn_vcpu_arg - Arguments to create a vCPU.
+ * @id: vcpu id
+ *
+ * Create this function with &GUNYAH_VM_ADD_FUNCTION using type &GUNYAH_FN_VCPU.
+ *
+ * The vcpu type will register with the VM Manager to expect to control
+ * vCPU number `vcpu_id`. It returns a file descriptor allowing interaction with
+ * the vCPU. See the Gunyah vCPU API description sections for interacting with
+ * the Gunyah vCPU file descriptors.
+ */
+struct gunyah_fn_vcpu_arg {
+	__u32 id;
+};
+
 /**
  * struct gunyah_fn_desc - Arguments to create a VM function
  * @type: Type of the function. See &enum gunyah_fn_type.
@@ -43,4 +68,142 @@ struct gunyah_fn_desc {
 #define GUNYAH_VM_ADD_FUNCTION	_IOW(GUNYAH_IOCTL_TYPE, 0x4, struct gunyah_fn_desc)
 #define GUNYAH_VM_REMOVE_FUNCTION	_IOW(GUNYAH_IOCTL_TYPE, 0x7, struct gunyah_fn_desc)
 
+/*
+ * ioctls for vCPU fds
+ */
+
+/**
+ * enum gunyah_vm_status - Stores status reason why VM is not runnable (exited).
+ * @GUNYAH_VM_STATUS_LOAD_FAILED: VM didn't start because it couldn't be loaded.
+ * @GUNYAH_VM_STATUS_EXITED: VM requested shutdown/reboot.
+ *                       Use &struct gunyah_vm_exit_info.reason for further details.
+ * @GUNYAH_VM_STATUS_CRASHED: VM state is unknown and has crashed.
+ */
+enum gunyah_vm_status {
+	GUNYAH_VM_STATUS_LOAD_FAILED	= 1,
+	GUNYAH_VM_STATUS_EXITED		= 2,
+	GUNYAH_VM_STATUS_CRASHED		= 3,
+};
+
+/*
+ * Gunyah presently sends max 4 bytes of exit_reason.
+ * If that changes, this macro can be safely increased without breaking
+ * userspace so long as struct gunyah_vcpu_run < PAGE_SIZE.
+ */
+#define GUNYAH_VM_MAX_EXIT_REASON_SIZE	8u
+
+/**
+ * struct gunyah_vm_exit_info - Reason for VM exit as reported by Gunyah
+ * See Gunyah documentation for values.
+ * @type: Describes how VM exited
+ * @padding: padding bytes
+ * @reason_size: Number of bytes valid for `reason`
+ * @reason: See Gunyah documentation for interpretation. Note: these values are
+ *          not interpreted by Linux and need to be converted from little-endian
+ *          as applicable.
+ */
+struct gunyah_vm_exit_info {
+	__u16 type;
+	__u16 padding;
+	__u32 reason_size;
+	__u8 reason[GUNYAH_VM_MAX_EXIT_REASON_SIZE];
+};
+
+/**
+ * enum gunyah_vcpu_exit - Stores reason why &GUNYAH_VCPU_RUN ioctl recently exited with status 0
+ * @GUNYAH_VCPU_EXIT_UNKNOWN: Not used, status != 0
+ * @GUNYAH_VCPU_EXIT_MMIO: vCPU performed a read or write that could not be handled
+ *                     by hypervisor or Linux. Use @struct gunyah_vcpu_run.mmio for
+ *                     details of the read/write.
+ * @GUNYAH_VCPU_EXIT_STATUS: vCPU not able to run because the VM has exited.
+ *                       Use @struct gunyah_vcpu_run.status for why VM has exited.
+ * @GUNYAH_VCPU_EXIT_PAGE_FAULT: vCPU tried to execute an instruction at an address
+ *                               for which memory hasn't been provided. Use
+ *                               @struct gunyah_vcpu_run.page_fault for details.
+ */
+enum gunyah_vcpu_exit {
+	GUNYAH_VCPU_EXIT_UNKNOWN,
+	GUNYAH_VCPU_EXIT_MMIO,
+	GUNYAH_VCPU_EXIT_STATUS,
+	GUNYAH_VCPU_EXIT_PAGE_FAULT,
+};
+
+/**
+ * enum gunyah_vcpu_resume_action - Provide resume action after an MMIO or page fault
+ * @GUNYAH_VCPU_RESUME_HANDLED: The mmio or page fault has been handled, continue
+ *                              normal operation of vCPU
+ * @GUNYAH_VCPU_RESUME_FAULT: The mmio or page fault could not be satisfied and
+ *                            inject the original fault back to the guest.
+ * @GUNYAH_VCPU_RESUME_RETRY: Retry the faulting instruction. Perhaps you added
+ *                            memory binding to satisfy the request.
+ */
+enum gunyah_vcpu_resume_action {
+	GUNYAH_VCPU_RESUME_HANDLED = 0,
+	GUNYAH_VCPU_RESUME_FAULT,
+	GUNYAH_VCPU_RESUME_RETRY,
+};
+
+/**
+ * struct gunyah_vcpu_run - Application code obtains a pointer to the gunyah_vcpu_run
+ *                      structure by mmap()ing a vcpu fd.
+ * @immediate_exit: polled when scheduling the vcpu. If set, immediately returns -EINTR.
+ * @padding: padding bytes
+ * @exit_reason: Set when GUNYAH_VCPU_RUN returns successfully and gives reason why
+ *               GUNYAH_VCPU_RUN has stopped running the vCPU. See &enum gunyah_vcpu_exit.
+ * @mmio: Used when exit_reason == GUNYAH_VCPU_EXIT_MMIO
+ *        The guest has faulted on an memory-mapped I/O that
+ *        couldn't be satisfied by gunyah.
+ * @mmio.phys_addr: Address guest tried to access
+ * @mmio.data: the value that was written if `is_write == 1`. Filled by
+ *        user for reads (`is_write == 0`).
+ * @mmio.len: Length of write. Only the first `len` bytes of `data`
+ *       are considered by Gunyah.
+ * @mmio.is_write: 1 if VM tried to perform a write, 0 for a read
+ * @mmio.resume_action: See &enum gunyah_vcpu_resume_action
+ * @status: Used when exit_reason == GUNYAH_VCPU_EXIT_STATUS.
+ *          The guest VM is no longer runnable. This struct informs why.
+ * @status.status: See &enum gunyah_vm_status for possible values
+ * @status.exit_info: Used when status == GUNYAH_VM_STATUS_EXITED
+ * @page_fault: Used when EXIT_REASON == GUNYAH_VCPU_EXIT_PAGE_FAULT
+ *              The guest has faulted on a region that can only be provided
+ *              by mapping memory at phys_addr.
+ * @page_fault.phys_addr: Address guest tried to access.
+ * @page_fault.attempt: Error code why Linux wasn't able to handle fault itself
+ *                      Typically, if no memory was mapped: -ENOENT,
+ *                      If permission bits weren't what the VM wanted: -EPERM
+ * @page_fault.resume_action: See &enum gunyah_vcpu_resume_action
+ */
+struct gunyah_vcpu_run {
+	/* in */
+	__u8 immediate_exit;
+	__u8 padding[7];
+
+	/* out */
+	__u32 exit_reason;
+
+	union {
+		struct {
+			__u64 phys_addr;
+			__u8  data[8];
+			__u32 len;
+			__u8  is_write;
+			__u8  resume_action;
+		} mmio;
+
+		struct {
+			enum gunyah_vm_status status;
+			struct gunyah_vm_exit_info exit_info;
+		} status;
+
+		struct {
+			__u64 phys_addr;
+			__s32 attempt;
+			__u8  resume_action;
+		} page_fault;
+	};
+};
+
+#define GUNYAH_VCPU_RUN		_IO(GUNYAH_IOCTL_TYPE, 0x5)
+#define GUNYAH_VCPU_MMAP_SIZE	_IO(GUNYAH_IOCTL_TYPE, 0x6)
+
 #endif

-- 
2.34.1


