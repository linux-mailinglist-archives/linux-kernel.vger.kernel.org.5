Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7711C7A0B82
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbjINRWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjINRWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:22:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 253B826BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:22:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D313511FB;
        Thu, 14 Sep 2023 10:23:00 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C91773F5A1;
        Thu, 14 Sep 2023 10:22:20 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
Subject: [PATCH v6 09/24] x86/resctrl: Use set_bit()/clear_bit() instead of open coding
Date:   Thu, 14 Sep 2023 17:21:23 +0000
Message-Id: <20230914172138.11977-10-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230914172138.11977-1-james.morse@arm.com>
References: <20230914172138.11977-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resctrl CLOSID allocator uses a single 32bit word to track which
CLOSID are free. The setting and clearing of bits is open coded.

A subsequent patch adds resctrl_closid_is_free(), which adds more open
coded bitmaps operations. These will eventually need changing to use
the bitops helpers so that a CLOSID bitmap of the correct size can be
allocated dynamically.

Convert the existing open coded bit manipulations of closid_free_map
to use set_bit() and friends.

Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-By: Peter Newman <peternewman@google.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ac1a6437469f..fa449ee0d1a7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -106,7 +106,7 @@ void rdt_staged_configs_clear(void)
  * - Our choices on how to configure each resource become progressively more
  *   limited as the number of resources grows.
  */
-static int closid_free_map;
+static unsigned long closid_free_map;
 static int closid_free_map_len;
 
 int closids_supported(void)
@@ -126,7 +126,7 @@ static void closid_init(void)
 	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
 
 	/* CLOSID 0 is always reserved for the default group */
-	closid_free_map &= ~1;
+	clear_bit(0, &closid_free_map);
 	closid_free_map_len = rdt_min_closid;
 }
 
@@ -137,14 +137,14 @@ static int closid_alloc(void)
 	if (closid == 0)
 		return -ENOSPC;
 	closid--;
-	closid_free_map &= ~(1 << closid);
+	clear_bit(closid, &closid_free_map);
 
 	return closid;
 }
 
 void closid_free(int closid)
 {
-	closid_free_map |= 1 << closid;
+	set_bit(closid, &closid_free_map);
 }
 
 /**
@@ -156,7 +156,7 @@ void closid_free(int closid)
  */
 static bool closid_allocated(unsigned int closid)
 {
-	return (closid_free_map & (1 << closid)) == 0;
+	return !test_bit(closid, &closid_free_map);
 }
 
 /**
-- 
2.39.2

