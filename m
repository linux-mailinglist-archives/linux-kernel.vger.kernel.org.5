Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60CA7CA885
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjJPMxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjJPMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:53:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06FFAE6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:53:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 506331FB;
        Mon, 16 Oct 2023 05:53:46 -0700 (PDT)
Received: from entos-ampere02.shanghai.arm.com (unknown [10.169.212.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EB523F5A1;
        Mon, 16 Oct 2023 05:53:03 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, nd@arm.com,
        Jia He <justin.he@arm.com>
Subject: [PATCH v3 0/2] fix dma_addressing_limited() if dma_range_map
Date:   Mon, 16 Oct 2023 12:52:52 +0000
Message-Id: <20231016125254.1875-1-justin.he@arm.com>
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

This is to fix the hangs at boot. The root cause is the nvme device dma
mapping is failed in the checking path of phys_to_dma() since
dma_max_mapping_size() gave the wrong answer to start with.

---
Changelog:
v1: https://lore.kernel.org/all/20230912084002.2168-1-justin.he@arm.com/
v2: https://lore.kernel.org/lkml/20231010020835.3678-1-justin.he@arm.com/
  - refine the subject and commit msg (By Robin Murphy)
  - refactor the checking loop in check_ram_in_range_map() in the pages
    unit to avoid wrap to 0 on 32bits platforms (Robin)
v3:
  - move and export dma_addressing_limited() to avoid adding a new
    exported helper (by Christoph Hellwig)

Jia He (2):
  dma-mapping: export dma_addressing_limited()
  dma-mapping: fix dma_addressing_limited() if dma_range_map can't cover
    all system RAM

 include/linux/dma-mapping.h | 19 ++++--------
 kernel/dma/mapping.c        | 60 +++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 14 deletions(-)

-- 
2.25.1

