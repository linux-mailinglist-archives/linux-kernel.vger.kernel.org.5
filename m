Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EC57AAD11
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjIVIsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjIVIsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:48:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40343BB;
        Fri, 22 Sep 2023 01:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695372496; x=1726908496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ysQSbD8xLKPwOI/It2RUGxNQ5FF2eqePkRV9v8KOFMY=;
  b=QXedXXN2m6XfC8IY12bFYRGSXP1o4u1tvmhP1aeKP6qZTsV8tg+/oLUN
   k/Fxt6kUTeQ7hHT/xiWD0qjAnBCrfyn6wD97TCYCXMF5p7otlzTJwhM17
   /CtzVvCtfkCrQXqQ3CTDG3zV6m9uIKKFXO5GBc/D0ifE/rXk06ApaQI6i
   ydMXEdS4gm0jx+Sq+6L6Tb7I6L8sJpTX6wbZf1SI2WnRMl/p9ZYJLvPYE
   HfeJdfFpqs1UCKgtHIoyE4phdd/Cq9amQkYE6XjX3uoBze//KwP1AEn4s
   l6iwPAfhNxaPA5P8CEw91w+hAC4DfgXK0fHJ4BrDIYBYPoctDG0sycS1e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383524165"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="383524165"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="697091137"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="697091137"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:48:11 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, corbet@lwn.net
Cc:     x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Subject: [PATCH v2 0/4] x86/resctrl: Non-contiguous bitmasks in Intel CAT
Date:   Fri, 22 Sep 2023 10:47:52 +0200
Message-ID: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changelog v2:
- Change git signature from Wieczor-Retman Maciej to Maciej
  Wieczor-Retman.
- Change bitmap naming convention to bit mask.
- Add patch to change arch_has_sparce_bitmaps name to match bitmask
  naming convention.

Fenghua Yu (2):
  x86/resctrl: Add sparse_masks file in info
  Documentation/x86: Document resctrl's new sparse_masks

Maciej Wieczor-Retman (2):
  x86/resctrl: Enable non-contiguous bits in Intel CAT
  x86/resctrl: Rename arch_has_sparse_bitmaps

 Documentation/arch/x86/resctrl.rst        | 16 ++++++++++++----
 arch/x86/kernel/cpu/resctrl/core.c        | 11 +++++++----
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 14 ++++++++------
 arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 18 ++++++++++++++++++
 include/linux/resctrl.h                   |  6 +++---
 6 files changed, 57 insertions(+), 17 deletions(-)


base-commit: 27bbf45eae9ca98877a2d52a92a188147cd61b07
-- 
2.42.0

