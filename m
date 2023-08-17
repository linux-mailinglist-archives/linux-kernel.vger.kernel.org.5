Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FBE77FF89
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355176AbjHQVJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355129AbjHQVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:09:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB1358D;
        Thu, 17 Aug 2023 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692306555; x=1723842555;
  h=message-id:subject:from:reply-to:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=RU5huI3tbguJ32IffneM090TDzieHgftTmnWJZO079U=;
  b=PNhZQ9ijE1YTAESEMHryPDnuvsLKcrBV1FGp5T2I06jFAvRiTOPtfEPP
   jKrj3eDxx8Zfo3ArRROIsHEUyvAKfZybJ6s+vvIHG+F90kOHWEiNv/UMP
   a6kI89Agt17wfabsLk8m3SPFOMuKOgwk5xzB6Pzf+moKHd3wL1VyxPy84
   zs54o2qJhbuZiupjFCn2xAVaDRdh8REVenJBzaP0M9ioy/rtYbWi8VSF4
   ZrudbCO43KrD2Z9QS0NIkeKd76zc/gO/WGigOpeEP5+fTQ0mC2TCuM/TR
   6S8ppvcs+t16MoEF812aGYSGdr7oSXwayD6z5uUD1kUCaR3tHUF9z5nxs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="372916027"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="372916027"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="858370883"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="858370883"
Received: from wopr.jf.intel.com ([10.54.75.146])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:09:14 -0700
Message-ID: <485e8740385239b56753ce01d8995f01f84a68e5.camel@linux.intel.com>
Subject: REGRESSION WITH BISECT: v6.5-rc6 TPM patch breaks S3 on some Intel
 systems
From:   Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To:     mario.limonciello@amd.com, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, len.brown@intel.com,
        charles.d.prestopine@intel.com, rafael.j.wysocki@intel.com
Date:   Thu, 17 Aug 2023 14:09:00 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing S3 on 6.5.0-rc6 we've found that 5 systems are seeing a
crash and reboot situation when S3 suspend is initiated. To reproduce
it, this call is all that's required "sudo sleepgraph -m mem -rtcwake
15".

Ive created a Bugzilla to track this issue here:
https://bugzilla.kernel.org/show_bug.cgi?id=217804

I've bisected the issue to this patch:

commit 554b841d470338a3b1d6335b14ee1cd0c8f5d754
Author: Mario Limonciello <mario.limonciello@amd.com>
Date:   Wed Aug 2 07:25:33 2023 -0500

    tpm: Disable RNG for all AMD fTPMs
    
    The TPM RNG functionality is not necessary for entropy when the CPU
    already supports the RDRAND instruction. The TPM RNG functionality
    was previously disabled on a subset of AMD fTPM series, but reports
    continue to show problems on some systems causing stutter root
caused
    to TPM RNG functionality.
    
    Expand disabling TPM RNG use for all AMD fTPMs whether they have
versions
    that claim to have fixed or not. To accomplish this, move the
detection
    into part of the TPM CRB registration and add a flag indicating
that
    the TPM should opt-out of registration to hwrng.

By reverting this patch in 6.5.0-rc6 the problem goes away, so it's
pretty clear that this commit is at fault. I've done further debugging
and I've found that if I simply comment out these lines in 6.5.0-rc6
the problem goes away. So the "crb_check_flags" call is the root cause.

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 9eb1a1859012..20ce8102e6bd 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -826,9 +826,9 @@ static int crb_acpi_add(struct acpi_device *device)
        if (rc)
                goto out;
 
-       rc = crb_check_flags(chip);
-       if (rc)
-               goto out;
+//     rc = crb_check_flags(chip);
+//     if (rc)
+//             goto out;
 
        rc = tpm_chip_register(chip);

