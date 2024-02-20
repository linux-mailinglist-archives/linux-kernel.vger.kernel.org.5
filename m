Return-Path: <linux-kernel+bounces-72889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085FD85BA30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FAB1C23BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1BD664CF;
	Tue, 20 Feb 2024 11:19:05 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891C65BD9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427944; cv=none; b=kBgNtCjODOXeJ6YXvbZheUjdqI5MIovWXDStycM/cVA4SROpqvtbzPdxxz+5rbK2usjXuZBpDL2uMk+cQapEcPDFYn3S7Q8DboH5t/eLVeVuxWEjJv+AyxyOU2+Ex94fPdD6H5mzZGR8Dz6DSXa+NChQ1xPOOQqRqc9DjAjd6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427944; c=relaxed/simple;
	bh=Ld3jKmC/tlqT6hW73OrH4yphsDala360G+3urdQrHpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hJy7nKeiSSixVj+poKCwXbOuYwlIGBpbzoIG4/IQIuHFMzblKcYRtojI4+wGdOxIbcRn9cj4w1QGCwdXko58fzgTGkMsh4sPtzlzBGGx1uyAyYo/Xcm0KYuHHNDUaGFeQ3oGZ6Q+ejVF1DRFK+d38BYhrX7uGZmBYubaxch4KQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 86cfdc469fc84c3e970cf284272c25a5-20240220
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:85130287-6884-4223-ba73-6490c422df58,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:25
X-CID-INFO: VERSION:1.1.35,REQID:85130287-6884-4223-ba73-6490c422df58,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:25
X-CID-META: VersionHash:5d391d7,CLOUDID:e24c1a84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2402201918544MC1VV6Q,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 86cfdc469fc84c3e970cf284272c25a5-20240220
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 350249388; Tue, 20 Feb 2024 19:18:53 +0800
From: Hao Ge <gehao@kylinos.cn>
To: dhowells@redhat.com,
	marc.dionne@auristor.com
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] afs/addr_prefs: Remove argc < 0 handle in afs_proc_addr_prefs_write
Date: Tue, 20 Feb 2024 19:18:51 +0800
Message-Id: <20240220111851.195483-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove argc < 0 handle in afs_proc_addr_prefs_write,because argc
can only be -EINVAL when argc < 0,This situation should be the
same as argc < 2 to release memory and unlock inode.

Fixes: f94f70d39cc2 ("afs: Provide a way to configure address priorities")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 fs/afs/addr_prefs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/afs/addr_prefs.c b/fs/afs/addr_prefs.c
index a189ff8a5034..ba391f8558d5 100644
--- a/fs/afs/addr_prefs.c
+++ b/fs/afs/addr_prefs.c
@@ -413,8 +413,6 @@ int afs_proc_addr_prefs_write(struct file *file, char *buf, size_t size)
 
 	do {
 		argc = afs_split_string(&buf, argv, ARRAY_SIZE(argv));
-		if (argc < 0)
-			return argc;
 		if (argc < 2)
 			goto inval;
 
-- 
2.25.1


