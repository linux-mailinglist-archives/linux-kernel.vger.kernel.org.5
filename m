Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE8F791966
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351102AbjIDOH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbjIDOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:07:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A5A2CDB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:07:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 039A11474;
        Mon,  4 Sep 2023 07:08:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D2353F766;
        Mon,  4 Sep 2023 07:07:15 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, broonie@kernel.org
Cc:     maz@kernel.org, James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] coresight: Allow guests to be traced when FEAT_TRF and VHE are present
Date:   Mon,  4 Sep 2023 15:07:01 +0100
Message-Id: <20230904140705.1620708-1-james.clark@arm.com>
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

FEAT_TRF is a Coresight feature that allows trace capture to be
completely filtered at different exception levels, unlike the existing
TRCVICTLR controls which may still emit target addresses of branches,
even if the following trace is filtered.

Without FEAT_TRF, it was possible to start a trace session on a host and
also collect trace from the guest as TRCVICTLR was never programmed to
exclude guests (and it could still emit target addresses even if it
was). Now when FEAT_TRF is present, because we don't write to
TRFCR_EL1, guest trace will be completely disabled.

This change fixes this issue, and also adds the ability to control it
with the Perf exclude_host and exclude_guest flags.

The first commit moves the register to sysreg because I add the EL12
version in the second commit.

The test results have some single spurious EL2 addresses, but I don't
think this is an issue with this patchset because it happens in the
host-userspace case which maintains the existing programming of
TRFCR. It's likely an issue with the model but I will follow it up
separately.

The corresponding change for nVHE is here [1]. With nVHE the behaviour
is reversed, currently guest trace is always generated because the host
already writes to TRFCR_EL1. This is the same both with and without
FEAT_TRF.

[1]: https://lore.kernel.org/kvmarm/20230804101317.460697-1-james.clark@arm.com/

---

Changes since v1:

 * Split new sysreg definitions into TRFCR_EL2 and TRFCR_ELx so that
   TRFCR_ELx doesn't include CX which TRFCR_EL1 doesn't have.
 * Mask out TS and CX before writing to TRFCR_EL1 because it doesn't
   have CX and TS has no effect.
 * Expand cover letter

James Clark (2):
  arm64/sysreg: Move TRFCR definitions to sysreg
  coresight: Allow guests to be traced when FEAT_TRF and VHE are present

 arch/arm64/include/asm/sysreg.h               | 12 -----
 arch/arm64/tools/sysreg                       | 40 +++++++++++++++
 .../coresight/coresight-etm4x-core.c          | 51 ++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.h |  2 +-
 drivers/hwtracing/coresight/coresight-priv.h  |  3 ++
 5 files changed, 89 insertions(+), 19 deletions(-)

-- 
2.34.1

