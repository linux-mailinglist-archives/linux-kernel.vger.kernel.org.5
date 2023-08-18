Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C82C780B06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376614AbjHRLV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376627AbjHRLVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:21:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0D123ABC;
        Fri, 18 Aug 2023 04:21:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CBACD75;
        Fri, 18 Aug 2023 04:21:45 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.55.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D39C43F762;
        Fri, 18 Aug 2023 04:20:59 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/3] coresight: etm: Make cycle count threshold user configurable
Date:   Fri, 18 Aug 2023 16:50:48 +0530
Message-Id: <20230818112051.594986-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
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

This series makes ETM TRCCCCTRL based 'cc_threshold' user configurable via
the perf event attribute. But first, this implements an errata work around
affecting ETM TRCIDR3.CCITMIN value on certain cpus, overriding the field.

This series applies on v6.5-rc6.

Cc: Catalin Marinas <catalin.marinas@arm.com> 
Cc: Will Deacon <will@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com> 
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Changes in V4:

- Fixed a typo s/rangess/ranges,
- Renamed etm4_work_around_wrong_ccitmin() as etm4_core_reads_wrong_ccitmin()
- Moved drvdata->ccitmin value check for 256 inside etm4_core_reads_wrong_ccitmin()
- Moved the comment inside etm4_core_reads_wrong_ccitmin()

Changes in V3:

https://lore.kernel.org/all/20230811034600.944386-1-anshuman.khandual@arm.com/

- Added errata work around affecting TRCIDR3.CCITMIN
- Split the document update into a separate patch

Changes in V2:

https://lore.kernel.org/all/20230808074533.380537-1-anshuman.khandual@arm.com/

- s/treshhold/threshold

Changes in V1:

https://lore.kernel.org/all/20230804044720.1478900-1-anshuman.khandual@arm.com/


Anshuman Khandual (3):
  coresight: etm: Override TRCIDR3.CCITMIN on errata affected cpus
  coresight: etm: Make cycle count threshold user configurable
  Documentation: coresight: Add cc_threshold tunable

 Documentation/arch/arm64/silicon-errata.rst   | 10 ++++
 Documentation/trace/coresight/coresight.rst   |  4 ++
 .../hwtracing/coresight/coresight-etm-perf.c  |  2 +
 .../coresight/coresight-etm4x-core.c          | 48 ++++++++++++++++++-
 4 files changed, 62 insertions(+), 2 deletions(-)

-- 
2.25.1

