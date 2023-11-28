Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796857FB83E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 11:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343981AbjK1KmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 05:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjK1KmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 05:42:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98B3C186
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 02:42:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6EECC15;
        Tue, 28 Nov 2023 02:43:04 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 407283F73F;
        Tue, 28 Nov 2023 02:42:16 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, jgg@ziepe.ca, kevin.tian@intel.com
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iommufd/selftest: Fix and cleanup for bus ops
Date:   Tue, 28 Nov 2023 10:42:10 +0000
Message-Id: <cover.1701165201.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The bus ops removal relies on iommu_ops_from_fwnode(NULL) finding the
"global" hardware driver ops on relevant platforms. Unfortunately I
overlooked that this will also match the IOMMUFD mock driver, such that
it can end up claiming to be the IOMMU for real platform etc. devices
which don't have an IOMMU described by a fwspec. This mini-series
addresses that.

I've split it so patch #1 is  minimal fix that mitigates the issue and
could be applied independently, then patch #2 then builds on it to take
full advantage of the new machinery and coexist as a normal IOMMU
driver. However they could be squashed if preferred.

Thanks,
Robin.


Robin Murphy (2):
  iommufd/selftest: Use a fwnode to distinguish devices
  iommufd/selftest: Use normal IOMMU registration

 drivers/iommu/iommu-priv.h           |  7 -----
 drivers/iommu/iommu.c                | 46 +++-------------------------
 drivers/iommu/iommufd/iommufd_test.h |  2 ++
 drivers/iommu/iommufd/selftest.c     | 45 +++++++++++++--------------
 4 files changed, 27 insertions(+), 73 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

