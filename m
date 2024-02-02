Return-Path: <linux-kernel+bounces-49475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5232F846AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59BF1F264A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1021862B;
	Fri,  2 Feb 2024 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="iLGZnmEC"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596D6182B3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862955; cv=none; b=A9Fnrqck860H5N+UdH0fgMlCaMJr32g8tEhdIxq4cvUYakvUJfKP7XUFOfjLe1jHq2b49jw2bi1F/KKjQzCbxDbU1c4P0mMFl+0CalLgJ6RWO76+AkgVSlMdaTF5c1E0moUth511ZfsyRg8wfbw+oJ+sqknRR4TnhTk1GJeZhjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862955; c=relaxed/simple;
	bh=8eV5u1OGTI4t/SRy8w9CenjXu8cgkdrUvYo8GQYd8m4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKU5mWB2BtGRUCgiCJ6PnOM8H7oJLqZ2OBARxy9STV7fIlY62+qhLLcaWNpqhuV1Buwd781tvot0eHWHH4BDUJp8aiIeZTlnujl7DcX7MRr5PdqEZbq0DX4XHiF5CtI83yEknzceHKCzYfzoihebpplnQU6XMdRAHOYSALhR3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=iLGZnmEC; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4126UcML019911;
	Fri, 2 Feb 2024 08:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=cifVdN/BWCjPEATbgcrIPOECirbrweYCh5LvFuV7M6o=; b=
	iLGZnmEC6smQCTqQnxEV9nCf90FsypouoilGQgSMjIM0oLHIB5GspxqNAg+tfb4F
	A0sNY1pG73pyKkfFffmTVz9rAbvrvzpMhHzA7zSWl4cR7ikR8qi7E/AyU2HX98Kw
	oezpAnxE0n6+RVq45hZfitGSzy0ud0KxSWTxB+Xm1A5bSaz6kiTqrSknZi1Ck7oj
	RCKFP9po+/NcdZplUaQHnRTiAkaPdrtfYWrQ66NXCqO0AR2gX/LO9nJG6ZBT4RaM
	wB1fk/B7pQqMdhphgO9XNeWTIARDSZCZo8PwYF63+LgvJoW15OyOtqtjWLaXgvXE
	/gvQY1dZEAIvSVnx2vRl8g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w0pvg08f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 02 Feb 2024 08:35:49 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 00:35:49 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 00:35:48 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in v9fs_stat2inode_dotl
Date: Fri, 2 Feb 2024 16:35:46 +0800
Message-ID: <20240202083546.2409378-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000055ecb906105ed669@google.com>
References: <00000000000055ecb906105ed669@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Q5pBYCrsXb9eoV-v_bYgVqFOXQyoU7ka
X-Proofpoint-ORIG-GUID: Q5pBYCrsXb9eoV-v_bYgVqFOXQyoU7ka
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=512 suspectscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020062

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ef9db3e03506..6ad86b604877 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -82,7 +82,6 @@ struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
 	if (retval)
 		goto error;
 
-	v9fs_stat2inode_dotl(st, inode, 0);
 	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	retval = v9fs_get_acl(inode, fid);

