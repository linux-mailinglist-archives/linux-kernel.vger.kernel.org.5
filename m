Return-Path: <linux-kernel+bounces-77505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A388860691
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B91E1C22B14
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC1B142659;
	Thu, 22 Feb 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bqtVg4cA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8AC137918;
	Thu, 22 Feb 2024 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643828; cv=none; b=IgsPUeYTIycl+ibYJMwo6sN6mOBJDRIlIN3dbGp33eZzlfBxXHWFJbVdTk8w3KFAQtC2uWS+orWc0M/PlWLXlrcNrBg/M9/rBFaJ9DxYRgUL+ultBVNepqK/ul5hBE4PwrqZJcOQiNyWE3/Frh9QsEemXIciZ8gjgGU++n7FbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643828; c=relaxed/simple;
	bh=Kv+rHtJfkmNXSA77cTn1OVoKnvCue27I/RnZAD++GyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=b4LzeXpza69SQ2svGTYjBAjEa5xXGp+AzC7t0drk6ZhcsybJ85yribMX4vdtyz64EdJb0HbcIhoT0XdybUh/cfYtqOyuPfb5BlURZht9fQK2YxEG5t6IOdtDwUhQ+LPUOxSBjpStnewwyEgeUBx5T0+cf0yBA+QFBzVwTIEQ0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bqtVg4cA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MMv6BT013527;
	Thu, 22 Feb 2024 23:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=qW7+D6aUt163gja6+AuWxPZ9BT7wrXk9X0wveYo7AB8
	=; b=bqtVg4cAMWkrBY9cQ8RCBnFA05Meino7ntJnPD+DlJPOBNVgKp6WI9cQucw
	B/eaWexCT0CQvw7b/wGnKI8bFW07CARJTtqDHj6O8d9S4yxK7F3ihFxbnHPjjshc
	DpUnFjntxLj9xssnEFX5J14ME+pN12QAahU29A+upnNizsQy0kyyE7/WY+C/2nAa
	OnPm1YX5l/EdeSL+ZOxOgtuusT8zMD1nE+HT0AqVJdQgy1CAiHvb9hYbFYZ3zPj4
	Gqpi2fPXL9IcbTRfww1hibj/Bzx6NWMRA6kv1FdUK7IbvbHk0ZxML7JifRHVGn7m
	0GZ6Fijrm0YkdEB4PXM8bGlGvdw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we4dq17ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGfBM025633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:41 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:40 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:48 -0800
Subject: [PATCH v17 25/35] virt: gunyah: guestmem: Initialize RM mem
 parcels from guestmem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-25-1e9da6763d38@quicinc.com>
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
X-Proofpoint-GUID: vR1aZuf4fzB2Ai69DQJ86JT63-NanqyJ
X-Proofpoint-ORIG-GUID: vR1aZuf4fzB2Ai69DQJ86JT63-NanqyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220179

Gunyah Resource Manager sets up a virtual machine based on a device
tree which lives in guest memory. Resource manager requires this memory
to be provided as a memory parcel for it to read and manipulate.
Implement a function to construct a memory parcel from a guestmem
binding.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/guest_memfd.c | 207 ++++++++++++++++++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h      |   6 ++
 2 files changed, 213 insertions(+)

diff --git a/drivers/virt/gunyah/guest_memfd.c b/drivers/virt/gunyah/guest_memfd.c
index d6be8bf67d996..0c35ffa616d9c 100644
--- a/drivers/virt/gunyah/guest_memfd.c
+++ b/drivers/virt/gunyah/guest_memfd.c
@@ -684,3 +684,210 @@ int gunyah_gmem_modify_mapping(struct gunyah_vm *ghvm,
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
+	lend = gunyah_guest_mem_is_lend(ghvm, b->flags);
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
+		if (lend) {
+			/* don't lend a folio that is mapped by host */
+			if (!gunyah_folio_lend_safe(folio)) {
+				folio_unlock(folio);
+				folio_put(folio);
+				ret = -EPERM;
+				goto out;
+			}
+			folio_set_private(folio);
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
+		if (WARN_ON(IS_ERR(folio)))
+			continue;
+		j = folio_index(folio) + folio_nr_pages(folio);
+		folio_unlock(folio); /* A */
+		if (ret) {
+			if (folio_test_private(folio)) {
+				gunyah_folio_host_reclaim(folio);
+				folio_clear_private(folio);
+			}
+			folio_put(folio); /* A */
+		}
+		folio_put(folio); /* D */
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
+
+			if (folio_test_private(folio))
+				gunyah_folio_host_reclaim(folio);
+
+			folio_clear_private(folio);
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
index d9f101fc52632..b6bc66f018b09 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -181,5 +181,11 @@ int gunyah_gmem_modify_mapping(struct gunyah_vm *ghvm,
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


