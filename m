Return-Path: <linux-kernel+bounces-155899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9198AF8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67011B211E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CA8142E74;
	Tue, 23 Apr 2024 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pstb36rT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B5F142909
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713906067; cv=none; b=bzj6OhN7ZMC4NUYkyGGtDQ7P9RX1c34KWXdxkBIDWASDl6+j5n0/YRcnNHTl/Seq4/BpddChZqaEt7DPVGE1gWXa8alO/zcq1YakIBlQqNKcyhhshCGnM6qycuZFtY1A2jJ/teNeSIlLJNfhMJVziXoXNDML1u7i7ylq8EhzK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713906067; c=relaxed/simple;
	bh=e7CauLaOjw66+QtRVHZdSP6Ftd9MxwefvkVgwFUByhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3pR/2vws6Ja/64+k+HmdDVpnKlsvEgK744uZi7YaRkCNpHauF1+meti030n7fuwswRfEvg70KBUGadsbdUk8jacX3vlqeq99megtaBUgHmW8P5iXV119nk/hGsiMnf85ZyVFt2snkYJPkgQvnQKI63iWMCsPtHBTi3IhFKVbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pstb36rT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713906065; x=1745442065;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e7CauLaOjw66+QtRVHZdSP6Ftd9MxwefvkVgwFUByhc=;
  b=Pstb36rT+GaCivipfbGyRAlnT+Me63fml+TrCDZmovLsGbruEIkozPXK
   e6rXJA7jaXAiWZjnltl6bo0AcJcTbK6ZLKfx0NIqqjWVT1Q4zcXuSJkOZ
   EREsQbwws1Kv4c9Tdz4dnGrglarm16GfNyHw7R4UcPAlgQW4SI9815Zkm
   XIcpMD1M9wdyueWR28raGr6Cj0SAhnfPrSxvvXU3xiXlbWaoSuB0oqcJK
   iLt1ZUVYP00QIm/kq297GrLKdMvjgv6wX6ykruLBA8QVn+QMRJWl6Fa4P
   uiUQ6WIP8TShdZTJ2Lr7dbB+cDcq9ry0wCxdB2LZkKy/oRn0tCYyTj6aB
   g==;
X-CSE-ConnectionGUID: m+alnfadRNaz7ynBKERLag==
X-CSE-MsgGUID: kQ3JeZ4zTUyv5/d6S5Xnsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9631510"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9631510"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 14:01:04 -0700
X-CSE-ConnectionGUID: OmAvpVRzTmikz60zNLtQ0A==
X-CSE-MsgGUID: LBhYWRXDQUyFEljakbpWEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28975539"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 23 Apr 2024 14:01:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6306528A; Wed, 24 Apr 2024 00:01:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] fs/ntfs3: Drop stray '\' (backslash) in formatting string
Date: Wed, 24 Apr 2024 00:01:01 +0300
Message-ID: <20240423210101.3678902-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CHECK   /home/andy/prj/linux-topic-uart/fs/ntfs3/super.c
fs/ntfs3/super.c:471:23: warning: unknown escape sequence: '\%'

Drop stray '\' (backslash) in formatting string.

Fixes: d27e202b9ac4 ("fs/ntfs3: Add more info into /proc/fs/ntfs3/<dev>/volinfo")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index fa3cc2b6d34a..c1730fffa0a5 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -468,7 +468,7 @@ static int ntfs3_volinfo(struct seq_file *m, void *o)
 	struct super_block *sb = m->private;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 
-	seq_printf(m, "ntfs%d.%d\n%u\n%zu\n\%zu\n%zu\n%s\n%s\n",
+	seq_printf(m, "ntfs%d.%d\n%u\n%zu\n%zu\n%zu\n%s\n%s\n",
 		   sbi->volume.major_ver, sbi->volume.minor_ver,
 		   sbi->cluster_size, sbi->used.bitmap.nbits,
 		   sbi->mft.bitmap.nbits,
-- 
2.43.0.rc1.1336.g36b5255a03ac


