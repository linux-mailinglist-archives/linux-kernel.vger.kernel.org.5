Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E02765B29
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjG0SGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjG0SGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:06:47 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07652D5B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690481206; x=1722017206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pNajP0H5SUJ9f+Q1Onyg09lY/pVe/W2pk6K32ziRX90=;
  b=gb9JxKALS1REZGkMaAFDjgpsW3NvfF0YzytTfFV/dkO+q2XV8cFVZcZE
   1lvy/+uRP6S9AKLAM8gvQRp+MkAW7jx/6Nryy6cStYMqYoRdBpQ7DV8ke
   xd+N610z0p9MQsQQcX+aNWQg6sFMzMJqiXg0Zs3ZTNzg+3SUSzxsg+QZm
   sO51Dkq+C89cMvBErz2BrWwbDy9F8gaCPVBNDVoHedcFG7Ig2tKMeqMwe
   bEyalnvN97A5lwgBEdfhT7+ny3X4pghX99e//+/b2ZvcTqTyBc+B1H8FD
   td/dNMvd0DWWy/4r7rkd2OeaOpc29nMmyPe7YO1X/KmqL7g0057UV1gLE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="454760087"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="454760087"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 11:06:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="870523921"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2023 11:06:47 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] x86/smpboot: Remove a stray comment about CPU hotplug
Date:   Thu, 27 Jul 2023 18:05:31 +0000
Message-Id: <20230727180533.3119660-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727180533.3119660-1-sohil.mehta@intel.com>
References: <20230727180533.3119660-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This old comment is irrelavant to the logic of disabling interrupts and
could be misleading. Remove it.

Now, hlt_play_dead() resembles the code that the comment was initially
added for, but, it doesn't make sense anymore because an offlined cpu
could also be put into other states such as mwait.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/kernel/smpboot.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e1aa2cd7734b..6a09a021b534 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1614,9 +1614,7 @@ void play_dead_common(void)
 	idle_task_exit();
 
 	cpuhp_ap_report_dead();
-	/*
-	 * With physical CPU hotplug, we should halt the cpu
-	 */
+
 	local_irq_disable();
 }
 
-- 
2.34.1

