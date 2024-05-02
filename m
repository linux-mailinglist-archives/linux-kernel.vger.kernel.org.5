Return-Path: <linux-kernel+bounces-166898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 031A88BA17A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2162C1C20B6A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E836540BE3;
	Thu,  2 May 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nGbUYAhs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D38180A62
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714681039; cv=none; b=lRIaR2dZjKLRi+4/ASk4UtR8icRK3RNAwUTNj+vgEy6SCIoWsjyrYQo0bbyhaNKHXiXJeOgwGrDls9K15KGIM0x55TEdmtQwoDxqVYsQxmIs3iL6DvZspeEkT5ObApv7j2rrks+j/ZGCzl3P2wRq5GF5ELUoa0vLwqT1Erzx7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714681039; c=relaxed/simple;
	bh=YL8D7SYvJLhlyjoxnrAyiBceEYkhFu4TTXAedNUKgRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OB0DtS9PBsxL7DFAzYNuHEVNy1eYFYshxTYeOGOXDtYLXW4LYVL6VVt8ljmpm+HxPftPRloXSSKz8VAFA5WA2J2VswphKp/WtLsBKgkV92l1P190/DibyufR/invDDSWIEQgLxgAQvsuMAuKGerW9roGbIA+t3sebit/gtol+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nGbUYAhs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 442Diu4v014399;
	Thu, 2 May 2024 20:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=s3c
	hDQOo+tPipRQL0+QuH7LkgscBLH/TgsRVja2GR4s=; b=nGbUYAhsCuZfzhXlOmf
	R99NhUyDSFSOzLL58xrPgBVRH8xYFDR8wMKAjJE50hWqgpUkY8wZmWsqYfl8/PNV
	8kbwzUp146blZdw5T51CuXQschtebA/fF+tsWcq+hAVszqoh/6s2dm4+5RdrnmXC
	8biA6jeCGO0u1eZ7UEn2hlhbwglynhQbrME7ZX66KFCSm68L+7m9tKk0M6zeL4xx
	QjBRO6AdNnuz2eDVRT5kA7KA/T/w9zsMXFFEl1S6PK53JecRJ6Sv/jxD+2P/HmRf
	xZkRtoDwbgaAX9W5YnddmoVDuqUOqGzRcaf41ii+pGTjK1WbRTNtb3Wn9PiMcs/f
	E+g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv6q0skb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 20:16:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442KGvta027282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 20:16:57 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 13:16:56 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 2 May 2024 13:16:55 -0700
Subject: [PATCH] ubifs: fix kernel-doc warnings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240502-ubifs-kdoc-v1-1-59c35a325141@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALb0M2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwMj3dKkzLRi3eyU/GRdg1QDc4u05DRzS0NzJaCGgqLUtMwKsGHRsbW
 1AEIrgIpcAAAA
To: Richard Weinberger <richard@nod.at>,
        Zhihao Cheng
	<chengzhihao1@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RUrIjTeK6LkW3D9-HtP-bizJM07yAN3J
X-Proofpoint-GUID: RUrIjTeK6LkW3D9-HtP-bizJM07yAN3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_12,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020133

make C=1 reports the following kernel-doc warnings:

fs/ubifs/compress.c:103: warning: Function parameter or struct member 'c' not described in 'ubifs_compress'
fs/ubifs/compress.c:155: warning: Function parameter or struct member 'c' not described in 'ubifs_decompress'
fs/ubifs/find.c:353: warning: Excess function parameter 'data' description in 'scan_for_free_cb'
fs/ubifs/find.c:353: warning: Function parameter or struct member 'arg' not described in 'scan_for_free_cb'
fs/ubifs/find.c:594: warning: Excess function parameter 'data' description in 'scan_for_idx_cb'
fs/ubifs/find.c:594: warning: Function parameter or struct member 'arg' not described in 'scan_for_idx_cb'
fs/ubifs/find.c:786: warning: Excess function parameter 'data' description in 'scan_dirty_idx_cb'
fs/ubifs/find.c:786: warning: Function parameter or struct member 'arg' not described in 'scan_dirty_idx_cb'
fs/ubifs/find.c:86: warning: Excess function parameter 'data' description in 'scan_for_dirty_cb'
fs/ubifs/find.c:86: warning: Function parameter or struct member 'arg' not described in 'scan_for_dirty_cb'
fs/ubifs/journal.c:369: warning: expecting prototype for wake_up_reservation(). Prototype was for add_or_start_queue() instead
fs/ubifs/lprops.c:1018: warning: Excess function parameter 'lst' description in 'scan_check_cb'
fs/ubifs/lprops.c:1018: warning: Function parameter or struct member 'arg' not described in 'scan_check_cb'
fs/ubifs/lpt.c:1938: warning: Function parameter or struct member 'ptr' not described in 'lpt_scan_node'
fs/ubifs/replay.c:60: warning: Function parameter or struct member 'hash' not described in 'replay_entry'

Fix them.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Note ubifs still has C=1 warnings from smatch that are not addressed:

