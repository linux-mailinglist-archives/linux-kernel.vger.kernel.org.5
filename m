Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79E77904BE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 04:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347286AbjIBCQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 22:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIBCQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 22:16:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3302C10FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 19:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693620984; x=1725156984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QQJudmV/d8S0VGYKMNHaf/x+fCWhFZ7iX/FdKSi9lNw=;
  b=nnzZ31mAktgMepgp8B4WvseR1ZYYgOlJZkbbWBAtVfycjvNOUvxTWjaK
   IAvp5XN4E3U8NxpyU+oMmShEIy+QmUD+4Dg5IZtEmEWxHZoShSvnNDv2+
   yw5KHZFfIhvwX4BVmkUK3FxV9RntG+BadTS/1xccrpVO4KnXc81m0kpa+
   5EbtvUNhAUEr6U3Hw3MN0G8AN6pG91xghDYudgojYoHk/XnJphsNIQnhx
   geEdYFyJGpwE3uWMgm7saIJ8LwWE08h/KJREXHbYDq145APiyBJg0sTI4
   WaKLnuCS08KzvbxAYeRpB16b699Rj+KyRLA+w0JfN6MoPQv8jyvZBmui6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="355839432"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="355839432"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 19:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="863743767"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="863743767"
Received: from xiao-desktop.sh.intel.com ([10.239.46.158])
  by orsmga004.jf.intel.com with ESMTP; 01 Sep 2023 19:16:21 -0700
From:   Xiao Wang <xiao.w.wang@intel.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     jszhang@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH] riscv: alternative: remove alternative boundary symbols in vdso
Date:   Sat,  2 Sep 2023 10:25:10 +0800
Message-Id: <20230902022510.818602-1-xiao.w.wang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instruction patching for vdso is based on elf header parsing to get the
beginning and ending of .alternative section, the __alt_start and __alt_end
symbols defined in vdso linker script are not used, so this patch removes
them.

Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/kernel/vdso/vdso.lds.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index 82ce64900f3d..d43fd7c7dd11 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -42,9 +42,7 @@ SECTIONS
 
 	. = ALIGN(4);
 	.alternative : {
-		__alt_start = .;
 		*(.alternative)
-		__alt_end = .;
 	}
 
 	.data		: {
-- 
2.25.1

