Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF69A76D48D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjHBRCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjHBRCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:02:36 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 526E9173A;
        Wed,  2 Aug 2023 10:02:35 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.147.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9CDBA238C42F;
        Wed,  2 Aug 2023 10:02:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CDBA238C42F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690995754;
        bh=7K46jHAh92Qicy9mQozF5U/IfJD15n4F+9m+pErxtW0=;
        h=From:To:Cc:Subject:Date:From;
        b=oMq9HTSkpDTjigWrizfIN6fmyw9f9fepwG7BhA5VCivovDZ4eZtC01jeQ97txvA/a
         Xqipp2wve8juaHkzl9oNsQKs0GsBBcUeLY2u8MG1TanA5hwVXiUM0EEVdaUeZcGqvX
         PYdrohvl5C1rHRNRPvm7DmjYdENHA0rrlfXiaGxM=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     easwar.hariharan@microsoft.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [PATCH v3 5.15 0/6] ARM64 errata for stable kernel 5.15
Date:   Wed,  2 Aug 2023 17:02:21 +0000
Message-Id: <20230802170227.1590187-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series works around a few ARM64 errata.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev

Changelog:
==========
v2 -> v3
 - Backport other relevant errata patches from the same series as MMU-700 erratum 2812531
 - v2 link: https://lore.kernel.org/stable/20230724185017.1675459-1-eahariha@linux.microsoft.com/T/#m0c2c7b9dac7ac8c0b12ce31f1a68542ef352ea2f

v1 -> v2:
 - Drop patch accepted as commit
   e4e7f67cc14e9638798f80513e84b8fb62cdb7e3 in v5.15.121
 - Appropriate sign-offs
 - v1 link:https://lore.kernel.org/stable/1689895414-17425-1-git-send-email-eahariha@linux.microsoft.com/


Robin Murphy (4):
  iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
  iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
  iommu/arm-smmu-v3: Add explicit feature for nesting
  iommu/arm-smmu-v3: Document nesting-related errata

Suzuki K Poulose (2):
  arm64: errata: Add workaround for TSB flush failures
  arm64: errata: Add detection for TRBE write to out-of-range

 Documentation/arm64/silicon-errata.rst      | 12 ++++
 arch/arm64/Kconfig                          | 74 +++++++++++++++++++++
 arch/arm64/include/asm/barrier.h            | 16 ++++-
 arch/arm64/kernel/cpu_errata.c              | 39 +++++++++++
 arch/arm64/tools/cpucaps                    |  2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 ++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 +++
 7 files changed, 200 insertions(+), 1 deletion(-)

-- 
2.25.1

