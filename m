Return-Path: <linux-kernel+bounces-66075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8C855648
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05611C219D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1912511E;
	Wed, 14 Feb 2024 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="cy9W9ytx"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70D61DDC1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950747; cv=none; b=EPWoXY++6kLO3Eon7UjLexzBtfj3pqJ3dAn3/ajdi51lAte2fSr+8T0P/4iPH7TZol8Qq6hoL3HLUK8fKEVNffvw12HHqXsLd2WJ/4c0eCi6FGtH5GSeuFX/ggkmrQCmAcPz5CjEVwrY+6L3kG0AxV4haB5R2tm+Aq61iHPU8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950747; c=relaxed/simple;
	bh=Tmfl2Q2d9LtThpZUB2HoXDesIEkpD1mXThibjey9ijo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V4+qpJrsdOtU+eVEbBZZ//ob0uUX9PT4ZHDXONnsCV87c+/6XlpnTJUoD8DgpX6/RX9io6woXOxy5I1cYaMFr63t6NUOvCVttMA8SJ5uO7wDBtwUIMsYPS4Ec3HrmSUzMm4+BaVky+2Qt0N8VVqUHlrZZ7mRuL9XioaxwmNNpDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=cy9W9ytx; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 01A25240101
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:45:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1707950742; bh=Tmfl2Q2d9LtThpZUB2HoXDesIEkpD1mXThibjey9ijo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=cy9W9ytxBHqdbX1LWIcnKyakyzujdS1CDgOswvp3yHNu9CIHa996sftEFlzRwX8v5
	 4osnsakbSXxk8Eny1TzcM6aVjIxPUCvFvyj7t37tZRtOjBaNWv48El3+R77WrrHIK5
	 SOHA/KYMt03jCx6yI55QikoA/GgBTwbXhZB0jGF0gDF+KYDDEXm2IltvEf21lDWHfk
	 t6TDpOWT8YLsK6fdcbljEosSS405wyd2Pr0/J8Y06pYkydheW0KdMv8AW6G3Ee5XK/
	 2IgKYNzf4ZIJ094ql04cBMrAUZ3HLjxGGWqNukhm0WKcPrw0UqRoESdJKObvWPBobG
	 WTM7HfPpfgEkg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TZtZY0DPtz6tw2;
	Wed, 14 Feb 2024 23:45:40 +0100 (CET)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: ntfs3@lists.linux.dev,
	almaz.alexandrovich@paragon-software.com,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH] fs/ntfs3: fix build without CONFIG_NTFS3_LZX_XPRESS
Date: Wed, 14 Feb 2024 22:45:00 +0000
Message-Id: <20240214224500.811609-1-shiftee@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_NTFS3_LZX_XPRESS is not set then we get the following:
fs/ntfs3/frecord.c:2460:16: error: unused variable ‘i_size’

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 3b42938a9d3b..7f27382e0ce2 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2457,7 +2457,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct runs_tree *run = &ni->file.run;
 	u64 valid_size = ni->i_valid;
-	loff_t i_size = i_size_read(&ni->vfs_inode);
 	u64 vbo_disk;
 	size_t unc_size;
 	u32 frame_size, i, npages_disk, ondisk_size;
@@ -2509,6 +2508,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		err = -EOPNOTSUPP;
 		goto out1;
 #else
+		loff_t i_size = i_size_read(&ni->vfs_inode);
 		u32 frame_bits = ni_ext_compress_bits(ni);
 		u64 frame64 = frame_vbo >> frame_bits;
 		u64 frames, vbo_data;

base-commit: 7e90b5c295ec1e47c8ad865429f046970c549a66
-- 
2.39.2


