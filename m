Return-Path: <linux-kernel+bounces-147098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683308A6F76
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D8F1C21405
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1CB130A79;
	Tue, 16 Apr 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh0V2L1V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA2130A48;
	Tue, 16 Apr 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280571; cv=none; b=RSB+PWIHYQbj/TKYrCaeWXZ9Uxk3wUGnegi2rZfoyRXsG9/tzeZOrS8Yj0JcmZZ7RmSQoIS4AqB0e/jSVRWCm/Havj/BeOCF32Jd0POBXFPG13nKEus4YbdGlD1cyY+tL/L16pziL3YCgAGtuggyFvhJtTQHUwPJoWxQSeTIdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280571; c=relaxed/simple;
	bh=pB3eL6Og55inUv0jxBTwVZj2HYy/Y6g0TVL2kPiLImE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UPI/1/NftdgzohndEp1byhABGiwrLkXi8/ly+yDu4/ZJygDyyhDwXI1IH+wtOFD1Eus6IpSfD4JKLD7E3uSbk7WaNtrK9/ZRaUIJ8qZx+3noj3Zyr6xfiiB950itBcBH0WEkSMN2d8tcP9LfT18BtfPX/5VMRNPdOTGO55klxFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh0V2L1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65600C113CE;
	Tue, 16 Apr 2024 15:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713280569;
	bh=pB3eL6Og55inUv0jxBTwVZj2HYy/Y6g0TVL2kPiLImE=;
	h=From:Date:Subject:To:Cc:From;
	b=oh0V2L1VJlq9rAC0hvKHIvKvgT3WuS7WraRiLXN9uX7tqjvCqurRBHV4LDANh9b5k
	 Tt1YEHnRaJA6OSXr5DCHSP3MvjOhTVarAi5qf6QbhpZuV/edtAkSPahpPuMkKLuNAk
	 BuvMiDlf3iaPqY229jpoyqzZ+QtCmqr6w7LS2MyLOAsXBZaqpOilcLFBHBqc3ALGR1
	 THmKU1uYh0IvQsIqJzGg7eh0UhzOfIJK1koy/3PLO6ieQMP10tpcYdJT0NwMLVFwfc
	 TT/7nUh/ZT2a2/FMDVeyBYb5BjUKnJkWkQxvsNk3fSUOkiN++PzNb8bdgw3AJocZ0j
	 8gUT9yqvh7NnQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 16 Apr 2024 08:16:02 -0700
Subject: [PATCH] bcachefs: Fix format specifier in validate_bset_keys()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-bcachefs-fix-format-specifier-validate_bset_keys-v1-1-3ea2cdf28b12@kernel.org>
X-B4-Tracking: v=1; b=H4sIADKWHmYC/x2N0QqDMAwAf0XyvIB1InS/MobENNXgptIUcYj/v
 rLHe7i7E0ySisGjOiHJrqbrUsDdKuCJllFQQ2Fo6qatW9fhwMSTRMOoB8Y1fSijbcIaVRLu9NZ
 AWfrBJPezfA07f2cXiIJnDyW7JSnqf/l8XdcP7vg9a4IAAAA=
To: kent.overstreet@linux.dev
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2827; i=nathan@kernel.org;
 h=from:subject:message-id; bh=pB3eL6Og55inUv0jxBTwVZj2HYy/Y6g0TVL2kPiLImE=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGly0yw/qRnkMy1z3cdYukl07nKLk3/v2Z9gvOddsni6W
 utG/ltzO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEylUZGW7q/f1bovwgTzUq
 /8Y3ztPnGJymxfZx7hR7d/apuN7cmjuMDH8vCXrvZW+3+ZtjUjlLPny+WOJJi/rZaw99vlxnK3d
 1IRsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building for 32-bit platforms, for which size_t is 'unsigned int',
there is a warning from a format string in validate_bset_keys():

  fs/bcachefs/btree_io.c: In function 'validate_bset_keys':
  fs/bcachefs/btree_io.c:891:34: error: format '%lu' expects argument of type 'long unsigned int', but argument 12 has type 'unsigned int' [-Werror=format=]
    891 |                                  "bad k->u64s %u (min %u max %lu)", k->u64s,
        |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  fs/bcachefs/btree_io.c:603:32: note: in definition of macro 'btree_err'
    603 |                                msg, ##__VA_ARGS__);                     \
        |                                ^~~
  fs/bcachefs/btree_io.c:887:21: note: in expansion of macro 'btree_err_on'
    887 |                 if (btree_err_on(!bkeyp_u64s_valid(&b->format, k),
        |                     ^~~~~~~~~~~~
  fs/bcachefs/btree_io.c:891:64: note: format string is defined here
    891 |                                  "bad k->u64s %u (min %u max %lu)", k->u64s,
        |                                                              ~~^
        |                                                                |
        |                                                                long unsigned int
        |                                                              %u
  cc1: all warnings being treated as errors

BKEY_U64s is size_t so the entire expression is promoted to size_t. Use
the '%zu' specifier so that there is no warning regardless of the width
of size_t.

Fixes: 031ad9e7dbd1 ("bcachefs: Check for packed bkeys that are too big")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404130747.wH6Dd23p-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202404131536.HdAMBOVc-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/bcachefs/btree_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/btree_io.c b/fs/bcachefs/btree_io.c
index 9678b2375bed..debb0edc3455 100644
--- a/fs/bcachefs/btree_io.c
+++ b/fs/bcachefs/btree_io.c
@@ -888,7 +888,7 @@ static int validate_bset_keys(struct bch_fs *c, struct btree *b,
 				 -BCH_ERR_btree_node_read_err_fixable,
 				 c, NULL, b, i,
 				 btree_node_bkey_bad_u64s,
-				 "bad k->u64s %u (min %u max %lu)", k->u64s,
+				 "bad k->u64s %u (min %u max %zu)", k->u64s,
 				 bkeyp_key_u64s(&b->format, k),
 				 U8_MAX - BKEY_U64s + bkeyp_key_u64s(&b->format, k)))
 			goto drop_this_key;

---
base-commit: 96fca68c4fbf77a8185eb10f7557e23352732ea2
change-id: 20240416-bcachefs-fix-format-specifier-validate_bset_keys-693c1daad9c9

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


