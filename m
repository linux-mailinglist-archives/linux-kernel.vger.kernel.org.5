Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AE97980DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 05:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbjIHDNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 23:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbjIHDNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 23:13:11 -0400
X-Greylist: delayed 293 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 20:13:06 PDT
Received: from mailhost.m5p.com (mailhost.m5p.com [74.104.188.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170D21BD8;
        Thu,  7 Sep 2023 20:13:05 -0700 (PDT)
Received: from m5p.com (mailhost.m5p.com [IPv6:2001:470:1f07:15ff:0:0:0:f7])
        by mailhost.m5p.com (8.17.1/8.15.2) with ESMTPS id 388381l7002774
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 7 Sep 2023 23:08:07 -0400 (EDT)
        (envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
        by m5p.com (8.17.1/8.15.2/Submit) id 388380oI002773;
        Thu, 7 Sep 2023 20:08:00 -0700 (PDT)
        (envelope-from ehem)
Date:   Thu, 7 Sep 2023 20:08:00 -0700
From:   Elliott Mitchell <ehem+xen@m5p.com>
To:     smita.koralahallichannabasappa@amd.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org, rric@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, yazen.ghannam@amd.com
Subject: [PATCH] Revert "EDAC/mce_amd: Do not load edac_mce_amd module on
 guests"
Message-ID: <ZPqQEHXgmak1LMNh@mattapan.m5p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 767f4b620edadac579c9b8b6660761d4285fa6f9.

There are at least 3 valid reasons why a VM may see MCE events/registers.

First, the hypervisor may have a bug.  Ideally this should be dealt with
by fixing the hypervisor.  Failing that, the hypervisor and versions
effected need to be identified so only they are flagged as buggy.

Second, the Linux kernel may be handling adminstrative duties/hardware
for a hypervisor.  In this case, the events need to be processed and
potentially passed back through the hypervisor.

Third, the hypervisor may do full virtualization of MCE events.  In such
case, they should be handled normally.

Any of these blanket disabling the functionality is bad.  The original
patch was wrong.
---
 drivers/edac/mce_amd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 9215c06783df..1b7fccfbb654 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1361,9 +1361,6 @@ static int __init mce_amd_init(void)
 	    c->x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;
 
-	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
-		return -ENODEV;
-
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		xec_mask = 0x3f;
 		goto out;
-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         ehem+sigmsg@m5p.com  PGP 87145445         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
8A19\___\_|_/58D2 7E3D DDF4 7BA6 <-PGP-> 41D1 B375 37D0 8714\_|_/___/5445