fs/ubifs/journal.c:307:9: warning: context imbalance in '__queue_and_wait' - unexpected unlock
fs/ubifs/journal.c:322:13: warning: context imbalance in 'wait_for_reservation' - different lock contexts for basic block
fs/ubifs/journal.c:368:13: warning: context imbalance in 'add_or_start_queue' - different lock contexts for basic block
---
 fs/ubifs/compress.c | 2 ++
 fs/ubifs/find.c     | 8 ++++----
 fs/ubifs/journal.c  | 2 +-
 fs/ubifs/lprops.c   | 2 +-
 fs/ubifs/lpt.c      | 1 +
 fs/ubifs/replay.c   | 1 +
 6 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ubifs/compress.c b/fs/ubifs/compress.c
index 75461777c466..0b48cbab8a3d 100644
--- a/fs/ubifs/compress.c
+++ b/fs/ubifs/compress.c
@@ -82,6 +82,7 @@ struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT];
 
 /**
  * ubifs_compress - compress data.
+ * @c: UBIFS file-system description object
  * @in_buf: data to compress
  * @in_len: length of the data to compress
  * @out_buf: output buffer where compressed data should be stored
@@ -140,6 +141,7 @@ void ubifs_compress(const struct ubifs_info *c, const void *in_buf,
 
 /**
  * ubifs_decompress - decompress data.
+ * @c: UBIFS file-system description object
  * @in_buf: data to decompress
  * @in_len: length of the data to decompress
  * @out_buf: output buffer where decompressed data should
diff --git a/fs/ubifs/find.c b/fs/ubifs/find.c
index 6ebf3c04ac5f..643718906b9f 100644
--- a/fs/ubifs/find.c
+++ b/fs/ubifs/find.c
@@ -73,7 +73,7 @@ static int valuable(struct ubifs_info *c, const struct ubifs_lprops *lprops)
  * @c: the UBIFS file-system description object
  * @lprops: LEB properties to scan
  * @in_tree: whether the LEB properties are in main memory
- * @data: information passed to and from the caller of the scan
+ * @arg: information passed to and from the caller of the scan
  *
  * This function returns a code that indicates whether the scan should continue
  * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
@@ -340,7 +340,7 @@ int ubifs_find_dirty_leb(struct ubifs_info *c, struct ubifs_lprops *ret_lp,
  * @c: the UBIFS file-system description object
  * @lprops: LEB properties to scan
  * @in_tree: whether the LEB properties are in main memory
- * @data: information passed to and from the caller of the scan
+ * @arg: information passed to and from the caller of the scan
  *
  * This function returns a code that indicates whether the scan should continue
  * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
@@ -581,7 +581,7 @@ int ubifs_find_free_space(struct ubifs_info *c, int min_space, int *offs,
  * @c: the UBIFS file-system description object
  * @lprops: LEB properties to scan
  * @in_tree: whether the LEB properties are in main memory
- * @data: information passed to and from the caller of the scan
+ * @arg: information passed to and from the caller of the scan
  *
  * This function returns a code that indicates whether the scan should continue
  * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
@@ -773,7 +773,7 @@ int ubifs_save_dirty_idx_lnums(struct ubifs_info *c)
  * @c: the UBIFS file-system description object
  * @lprops: LEB properties to scan
  * @in_tree: whether the LEB properties are in main memory
- * @data: information passed to and from the caller of the scan
+ * @arg: information passed to and from the caller of the scan
  *
  * This function returns a code that indicates whether the scan should continue
  * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 74aee92433d7..f997a85bcdce 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -359,7 +359,7 @@ static void wake_up_reservation(struct ubifs_info *c)
 }
 
 /**
- * wake_up_reservation - add current task in queue or start queuing.
+ * add_or_start_queue - add current task in queue or start queuing.
  * @c: UBIFS file-system description object
  *
  * This function starts queuing if queuing is not started, otherwise adds
diff --git a/fs/ubifs/lprops.c b/fs/ubifs/lprops.c
index a11c3dab7e16..8788740ec57f 100644
--- a/fs/ubifs/lprops.c
+++ b/fs/ubifs/lprops.c
@@ -1005,7 +1005,7 @@ void dbg_check_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap, int cat,
  * @c: the UBIFS file-system description object
  * @lp: LEB properties to scan
  * @in_tree: whether the LEB properties are in main memory
- * @lst: lprops statistics to update
+ * @arg: lprops statistics to update
  *
  * This function returns a code that indicates whether the scan should continue
  * (%LPT_SCAN_CONTINUE), whether the LEB properties should be added to the tree
diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index 778a22bf9a92..441d0beca4cf 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -1918,6 +1918,7 @@ int ubifs_lpt_init(struct ubifs_info *c, int rd, int wr)
  * @pnode: where to keep a pnode
  * @cnode: where to keep a cnode
  * @in_tree: is the node in the tree in memory
+ * @ptr: union of node pointers
  * @ptr.nnode: pointer to the nnode (if it is an nnode) which may be here or in
  * the tree
  * @ptr.pnode: ditto for pnode
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 17da28d6247a..a950c5f2560e 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -29,6 +29,7 @@
  * @lnum: logical eraseblock number of the node
  * @offs: node offset
  * @len: node length
+ * @hash: node hash
  * @deletion: non-zero if this entry corresponds to a node deletion
  * @sqnum: node sequence number
  * @list: links the replay list

---
base-commit: b8a77b9a5f9c2ba313f2beef8440b6f9f69768e7
change-id: 20240502-ubifs-kdoc-0e078fcf7917


