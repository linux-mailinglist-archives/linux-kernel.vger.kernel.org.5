Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F597EE2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjKPOW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345294AbjKPOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:22:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C6211F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700144573; x=1731680573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2R+BjQjLudjCIoEuDzJL5Lh1qKRQYoCXOxXB+xKHIbo=;
  b=PA68P2py1a2gv9Q9OcTPHQe6KtbGZk3gWaxJRHUFqk7mbCxwnhtlW3ei
   eaDqh8+8i28M2eRHPg1BG+wR79LOe3ecRIC7r42L5uf1MUrHCdOOc67cV
   llI9qKERo7kY6CZl6Wly/eYDALvhWvXHCYVTHItG9P8WYBaxvIdTd9Ddp
   d++NyKv/ZgbxsGtpuLDeAnMY9bvQMDSukcSYGljLDWH/B39brWyw9CMe5
   RL2Not9yc+JSwcl0nbqfcj88gkCffgechy1oCuH0BS1Un9H0uI0AIXBa8
   6RjO53xFGBq6z9Zib9l2/hD8hGV/8GJJqAyKqxZo6uyfKNMOJtGqgZVTN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="12644428"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="12644428"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 06:22:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="800173368"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="800173368"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 16 Nov 2023 06:22:49 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rui.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH 2/4] x86/smp: Export symbol cpu_clustergroup_mask
Date:   Thu, 16 Nov 2023 06:22:43 -0800
Message-Id: <20231116142245.1233485-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231116142245.1233485-1-kan.liang@linux.intel.com>
References: <20231116142245.1233485-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Intel cstate PMU driver will invoke the topology_cluster_cpumask() to
retrieve the CPU mask of a cluster. A modpost error is triggered since
the symbol cpu_clustergroup_mask is not exported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 48e040618731..376387ca6be5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -747,6 +747,7 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
 {
 	return cpu_l2c_shared_mask(cpu);
 }
+EXPORT_SYMBOL(cpu_clustergroup_mask);
 
 static void impress_friends(void)
 {
-- 
2.35.1

