Return-Path: <linux-kernel+bounces-1889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E678D815551
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDBA28339A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708F432C7C;
	Sat, 16 Dec 2023 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ije1xgeW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FCB19450;
	Sat, 16 Dec 2023 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG0Gixe008289;
	Sat, 16 Dec 2023 00:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=xctNUcQvlpqTuEFQH3xW/yX6RJBdeipXq5ilyhd7G8k
	=; b=Ije1xgeW4gs6FJWTbThF2eTxAMrbkFeBhI6wfY1o97dQBQhb2yKSx7Ip546
	0+IxUjO+zoYJPpUewOyGQ4B+fTWfKYcCp3NiQxym2vP0/Gf2dcv2O8cpkVZVaR11
	xSfN0HoJOadpc0aGnY392pl1IT+zRyYgah8ah3dXPtvpEc3eEk2qLTQXd39Xnibt
	r9Gucl7E0q6J3Avt6q17nTYtUQpreeMMolPO8+O3sEu4xJzOAxtIEtZvh8xP2Vn0
	eXnjaDV3rC+3+YvT6c1fweCCaqPxmbr8cF7Zr9ZEjPRMkHDogbSNLwnAqTpsZBeK
	7mM8pftqXnAfg4jU2ZmnoBMrNJQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hdfaffq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0LEMw004968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:14 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:13 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:21:03 -0800
Subject: [PATCH RFC v15 22/30] virt: gunyah: guestmem: Initialize RM mem
 parcels from guestmem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-22-192a5d872a30@quicinc.com>
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
X-Proofpoint-ORIG-GUID: xlCdkxLoUm7ByqI1D0XitK2ULxKUNfce
X-Proofpoint-GUID: xlCdkxLoUm7ByqI1D0XitK2ULxKUNfce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=983 impostorscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160000

Gunyah Resource Manager sets up a virtual machine based on a device
tree which lives in guest memory. Resource manager requires this memory
to be provided as a memory parcel for it to read and manipulate.
Implement a function to construct a memory parcel from a guestmem
binding.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/guest_memfd.c | 188 ++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h      |   6 ++
 2 files changed, 194 insertions(+)

diff --git a/drivers/virt/gunyah/guest_memfd.c b/drivers/virt/gunyah/guest_memfd.c
index c38380c4dc50..419ed617bd0b 100644
--- a/drivers/virt/gunyah/guest_memfd.c
+++ b/drivers/virt/gunyah/guest_memfd.c
@@ -544,3 +544,191 @@ int gunyah_gmem_modify_binding(struct gunyah_vm *ghvm,
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
+	u64 size;
+	int ret;
+
+	if (!*nr)
+		return -EINVAL;
+
+	down_read(&ghvm->mem_lock);
+	b = mtree_load(&ghvm->mem_layout, *gfn);
+	if (!b) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+
+	start = *gfn - b->gfn;
+	end = min(*gfn + *nr, b->gfn + b->nr) - b->gfn;
+
+	nr_entries = 0;
+	prev_folio = NULL;
+	for (i = start + b->i_off; i < end + b->i_off;) {
+		folio = gunyah_gmem_get_folio(b->inode, i); /* A */
+		if (!folio) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		if (!prev_folio || folio_next(prev_folio) != folio)
+			nr_entries++;
+		i = folio_index(folio) + folio_nr_pages(folio);
+		prev_folio = folio;
+	}
+
+	parcel->mem_entries =
+		kcalloc(nr_entries, sizeof(*parcel->mem_entries), GFP_KERNEL);
+	if (!parcel->mem_entries) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	j = 0;
+	prev_folio = NULL;
+	size = 0;
+	for (i = start + b->i_off; i < end + b->i_off;) {
+		folio = filemap_get_folio(b->inode->i_mapping, i); /* B */
+		if (WARN_ON(IS_ERR(folio))) {
+			ret = PTR_ERR(folio);
+			i = end + b->i_off;
+			goto out;
+		}
+
+		if (!prev_folio || folio_next(prev_folio) != folio) {
+			if (likely(prev_folio)) {
+				parcel->mem_entries[j].size = cpu_to_le64(size);
+				size = 0;
+				j++;
+				BUG_ON(j == nr_entries);
+			}
+			parcel->mem_entries[j].phys_addr = cpu_to_le64(PFN_PHYS(folio_pfn(folio)));
+		}
+		size += folio_size(folio);
+		if (likely(prev_folio))
+			folio_put(prev_folio); /* B */
+		i = folio_index(folio) + folio_nr_pages(folio);
+		prev_folio = folio;
+	}
+	folio_put(prev_folio); /* B */
+	BUG_ON(j + 1 != nr_entries);
+	parcel->mem_entries[j].size = cpu_to_le64(size);
+	parcel->n_mem_entries = nr_entries;
+
+	lend = parcel->n_acl_entries == 1 || gunyah_guest_mem_is_lend(ghvm, b->flags);
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
+	*nr = end;
+	folio = filemap_get_folio(b->inode->i_mapping, start); /* C */
+	*gfn = folio_index(folio) - b->i_off + b->gfn;
+	folio_put(folio); /* C */
+
+	ret = gunyah_rm_mem_share(ghvm->rm, parcel);
+	if (ret)
+		dev_warn(ghvm->parent, "Failed to share parcel for DTB: %d\n",
+			 ret);
+
+	goto out;
+free_acl:
+	kfree(parcel->acl_entries);
+	parcel->acl_entries = NULL;
+free_entries:
+	kfree(parcel->mem_entries);
+	parcel->mem_entries = NULL;
+out:
+	for (j = start + b->i_off; j < i;) {
+		folio = filemap_get_folio(b->inode->i_mapping, j); /* D */
+		if (IS_ERR(folio))
+			continue;
+		j = folio_index(folio) + folio_nr_pages(folio);
+		if (!ret) {
+			folio_set_private(folio);
+			WARN_ON(mtree_insert_range(&b->mt, folio_index(folio),
+						   j - 1, folio, GFP_KERNEL));
+		}
+		folio_unlock(folio); /* A */
+		folio_put(folio); /* D */
+		/* matching folio_put for A is done at
+		 * (1) gunyah_gmem_reclaim_parcel or
+		 * (2) after gunyah_gmem_parcel_to_paged, gunyah_vm_reclaim_folio
+		 */
+	}
+unlock:
+	up_read(&ghvm->mem_lock);
+	return ret;
+}
+
+int gunyah_gmem_reclaim_parcel(struct gunyah_vm *ghvm,
+			       struct gunyah_rm_mem_parcel *parcel, u64 gfn,
+			       u64 nr)
+{
+	struct gunyah_gmem_binding *b;
+	struct folio *folio;
+	unsigned long i;
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
+		parcel->mem_handle = 0;
+		kfree(parcel->mem_entries);
+		kfree(parcel->acl_entries);
+	}
+
+	down_read(&ghvm->mem_lock);
+	b = mtree_load(&ghvm->mem_layout, gfn);
+	if (WARN_ON(!b)) {
+		up_read(&ghvm->mem_lock);
+		return 0;
+	}
+
+	i = gfn - b->gfn + b->i_off;
+	mt_for_each(&b->mt, folio, i, nr + b->i_off) {
+		mtree_erase(&b->mt, i);
+		folio_put(folio); /* A */
+	}
+	up_read(&ghvm->mem_lock);
+	return 0;
+}
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index 8f1c3ade08dd..1cad729b017a 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -84,5 +84,11 @@ int gunyah_gmem_modify_binding(struct gunyah_vm *ghvm,
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
2.43.0


