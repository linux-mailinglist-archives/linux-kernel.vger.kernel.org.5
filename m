Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB5B756C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGQS2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjGQS2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:28:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119E2E6F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1467611F0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBABC433C8;
        Mon, 17 Jul 2023 18:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618496;
        bh=LxVPV/awBr9JfrIXQcn7s5nybGvSK4R3yuZ8UegsyEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7HCYboIy3k9DTctpmN4Na4Olx0Cl/2WKV4x3hO5adpOJs9UdrnskmzdF0EYOzt3C
         kxvC9Vb9O4mdfIuRerjrWE5UXoIzFkU0VDwuX7N5pI/bxZwqDPz+7CVAc8v93Z65M/
         Q79nxpbCVvlesiSbtqppsdZA0M5P7OXDA5aiie1sT9mxzx6Jy+CrSvsG4L/TLmTbmx
         O3HUml2d9qqsH76oGWKlHof+tldsQI03K5VQ0w2LTyoCVx3OMDlJIPNXVfGQEnLoDM
         NZClUUW//W1SxqNzqwUqlk5sif3Wp3TyH8UDYoCJq09n+p4fXVeS+Hwn3xNKPf0YZP
         SPGbU9iD5D4Yg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A4D05CE04CD; Mon, 17 Jul 2023 11:28:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        daniel.lezcano@linaro.org, Yu Liao <liaoyu15@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH clocksource 2/2] x86/tsc: Extend watchdog check exemption to 4-Sockets platform
Date:   Mon, 17 Jul 2023 11:28:14 -0700
Message-Id: <20230717182814.1099419-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <db4a845e-5f87-4aee-8957-150c253f67e7@paulmck-laptop>
References: <db4a845e-5f87-4aee-8957-150c253f67e7@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Tang <feng.tang@intel.com>

There were reports again that the tsc clocksource on 4 sockets x86
servers was wrongly judged as 'unstable' by 'jiffies' and other
watchdogs, and disabled [1][2].

Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
on qualified platorms") was introduce to deal with these false
alarms of tsc unstable issues, covering qualified platforms for 2
sockets or smaller ones. And from history of chasing TSC issues,
Thomas and Peter only saw real TSC synchronization issue on 8 socket
machines.

So extend the exemption to 4 sockets to fix the issue.

Rui also proposed another way to disable 'jiffies' as clocksource
watchdog [3], which can also solve problem in [1]. in an architecture
independent way, but can't cure the problem in [2]. whose watchdog
is HPET or PMTIMER, while 'jiffies' is mostly used as watchdog in
boot phase.

'nr_online_nodes' has known inaccurate problem for cases like
platform with cpu-less memory nodes, sub numa cluster enabled,
fakenuma, kernel cmdline parameter 'maxcpus=', etc. The harmful case
is the 'maxcpus' one which could possibly under estimates the package
number, and disable the watchdog, but bright side is it is mostly
for debug usage. All these will be addressed in other patches, as
discussed in thread [4].

[1]. https://lore.kernel.org/all/9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com/
[2]. https://lore.kernel.org/lkml/06df410c-2177-4671-832f-339cff05b1d9@paulmck-laptop/
[3]. https://lore.kernel.org/all/bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com/
[4]. https://lore.kernel.org/all/20221021062131.1826810-1-feng.tang@intel.com/

Reported-by: Yu Liao <liaoyu15@huawei.com>
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3425c6a943e4..15f97c0abc9d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1258,7 +1258,7 @@ static void __init check_system_tsc_reliable(void)
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    nr_online_nodes <= 2)
+	    nr_online_nodes <= 4)
 		tsc_disable_clocksource_watchdog();
 }
 
-- 
2.40.1

