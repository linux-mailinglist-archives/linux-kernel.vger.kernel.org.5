Return-Path: <linux-kernel+bounces-86685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA7686C900
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DC81F248AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9698F7CF2F;
	Thu, 29 Feb 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="YPQZvCho"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC877B3D1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209145; cv=none; b=hg/IC6XuX4/O1rAUXw1BdJAhoQjTgKDqDt6aPPSDuoUJg/jPKu3dKeWDCknSQAuUEG85DOcEggrNUdU2wzYaH5ppSXTOa8uttyoaq8R4ts4ibabbgZNjxRICcLBgJz0kgqstGqpqcHd+R738c5FXf2EexuPHgMBNpKC6aiYKPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209145; c=relaxed/simple;
	bh=ob9I68XwHPK2eYEM0MtrNgpwmwAN/WdbqJzDEKS2+i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kdy/bMQMcP9ez4WFxNaDz16LAo2Zp53RgyCiLO2f4Q+DHJOBLZjcm7MY0EkbPrZoVa+Ed2dtVi279z31YFrcaxQF7cHXh2o3GqREb7AfQoVedXjj+vR7emScyr0nVBC3PUME+CMsuAc1MJwaTrjk3N7OAp3J9YZLpvSm+2+DPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=YPQZvCho; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4348aaa705so131052066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709209142; x=1709813942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CK/gyhWcnx3ozsMFB9IWH6XZsidf01J5WrD6CcF2Cpk=;
        b=YPQZvChopeY9iFwuo+s48f4HVQ9CKnfYQCIZgELkj334wmHYIa8L1G150L3OhACbrA
         f5EszpFYTRKuNXuaMPaTM3xYGsmKm/71bjMuUo+Dxxdbt8UzAtRuBn0bV1pBm+MvzjoE
         yr2jjOyAR9seg4Cn5eXubaztErGFbQlS2FvlW/F852VnqCuc6xApmAhlD0x3VZnErZEc
         CamXHbHmj53Nrpeka3SD6fquFODbv8IXEXnd9eCI0tD4bLBNjziptU/UqVbLZDhh1iCS
         U8aGNiZSJl0/597qrfO4Ax7IZ54tsioY4FOkXRVtaqHMz2Oh5HMEXgvKDJj+PAlcIOpX
         eTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709209142; x=1709813942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CK/gyhWcnx3ozsMFB9IWH6XZsidf01J5WrD6CcF2Cpk=;
        b=Tj37i+o6beEqgr5LmzikYIW8RpymEbKuoqzSvW5A04KqAMBcFaI+UYaCo9c5jsF9nE
         ko6bx3yOEvlWdrwG4cZ3fSbvAGTRMwNEeRr2KnTu2gxl+Lnf7Tmxl76FMOXQf75kQEOJ
         kWMVF6qiF6wJ4NEpMWy9KfHFVAZGH8OapSznBrUorTiTpgLPfbFiWKAj8kv8lOT53Ez/
         bDlNRW9qEEOtRTjYEhHICjQOubwtuxSmNNnaFowh1JqqAIb31TBSoQrS84+ZfaHAeEfq
         7qtPDAFoE8o8GJxuco95ad+KWzFPv1G1Jo3/vSUbr/AAR46v7ruhfrElAz8u4G0zSOFp
         tMuA==
X-Forwarded-Encrypted: i=1; AJvYcCV4VgFT5vzToF/2/bvBwdoTYq8IG/jl2+ckyHWV03nG22gENZWSxxUfCIcDmx5eLrWOsoTIQB5ngXWEvgxiFWpM+Egg0PGgWDjFSYNR
X-Gm-Message-State: AOJu0YwJf3fjqv6GY3Rp6DwSxh24ncEwkoRFeJNBb/eDxtFtol1FOUzL
	l5/XXbje+iH03wNK/wUOEMzm+uxyAgHq5QDwNvdo3ATcoTvaf3ARsRFbb5wEgcg=
X-Google-Smtp-Source: AGHT+IF6pa9RCtJLn2UJSZqPkK7BUg0kISl2l4MpvEHaWBWsTVgXcg8Nrgt3oGsfmrlMYsK5JbqVOQ==
X-Received: by 2002:a17:906:f6d2:b0:a44:415d:fa3b with SMTP id jo18-20020a170906f6d200b00a44415dfa3bmr1229733ejb.6.1709209142367;
        Thu, 29 Feb 2024 04:19:02 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-35.dynamic.mnet-online.de. [82.135.80.35])
        by smtp.gmail.com with ESMTPSA id vi10-20020a170907d40a00b00a445db55f39sm161039ejc.156.2024.02.29.04.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:19:02 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] nilfs2: Use div64_ul() instead of do_div()
Date: Thu, 29 Feb 2024 13:16:50 +0100
Message-ID: <20240229121650.33983-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes Coccinelle/coccicheck warning reported by do_div.cocci.

Compared to do_div(), div64_ul() does not implicitly cast the divisor and
does not unnecessarily calculate the remainder.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/nilfs2/cpfile.c | 2 +-
 fs/nilfs2/dat.c    | 2 +-
 fs/nilfs2/ioctl.c  | 4 ++--
 fs/nilfs2/sufile.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index 39136637f715..bafbdca1a17d 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -28,7 +28,7 @@ nilfs_cpfile_get_blkoff(const struct inode *cpfile, __u64 cno)
 {
 	__u64 tcno = cno + NILFS_MDT(cpfile)->mi_first_entry_offset - 1;
 
-	do_div(tcno, nilfs_cpfile_checkpoints_per_block(cpfile));
+	tcno = div64_ul(tcno, nilfs_cpfile_checkpoints_per_block(cpfile));
 	return (unsigned long)tcno;
 }
 
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 9cf6ba58f585..df5324b0c0cd 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -460,7 +460,7 @@ ssize_t nilfs_dat_get_vinfo(struct inode *dat, void *buf, unsigned int visz,
 		kaddr = kmap_atomic(entry_bh->b_page);
 		/* last virtual block number in this block */
 		first = vinfo->vi_vblocknr;
-		do_div(first, entries_per_block);
+		first = div64_ul(first, entries_per_block);
 		first *= entries_per_block;
 		last = first + entries_per_block - 1;
 		for (j = i, n = 0;
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index cfb6aca5ec38..f1a01c191cf5 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -1111,7 +1111,7 @@ static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
 	segbytes = nilfs->ns_blocks_per_segment * nilfs->ns_blocksize;
 
 	minseg = range[0] + segbytes - 1;
-	do_div(minseg, segbytes);
+	minseg = div64_ul(minseg, segbytes);
 
 	if (range[1] < 4096)
 		goto out;
@@ -1120,7 +1120,7 @@ static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
 	if (maxseg < segbytes)
 		goto out;
 
-	do_div(maxseg, segbytes);
+	maxseg = div64_ul(maxseg, segbytes);
 	maxseg--;
 
 	ret = nilfs_sufile_set_alloc_range(nilfs->ns_sufile, minseg, maxseg);
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index 0a8119456c21..c02b523d9c7e 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -48,7 +48,7 @@ nilfs_sufile_get_blkoff(const struct inode *sufile, __u64 segnum)
 {
 	__u64 t = segnum + NILFS_MDT(sufile)->mi_first_entry_offset;
 
-	do_div(t, nilfs_sufile_segment_usages_per_block(sufile));
+	t = div64_ul(t, nilfs_sufile_segment_usages_per_block(sufile));
 	return (unsigned long)t;
 }
 
-- 
2.44.0


