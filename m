Return-Path: <linux-kernel+bounces-77520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CA78606BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2555B1C22D96
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDF720DE7;
	Thu, 22 Feb 2024 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Yc5tWIN0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85886137918;
	Thu, 22 Feb 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643840; cv=none; b=il4xYhJwFYgq3VRUMiW7D7+9sk4CfhaI4Awfso8YQtgIz1d6J0T/Vm4xAn3rKnFEMswlEPtEVaEdeDP3xuZ+/sdbjSySeYSkRRJ8lIBZKhqaqEb59LkNoZdHhPNHiPKUFAtfSlGB1Jjxxs2VJOspbZbzumCLMOqPH7HakjVM1v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643840; c=relaxed/simple;
	bh=gC0xDumMxaBGvIreifjg3ktpJC4Rx3Ne3pILcMxYLaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=abNdCflQECmB7T5jhqL+woS4iu7iBoMnKqE0QmmEEUbbK8nkAx3TrBTYM0i84LNzHe0NpSN3I/Gs2eaWq2sEtENI/LRpBSRYBB60OoWf89jPgFl1H3SQGwTRf5ZDr4Iy0wzI+klLiR94BJEdy8GGixoQYu/a/f8AtVmcxEdcl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Yc5tWIN0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MM8tRX031789;
	Thu, 22 Feb 2024 23:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=AqRBgoMwHFsPe/avimmGMJYvOaG0LLtyLOSPpj0/UN8
	=; b=Yc5tWIN0NHTjsiZi2As3t+YMG7By+G8XHo92TtZMZ2M87GrIBSJf72yTmsZ
	EUkpMVMsBhHSduA389li2zXF6nDfjHgt0vTTbFoUVOJDHpx/KufnueEnGomhWhRL
	55OkbxVqaQBDRuO9HNWCaiWaXISNjktsOqsOJKHNDwl15NPzXPho7CDk7b7xcAIe
	Bsl26IAPp9xzVoeAQlaMBIQFtpdlD32Fd/KQxWLDaYsDKkHzlmahxrKE6xz03ORs
	9NbtXXkBcpeSj8NSpr57I5Aio5thfqK/KGd1iuUIzkSkv7nd6A5uE0VwyDAPVuee
	+JSolBMh7XxdkHXpvZjpKjLSwtQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wea7csc2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGXCk018212
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:33 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:32 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:33 -0800
Subject: [PATCH v17 10/35] gunyah: vm_mgr: Add VM start/stop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-10-1e9da6763d38@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
In-Reply-To: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
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
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W4enkRgvHYvXwGyGPHcTI81Bm4TEY0_P
X-Proofpoint-GUID: W4enkRgvHYvXwGyGPHcTI81Bm4TEY0_P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220179

Add ioctl to trigger the start of a Gunyah virtual machine. Subsequent
commits will provide memory to the virtual machine and add ability to
interact with the resources (capabilities) of the virtual machine.
Although start of the virtual machine can be done implicitly on the
first vCPU run for proxy-schedule virtual machines, there is a
non-trivial number of calls to Gunyah: a more precise error can be given
to userspace which calls VM_START without looking at kernel logs because
userspace can detect that the VM start failed instead of "couldn't run
the vCPU".

Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c | 198 +++++++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h |  19 +++++
 include/uapi/linux/gunyah.h  |   5 ++
 3 files changed, 222 insertions(+)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index e9dff733e35ef..364a53cad643e 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -15,6 +15,68 @@
 #include "rsc_mgr.h"
 #include "vm_mgr.h"
 
