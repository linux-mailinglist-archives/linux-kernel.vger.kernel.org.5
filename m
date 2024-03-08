Return-Path: <linux-kernel+bounces-97446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D341B876AA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8808A1F2206F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA705381D4;
	Fri,  8 Mar 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFVXWACm"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462D17745
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921813; cv=none; b=kff1UQJKYoHpr1pqLGlzpuOvjoVfBovyaP2cWADPzvQ5aOEYXymxYUXXJk9OMGiMb2Bpnbd9VLPB5qW37h8G8LEAZTTeqDH3/E7yBNvbMGz0bCa0sQO8+l3VUlwJWpUTodUeIV93Cei5l7l9uI+Lyp1bm7CVZaTXJS1Jf3nHjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921813; c=relaxed/simple;
	bh=BsmKqwy1cXQm1JnmElhH7wdLTmEhSTAibqWkTFXf/HE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dMkcO+qGRqDAoyGJjgAl3jZNfBAfhkuiBNX8blgVPkJbjT+/fwxAoQX1NkfuGhHvFYfQXjC4q3+XcX0ZJNFVq81n3QM3Qoa/pC9rIlnsaQsFhgn7kJuuy1oZDkycqKVTPzWEN5n9aJroGpWDUFUHK9o+RX+BFseJOETvVifdw9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFVXWACm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso1595456b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709921811; x=1710526611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Don58ETJLu3MMttJk2TjQgvjt5Qt3lhRQAH5cABWwSI=;
        b=FFVXWACmn1S+CWgzws0aZ3Yea9Y/jB7bmBautWdQMraT2fpk0FuQD94HPrTCAZ3wgu
         AisZGSldmWLTcc9jXKORPM0eSl4VtOKhIYyvviKka0wLiD/ItBFVaqRmdMReP2jLiLSh
         4hFUHiP/t3+22hoyJoaRClk45NNR4xJxqfPb6HfHdhGLwzB5XjesyUp6rMD+zzERG/A6
         0peYOh6nmcIVC19d2T+x/mpQdb409GBlxX55y+9RalalrzAfeyrT31lLTsuCArxQgTZS
         EM6r4PdiqsGUA6RHffr3QX5luM+/omfpNBurbZiGtTtaBMFiQhnfeFg7MJn2pdPv893o
         kJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709921811; x=1710526611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Don58ETJLu3MMttJk2TjQgvjt5Qt3lhRQAH5cABWwSI=;
        b=TG1rZqI1AXHUjnSznziKhgNbHS10uPrPF6A2jZkR4cbbhh0smuWNKqx3Vt4pCqIPos
         BCgsbV2W3PFVzWDycEvk1vqwikEYgUHv3psIDBZNjnPrc9Gc2GLDPJ32H0qdCniAb0e0
         uGqcE6S++06JWzzUf2WawHG2umNQ454WkquVDLwn75VrAuoSoGLH+9qeE4pki9agW0iZ
         vvXjV1xte8mEsnMM8IoMjSW2PyaBwhZwc5SMF8PZhE9sEf90RYD30Dju3FGYhJVjAwHP
         ewwmZI4kKdVwuu6EcEiwpYqlfppDXSIOaNO4jxmZNKNu/ylk+zHRVGosFPLzqSSv+RKV
         dabg==
X-Gm-Message-State: AOJu0YzDPBjp2nr7ymsM9ArPmUYvN7AGzjZVtJJNLTekEGLIbasqPtkd
	ys6ysJzEbNJ5bveQwQ/2aPrLMYjp869bX6hf/XGI8/LCLPrATDOjDVW70lok
X-Google-Smtp-Source: AGHT+IGtYigR3RzqJjLWV3TyD2YNhQJOxexcT2wNT3BQn0QvCIXjwxqQX5KarsbGcgsbx0veEM/XDA==
X-Received: by 2002:a05:6a00:4f96:b0:6e5:3b8e:bb6b with SMTP id ld22-20020a056a004f9600b006e53b8ebb6bmr24314668pfb.7.1709921810644;
        Fri, 08 Mar 2024 10:16:50 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:b29d:b799:71f5:b0e6])
        by smtp.gmail.com with ESMTPSA id g26-20020aa79f1a000000b006e6660588dasm2123737pfr.128.2024.03.08.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:16:50 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: reset only current zones
Date: Fri,  8 Mar 2024 10:16:46 -0800
Message-ID: <20240308181646.70959-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Send reset commands to only current zones and finish the others.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/fsck.c | 53 +++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 3461a52..5b32d1f 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -3288,38 +3288,39 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), void *blkzone, void *opaque)
 
 	last_valid_blkoff = last_vblk_off_in_zone(sbi, zone_segno);
 
-	/*
-	 * When there is no valid block in the zone, check write pointer is
-	 * at zone start. If not, reset the write pointer.
-	 */
-	if (last_valid_blkoff < 0 &&
-	    blk_zone_wp_sector(blkz) != blk_zone_sector(blkz)) {
-		if (!c.fix_on) {
-			MSG(0, "Inconsistent write pointer: wp[0x%x,0x%x]\n",
-			    wp_segno, wp_blkoff);
-			fsck->chk.wp_inconsistent_zones++;
-			return 0;
-		}
-
-		FIX_MSG("Reset write pointer of zone at segment 0x%x",
-			zone_segno);
-		ret = f2fs_reset_zone(wpd->dev_index, blkz);
-		if (ret) {
-			printf("[FSCK] Write pointer reset failed: %s\n",
-			       dev->path);
-			return ret;
-		}
-		fsck->chk.wp_fixed = 1;
-		return 0;
-	}
-
 	/* if a curseg points to the zone, do not finishing zone */
 	for (i = 0; i < NO_CHECK_TYPE; i++) {
 		struct curseg_info *cs = CURSEG_I(sbi, i);
 
 		if (zone_segno <= cs->segno &&
-				cs->segno < zone_segno + segs_per_zone)
+				cs->segno < zone_segno + segs_per_zone) {
+			/*
+			 * When there is no valid block in the zone, check
+			 * write pointer is at zone start. If not, reset
+			 * the write pointer.
+			 */
+			if (last_valid_blkoff < 0 &&
+			    blk_zone_wp_sector(blkz) != blk_zone_sector(blkz)) {
+				if (!c.fix_on) {
+					MSG(0, "Inconsistent write pointer: "
+					       "wp[0x%x,0x%x]\n",
+					       wp_segno, wp_blkoff);
+					fsck->chk.wp_inconsistent_zones++;
+					return 0;
+				}
+
+				FIX_MSG("Reset write pointer of zone at "
+					"segment 0x%x", zone_segno);
+				ret = f2fs_reset_zone(wpd->dev_index, blkz);
+				if (ret) {
+					printf("[FSCK] Write pointer reset "
+					       "failed: %s\n", dev->path);
+					return ret;
+				}
+				fsck->chk.wp_fixed = 1;
+			}
 			return 0;
+		}
 	}
 
 	/*
-- 
2.44.0.278.ge034bb2e1d-goog


