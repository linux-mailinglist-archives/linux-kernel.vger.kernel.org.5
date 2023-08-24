Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F51D786F51
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbjHXMl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbjHXMlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:41:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1A7170C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692880898; x=1724416898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W4inTP8TLkuEWi2okEidNtu2BT+Jd+hRVtrJjtpXolk=;
  b=MedOvJQYWTNxeSKP2+Zgjj77HW5ERQAB9Po2bPZG/l77dgAfAvcxFU1Z
   PPVIQHVHoGdjafOwm/5fhYZZRwtKgH9+j4repdrjL3g3QVQFgo5N34XoK
   n6nBl3uTraetm/SL+OZlJlV9K8xz4dRATYz0bR8NHhnN5OFaR7uLN7+Ud
   Xsk5logous5zkl2tmMx1G28L7ZKlj4C/ne3sYnjgKAExDeZ7mOS5TpDh7
   PmVyJgndMYvg7q7wYrCiTxy1VbVPusi/3siaObWXFUv7G2+gSgSYDZ0rQ
   TDV34+amfI0TzlFWFBdjQYu87qwd+qTmDtzPLy4zyXNuvCArwAIsTqh7a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="460783937"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="460783937"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="740161404"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="740161404"
Received: from mdziurdx-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.11.127])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:41:36 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     linux-kernel@vger.kernel.org, reinette.chatre@intel.com,
        fenghua.yu@intel.com
Cc:     ilpo.jarvinen@linux.intel.com
Subject: [PATCH 0/3] selftests/resctrl: Bug fix and optimizations
Date:   Thu, 24 Aug 2023 14:41:23 +0200
Message-ID: <cover.1692880423.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write_schemata() uses fprintf() to write a bitmask into a schemata file
inside resctrl FS. It checks fprintf() return value but it doesn't check
fclose() return value. Error codes from fprintf() such as write errors,
are flushed back to the user only after fclose() is executed which means
any invalid bitmask can be written into the schemata file.

Save fclose() return value so it can be returned at the end of the
function.

Add a perror() call after fprintf() so if any error occurs the error
message is more verbose

Kselftest.h declares many variadic functions that can print some
formatted message while also executing selftest logic. These
declarations don't have any compiler mechanism to verify if passed
arguments are valid in comparison with format specifiers used in
printf() calls.

Add a __printf() macro similiar to other tools in the kernel.

Add __printf() attributes to function definitions inside kselftest.h that
use printing

The resctrlfs.c file defines functions that interact with the resctrl FS
while resctrl_val.c file defines functions that perform measurements on
the cache. Run_benchmark() fits logically into the second file before
resctrl_val() function that uses it.

Move run_benchmark() from resctrlfs.c to resctrl_val.c just before
resctrl_val() function definition.

Series is based on kselftest next branch

Wieczor-Retman, Maciej (3):
  selftests/resctrl: Fix schemata write error check
  selftests/resctrl: Move run_benchmark() to a more fitting file
  selftests: Add printf attribute to ksefltest prints

 tools/testing/selftests/kselftest.h           | 18 +++---
 tools/testing/selftests/resctrl/resctrl_val.c | 52 ++++++++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c   | 60 ++-----------------
 3 files changed, 68 insertions(+), 62 deletions(-)


base-commit: 13eb52f6293dbda02890698d92f3d9913d8d5aeb
-- 
2.42.0

