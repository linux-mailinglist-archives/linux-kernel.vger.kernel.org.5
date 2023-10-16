Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5D7CB17A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjJPRkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJPRk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:40:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C069F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697478027; x=1729014027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2R+BjQjLudjCIoEuDzJL5Lh1qKRQYoCXOxXB+xKHIbo=;
  b=ERJDAJsdRSAF9gOspAPdXmYE5MX79gevWaj6LMJ13aLDxhdQgdoRE21q
   kSFNTvb9YsDKUOcVGRoI0L9iZuwC6tE8XI14xUtWcPLB/nWQr8Kz/+VTV
   27Zdp5gRegO821T7ocP8LG6ABzpUpD5INPQpjXQdUE9j9ZMPziJiT72C4
   wBqudqo0PhxBxT78HcaLoXHPuqLjNTudEWcgtd+mFUSmYrMfKyBBTS+lN
   rbRO6A71aRTz2JEXG9q8Z/V30mvvWWySxOtIMjG+lhYf3vyXlKH3gyWEW
   ZpdEaYIZmbgs5FSbrN8Yur65P/EVCwekTengrjbfTzzp+RNMF2c0HzKG5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365858554"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="365858554"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785175359"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="785175359"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2023 10:40:22 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, rui.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/4] x86/smp: Export symbol cpu_clustergroup_mask
Date:   Mon, 16 Oct 2023 10:40:12 -0700
Message-Id: <20231016174014.453169-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231016174014.453169-1-kan.liang@linux.intel.com>
References: <20231016174014.453169-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

