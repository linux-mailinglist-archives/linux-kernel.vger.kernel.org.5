Return-Path: <linux-kernel+bounces-101376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D213687A649
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B50B21B61
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E173F8F4;
	Wed, 13 Mar 2024 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXhzvalU"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9343E48F;
	Wed, 13 Mar 2024 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327516; cv=none; b=HgLVK1Mhk+kTZ5JvLokfXnV1n/SSbM4VggFNlUce5rkCnaleYXsv0Z/EQDEIncFYAR2iQK7LYklpgWRmScS0zAmtIKgXz2fG/fn3da8gS2OQoX5mUwO7/HC0Qx4TMwcsv1/DDsgzfHJdZ5em+5GFqStHlcI9ACuYFGRZVOFVEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327516; c=relaxed/simple;
	bh=dccZtKU0JlNUVr32j5N+d7c3EvI4g68BqJxBgIIgVhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=onF+Ue/O46U29DTI6vA6GFxdy8O2rXBLtRTL4A/ZZPAK8deng8rGc3m9yt9VTHOpWvZ6ByzS1W++QiovtcVKLp8uHJ7KmXT4PcGWfZ8eYMJIvtlhb8DOoCE6gQubq5em5YV/8f/oJnhABEq28nZaE7vBT3tLmzyqaS8nhIzCIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXhzvalU; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8b276979aso658838a12.2;
        Wed, 13 Mar 2024 03:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710327514; x=1710932314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m984Ws2yJdwqjTVQsyhkvfVodbR7IH0GQOBzSAUxcQY=;
        b=FXhzvalUq4/l9LTZf/kLVm4J2iHo3kr3jaKDNwS7GVlsl4lM2MoFk3gwlxErAbeX87
         yS16JM2UajFIsjZbBnyfEj4xc3BegH2RfOPQ1NMno70P2G++prFY8eGBFqqL8zTyyyj7
         FcVkv9jlmHGc9FF6L0Qw7P/Pk6Yfr5jhy9oeSmw4SwISP3qqyITMOH7A2jiSXo3WHZkg
         bj6AFrOgFN2r1QLYWdw+dX+mSOH2+KSylUCVRdeiPfp2TavDEsU9rkzj6qHvy5rqaCOo
         02WyZCCMJImjuE7O5V+uHtxp7Fql4KTTnXqEvxq7qrlkzq1qHWSXx2hm2uujYTzYzfQf
         8EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327514; x=1710932314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m984Ws2yJdwqjTVQsyhkvfVodbR7IH0GQOBzSAUxcQY=;
        b=TKTfukCvwJ6A5P+lEG/taoP313IXXN/IigeRb3MPo0l12jIdRkPrjWlhh1TxXK8aw3
         HEfn9K7ZkqfQpHLEMiWGfqdAP8/Showwz3nzB2ssdAF1aSNrPJdODDOptpmTivlqNTw6
         M2TpFExiQWOXSFmHimuUbqYhsNiKGKHr8ZkZQGgW3wyOrKQrmBp6Btx5KD1EQvN+qrrU
         /pz0z3cxlwj6LHIBOJ6vk+HTmp6JKI0+L4pWYCSC3r6BIH4RjeLfgrIb2hTre7hl1Itj
         HzmgvTp47Z4kuO4o9hnSbyPx2JOwCUHx2gZcXDZlk9xoJ/yd1+gCo6dQ1AkKofOoPh6E
         dREA==
X-Forwarded-Encrypted: i=1; AJvYcCWn2zWOZrO5nz1pGhvLhnVC9rOnvV8W9Mj23pg5zIrWfusFqRLzmHgW1IXK/NHO3eat9rRir4bLO37uYBG2OCbkWvj04Sx43QGz9ScwanyG3f3fEPS8gqvDJ2wxBbjWQ2iHzbBL4qxKX84=
X-Gm-Message-State: AOJu0Yx8oV3vHxRojEW4z1OZjWTTmXi8Vx4NaTtGFqS4yBs7UST4+og3
	MYMPZ4/GTJbf2eG5SYTobx6b5M7iLJKkfgqTEm+uMJyWjNhXQjeL
X-Google-Smtp-Source: AGHT+IFES8pqkygZOq7hunkkntfKi8UTKMQzY4eTOyNocnWOJt08ELxH/Tj9ZSY4K4MJdoBvs4lTBw==
X-Received: by 2002:a05:6a20:d387:b0:1a2:f4fd:b1cb with SMTP id iq7-20020a056a20d38700b001a2f4fdb1cbmr7686010pzb.55.1710327514158;
        Wed, 13 Mar 2024 03:58:34 -0700 (PDT)
