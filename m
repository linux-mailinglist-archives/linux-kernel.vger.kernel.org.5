Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714C576FCCC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjHDJE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHDJDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:03:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9843B4ECE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:00:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01A1B2F4;
        Fri,  4 Aug 2023 01:53:20 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.3.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F40E3F6C4;
        Fri,  4 Aug 2023 01:52:34 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        James Morse <james.morse@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] coresight: Allow guests to be traced when FEAT_TRF and VHE are present
Date:   Fri,  4 Aug 2023 09:52:15 +0100
Message-Id: <20230804085219.260790-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first commit moves the register to sysreg because I add the EL12
version in the second commit. I couldn't really think of the best way
to make it fit in sysreg without any changes, because all the fields are
shared between EL1 and EL2 except for the CX bit which was named
differently for that reason in the original definition. The CX bit only
exists in TRFCR_EL2.

The test results have some single spurious EL2 addresses, but I don't
think this is an issue with this patchset because it happens in the
host-userspace case which maintains the existing programming of
TRFCR. It's likely an issue with the model but I will follow it up
separately.

James Clark (2):
  arm64/sysreg: Move TRFCR definitions to sysreg
  coresight: Allow guests to be traced when FEAT_TRF and VHE are present

 arch/arm64/include/asm/sysreg.h               | 12 -----
 arch/arm64/tools/sysreg                       | 26 ++++++++++
 .../coresight/coresight-etm4x-core.c          | 47 ++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.h |  2 +-
 drivers/hwtracing/coresight/coresight-priv.h  |  3 ++
 5 files changed, 70 insertions(+), 20 deletions(-)

-- 
2.34.1

