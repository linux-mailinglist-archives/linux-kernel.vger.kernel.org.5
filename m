Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05B47AAFB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjIVKji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjIVKje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:39:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E22B99
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:39:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E26C433C8;
        Fri, 22 Sep 2023 10:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379168;
        bh=AM9mXyWNom/7C0Z2nwwzwPj8EXnzn7AMdkX3ObUV7Ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOIbbxeTMTzG0Jr5xF2VjSZkUWgrYY0n8we5/V/MHM6oaWLHMFHvxPjd5wvc4GDDB
         6VfffhJcgLcMq45eqb7LhpdqwKvM3A03ii7Kq6VN6Umm3kbZHWxA2SLz2k7uqEuRCF
         NfzEmy8d/7P/gA4yGM7qA/sTiI4vHlJ3XW4yoGWdoqdLXufAXV5ST0b5BWIxZoTLxN
         /CdvUQ0mWtGXxEsbN4Qcnc1HqOqyYp8ieHddsAOoKSezCrfWBtHXCIl4qBp+jW1gnW
         wBbtrioU6hCekat5XsuC9gYRVlvTw8cKvTiDi61VxGXiUiWoujwK6uJEzXjylTYYyh
         9hTkghKty4F8w==
From:   Will Deacon <will@kernel.org>
To:     Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, joro@8bytes.org,
        jean-philippe@linaro.org, iommu@lists.linux.dev,
        apopple@nvidia.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jgg@nvidia.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range
Date:   Fri, 22 Sep 2023 11:39:23 +0100
Message-Id: <169537774299.3625412.855050231563231169.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230920052257.8615-1-nicolinc@nvidia.com>
References: <20230920052257.8615-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 22:22:57 -0700, Nicolin Chen wrote:
> When running an SVA case, the following soft lockup is triggered:
> --------------------------------------------------------------------
> watchdog: BUG: soft lockup - CPU#244 stuck for 26s!
> pstate: 83400009 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> pc : arm_smmu_cmdq_issue_cmdlist+0x178/0xa50
> lr : arm_smmu_cmdq_issue_cmdlist+0x150/0xa50
> sp : ffff8000d83ef290
> x29: ffff8000d83ef290 x28: 000000003b9aca00 x27: 0000000000000000
> x26: ffff8000d83ef3c0 x25: da86c0812194a0e8 x24: 0000000000000000
> x23: 0000000000000040 x22: ffff8000d83ef340 x21: ffff0000c63980c0
> x20: 0000000000000001 x19: ffff0000c6398080 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: ffff3000b4a3bbb0
> x14: ffff3000b4a30888 x13: ffff3000b4a3cf60 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc08120e4d6bc
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000048cfa
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 000000000000000a
> x2 : 0000000080000000 x1 : 0000000000000000 x0 : 0000000000000001
> Call trace:
>  arm_smmu_cmdq_issue_cmdlist+0x178/0xa50
>  __arm_smmu_tlb_inv_range+0x118/0x254
>  arm_smmu_tlb_inv_range_asid+0x6c/0x130
>  arm_smmu_mm_invalidate_range+0xa0/0xa4
>  __mmu_notifier_invalidate_range_end+0x88/0x120
>  unmap_vmas+0x194/0x1e0
>  unmap_region+0xb4/0x144
>  do_mas_align_munmap+0x290/0x490
>  do_mas_munmap+0xbc/0x124
>  __vm_munmap+0xa8/0x19c
>  __arm64_sys_munmap+0x28/0x50
>  invoke_syscall+0x78/0x11c
>  el0_svc_common.constprop.0+0x58/0x1c0
>  do_el0_svc+0x34/0x60
>  el0_svc+0x2c/0xd4
>  el0t_64_sync_handler+0x114/0x140
>  el0t_64_sync+0x1a4/0x1a8
> --------------------------------------------------------------------
> 
> [...]

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/1] iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range
      https://git.kernel.org/will/c/d5afb4b47e13

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
