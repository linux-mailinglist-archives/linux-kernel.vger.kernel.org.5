Return-Path: <linux-kernel+bounces-158236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4A58B1D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1817F286126
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6C784DEC;
	Thu, 25 Apr 2024 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXZiv1yx"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628DA7F7F5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035849; cv=none; b=Vsc276PIqfgFbIr3DDwPg/QXHCaWfyj2US60hW/W4xv4wkeZDpWk72ohDc+AFF1p5veBWK0xdhgWSg9I7AsWfIl5q6wLb75kdxFmnBklRFkCU2dTcfmtT7CPXAkpefoIO+PQRo2iLoN6ItVJbhkbVCoI1/WUxCn82rAgoTl940c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035849; c=relaxed/simple;
	bh=on8rRT8rMY6gATS+tExFOpawaAVnjFYUdZ/CCHFPpGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B+LgWVQx6RvCuY5Px+tOFevHhyguqftLrxoiAPOhcoLYzw4i//Wk5xia5xiCw0RZtsQjNUPU1lKifl/BIGD9yuVItd5TKut2TgZWqhdouijkjcnDsgnK6qwvk8VNnypu8e10vMb1lHC3oLD3Wb3ZLrFPbeyK55z5rL/zEoWuzww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXZiv1yx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a6fa7773d3so661766a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714035848; x=1714640648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHSLuFLizRd4+tmfCItUcblIOCsQpklxapzLMa2vQ8U=;
        b=kXZiv1yxJNQnPmXp25nlpbg4L4hZf0VBUkBwS4cHsfWtR0VJHiREag1PWs7JUWKaRd
         AuNgqDk6YfpmpasDK3D5JwHbTfJ46dnOoEHoe64yGf/36ugc8Tf2wEbtG/vnROjIr3Dx
         i2ajwj8tlhVquQ9S87+2Xj9VgdZfpfEsJ3jBTC89AwPFU+/KVjjWVi27WQjMSYwf8IXh
         /5ztxafeeP3KxW3Ut6WzUV7p8yL0ZAwoLp/Bh4T+yvqTogyJJZnQfkcfIkUtqz9FPqqT
         hJ4RqwVCbb8mJ0Aq4vNxLIqZx6myQAqtyYnWvffdXATQdgrUyHngsUvtRfiDafRjxBnK
         nFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714035848; x=1714640648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHSLuFLizRd4+tmfCItUcblIOCsQpklxapzLMa2vQ8U=;
        b=UQETptHJTmmMFx71nCes8D9frbB07uWd9sJLvNg8ScLV4stzdVJCvxA//H8Dq/pR4E
         yLas7/6gET0v7oRVNipaQryL7GbtVzwEHz5xx5ycGBg28o9s8lSUILKGENg3vPKdma3d
         AMC8T4CxLb31o8QDhuzmhAShaJZWOtR8IwqR1yMpy5EfAgV6hEEx3LR/Mg4aMtG+kheL
         HKl8RXfE8n011TUXoN/AOMVHwovwfq7J60glH1kI+DZ7YBQxMg/66anzma4TwhdllQtr
         3HPmGgv/1BvwSoZ+V4S1M9p6lLYsSO8qpZXQrgKC5hQiEkCaWDERRKq71Ke9Em2vzt4y
         96MA==
X-Gm-Message-State: AOJu0Yy9KRSDC+w4EvUqruHXDqi5HQnAABnKFN4GxdSWfYsWj0r0ImFz
	Q7YuK8ESlzq0edLvdAj6rAhD0mbnu6vtxeiKiZXX3xi/+GjCicJnNmQ/5/a/RMg=
X-Google-Smtp-Source: AGHT+IGfHAxrDFVOGqiQwA5iyjdHA+C0fswWddc9sxsk9epwoagdEYYweJRBLrPMjmfqRd/NzWSB/A==
X-Received: by 2002:a17:90b:4c8e:b0:2a2:3223:1930 with SMTP id my14-20020a17090b4c8e00b002a232231930mr5146142pjb.8.1714035847608;
        Thu, 25 Apr 2024 02:04:07 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id mt13-20020a17090b230d00b002ac5335f554sm540703pjb.1.2024.04.25.02.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 02:04:07 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in diFree
