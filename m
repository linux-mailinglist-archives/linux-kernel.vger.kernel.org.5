Return-Path: <linux-kernel+bounces-21351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D41F828E15
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3ED71C24A05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81956495D7;
	Tue,  9 Jan 2024 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iM1PMyMP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A6481D5;
	Tue,  9 Jan 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409DRiAN016723;
	Tue, 9 Jan 2024 19:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=TnTPpzUDBWIYZLcHE8dxPtRIMqaLPUN2IK1SZ81q1vU
	=; b=iM1PMyMPrfgGq7LwkLipapCuBEO88AtOhN+uO8TjnDt5kr8v4PX+sZKPacv
	S2FVlPAu6WMphynffHZFe02BbDtNyxhIBkvvQBNYEqgLNLsF/BnkY04RI8+WE+MX
	IIFN1DOGAbDnI6QZgnJWZ5YKScN+GWB6j3g21qiiZaDm/hos6+62F7qXZmj9mE4u
	HSlyLdD/pgNXvmzZEa1H4kfgKfyXo7dwnPaLk6OWKRRtVoskH8vcoNavWCCO0y7K
	bYDcWzG5qjPECJDsCSSte8ubav2S3PLDkL4S2NhKU4QkHIwOJNpLrJymr8NL58fg
	ipODtktStLltwSX6v4wB+2nptdw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh3g699py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:38:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Jc4qw030540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:38:04 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:38:03 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:38:01 -0800
Subject: [PATCH v16 23/34] virt: gunyah: guestmem: Initialize RM mem
 parcels from guestmem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-23-634904bf4ce9@quicinc.com>
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
X-Proofpoint-GUID: UAaQhQuWqi5aWtBsqKdQLmvnLI__Nw8A
X-Proofpoint-ORIG-GUID: UAaQhQuWqi5aWtBsqKdQLmvnLI__Nw8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

Gunyah Resource Manager sets up a virtual machine based on a device
tree which lives in guest memory. Resource manager requires this memory
to be provided as a memory parcel for it to read and manipulate.
Implement a function to construct a memory parcel from a guestmem
binding.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/guest_memfd.c | 190 ++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h      |   6 ++
 2 files changed, 196 insertions(+)

diff --git a/drivers/virt/gunyah/guest_memfd.c b/drivers/virt/gunyah/guest_memfd.c
index 71686f1946da..5eeac6ac451e 100644
--- a/drivers/virt/gunyah/guest_memfd.c
+++ b/drivers/virt/gunyah/guest_memfd.c
@@ -653,3 +653,193 @@ int gunyah_gmem_modify_mapping(struct gunyah_vm *ghvm,
 		fput(file);
 	return ret;
 }
