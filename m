Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DCD78FA49
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344791AbjIAIzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIAIzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:55:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB5D10D2;
        Fri,  1 Sep 2023 01:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693558517; x=1725094517;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EEPjv3QXGYpmNq8vsQeiDkLN0h3pB82Y9iSOqfnsMyU=;
  b=gwVapUKZVdvtZwFowvVoIWNIiyhODANKbZcctr/ciQ955EVNyq5Jv6VN
   kV984rkf6+49smgeMiTyvcA9YVGw8kXORMK6l8mYCXbOOJ1s66az2QW0y
   0xtVM7rl99+l7oCBs77OusiJwwhuTUzppY8lTxLIZ5PDTox5LpgwC9zcH
   9mgNz90DBNvOKl6Sq9UHiGjKMOl7E1MG6ez1FFN4E22WfDuVyTs9196hS
   JVV6iouHodlIFpJm8GEds8cDxCVqg8/XY+o2RsAC8M0Q6WTqyRvOz2Gl8
   hlhqsZPHvgCbE08V/uWDiF7YFjTUTL43wF1qiwjt/7aP+QT8iLhiKpDHD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356485296"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="356485296"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="810003054"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="810003054"
Received: from akoczor-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.14.236])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:55:13 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, corbet@lwn.net
Cc:     x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: [PATCH 0/3] x86/resctrl: Non-contiguous bitmasks in Intel CAT
Date:   Fri,  1 Sep 2023 10:53:28 +0200
Message-ID: <cover.1693557919.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Until recently Intel CPUs didn't support using non-contiguous 1s
in Cache Allocation Technology (CAT). Writing a bitmask with
non-contiguous 1s to the resctrl schemata file would fail.

Intel CPUs that support non-contiguous 1s can be identified through a
CPUID leaf mentioned in the "Intel® Architecture Instruction Set
Extensions Programming Reference" document available at:
https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html

Add kernel support for detecting if non-contiguous 1s in Cache
Allocation Technology (CAT) are supported by the hardware. Also add a
new resctrl FS file to output this information to the userspace.
Keep the hardcoded value for Haswell CPUs only since they do not have
CPUID enumeration support for Cache allocation.

Since the selftests/resctrl files are going through many rewrites and
cleanups the appropriate selftest is still a work in progress. For
basic selftesting capabilities use the bash script attached below this
paragraph. It checks whether various bitmasks written into resctrl FS
generate output consistent with reported feature support.

#!/bin/bash
# must be run as root, depends on a recent cpuid tool (20230406 or later)
# variables
RESCTRL_INFO="/sys/fs/resctrl/info"
L3_NON_CONT_VAL="${RESCTRL_INFO}/L3/sparse_bitmaps"
L2_NON_CONT_VAL="${RESCTRL_INFO}/L2/sparse_bitmaps"
L3_NON_CONT_CBM="${RESCTRL_INFO}/L3/cbm_mask"
L2_NON_CONT_CBM="${RESCTRL_INFO}/L2/cbm_mask"
L3_CPUID_CMD="cpuid -1 -l 0x10 -s 0x01"
L2_CPUID_CMD="cpuid -1 -l 0x10 -s 0x02"
PASSED_TESTS=0
L3_SUPPORT=0
L2_SUPPORT=0
TESTS=0

