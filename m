Return-Path: <linux-kernel+bounces-1894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B181556C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222FF1F257E7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7026B39AED;
	Sat, 16 Dec 2023 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E0uFamLU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43073527A;
	Sat, 16 Dec 2023 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFNnCBF026098;
	Sat, 16 Dec 2023 00:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=8a59vkuZ6on+rnqsHsk3e+kiU8WVcrEgmmuTlTWOVYI
	=; b=E0uFamLUPsT3I/kre60qY9ToAxwgwpsLkrdZZ1eXWaTIY5IAsytUo/d8ivG
	RP3EwL4vpR1KyNhN0KMmM9OfhsBD6rNxkibbihcJpRa/XUSRar3BX8+VrTdY7Lkh
	E20iCmx7zi7Xh97HwF0lcf8fVXNfXx4G9SA7BC1VdY6dpNyC8UYOetO1lweNegWi
	QHb3iIIV/qnlKyfffLhMN1gjoknGtTyV9e6Z6YXvfH/Ma6SqPt5dDpuZBwwPPT+V
	sbYPx5D6wj6EqLifngDz8lBd/ZIoBiHQKIYADplyUfpm6tNEPZkTsuQBSELtXROj
	MZW/QkCPxh3Qi4e+s0N0Ac3azbQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0vv9ghjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0LGVS015677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:15 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:21:06 -0800
Subject: [PATCH RFC v15 25/30] virt: gunyah: Enable demand paging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-25-192a5d872a30@quicinc.com>
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
X-Proofpoint-GUID: i9H9U3HfAXjviR2sQmCMSiM37QlrkT9J
X-Proofpoint-ORIG-GUID: i9H9U3HfAXjviR2sQmCMSiM37QlrkT9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=633 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312160001

Tell resource manager to enable demand paging and wire vCPU faults to
provide the backing folio when a guestmemfd is bound to the faulting
access.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/guest_memfd.c | 92 +++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/gunyah_vcpu.c | 39 ++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.c      | 17 ++++++++
 drivers/virt/gunyah/vm_mgr.h      |  3 ++
 include/linux/gunyah.h            |  2 +
 5 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/guest_memfd.c b/drivers/virt/gunyah/guest_memfd.c
index 419ed617bd0b..206ce51c9a7d 100644
--- a/drivers/virt/gunyah/guest_memfd.c
+++ b/drivers/virt/gunyah/guest_memfd.c
@@ -732,3 +732,95 @@ int gunyah_gmem_reclaim_parcel(struct gunyah_vm *ghvm,
 	up_read(&ghvm->mem_lock);
 	return 0;
 }