+
+int gunyah_gmem_share_parcel(struct gunyah_vm *ghvm, struct gunyah_rm_mem_parcel *parcel,
+			     u64 *gfn, u64 *nr)
+{
+	struct folio *folio, *prev_folio;
+	unsigned long nr_entries, i, j, start, end;
+	struct gunyah_gmem_binding *b;
+	bool lend;
+	int ret;
+
+	parcel->mem_handle = GUNYAH_MEM_HANDLE_INVAL;
+
+	if (!*nr)
+		return -EINVAL;
+
+
+	down_read(&ghvm->bindings_lock);
+	b = mtree_load(&ghvm->bindings, *gfn);
+	if (!b || *gfn > b->gfn + b->nr || *gfn < b->gfn) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	/**
+	 * Generally, indices can be based on gfn, guest_memfd offset, or
+	 * offset into binding. start and end are based on offset into binding.
+	 */
+	start = *gfn - b->gfn;
+
+	if (start + *nr > b->nr) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	end = start + *nr;
+	lend = parcel->n_acl_entries == 1 || gunyah_guest_mem_is_lend(ghvm, b->flags);
+
+	/**
+	 * First, calculate the number of physically discontiguous regions
+	 * the parcel covers. Each memory entry corresponds to one folio.
+	 * In future, each memory entry could correspond to contiguous
+	 * folios that are also adjacent in guest_memfd, but parcels
+	 * are only being used for small amounts of memory for now, so
+	 * this optimization is premature.
+	 */
+	nr_entries = 0;
+	prev_folio = NULL;
+	for (i = start + b->i_off; i < end + b->i_off;) {
+		folio = gunyah_gmem_get_folio(file_inode(b->file), i); /* A */
+		if (!folio) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		nr_entries++;
+		i = folio_index(folio) + folio_nr_pages(folio);
+	}
+	end = i - b->i_off;
+
+	parcel->mem_entries =
+		kcalloc(nr_entries, sizeof(*parcel->mem_entries), GFP_KERNEL);
+	if (!parcel->mem_entries) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/**
+	 * Walk through all the folios again, now filling the mem_entries array.
+	 */
+	j = 0;
+	prev_folio = NULL;
+	for (i = start + b->i_off; i < end + b->i_off; j++) {
+		folio = filemap_get_folio(file_inode(b->file)->i_mapping, i); /* B */
+		if (WARN_ON(IS_ERR(folio))) {
+			ret = PTR_ERR(folio);
+			i = end + b->i_off;
+			goto out;
+		}
+
+		if (lend)
+			folio_set_private(folio);
+
+		parcel->mem_entries[j].size = cpu_to_le64(folio_size(folio));
+		parcel->mem_entries[j].phys_addr = cpu_to_le64(PFN_PHYS(folio_pfn(folio)));
+		i = folio_index(folio) + folio_nr_pages(folio);
+		folio_put(folio); /* B */
+	}
+	BUG_ON(j != nr_entries);
+	parcel->n_mem_entries = nr_entries;
+
+	if (lend)
+		parcel->n_acl_entries = 1;
+
+	parcel->acl_entries = kcalloc(parcel->n_acl_entries,
+				      sizeof(*parcel->acl_entries), GFP_KERNEL);
+	if (!parcel->n_acl_entries) {
+		ret = -ENOMEM;
+		goto free_entries;
+	}
+
+	parcel->acl_entries[0].vmid = cpu_to_le16(ghvm->vmid);
+	if (b->flags & GUNYAH_MEM_ALLOW_READ)
+		parcel->acl_entries[0].perms |= GUNYAH_RM_ACL_R;
+	if (b->flags & GUNYAH_MEM_ALLOW_WRITE)
+		parcel->acl_entries[0].perms |= GUNYAH_RM_ACL_W;
+	if (b->flags & GUNYAH_MEM_ALLOW_EXEC)
+		parcel->acl_entries[0].perms |= GUNYAH_RM_ACL_X;
+
+	if (!lend) {
+		u16 host_vmid;
+
+		ret = gunyah_rm_get_vmid(ghvm->rm, &host_vmid);
+		if (ret)
+			goto free_acl;
+
+		parcel->acl_entries[1].vmid = cpu_to_le16(host_vmid);
+		parcel->acl_entries[1].perms = GUNYAH_RM_ACL_R | GUNYAH_RM_ACL_W | GUNYAH_RM_ACL_X;
+	}
+
+	parcel->mem_handle = GUNYAH_MEM_HANDLE_INVAL;
+	folio = filemap_get_folio(file_inode(b->file)->i_mapping, start); /* C */
+	*gfn = folio_index(folio) - b->i_off + b->gfn;
+	*nr = end - (folio_index(folio) - b->i_off);
+	folio_put(folio); /* C */
+
+	ret = gunyah_rm_mem_share(ghvm->rm, parcel);
+	goto out;
+free_acl:
+	kfree(parcel->acl_entries);
+	parcel->acl_entries = NULL;
+free_entries:
+	kfree(parcel->mem_entries);
+	parcel->mem_entries = NULL;
+	parcel->n_mem_entries = 0;
+out:
+	/* unlock the folios */
+	for (j = start + b->i_off; j < i;) {
+		folio = filemap_get_folio(file_inode(b->file)->i_mapping, j); /* D */
+		if (IS_ERR(folio))
+			continue;
+		j = folio_index(folio) + folio_nr_pages(folio);
+		folio_unlock(folio); /* A */
+		folio_put(folio); /* D */
+		if (ret)
+			folio_put(folio); /* A */
+		/* matching folio_put for A is done at
+		 * (1) gunyah_gmem_reclaim_parcel or
+		 * (2) after gunyah_gmem_parcel_to_paged, gunyah_vm_reclaim_folio
+		 */
+	}
+unlock:
+	up_read(&ghvm->bindings_lock);
+	return ret;
+}
+
+int gunyah_gmem_reclaim_parcel(struct gunyah_vm *ghvm,
+			       struct gunyah_rm_mem_parcel *parcel, u64 gfn,
+			       u64 nr)
+{
+	struct gunyah_rm_mem_entry *entry;
+	struct folio *folio;
+	pgoff_t i;
+	int ret;
+
+	if (parcel->mem_handle != GUNYAH_MEM_HANDLE_INVAL) {
+		ret = gunyah_rm_mem_reclaim(ghvm->rm, parcel);
+		if (ret) {
+			dev_err(ghvm->parent, "Failed to reclaim parcel: %d\n",
+				ret);
+			/* We can't reclaim the pages -- hold onto the pages
+			 * forever because we don't know what state the memory
+			 * is in
+			 */
+			return ret;
+		}
+		parcel->mem_handle = GUNYAH_MEM_HANDLE_INVAL;
+
+		for (i = 0; i < parcel->n_mem_entries; i++) {
+			entry = &parcel->mem_entries[i];
+
+			folio = pfn_folio(PHYS_PFN(le64_to_cpu(entry->phys_addr)));
+			folio_put(folio); /* A */
+		}
+
+		kfree(parcel->mem_entries);
+		kfree(parcel->acl_entries);
+	}
+
+	return 0;
+}
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 518d05eeb642..a79c11f1c3a5 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -119,5 +119,11 @@ int gunyah_gmem_modify_mapping(struct gunyah_vm *ghvm,
 			       struct gunyah_map_mem_args *args);
 struct gunyah_gmem_binding;
 void gunyah_gmem_remove_binding(struct gunyah_gmem_binding *binding);
+int gunyah_gmem_share_parcel(struct gunyah_vm *ghvm,
+			     struct gunyah_rm_mem_parcel *parcel, u64 *gfn,
+			     u64 *nr);
+int gunyah_gmem_reclaim_parcel(struct gunyah_vm *ghvm,
+			       struct gunyah_rm_mem_parcel *parcel, u64 gfn,
+			       u64 nr);
 
 #endif

-- 
2.34.1