Received: from carrot.. (i223-217-148-4.s42.a014.ap.plala.or.jp. [223.217.148.4])
        by smtp.gmail.com with ESMTPSA id m5-20020aa78a05000000b006e6ab7cb10esm2338844pfa.186.2024.03.13.03.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:58:33 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nilfs2: fix failure to detect DAT corruption in btree and direct mappings
Date: Wed, 13 Mar 2024 19:58:26 +0900
Message-Id: <20240313105827.5296-2-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313105827.5296-1-konishi.ryusuke@gmail.com>
References: <0000000000002df264056a35b16b@google.com>
 <20240313105827.5296-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has reported a kernel bug in submit_bh_wbc() when writing file
data to a nilfs2 file system whose metadata is corrupted.

There are two flaws involved in this issue.

The first flaw is that when nilfs_get_block() locates a data block
using btree or direct mapping, if the disk address translation routine
nilfs_dat_translate() fails with internal code -ENOENT due to DAT
metadata corruption, it can be passed back to nilfs_get_block().  This
causes nilfs_get_block() to misidentify an existing block as
non-existent, causing both data block lookup and insertion to fail
inconsistently.

The second flaw is that nilfs_get_block() returns a successful status
in this inconsistent state.  This causes the caller
__block_write_begin_int() or others to request a read even though the
buffer is not mapped, resulting in a BUG_ON check for the BH_Mapped
flag in submit_bh_wbc() failing.

This fixes the first issue by changing the return value to code
-EINVAL when a conversion using DAT fails with code -ENOENT, avoiding
the conflicting condition that leads to the kernel bug described
above.  Here, code -EINVAL indicates that metadata corruption was
detected during the block lookup, which will be properly handled as a
file system error and converted to -EIO when passing through the
nilfs2 bmap layer.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+cfed5b56649bddf80d6e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cfed5b56649bddf80d6e
Fixes: c3a7abf06ce7 ("nilfs2: support contiguous lookup of blocks")
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
 fs/nilfs2/btree.c  | 9 +++++++--
 fs/nilfs2/direct.c | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 13592e82eaf6..65659fa0372e 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -724,7 +724,7 @@ static int nilfs_btree_lookup_contig(const struct nilfs_bmap *btree,
 		dat = nilfs_bmap_get_dat(btree);
 		ret = nilfs_dat_translate(dat, ptr, &blocknr);
 		if (ret < 0)
-			goto out;
+			goto dat_error;
 		ptr = blocknr;
 	}
 	cnt = 1;
@@ -743,7 +743,7 @@ static int nilfs_btree_lookup_contig(const struct nilfs_bmap *btree,
 			if (dat) {
 				ret = nilfs_dat_translate(dat, ptr2, &blocknr);
 				if (ret < 0)
-					goto out;
+					goto dat_error;
 				ptr2 = blocknr;
 			}
 			if (ptr2 != ptr + cnt || ++cnt == maxblocks)
@@ -781,6 +781,11 @@ static int nilfs_btree_lookup_contig(const struct nilfs_bmap *btree,
  out:
 	nilfs_btree_free_path(path);
 	return ret;
+
+ dat_error:
+	if (ret == -ENOENT)
+		ret = -EINVAL;  /* Notify bmap layer of metadata corruption */
+	goto out;
 }
 
 static void nilfs_btree_promote_key(struct nilfs_bmap *btree,
diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index 4c85914f2abc..893ab36824cc 100644
--- a/fs/nilfs2/direct.c
+++ b/fs/nilfs2/direct.c
@@ -66,7 +66,7 @@ static int nilfs_direct_lookup_contig(const struct nilfs_bmap *direct,
 		dat = nilfs_bmap_get_dat(direct);
 		ret = nilfs_dat_translate(dat, ptr, &blocknr);
 		if (ret < 0)
-			return ret;
+			goto dat_error;
 		ptr = blocknr;
 	}
 
@@ -79,7 +79,7 @@ static int nilfs_direct_lookup_contig(const struct nilfs_bmap *direct,
 		if (dat) {
 			ret = nilfs_dat_translate(dat, ptr2, &blocknr);
 			if (ret < 0)
-				return ret;
+				goto dat_error;
 			ptr2 = blocknr;
 		}
 		if (ptr2 != ptr + cnt)
@@ -87,6 +87,11 @@ static int nilfs_direct_lookup_contig(const struct nilfs_bmap *direct,
 	}
 	*ptrp = ptr;
 	return cnt;
+
+ dat_error:
+	if (ret == -ENOENT)
+		ret = -EINVAL;  /* Notify bmap layer of metadata corruption */
+	return ret;
 }
 
 static __u64
-- 
2.34.1