Date: Thu, 25 Apr 2024 18:04:03 +0900
Message-Id: <20240425090403.15270-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000000866ea0616cb082c@google.com>
References: <0000000000000866ea0616cb082c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test array-index-out-of-bounds in diFree

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master

---
 fs/jfs/jfs_dmap.c | 4 +++-
 fs/jfs/jfs_imap.c | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..6681a6272ae7 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -206,6 +206,7 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
+	printk("dmMount : %d\n",bmp->db_agl2size);
 	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
 	    bmp->db_agl2size < 0) {
 		err = -EINVAL;
@@ -316,6 +317,7 @@ int dbSync(struct inode *ipbmap)
 	dbmp_le->dn_agwidth = cpu_to_le32(bmp->db_agwidth);
 	dbmp_le->dn_agstart = cpu_to_le32(bmp->db_agstart);
 	dbmp_le->dn_agl2size = cpu_to_le32(bmp->db_agl2size);
+	printk("dbSync : %d\n",bmp->db_agl2size);
 	for (i = 0; i < MAXAG; i++)
 		dbmp_le->dn_agfree[i] = cpu_to_le64(bmp->db_agfree[i]);
 	dbmp_le->dn_agsize = cpu_to_le64(bmp->db_agsize);
@@ -3393,7 +3395,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
 
 	bmp->db_agl2size = l2agsize;
 	bmp->db_agsize = 1 << l2agsize;
-
+	printk("dbExtendFS : %d\n",bmp->db_agl2size);
 	/* compute new number of AG */
 	agno = bmp->db_numag;
 	bmp->db_numag = newsize >> l2agsize;
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 2ec35889ad24..c39f7685aa97 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -339,7 +339,7 @@ int diRead(struct inode *ip)
 
 	/* get the ag for the iag */
 	agstart = le64_to_cpu(iagp->agstart);
-
+	printk("diRead : %ld\n",agstart);
 	release_metapage(mp);
 
 	rel_inode = (ino & (INOSPERPAGE - 1));
@@ -881,6 +881,8 @@ int diFree(struct inode *ip)
 	 */
 	agno = BLKTOAG(JFS_IP(ip)->agstart, JFS_SBI(ip->i_sb));
 
+	printk("%lu %d %d",JFS_IP(ip)->agstart, JFS_SBI(ip->i_sb)->bmap->db_agl2size, agno);
+
 	/* Lock the AG specific inode map information
 	 */
 	AG_LOCK(imap, agno);
@@ -1298,6 +1300,7 @@ diInitInode(struct inode *ip, int iagno, int ino, int extno, struct iag * iagp)
 	jfs_ip->ixpxd = iagp->inoext[extno];
 	jfs_ip->agstart = le64_to_cpu(iagp->agstart);
 	jfs_ip->active_ag = -1;
+	printk("diInitInode : %lu",jfs_ip->agstart);
 }
 
 
@@ -1908,6 +1911,7 @@ static int diAllocExt(struct inomap * imap, int agno, struct inode *ip)
 		 */
 		iagp->agstart =
 		    cpu_to_le64(AGTOBLK(agno, imap->im_ipimap));
+		printk("diAllocExt : %lu\n",iagp->agstart);
 	} else {
 		/* read the iag.
 		 */
@@ -2898,7 +2902,7 @@ int diExtendFS(struct inode *ipimap, struct inode *ipbmap)
 		agstart = le64_to_cpu(iagp->agstart);
 		n = agstart >> mp->db_agl2size;
 		iagp->agstart = cpu_to_le64((s64)n << mp->db_agl2size);
-
+		printk("diExtendFs : %lu %d\n",agstart, mp->db_agl2size);
 		/* compute backed inodes */
 		numinos = (EXTSPERIAG - le32_to_cpu(iagp->nfreeexts))
 		    << L2INOSPEREXT;
-- 
2.34.1

