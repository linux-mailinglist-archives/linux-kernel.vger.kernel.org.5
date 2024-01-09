Return-Path: <linux-kernel+bounces-21345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE45828DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D9A287B49
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093C647F74;
	Tue,  9 Jan 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N9WJqtBu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C3E45BE0;
	Tue,  9 Jan 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409GTKRk006618;
	Tue, 9 Jan 2024 19:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=xmkTmjNsdPCs10aYcSn7XO86TvYDKbjp9vja8YDUKN0
	=; b=N9WJqtBujwwUhLG/HBE5Z/UFBG1ofvojUfp3iKfVzqKaxm/kS8nZQuIPWFi
	vOwR3KVMHLY4s0bMG/nyHrPGegjtSCEkq4Rsc2S1fNFNUNfvOwM4FeeWyrYVEfD5
	CmmDFLUggrFTzFcdp1pjtuijkItvKcbfhSWXQ6eI2aC5csVZvr0vyPhsqW5/6R9u
	GItgPaoqr6Vb55R960tUsBD3LQ0E08l5WdYZ80Ztks6ewnjQPECy7t0lKLj/nzMx
	CbsMkO8iGaux+Hw/lr0oEhe1eCnI0D+qS/sVcHAZY69KbIMZ4+b4Juw7IXJrbO80
	oVy9SkDPMumDF8zffBpw3D+Q10w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9q70egv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:38:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Jc7lf011554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:38:07 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:38:06 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:38:05 -0800
Subject: [PATCH v16 27/34] virt: gunyah: Enable demand paging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-27-634904bf4ce9@quicinc.com>
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
X-Proofpoint-ORIG-GUID: WPtW2STFLzqb5RdGaoN_fa6pORGkIgFJ
X-Proofpoint-GUID: WPtW2STFLzqb5RdGaoN_fa6pORGkIgFJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=766
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

Tell resource manager to enable demand paging and wire vCPU faults to
provide the backing folio when a guestmemfd is bound to the faulting
access.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/guest_memfd.c | 115 ++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/gunyah_vcpu.c |  39 ++++++++++---
 drivers/virt/gunyah/vm_mgr.c      |  17 ++++++
 drivers/virt/gunyah/vm_mgr.h      |   3 +
 4 files changed, 166 insertions(+), 8 deletions(-)

