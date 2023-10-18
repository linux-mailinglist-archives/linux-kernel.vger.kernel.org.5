Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E937CD5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344604AbjJRHre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjJRHra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:47:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCB2100;
        Wed, 18 Oct 2023 00:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697615249; x=1729151249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h4XVZHdvlqX9EhvYBVM6hRqpG6MuHehCUD0ZGVf9mxo=;
  b=nwGhBag7Umuj9lVlVHubj3mtv7m/PAUCe1g1045dsouKOV6i7Rl3jvVM
   nv+8yCxWRHgUlfv44L3jrCMm64f4NVjWu4QXbhDf1VMnOmnamR/x+6Bar
   RFxQlP9CvTrkrCrI5bGg8Zj7s2RRYY9escvec9ofvNvJBbINIF2e3OLct
   8muC2TP0HwHGEsYRDdR+ZWHJ5fKXVXHcMDioYFao2Rvu+4QSz+f9LRNUU
   ieV22hAXO2OszHPx18NRCHM7PxE11LAzDuXkWY5QaTf9YemgNG4fW66LR
   9/GJAIMoasLZ22GsDMbzJ3TXbb/JZd2CTXbAxkRB81sSLPJ/0Cn9ug0hn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388823972"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="388823972"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:47:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="785795153"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="785795153"
Received: from 001b21e7c6a0.jf.intel.com ([10.165.56.54])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2023 00:47:27 -0700
From:   Chen Hu <hu1.chen@intel.com>
To:     miklos@szeredi.hu, amir73il@gmail.com
Cc:     malini.bhandaru@intel.com, tim.c.chen@intel.com,
        mikko.ylinen@intel.com, lizhen.you@intel.com,
        vinicius.gomes@intel.com, hu1.chen@intel.com,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ovl: ovl_fs::creator_cred::usage scalability issues
Date:   Wed, 18 Oct 2023 00:45:53 -0700
Message-Id: <20231018074553.41333-1-hu1.chen@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*Problem*
ovl_permission() checks the underlying inode with the credential of mounter.
The cred, struct ovl_fs::creator_cred, is somewhat global per overlayfs
superblock. Performance degrades when concurrency increases on the cred, to be
specific, on ovl_fs::creator_cred::usage.

This happens when there are massive file access inside container, especially
on SoC with many cores. With Linux 6.6.0-rc2, we run a web workload container
on Intel 4th Xeon Sapphire Rapids which has 56 cores. Perf reports that 5.7%
(2.50% + 1.87% + 1.33%) CPU stall in overlayfs:
Self    Command       Shared Object            Symbol
2.50%   foo           [kernel.vmlinux]         [k] override_creds
1.87%   foo           [kernel.vmlinux]         [k] revert_creds
1.33%   foo           [kernel.vmlinux]         [k] generic_permission

On Soc with more than 100 cores, we can even observe ~30% CPU stalled!

This scalability issue is caused by two factors:
1) Contention on creator_cred::usage
   creator_cred::usage is atomic_t and is inc/dec atomically during every file
   access. So HW acquires the corresponding cache line exclusively. This
   operataiton is expensive and gets worse when contention is heavy.
   Call chain:
      ovl_permission()
      -> ovl_override_creds()
      -> override_creds()
      -> get_new_cred()
      -> atomic_inc(&cred->usage);

      ovl_permission()
      -> revert_creds()
      -> put_cred()
      -> atomic_dec_and_test(&(cred)->usage))

2) False sharing
   `perf c2c` shows false sharing issue between cred::usage and cred::fsuid.
   This is why generic_permission() stalls 1.33% CPU in above perf report.
   ovl_permission() updates cred::usage and it also reads cred::fsuid.
   Unfortunately, they locate in the same cache line and thus false sharing
   occurs. cred::fsuid is read at:
      ovl_permission()
      -> inode_permission()
      -> generic_permission()
      -> acl_permission_check()
      -> current_fsuid()

*Mitigations we tried*
We tried several mitigations but are not sure if it can be a fix or just
workaround / hack. So we report this and want to have some discussions.

Our mitigations aims to eliminate the contention on creator_cred->usage.
Without contention, the false sharing will be tiny and no need to handle. The
mitigations we tested are:
   1) Check underlying inode once in its lifetime. 
   OR
   2) In ovl_permission(), copy global creator_cred to a local variable to
      avoid concurrency.

With any mitigations above, CPU will not stall on overlayfs.

Paste mitigation 1 below.

From 472bd18eaabcde0d41e450f556691151b1bdb64e Mon Sep 17 00:00:00 2001
From: Chen Hu <hu1.chen@intel.com>
Date: Fri, 1 Sep 2023 15:03:28 +0800
Subject: [RFC PATCH] ovl: check underlying upper inode once in its lifetime

ovl_permission() checks the underlying inode with the credential of
mounter. The cred, struct ovl_fs::creator_cred, is global per overlayfs
superblock. Performance degrades when concurrency increases on the cred,
to be specific, on ovl_fs::creator_cred::usage.

This patch (or hack to some extent) checks underlying upper inode once
in its lifetime, eliminates the cache line contention on
creator_cred::usage and gets 40%+ perf improvement on a 128 cores CPU.

CAUTION:
this may compromise the file permission check. Need to talk with
overlayfs experts.

Signed-off-by: Chen Hu <hu1.chen@intel.com>
---
 fs/overlayfs/inode.c     | 5 ++++-
 fs/overlayfs/overlayfs.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 83ef66644c21..62ec99316c7a 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -307,7 +307,7 @@ int ovl_permission(struct mnt_idmap *idmap,
 	 * with creds of mounter
 	 */
 	err = generic_permission(&nop_mnt_idmap, inode, mask);
-	if (err)
+	if (err || ovl_test_flag(OVL_FASTPERM, inode))
 		return err;
 
 	old_cred = ovl_override_creds(inode->i_sb);
@@ -318,6 +318,9 @@ int ovl_permission(struct mnt_idmap *idmap,
 		mask |= MAY_READ;
 	}
 	err = inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
+	if (err == 0 && upperinode)
+		/* This gets set once for the upper inode lifetime */
+		ovl_set_flag(OVL_FASTPERM, inode);
 	revert_creds(old_cred);
 
 	return err;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 9817b2dcb132..5b71aaa8f77c 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -53,6 +53,7 @@ enum ovl_inode_flag {
 	OVL_CONST_INO,
 	OVL_HAS_DIGEST,
 	OVL_VERIFIED_DIGEST,
+	OVL_FASTPERM,
 };
 
 enum ovl_entry_flag {
-- 
2.34.1