+
+int gunyah_gmem_setup_demand_paging(struct gunyah_vm *ghvm)
+{
+	struct gunyah_rm_mem_entry *entries;
+	struct gunyah_gmem_binding *b;
+	unsigned long index = 0;
+	u32 count = 0, i;
+	int ret = 0;
+
+	down_read(&ghvm->mem_lock);
+	mt_for_each(&ghvm->mem_layout, b, index, ULONG_MAX)
+		if (gunyah_guest_mem_is_lend(ghvm, b->flags))
+			count++;
+
+	if (!count)
+		goto out;
+
+	entries = kcalloc(count, sizeof(*entries), GFP_KERNEL);
+	if (!entries) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	index = i = 0;
+	mt_for_each(&ghvm->mem_layout, b, index, ULONG_MAX) {
+		if (!gunyah_guest_mem_is_lend(ghvm, b->flags))
+			continue;
+		entries[i].phys_addr = cpu_to_le64(gunyah_gfn_to_gpa(b->gfn));
+		entries[i].size = cpu_to_le64(b->nr << PAGE_SHIFT);
+		if (++i == count)
+			break;
+	}
+
+	ret = gunyah_rm_vm_set_demand_paging(ghvm->rm, ghvm->vmid, i, entries);
+	kfree(entries);
+out:
+	up_read(&ghvm->mem_lock);
+	return ret;
+}
+
+int gunyah_gmem_demand_page(struct gunyah_vm *ghvm, u64 gpa, bool write)
+{
+	unsigned long gfn = gunyah_gpa_to_gfn(gpa);
+	struct gunyah_gmem_binding *b;
+	struct folio *folio;
+	int ret;
+
+	down_read(&ghvm->mem_lock);
+	b = mtree_load(&ghvm->mem_layout, gfn);
+	if (!b) {
+		up_read(&ghvm->mem_lock);
+		return -ENOENT;
+	}
+
+	if (write && !(b->flags & GUNYAH_MEM_ALLOW_WRITE))
+		return -EPERM;
+
+	folio = gunyah_gmem_get_folio(b->inode, gunyah_gfn_to_off(b, gfn));
+	if (IS_ERR(folio)) {
+		up_read(&ghvm->mem_lock);
+		pr_err_ratelimited(
+			"Failed to obtain memory for guest addr %016llx: %ld\n",
+			gpa, PTR_ERR(folio));
+		return PTR_ERR(folio);
+	}
+
+	if (gunyah_guest_mem_is_lend(ghvm, b->flags) && folio_mapped(folio)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	gfn = gunyah_off_to_gfn(b, folio_index(folio));
+
+	ret = gunyah_vm_provide_folio(ghvm, folio, gfn,
+				      !gunyah_guest_mem_is_lend(ghvm, b->flags),
+				      !!(b->flags & GUNYAH_MEM_ALLOW_WRITE));
+	if (ret) {
+		pr_err_ratelimited(
+			"Failed to provide folio for guest addr: %016llx: %d\n",
+			gpa, ret);
+		goto out;
+	}
+
+	if (gunyah_guest_mem_is_lend(ghvm, b->flags))
+		folio_set_private(folio);
+out:
+	folio_unlock(folio);
+	folio_put(folio);
+	up_read(&ghvm->mem_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_gmem_demand_page);
diff --git a/drivers/virt/gunyah/gunyah_vcpu.c b/drivers/virt/gunyah/gunyah_vcpu.c
index aa40f5977cbf..1952a1797430 100644
--- a/drivers/virt/gunyah/gunyah_vcpu.c
+++ b/drivers/virt/gunyah/gunyah_vcpu.c
@@ -91,6 +91,29 @@ static irqreturn_t gunyah_vcpu_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static bool gunyah_handle_page_fault(
+	struct gunyah_vcpu *vcpu, u64 state_data[3],
+	const struct gunyah_hypercall_vcpu_run_resp *vcpu_run_resp)
+{
+	int ret = 0;
+	u64 addr = vcpu_run_resp->state_data[0];
+	bool write = !!vcpu_run_resp->state_data[1];
+
+	ret = gunyah_gmem_demand_page(vcpu->ghvm, addr, write);
+	if (ret) {
+		if (ret != -ENOENT)
+			pr_warn_ratelimited(
+				"Failed to provide guest address for: %08llx: %d\n",
+				addr, ret);
+
+		vcpu->vcpu_run->page_fault.resume_action = GUNYAH_VCPU_RESUME_FAULT;
+		vcpu->vcpu_run->page_fault.attempt = ret;
+		vcpu->vcpu_run->page_fault.phys_addr = addr;
+		vcpu->vcpu_run->exit_reason = GUNYAH_VCPU_EXIT_PAGE_FAULT;
+	}
+	return !!ret;
+}
+
 static bool
 gunyah_handle_mmio(struct gunyah_vcpu *vcpu, u64 state_data[3],
 		   const struct gunyah_hypercall_vcpu_run_resp *vcpu_run_resp)
@@ -103,6 +126,12 @@ gunyah_handle_mmio(struct gunyah_vcpu *vcpu, u64 state_data[3],
 	if (WARN_ON(len > sizeof(u64)))
 		len = sizeof(u64);
 
+	if (!gunyah_gmem_demand_page(vcpu->ghvm, addr,
+				     vcpu->vcpu_run->mmio.is_write)) {
+		state_data[1] = GUNYAH_ADDRSPACE_VMMIO_ACTION_RETRY;
+		return true;
+	}
+
 	if (vcpu_run_resp->state == GUNYAH_VCPU_ADDRSPACE_VMMIO_READ) {
 		vcpu->vcpu_run->mmio.is_write = 0;
 		/* Record that we need to give vCPU user's supplied value next gunyah_vcpu_run() */
@@ -120,7 +149,8 @@ gunyah_handle_mmio(struct gunyah_vcpu *vcpu, u64 state_data[3],
 		vcpu->state = GUNYAH_VCPU_MMIO_WRITE;
 	}
 
-	vcpu->vcpu_run->mmio.phys_addr = addr;
+	vcpu->vcpu_run->mmio.resume_action = 0;
+	vcpu->mmio_addr = vcpu->vcpu_run->mmio.phys_addr = addr;
 	vcpu->vcpu_run->mmio.len = len;
 	vcpu->vcpu_run->exit_reason = GUNYAH_VCPU_EXIT_MMIO;
 
@@ -144,6 +174,8 @@ static int gunyah_handle_mmio_resume(struct gunyah_vcpu *vcpu, u64 state_data[3]
 		state_data[1] = GUNYAH_ADDRSPACE_VMMIO_ACTION_FAULT;
 		break;
 	case GUNYAH_VCPU_RESUME_RETRY:
+		gunyah_gmem_demand_page(vcpu->ghvm, vcpu->mmio_addr,
+					vcpu->state == GUNYAH_VCPU_MMIO_WRITE);
 		state_data[1] = GUNYAH_ADDRSPACE_VMMIO_ACTION_RETRY;
 		break;
 	default:
@@ -300,6 +332,11 @@ static int gunyah_vcpu_run(struct gunyah_vcpu *vcpu)
 							&vcpu_run_resp))
 					goto out;
 				break;
+			case GUNYAH_VCPU_ADDRSPACE_PAGE_FAULT:
+				if (gunyah_handle_page_fault(vcpu, resume_data,
+							     &vcpu_run_resp))
+					goto out;
+				break;
 			default:
 				pr_warn_ratelimited(
 					"Unknown vCPU state: %llx\n",
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 8f8d962c9f8c..0bb2b6a461a5 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -653,6 +653,23 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
 		goto err;
 	}
 
+	ret = gunyah_gmem_setup_demand_paging(ghvm);
+	if (ret) {
+		dev_warn(ghvm->parent,
+			 "Failed to set up gmem demand paging: %d\n", ret);
+		goto err;
+	}
+
+	ret = gunyah_rm_vm_set_address_layout(
+		ghvm->rm, ghvm->vmid, GUNYAH_RM_RANGE_ID_IMAGE,
+		ghvm->dtb.parcel_start << PAGE_SHIFT,
+		ghvm->dtb.parcel_pages << PAGE_SHIFT);
+	if (ret) {
+		dev_warn(ghvm->parent,
+			 "Failed to set location of DTB mem parcel: %d\n", ret);
+		goto err;
+	}
+
 	ret = gunyah_rm_vm_init(ghvm->rm, ghvm->vmid);
 	if (ret) {
 		ghvm->vm_status = GUNYAH_RM_VM_STATUS_INIT_FAILED;
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 357414e67d72..088ed9c55376 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -98,4 +98,7 @@ int gunyah_gmem_reclaim_parcel(struct gunyah_vm *ghvm,
 			       struct gunyah_rm_mem_parcel *parcel, u64 gfn,
 			       u64 nr);
 
+int gunyah_gmem_setup_demand_paging(struct gunyah_vm *ghvm);
+int gunyah_gmem_demand_page(struct gunyah_vm *ghvm, u64 gpa, bool write);
+
 #endif
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index ae9be5eef7a9..ed461acb9e1b 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -223,6 +223,8 @@ struct gunyah_hypercall_vcpu_run_resp {
 			GUNYAH_VCPU_ADDRSPACE_VMMIO_READ	= 4,
 			/* VCPU has returned for MMIO WRITE */
 			GUNYAH_VCPU_ADDRSPACE_VMMIO_WRITE	= 5,
+			/* Host needs to satisfy a page fault */
+			GUNYAH_VCPU_ADDRSPACE_PAGE_FAULT	= 7,
 			/* clang-format on */
 		} state;
 		u64 sized_state;

-- 
2.43.0