run_test() {
        # L2 or L3
        CACHE_LEVEL=$1
        CACHE_LEVEL_SUPPORT="${CACHE_LEVEL}_SUPPORT"
        echo "Checking ${RESCTRL_INFO}/${CACHE_LEVEL}..."
        if [[ -d "${RESCTRL_INFO}/${CACHE_LEVEL}" ]]; then
                eval "${CACHE_LEVEL_SUPPORT}=1"
                echo "${CACHE_LEVEL} CAT Feature is supported"
        else
                echo "${CACHE_LEVEL} CAT Feature is not supported"
        fi

        if [[ ${!CACHE_LEVEL_SUPPORT} -eq 1 ]]; then
                echo " --- Running tests for ${CACHE_LEVEL} CAT ---"

                # read sysfs entries
                # are non-contiguous cbm supported? (driver sysfs)
                eval "NON_CONT_VAL=${CACHE_LEVEL}_NON_CONT_VAL"
                eval "NON_CONT_FEAT=$( cat ${!NON_CONT_VAL} )"

                # are non-contiguous cbm supported? (cpuid)
                CACHE_CPUID_CMD="${CACHE_LEVEL}_CPUID_CMD"
                NONCONT_CPUID=$(${!CACHE_CPUID_CMD} | grep non-contiguous | grep true)
                NONCONT_CPUID_RET=$(( !$? ))

                # what is the mask size?
                eval "NON_CONT_CBM=${CACHE_LEVEL}_NON_CONT_CBM"
                MAX_MASK=$(( 16#$( cat ${!NON_CONT_CBM} ) ))

                # prepare contiguous and non-contiguous masks for tests
                BC_STRING="l(${MAX_MASK})/l(2)"
                MAX_MASK_BIT_COUNT=$(echo ${BC_STRING} | bc -l)
                MAX_MASK_BIT_COUNT=$(printf "%.0f" "$MAX_MASK_BIT_COUNT")
                BITSHIFT=$(( $MAX_MASK_BIT_COUNT/2 - ($MAX_MASK_BIT_COUNT/2 % 4) ))
                CONT_MASK=$(( $MAX_MASK >> $BITSHIFT ))
                NONCONT_MASK=$(( ~( $MAX_MASK & ( 15<<$BITSHIFT) ) ))
                NONCONT_MASK=$(( $NONCONT_MASK & $MAX_MASK ))

                # test if cpuid reported support matches the sysfs one
                echo " * Testing if CPUID matches ${CACHE_LEVEL}/sparse_bitmaps..."
                TESTS=$((TESTS + 1))
                if [[ $NONCONT_CPUID_RET -eq $NON_CONT_FEAT ]]; then
                        PASSED_TESTS=$((PASSED_TESTS + 1))
                        echo "There is a match!"
                else
                        echo "Error - no match!"
                fi

                # test by writing CBMs to the schemata
                printf " * Writing 0x%x mask to the schemata...\n" ${CONT_MASK}
                TESTS=$((TESTS + 1))
                SCHEMATA=$(printf "${CACHE_LEVEL}:0=%x" $CONT_MASK)
                echo "$SCHEMATA" > /sys/fs/resctrl/schemata
                if [[ $? -eq 0 ]]; then
                        PASSED_TESTS=$((PASSED_TESTS + 1))
                        echo "Contiguous ${CACHE_LEVEL} write correct!"
                else
                        echo "Contiguous ${CACHE_LEVEL} write ERROR!"
                fi

                printf " * Writing 0x%x mask to the schemata...\n" ${NONCONT_MASK}
                TESTS=$((TESTS + 1))
                SCHEMATA=$(printf "${CACHE_LEVEL}:0=%x" $NONCONT_MASK)
                echo "$SCHEMATA" > /sys/fs/resctrl/schemata
                if [[ (($? -eq 0) && ($NON_CONT_FEAT -eq 1)) || \
                        (($? -ne 0) && ($NON_CONT_FEAT -eq 0)) ]]; then
                        PASSED_TESTS=$((PASSED_TESTS + 1))
                        echo "Non-contiguous ${CACHE_LEVEL} write correct!"
                else
                        echo "Non-contiguous ${CACHE_LEVEL} write ERROR!"
                fi
        fi
}

# mount resctrl
mount -t resctrl resctrl /sys/fs/resctrl

run_test L3
run_test L2

echo "TESTS PASSED / ALL TESTS : ${PASSED_TESTS} / ${TESTS}"

# unmount resctrl
umount /sys/fs/resctrl

Fenghua Yu (2):
  x86/resctrl: Add sparse_bitmaps file in info
  Documentation/x86: Document resctrl's new sparse_bitmaps

Wieczor-Retman, Maciej (1):
  x86/resctrl: Enable non-contiguous bits in Intel CAT

 Documentation/arch/x86/resctrl.rst        | 16 ++++++++++++----
 arch/x86/kernel/cpu/resctrl/core.c        |  9 ++++++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 11 +++++++----
 arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 18 ++++++++++++++++++
 5 files changed, 52 insertions(+), 11 deletions(-)

-- 
2.42.0