+static int gunyah_vm_rm_notification_status(struct gunyah_vm *ghvm, void *data)
+{
+	struct gunyah_rm_vm_status_payload *payload = data;
+
+	if (le16_to_cpu(payload->vmid) != ghvm->vmid)
+		return NOTIFY_OK;
+
+	/* All other state transitions are synchronous to a corresponding RM call */
+	if (payload->vm_status == GUNYAH_RM_VM_STATUS_RESET) {
+		down_write(&ghvm->status_lock);
+		ghvm->vm_status = payload->vm_status;
+		up_write(&ghvm->status_lock);
+		wake_up(&ghvm->vm_status_wait);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int gunyah_vm_rm_notification_exited(struct gunyah_vm *ghvm, void *data)
+{
+	struct gunyah_rm_vm_exited_payload *payload = data;
+
+	if (le16_to_cpu(payload->vmid) != ghvm->vmid)
+		return NOTIFY_OK;
+
+	down_write(&ghvm->status_lock);
+	ghvm->vm_status = GUNYAH_RM_VM_STATUS_EXITED;
+	up_write(&ghvm->status_lock);
+	wake_up(&ghvm->vm_status_wait);
+
+	return NOTIFY_DONE;
+}
+
+static int gunyah_vm_rm_notification(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct gunyah_vm *ghvm = container_of(nb, struct gunyah_vm, nb);
+
+	switch (action) {
+	case GUNYAH_RM_NOTIFICATION_VM_STATUS:
+		return gunyah_vm_rm_notification_status(ghvm, data);
+	case GUNYAH_RM_NOTIFICATION_VM_EXITED:
+		return gunyah_vm_rm_notification_exited(ghvm, data);
+	default:
+		return NOTIFY_OK;
+	}
+}
+
+static void gunyah_vm_stop(struct gunyah_vm *ghvm)
+{
+	int ret;
+
+	if (ghvm->vm_status == GUNYAH_RM_VM_STATUS_RUNNING) {
+		ret = gunyah_rm_vm_stop(ghvm->rm, ghvm->vmid);
+		if (ret)
+			dev_warn(ghvm->parent, "Failed to stop VM: %d\n", ret);
+	}
+
+	wait_event(ghvm->vm_status_wait,
+		   ghvm->vm_status != GUNYAH_RM_VM_STATUS_RUNNING);
+}
+
 static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 {
 	struct gunyah_vm *ghvm;
@@ -24,14 +86,148 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 		return ERR_PTR(-ENOMEM);
 
 	ghvm->parent = gunyah_rm_get(rm);
+	ghvm->vmid = GUNYAH_VMID_INVAL;
 	ghvm->rm = rm;
 
+	init_rwsem(&ghvm->status_lock);
+	init_waitqueue_head(&ghvm->vm_status_wait);
+	ghvm->vm_status = GUNYAH_RM_VM_STATUS_NO_STATE;
+
 	return ghvm;
 }
 
+static int gunyah_vm_start(struct gunyah_vm *ghvm)
+{
+	int ret;
+
+	down_write(&ghvm->status_lock);
+	if (ghvm->vm_status != GUNYAH_RM_VM_STATUS_NO_STATE) {
+		up_write(&ghvm->status_lock);
+		return 0;
+	}
+
+	ghvm->nb.notifier_call = gunyah_vm_rm_notification;
+	ret = gunyah_rm_notifier_register(ghvm->rm, &ghvm->nb);
+	if (ret)
+		goto err;
+
+	ret = gunyah_rm_alloc_vmid(ghvm->rm, 0);
+	if (ret < 0) {
+		gunyah_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
+		goto err;
+	}
+	ghvm->vmid = ret;
+	ghvm->vm_status = GUNYAH_RM_VM_STATUS_LOAD;
+
+	ret = gunyah_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth, 0, 0, 0,
+				     0, 0);
+	if (ret) {
+		dev_warn(ghvm->parent, "Failed to configure VM: %d\n", ret);
+		goto err;
+	}
+
+	ret = gunyah_rm_vm_init(ghvm->rm, ghvm->vmid);
+	if (ret) {
+		ghvm->vm_status = GUNYAH_RM_VM_STATUS_INIT_FAILED;
+		dev_warn(ghvm->parent, "Failed to initialize VM: %d\n", ret);
+		goto err;
+	}
+	ghvm->vm_status = GUNYAH_RM_VM_STATUS_READY;
+
+	ret = gunyah_rm_vm_start(ghvm->rm, ghvm->vmid);
+	if (ret) {
+		dev_warn(ghvm->parent, "Failed to start VM: %d\n", ret);
+		goto err;
+	}
+
+	ghvm->vm_status = GUNYAH_RM_VM_STATUS_RUNNING;
+	up_write(&ghvm->status_lock);
+	return ret;
+err:
+	/* gunyah_vm_free will handle releasing resources and reclaiming memory */
+	up_write(&ghvm->status_lock);
+	return ret;
+}
+
+static int gunyah_vm_ensure_started(struct gunyah_vm *ghvm)
+{
+	int ret;
+
+	ret = down_read_interruptible(&ghvm->status_lock);
+	if (ret)
+		return ret;
+
+	/* Unlikely because VM is typically started */
+	if (unlikely(ghvm->vm_status == GUNYAH_RM_VM_STATUS_NO_STATE)) {
+		up_read(&ghvm->status_lock);
+		ret = gunyah_vm_start(ghvm);
+		if (ret)
+			return ret;
+		ret = down_read_interruptible(&ghvm->status_lock);
+		if (ret)
+			return ret;
+	}
+
+	/* Unlikely because VM is typically running */
+	if (unlikely(ghvm->vm_status != GUNYAH_RM_VM_STATUS_RUNNING))
+		ret = -ENODEV;
+
+	up_read(&ghvm->status_lock);
+	return ret;
+}
+
+static long gunyah_vm_ioctl(struct file *filp, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct gunyah_vm *ghvm = filp->private_data;
+	long r;
+
+	switch (cmd) {
+	case GUNYAH_VM_START: {
+		r = gunyah_vm_ensure_started(ghvm);
+		break;
+	}
+	default:
+		r = -ENOTTY;
+		break;
+	}
+
+	return r;
+}
+
 static int gunyah_vm_release(struct inode *inode, struct file *filp)
 {
 	struct gunyah_vm *ghvm = filp->private_data;
+	int ret;
+
+	/**
+	 * We might race with a VM exit notification, but that's ok:
+	 * gh_rm_vm_stop() will just return right away.
+	 */
+	if (ghvm->vm_status == GUNYAH_RM_VM_STATUS_RUNNING)
+		gunyah_vm_stop(ghvm);
+
+	if (ghvm->vm_status == GUNYAH_RM_VM_STATUS_EXITED ||
+	    ghvm->vm_status == GUNYAH_RM_VM_STATUS_READY ||
+	    ghvm->vm_status == GUNYAH_RM_VM_STATUS_INIT_FAILED) {
+		ret = gunyah_rm_vm_reset(ghvm->rm, ghvm->vmid);
+		/* clang-format off */
+		if (!ret)
+			wait_event(ghvm->vm_status_wait,
+				   ghvm->vm_status == GUNYAH_RM_VM_STATUS_RESET);
+		else
+			dev_err(ghvm->parent, "Failed to reset the vm: %d\n",ret);
+		/* clang-format on */
+	}
+
+	if (ghvm->vm_status > GUNYAH_RM_VM_STATUS_NO_STATE) {
+		gunyah_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
+
+		ret = gunyah_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
+		if (ret)
+			dev_warn(ghvm->parent,
+				 "Failed to deallocate vmid: %d\n", ret);
+	}
 
 	gunyah_rm_put(ghvm->rm);
 	kfree(ghvm);
@@ -40,6 +236,8 @@ static int gunyah_vm_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations gunyah_vm_fops = {
 	.owner = THIS_MODULE,
+	.unlocked_ioctl = gunyah_vm_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.release = gunyah_vm_release,
 	.llseek = noop_llseek,
 };
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 50790d4026765..e6cc9aead0b67 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -7,6 +7,8 @@
 #define _GUNYAH_VM_MGR_PRIV_H
 
 #include <linux/device.h>
+#include <linux/rwsem.h>
+#include <linux/wait.h>
 
 #include <uapi/linux/gunyah.h>
 
@@ -17,12 +19,29 @@ long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
 
 /**
  * struct gunyah_vm - Main representation of a Gunyah Virtual machine
+ * @vmid: Gunyah's VMID for this virtual machine
  * @rm: Pointer to the resource manager struct to make RM calls
  * @parent: For logging
+ * @nb: Notifier block for RM notifications
+ * @vm_status: Current state of the VM, as last reported by RM
+ * @vm_status_wait: Wait queue for status @vm_status changes
+ * @status_lock: Serializing state transitions
+ * @auth: Authentication mechanism to be used by resource manager when
+ *        launching the VM
+ *
+ * Members are grouped by hot path.
  */
 struct gunyah_vm {
+	u16 vmid;
 	struct gunyah_rm *rm;
+
+	struct notifier_block nb;
+	enum gunyah_rm_vm_status vm_status;
+	wait_queue_head_t vm_status_wait;
+	struct rw_semaphore status_lock;
+
 	struct device *parent;
+	enum gunyah_rm_vm_auth_mechanism auth;
 };
 
 #endif
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
index ac338ec4b85dd..31e7f79a6c398 100644
--- a/include/uapi/linux/gunyah.h
+++ b/include/uapi/linux/gunyah.h
@@ -20,4 +20,9 @@
  */
 #define GUNYAH_CREATE_VM _IO(GUNYAH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
 
+/*
+ * ioctls for gunyah-vm fds (returned by GUNYAH_CREATE_VM)
+ */
+#define GUNYAH_VM_START		_IO(GUNYAH_IOCTL_TYPE, 0x3)
+
 #endif

-- 
2.34.1


