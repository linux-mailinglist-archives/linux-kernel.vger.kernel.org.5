Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EF47B2180
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjI1PkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjI1PQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:16:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 098441A4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:16:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72E7F1FB;
        Thu, 28 Sep 2023 08:17:02 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.3.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C2553F59C;
        Thu, 28 Sep 2023 08:16:21 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, broonie@kernel.org, maz@kernel.org,
        suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] kvm/coresight: Support exclude guest and exclude host
Date:   Thu, 28 Sep 2023 16:16:04 +0100
Message-Id: <20230928151611.3042443-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a combination of the RFC for nVHE here [1] and v3 of VHE version
here [2]. After a few of the review comments it seemed much simpler for
both versions to use the same interface and be in the same patchset.

FEAT_TRF is a Coresight feature that allows trace capture to be
completely filtered at different exception levels, unlike the existing
TRCVICTLR controls which may still emit target addresses of branches,
even if the following trace is filtered.

Without FEAT_TRF, it was possible to start a trace session on a host and
also collect trace from the guest as TRCVICTLR was never programmed to
exclude guests (and it could still emit target addresses even if it
was).

With FEAT_TRF, the current behavior of trace in guests exists depends on
whether nVHE or VHE are being used. Both of the examples below are from
the host's point of view, as Coresight isn't accessible from guests.
This patchset is only relevant to when FEAT_TRF exists, otherwise there
is no change.

  nVHE:

  Because the host and the guest are both using TRFCR_EL1, trace will be
  generated in guests depending on the same filter rules the host is
  using. For example if the host is tracing userspace only, then guest
  userspace trace will also be collected.

  (This is further limited by whether TRBE is used because an issue
  with TRBE means that it's completely disabled in nVHE guests, but it's
  possible to have other tracing components.)

  VHE:

  With VHE, the host filters will be in TRFCR_EL2, but the filters in
  TRFCR_EL1 will be active when the guest is running. Because we don't
  write to TRFCR_EL1, guest trace will be completely disabled.

With this change, the guest filtering rules from the Perf session are
honored for both nVHE and VHE modes. This is done by either writing to
TRFCR_EL12 at the start of the Perf session and doing nothing else
further, or caching the guest value and writing it at guest switch for
nVHE.

The first commit moves the register to sysreg because I add the EL12
version in a later commit.

---

Changes since nVHE RFC [1]:

 * Re-write just in terms of the register value to be written for the
   host and the guest. This removes some logic from the hyp code and
   a value of kvm_vcpu_arch:trfcr_el1 = 0 no longer means "don't
   restore".
 * Remove all the conditional compilation and new files.
 * Change the kvm_etm_update_vcpu_events macro to a function.
 * Re-use DEBUG_STATE_SAVE_TRFCR so iflags don't need to be expanded
   anymore.
 * Expand the cover letter.

Changes since VHE v3 [2]:

 * Use the same interface as nVHE mode so TRFCR_EL12 is now written by
   kvm.

[1]: https://lore.kernel.org/kvmarm/20230804101317.460697-1-james.clark@arm.com/
[2]: https://lore.kernel.org/kvmarm/20230905102117.2011094-1-james.clark@arm.com/

James Clark (5):
  arm64/sysreg: Move TRFCR definitions to sysreg
  arm64: KVM: Rename DEBUG_STATE_SAVE_TRBE to DEBUG_STATE_SAVE_TRFCR
  arm64: KVM: Add interface to set guest value for TRFCR register
  arm64: KVM: Write TRFCR value on guest switch with nVHE
  coresight: Pass guest TRFCR value to KVM

 arch/arm64/include/asm/kvm_host.h             | 10 +++-
 arch/arm64/include/asm/sysreg.h               | 12 ----
 arch/arm64/kvm/arm.c                          |  1 +
 arch/arm64/kvm/debug.c                        | 38 +++++++++++-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c            | 60 +++++++++++--------
 arch/arm64/tools/sysreg                       | 41 +++++++++++++
 .../coresight/coresight-etm4x-core.c          | 42 +++++++++++--
 drivers/hwtracing/coresight/coresight-etm4x.h |  2 +-
 drivers/hwtracing/coresight/coresight-priv.h  |  3 +
 9 files changed, 160 insertions(+), 49 deletions(-)

-- 
2.34.1

