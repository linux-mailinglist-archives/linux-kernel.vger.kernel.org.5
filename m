Return-Path: <linux-kernel+bounces-49479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F4D846AE8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3BEEB24CE0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1345FDAE;
	Fri,  2 Feb 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Vn2bER8u"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F5818030
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863301; cv=none; b=Z0OjrsiiWfR7ydXgvnVKXUjswSvcDPF5F2cffcVGswULcjF5sbrWxzniPdEOSsQFTd+o4XEM2LfZN7w+87U8EmFzjN8pdDWo6B4dX+r1+o1w3wpMA1J0veUOxlxBNBkqEXjjWDNH93hf2TLmPvrGIBpLONCQFfoT94yJbtYxDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863301; c=relaxed/simple;
	bh=gA/Z0+DSpH/yT0fSkOTdXt0ILwlkJXJtzdovV8rpbrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpAATx76GTb4FLz0zP10mtUBLdZxDGPUldV4TDxHLKGSZ35cALkgU8favmE42xt3usRaCn++wR+M0HbeYPFtmJudzapBx5UtqQ+zYLM54tbOCbeC92ABOF2Ais6gdvNDHI9Mcd7mPfALre0oGhaNWVFPvMqHoEBGutxRw2vHelc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Vn2bER8u; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4127LWG8014123;
	Fri, 2 Feb 2024 08:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=yOMcDWuIdqi4X/XH2Ss9A4elZ8w12/yy7KA0NG0SqeY=; b=
	Vn2bER8uGeMbId7IzSDD5ewZgC3m9Va7JX20oRcZga8TbuPfhCHYQ1FMDLEzG8Xx
	ITNmXA1FZkwTx1EGry47j2LJJjRQMz4zwZw5NUzS00U/eLSTggIYGsGvKsHUL0jo
	wjX0gJC2OLnpAuMPo2TDlVo/XTZVrvZmEyvwm+Ju3oDHk2IBjx0MdZQrREQF0O0a
	qnvilHYyb5T0N0pG0IJMhV2UvP6DZdWUgAPhxk7l1dS+Gu/L/jhmdWAEgWx2wDDx
	TrEBOz7kOXRcAyxKqr6fOAjQEQXU0v9o/stMoSUFDJA5ZqAu1Ub2oUZqqwZ4EQhN
	MZxjbd4gdILifzz18mly6A==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w0pvg08kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 02 Feb 2024 08:41:36 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 00:41:34 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 00:41:34 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in v9fs_stat2inode_dotl
Date: Fri, 2 Feb 2024 16:41:33 +0800
Message-ID: <20240202084133.2624148-1-lizhi.xu@windriver.com>
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
X-Proofpoint-GUID: rMCtFHw6gp6hYs3YDoCnBVA8aL8E5iV6
X-Proofpoint-ORIG-GUID: rMCtFHw6gp6hYs3YDoCnBVA8aL8E5iV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=481 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020062

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index ef9db3e03506..2b313fe7003e 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -78,11 +78,11 @@ struct inode *v9fs_fid_iget_dotl(struct super_block *sb, struct p9_fid *fid)
 
 	retval = v9fs_init_inode(v9ses, inode, &fid->qid,
 				 st->st_mode, new_decode_dev(st->st_rdev));
+	v9fs_stat2inode_dotl(st, inode, 0);
 	kfree(st);
 	if (retval)
 		goto error;
 
-	v9fs_stat2inode_dotl(st, inode, 0);
 	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	retval = v9fs_get_acl(inode, fid);

