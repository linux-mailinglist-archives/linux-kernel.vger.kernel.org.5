Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731A17DC94E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbjJaJVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343834AbjJaJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:21:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D752B3;
        Tue, 31 Oct 2023 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698744108; x=1730280108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yjOXbjPiGipjy8R9wCtdAqsCejHtbndkyznTFcK3Fpc=;
  b=Uqjq+UmR2IvTvPCDG7eO9mT2BFhfE3yq80xVVJT+JMrtLjkAlxRuDQd0
   +raHSMUmHLSUqh18OZPG7Y1K9QU4HF5vraK85DcR0/RdEnFyore2vm8rK
   /PTyZyxhs6kXCopsk4rNVKO+Q49YOuHWJKXvSdwvkAYhMvufZQCkzTtOq
   A7oaePsptLh547N3LUTOwYpp++UnBQGM+xR8CLXR88QfYz3CEhnUTW2Zg
   SuuoXfMWUdqX3yUiFy5NcrzXO4O9142/ZNQJ9YAmZ8XVjZ0MPgfV7AXkM
   Z5DGH4G4qNT0xi8J3BO5QBixVOCpFkzlb0CfIxfDXKrbe7ma2iZl4NYck
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="385435948"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="385435948"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 02:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="877445514"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="877445514"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.155])
  by fmsmga002.fm.intel.com with ESMTP; 31 Oct 2023 02:21:44 -0700
From:   Dapeng Mi <dapeng1.mi@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Dapeng Mi <dapeng1.mi@intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [kvm-unit-tests Patch v2 0/5] Fix PMU test failures on Sapphire Rapids
Date:   Tue, 31 Oct 2023 17:29:16 +0800
Message-Id: <20231031092921.2885109-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running pmu test on Intel Sapphire Rapids, we found several
failures are encountered, such as "llc misses" failure, "all counters"
failure and "fixed counter 3" failure.

Intel Sapphire Rapids introduces new fixed counter 3, total PMU counters
including GP and fixed counters increase to 12 and also optimizes cache
subsystem. All these changes make the original assumptions in pmu test
be unavailable any more on Sapphire Rapids. Patches 2-4 fixes these
failures, especially patch 2 improves current loop() function and ensure
the LLC/branch misses are always be triggered and don't depend on the 
possibility like before, patch 1 removes the duplicate code and patch 5
adds asserts to ensure pre-defined fixed events are matched with HW fixed
counters.

Plese note 1) this patchset depends on the Kernel patches "Enable topdown
 slots event in vPMU" 2) this patchset is only tested on Intel Sapphire
rapids platform, the tests on other platforms are welcomed. 


Dapeng Mi (4):
  x86: pmu: Improve loop() to force to generate llc/branch misses
  x86: pmu: Enlarge cnt array length to 64 in check_counters_many()
  x86: pmu: Support validation for Intel PMU fixed counter 3
  x86: pmu: Add asserts to warn inconsistent fixed events and counters

Xiong Zhang (1):
  x86: pmu: Remove duplicate code in pmu_init()

 lib/x86/pmu.c |  5 -----
 x86/pmu.c     | 54 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 33 insertions(+), 26 deletions(-)


base-commit: bfe5d7d0e14c8199d134df84d6ae8487a9772c48
-- 
2.34.1