diff --git a/drivers/virt/gunyah/guest_memfd.c b/drivers/virt/gunyah/guest_memfd.c
index 5eeac6ac451e..4696ff4c7c22 100644
--- a/drivers/virt/gunyah/guest_memfd.c
+++ b/drivers/virt/gunyah/guest_memfd.c
@@ -843,3 +843,118 @@ int gunyah_gmem_reclaim_parcel(struct gunyah_vm *ghvm,
 
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
+	down_read(&ghvm->bindings_lock);
+	mt_for_each(&ghvm->bindings, b, index, ULONG_MAX)
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
+	mt_for_each(&ghvm->bindings, b, index, ULONG_MAX) {
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
+	up_read(&ghvm->bindings_lock);
+	return ret;
+}
+
+static bool folio_mmapped(struct folio *folio)
+{
+	struct address_space *mapping = folio->mapping;
+	struct vm_area_struct *vma;
+	bool ret = false;
+
+	i_mmap_lock_read(mapping);
+	vma_interval_tree_foreach(vma, &mapping->i_mmap, folio_index(folio),
+				  folio_index(folio) + folio_nr_pages(folio)) {
+		ret = true;
+		break;
+	}
+	i_mmap_unlock_read(mapping);
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
+	down_read(&ghvm->bindings_lock);
+	b = mtree_load(&ghvm->bindings, gfn);
+	if (!b) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	if (write && !(b->flags & GUNYAH_MEM_ALLOW_WRITE)) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
+	folio = gunyah_gmem_get_folio(file_inode(b->file), gunyah_gfn_to_off(b, gfn));
+	if (IS_ERR(folio)) {
+		ret = PTR_ERR(folio);
+		pr_err_ratelimited(
+			"Failed to obtain memory for guest addr %016llx: %d\n",
+			gpa, ret);
+		goto unlock;
+	}
+
+	if (gunyah_guest_mem_is_lend(ghvm, b->flags) &&
+	    (folio_mapped(folio) || folio_mmapped(folio))) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	/**
+	 * the folio covers the requested guest address, but the folio may not
+	 * start at the requested guest address. recompute the gfn based on the
+	 * folio itself.
+	 */
+	gfn = gunyah_off_to_gfn(b, folio_index(folio));
+
+	ret = gunyah_vm_provide_folio(ghvm, folio, gfn,
+				      !gunyah_guest_mem_is_lend(ghvm, b->flags),
+				      !!(b->flags & GUNYAH_MEM_ALLOW_WRITE));
+	if (ret) {
+		if (ret != -EAGAIN)
+			pr_err_ratelimited(
+				"Failed to provide folio for guest addr: %016llx: %d\n",
+				gpa, ret);
+		goto out;
+	}
+out:
+	folio_unlock(folio);
+	folio_put(folio);
+unlock:
+	up_read(&ghvm->bindings_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_gmem_demand_page);
diff --git a/drivers/virt/gunyah/gunyah_vcpu.c b/drivers/virt/gunyah/gunyah_vcpu.c
index b636b54dc9a1..f01e6d6163ba 100644
--- a/drivers/virt/gunyah/gunyah_vcpu.c
+++ b/drivers/virt/gunyah/gunyah_vcpu.c
@@ -89,29 +89,44 @@ static irqreturn_t gunyah_vcpu_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void gunyah_handle_page_fault(
+static bool gunyah_handle_page_fault(
 	struct gunyah_vcpu *vcpu,
 	const struct gunyah_hypercall_vcpu_run_resp *vcpu_run_resp)
 {
 	u64 addr = vcpu_run_resp->state_data[0];
+	bool write = !!vcpu_run_resp->state_data[1];
+	int ret = 0;
+
+	ret = gunyah_gmem_demand_page(vcpu->ghvm, addr, write);
+	if (!ret || ret == -EAGAIN)
+		return true;
 
 	vcpu->vcpu_run->page_fault.resume_action = GUNYAH_VCPU_RESUME_FAULT;
-	vcpu->vcpu_run->page_fault.attempt = 0;
+	vcpu->vcpu_run->page_fault.attempt = ret;
 	vcpu->vcpu_run->page_fault.phys_addr = addr;
 	vcpu->vcpu_run->exit_reason = GUNYAH_VCPU_EXIT_PAGE_FAULT;
+	return false;
 }
 
-static void
-gunyah_handle_mmio(struct gunyah_vcpu *vcpu,
+static bool
+gunyah_handle_mmio(struct gunyah_vcpu *vcpu, unsigned long resume_data[3],
 		   const struct gunyah_hypercall_vcpu_run_resp *vcpu_run_resp)
 {
 	u64 addr = vcpu_run_resp->state_data[0],
 	    len = vcpu_run_resp->state_data[1],
 	    data = vcpu_run_resp->state_data[2];
+	int ret;
 
 	if (WARN_ON(len > sizeof(u64)))
 		len = sizeof(u64);
 
+	ret = gunyah_gmem_demand_page(vcpu->ghvm, addr,
+				     vcpu->vcpu_run->mmio.is_write);
+	if (!ret || ret == -EAGAIN) {
+		resume_data[1] = GUNYAH_ADDRSPACE_VMMIO_ACTION_RETRY;
+		return true;
+	}
+
 	if (vcpu_run_resp->state == GUNYAH_VCPU_ADDRSPACE_VMMIO_READ) {
 		vcpu->vcpu_run->mmio.is_write = 0;
 		/* Record that we need to give vCPU user's supplied value next gunyah_vcpu_run() */
@@ -127,6 +142,8 @@ gunyah_handle_mmio(struct gunyah_vcpu *vcpu,
 	vcpu->mmio_addr = vcpu->vcpu_run->mmio.phys_addr = addr;
 	vcpu->vcpu_run->mmio.len = len;
 	vcpu->vcpu_run->exit_reason = GUNYAH_VCPU_EXIT_MMIO;
+
+	return false;
 }
 
 static int gunyah_handle_mmio_resume(struct gunyah_vcpu *vcpu,
@@ -147,6 +164,8 @@ static int gunyah_handle_mmio_resume(struct gunyah_vcpu *vcpu,
 		resume_data[1] = GUNYAH_ADDRSPACE_VMMIO_ACTION_FAULT;
 		break;
 	case GUNYAH_VCPU_RESUME_RETRY:
+		gunyah_gmem_demand_page(vcpu->ghvm, vcpu->mmio_addr,
+					vcpu->state == GUNYAH_VCPU_RUN_STATE_MMIO_WRITE);
 		resume_data[1] = GUNYAH_ADDRSPACE_VMMIO_ACTION_RETRY;
 		break;
 	default:
@@ -309,11 +328,15 @@ static int gunyah_vcpu_run(struct gunyah_vcpu *vcpu)
 				break;
 			case GUNYAH_VCPU_ADDRSPACE_VMMIO_READ:
 			case GUNYAH_VCPU_ADDRSPACE_VMMIO_WRITE:
-				gunyah_handle_mmio(vcpu, &vcpu_run_resp);
-				goto out;
+				if (!gunyah_handle_mmio(vcpu, resume_data,
+							&vcpu_run_resp))
+					goto out;
+				break;
 			case GUNYAH_VCPU_ADDRSPACE_PAGE_FAULT:
-				gunyah_handle_page_fault(vcpu, &vcpu_run_resp);
-				goto out;
+				if (!gunyah_handle_page_fault(vcpu,
+							     &vcpu_run_resp))
+					goto out;
+				break;
 			default:
 				pr_warn_ratelimited(
 					"Unknown vCPU state: %llx\n",
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index 4379b5ba151e..3b767eeeb7c2 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -471,6 +471,23 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
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
index b2ab2f1bda3a..474ac866d237 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -137,4 +137,7 @@ int gunyah_gmem_reclaim_parcel(struct gunyah_vm *ghvm,
 			       struct gunyah_rm_mem_parcel *parcel, u64 gfn,
 			       u64 nr);
 
+int gunyah_gmem_setup_demand_paging(struct gunyah_vm *ghvm);
+int gunyah_gmem_demand_page(struct gunyah_vm *ghvm, u64 gpa, bool write);
+
 #endif

-- 
2.34.1


