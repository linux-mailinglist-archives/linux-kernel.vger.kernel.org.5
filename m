Return-Path: <linux-kernel+bounces-155895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB848AF8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093211F22E91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E6142E9A;
	Tue, 23 Apr 2024 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvV/rc20"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2991422B7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905801; cv=none; b=CY5dzySOUKuN2ej4prJgZq48r53VaW8j1CYyYxVRuCKSVCG9ecPhlS1IULQBBhYaVQhS4uH6wdHFlzcMPqCyKh4O108S2BUD7Q3OTeBffWNng21/vuT3Wz8Lf3rvYlxvroYSIcV69d1/FTnNTk0wLNJM0D++8NgL2/p0H76UwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905801; c=relaxed/simple;
	bh=OSZW1dIo9HrRXcWIzvZDXhaKoai+7qSvUqIhaBvvJBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cMapAEc/YDwCfnVLxdIMiib5/1q+HkNi+sok06mKvGqk3hm3tp8aGvR0R+iZcZvSPuK9udQe88kXt+zl8R7lddi23cmr/vHBainize7Fse2VPbRBF4WP3rMSCwgK8FL1xdoGqLG+8b+wS2UTNVToLaczat3yP5Pbw99A6oinal8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvV/rc20; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905800; x=1745441800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OSZW1dIo9HrRXcWIzvZDXhaKoai+7qSvUqIhaBvvJBQ=;
  b=HvV/rc20pz99hG59qEUVtQdLwrDcrHiC92M7hsCcHFtJsluQopr+bT7R
   L5fuLIBIYU5hkB+6VUIo2VmzbIyliHxbkyM2Ff7e7mbg+NetOJM4CbXDo
   P3UPMqkjJ9GNggBCfWqZYWpeRwXW15qF7Xm9l/UiEx0DD7mx9z3XMauG+
   ytCWCT2MMWS4AeiSI4oF+lA5P2kUIT+FLw3b09XyIL0hzaBMA+RzJ0LGZ
   Okc8534ork6sP2GtArWxER5oiVSOXi50T6P8WXIf/1y3iqbiiX46eIJqE
   U12Id4g1ZqfTf/6MXU8mQnGMoeF+GtgQ4C+5ExCe6bOrpO6S4B0XFYSP+
   A==;
X-CSE-ConnectionGUID: vtUh2n/DTk2tJ+4EurkVTA==
X-CSE-MsgGUID: hMn+opqLQhGYUy96YGfEnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20061371"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20061371"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:56:39 -0700
X-CSE-ConnectionGUID: qfsKJUEvRVGUK5vkolM/Vg==
X-CSE-MsgGUID: F5c30+5iTgK0bzhSdw4KvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29284140"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 23 Apr 2024 13:56:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8AEDC192; Tue, 23 Apr 2024 23:56:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] fs/ntfs3: Fix compilation error
Date: Tue, 23 Apr 2024 23:56:34 +0300
Message-ID: <20240423205634.3673120-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compilation with CONFIG_WERROR=y, which is default, is broken:

  fs/ntfs3/super.c:1247:26: error: variable 'attr' is uninitialized when used here [-Werror,-Wuninitialized]

  attr = ni_find_attr(ni, attr, NULL, ATTR_VOL_INFO, NULL, 0, NULL, NULL);
				^~~~
Pass NULL instead.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 4a514931269e..fa3cc2b6d34a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1244,7 +1244,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	ni = ntfs_i(inode);
 
-	attr = ni_find_attr(ni, attr, NULL, ATTR_VOL_INFO, NULL, 0, NULL, NULL);
+	attr = ni_find_attr(ni, NULL, NULL, ATTR_VOL_INFO, NULL, 0, NULL, NULL);
 	if (!attr || is_attr_ext(attr) ||
 	    !(info = resident_data_ex(attr, SIZEOF_ATTRIBUTE_VOLUME_INFO))) {
 		ntfs_err(sb, "$Volume is corrupted.");
-- 
2.43.0.rc1.1336.g36b5255a03ac


