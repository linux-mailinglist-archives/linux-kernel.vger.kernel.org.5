Return-Path: <linux-kernel+bounces-123022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFC5890126
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F03FB23AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3C582D62;
	Thu, 28 Mar 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R998RHJ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9DC84D31;
	Thu, 28 Mar 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634808; cv=none; b=qRoMbQ0uxkfl+MOL3rvHFVyw/MqQ6XV3Snl/est9smpEbNC3gFl91boUJ/OZKET8I5UY3ZtW0RwaM/SVTPzNr0TWQJEUc8tS8WhrqSN9pOG7kztjyQrHyVLmgGbNy2pM5SsqWgjAEr8CplOaRassyRSr2UwBZyzrgsc1gdjN1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634808; c=relaxed/simple;
	bh=yHFhPfrMMHs59SCQp+6DZsAO2LqRForPxbzKn/h9OZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lnP6Gu+2h+Z0gfI1FOG37wqu+3ARzH10LbuN/gGkWignOQ1F77dpHWE5+28eLVOK/h9ts7gWgcWRtGDgVGwX0fcyuiHiAFI2CcRcHaIfFxNmEGPUeGXL9pUhFqDY0Bb75VU9+Yh1+vQChLZVXFCZR/zgN8sliwYbmN6wKWgBpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R998RHJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68FAC433C7;
	Thu, 28 Mar 2024 14:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634808;
	bh=yHFhPfrMMHs59SCQp+6DZsAO2LqRForPxbzKn/h9OZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R998RHJ3bF9lTIX5YWthw9VZaOAKxAC8PYU9VG6hxbfvkV/2ojvYP+QAo5KdLlrQ7
	 /wz84TbbA9274ily1eOENho1tB+8cFC9giRCQegDvg4tPyUwccnz0Bdw4+I8Moyt5s
	 Rw0NhibOpG0YPZHN8OLMstOKFp8ZFMWrowVFFP0BQ5sTlgZ4NiVcAIGqdCXFuNq3ne
	 uKY3f9mdvItaaz+H+E9vnv4jxK/06AW1LCwyelKi2hAuNcupkYrRwVqZD+9E7z3+B5
	 dAytiqSnnjaHoDp+hvabvCDcEm3Rry4aP06xRnDKpxAYTsukGYcIucItdTYFK0MG4s
	 JHhAW59Pcv4eg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Richard Russon (FlatCap)" <ldm@flatcap.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-ntfs-dev@lists.sourceforge.net,
	linux-block@vger.kernel.org
Subject: [PATCH 07/11] block/partitions/ldm: convert strncpy() to strscpy()
Date: Thu, 28 Mar 2024 15:04:51 +0100
Message-Id: <20240328140512.4148825-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140512.4148825-1-arnd@kernel.org>
References: <20240328140512.4148825-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The strncpy() here can cause a non-terminated string, which older gcc
versions such as gcc-9 warn about:

In function 'ldm_parse_tocblock',
    inlined from 'ldm_validate_tocblocks' at block/partitions/ldm.c:386:7,
    inlined from 'ldm_partition' at block/partitions/ldm.c:1457:7:
block/partitions/ldm.c:134:2: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
  134 |  strncpy (toc->bitmap1_name, data + 0x24, sizeof (toc->bitmap1_name));
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
block/partitions/ldm.c:145:2: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
  145 |  strncpy (toc->bitmap2_name, data + 0x46, sizeof (toc->bitmap2_name));
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

New versions notice that the code is correct after all because of the
following termination, but replacing the strncpy() with strscpy_pad()
or strcpy() avoids the warning and simplifies the code at the same time.

Use the padding version here to keep the existing behavior, in case
the code relies on not including uninitialized data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/partitions/ldm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 38e58960ae03..2bd42fedb907 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -131,8 +131,7 @@ static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
 		ldm_crit ("Cannot find TOCBLOCK, database may be corrupt.");
 		return false;
 	}
-	strncpy (toc->bitmap1_name, data + 0x24, sizeof (toc->bitmap1_name));
-	toc->bitmap1_name[sizeof (toc->bitmap1_name) - 1] = 0;
+	strscpy_pad(toc->bitmap1_name, data + 0x24, sizeof(toc->bitmap1_name));
 	toc->bitmap1_start = get_unaligned_be64(data + 0x2E);
 	toc->bitmap1_size  = get_unaligned_be64(data + 0x36);
 
@@ -142,8 +141,7 @@ static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
 				TOC_BITMAP1, toc->bitmap1_name);
 		return false;
 	}
-	strncpy (toc->bitmap2_name, data + 0x46, sizeof (toc->bitmap2_name));
-	toc->bitmap2_name[sizeof (toc->bitmap2_name) - 1] = 0;
+	strscpy_pad(toc->bitmap2_name, data + 0x46, sizeof(toc->bitmap2_name));
 	toc->bitmap2_start = get_unaligned_be64(data + 0x50);
 	toc->bitmap2_size  = get_unaligned_be64(data + 0x58);
 	if (strncmp (toc->bitmap2_name, TOC_BITMAP2,
-- 
2.39.2


