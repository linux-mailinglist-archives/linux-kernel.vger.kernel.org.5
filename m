Return-Path: <linux-kernel+bounces-7844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF6E81AE23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E421C22341
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF428C1A;
	Thu, 21 Dec 2023 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="JnIBrTLY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2728828
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL4avfP030101;
	Thu, 21 Dec 2023 04:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=7JkIncfRxyQ+Fej3GFTekTiPTesvlqx4ud148+UtSbo=; b=
	JnIBrTLYeKG+l0/0Rm4HTBce2nsHDhD5kdmAsipJOM9oCiKpujQavNPupz8n9Mqr
	yQIihjbyhNF94kQelGClcpm5jog9B9Fci1DJnuX7TR+uXwATJkv6G4ws4ClOtHJI
	nNP0iALcD0Nh5oYHLYwvx5au5Hf9IeK+l8uKZu6WKw4w9k/NeYU6+0N3shXMlHFo
	V5HHNzU60tKVWD5laJR5KfGMI9jNi/9+clm/yqKtsuQ2ElMONAuDQyaq5HYp8L9Y
	bpUkPMVa9rWJ+dbZA4LqPtDGEdEYkBguboJuaibS6z8bN9spfgVhms/yMmylUvLq
	NnMmhpl1zIvKvDdXnCsz+Q==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v12v5wqxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Dec 2023 04:50:17 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 20:50:23 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 20:50:21 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+2f73ed585f115e98aee8@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: task hung in exfat_write_inode
Date: Thu, 21 Dec 2023 12:50:14 +0800
Message-ID: <20231221045014.3986230-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000db858c05f06f30b0@google.com>
References: <000000000000db858c05f06f30b0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4ciVVk5SHtqahktTgA_Y_-OLRdR_qJb2
X-Proofpoint-GUID: 4ciVVk5SHtqahktTgA_Y_-OLRdR_qJb2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=551
 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312210033

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f9ff5644bcc0

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 56b870d9cc0d..a40e0f5ca67c 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -149,7 +149,7 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	int cur_cmap_i, next_cmap_i;
+	int cur_cmap_i, next_cmap_i, ei = 0;
 	unsigned int num_clusters = 0;
 	unsigned int clu;
 
@@ -176,8 +176,11 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 
 	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
 		unsigned int last_cluster = p_chain->dir + p_chain->size - 1;
+		printk("b dir: %u, s: %u, nc: %u\n", p_chain->dir, p_chain->size, num_clusters);
 		do {
 			bool sync = false;
+			if (ei > 100)
+				break;
 
 			if (clu < last_cluster)
 				next_cmap_i =
@@ -192,12 +195,17 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 			exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
 			clu++;
 			num_clusters++;
+			ei++;
 		} while (num_clusters < p_chain->size);
+		printk("e dir: %u, s: %u, nc: %u, e: %d\n", p_chain->dir, p_chain->size, num_clusters, ei);
 	} else {
+		printk("b2 dir: %u, s: %u, nc: %u\n", p_chain->dir, p_chain->size, num_clusters);
 		do {
 			bool sync = false;
 			unsigned int n_clu = clu;
 			int err = exfat_get_next_cluster(sb, &n_clu);
+			if (ei > 100)
+				break;
 
 			if (err || n_clu == EXFAT_EOF_CLUSTER)
 				sync = true;
@@ -213,10 +221,12 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 			exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
 			clu = n_clu;
 			num_clusters++;
+			ei++;
 
 			if (err)
 				goto dec_used_clus;
 		} while (clu != EXFAT_EOF_CLUSTER);
+		printk("e2 dir: %u, s: %u, nc: %u, e: %d\n", p_chain->dir, p_chain->size, num_clusters, ei);
 	}
 
 dec_used_clus:

