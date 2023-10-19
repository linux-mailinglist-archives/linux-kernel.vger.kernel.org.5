Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6AA7CFD62
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjJSOyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjJSOyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:54:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3688119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:54:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE2AC433C7;
        Thu, 19 Oct 2023 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697727288;
        bh=jkHuYeGL2ofj+QVQ5MN8OD/RwxmRNRYmFwYVvzsMF+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5tvghvs6cebhIu85saNPKDcyD36VW631lye8xhhJcRUiCRi6SaGeaKZmKSuWIaoi
         DJNyC/Eo6e3E6ND+lFjmeFxzrz9QJdoUZqfekNB4FjdECvgAk+gnpnGBFwyPMFcBDT
         EW+ZoS9mYUtB0t+3J+1g9OYQHLR8axhPwIDx5tas0WjjDx3Cse5aylfkiYI2euexIG
         DNcgrpW+YrLTOxP8O3P15KLAFlroyAiwsgfCRNUwHgPYVVWWVA4I2R7b9KIGICLTiB
         5Aiov84Hr/guPTRgZm7Ggyv7G+IrKcWaRANm5wM6EE15cDD22dOxk/3Oyw9KlUW4YL
         koDG/1XdGDJog==
From:   Will Deacon <will@kernel.org>
To:     Jijie Shao <shaojijie@huawei.com>, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, chenhao418@huawei.com,
        linux-arm-kernel@lists.infradead.org, shenjian15@huawei.com,
        wangjie125@huawei.com, liuyonglong@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 drivers/perf: hisi:] drivers/perf: hisi: use cpuhp_state_remove_instance_nocalls() for hisi_hns3_pmu uninit process
Date:   Thu, 19 Oct 2023 15:54:41 +0100
Message-Id: <169772582831.3316776.493699330485489130.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231019091352.998964-1-shaojijie@huawei.com>
References: <20231019091352.998964-1-shaojijie@huawei.com>
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

On Thu, 19 Oct 2023 17:13:52 +0800, Jijie Shao wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> For pmu uninit process, we unregister pmu and then call cpuhp_state_remove_instance()
> to call callback function to migrate pmu context. the logic is unreasonable and
> may result in NULL pointer call trace.
> 
> Found NULL pointer call trace for kernel-5.12 at the first time, log shows as below:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [27169.471153] Mem abort info:
> [27169.478859]   ESR = 0x96000006
> [27169.485117]   EC = 0x25: DABT (current EL), IL = 32 bits
> [27169.501386]   SET = 0, FnV = 0
> [27169.508038]   EA = 0, S1PTW = 0
> [27169.559839] Data abort info:
> [27169.567296]   ISV = 0, ISS = 0x00000006
> [27169.585332]   CM = 0, WnR = 0
> [27169.592627] user pgtable: 4k pages, 48-bit VAs, pgdp=00000820ac0c2000
> [27169.615618] [0000000000000000] pgd=00000820af2bf003, p4d=00000820af2bf003, pud=00000820af2bd003, pmd=0000000000000000
> [27169.641348] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> [27169.649879] Modules linked in: hisi_hns3_pmu(-) hns3 hclge hclgevf hnae3 hns3_cae(O) vfio_iommu_type1 vfio_pci vfio_virqfd vfio pv680_mii(O) [last unloaded: hisi_hns3_pmu]
> [27169.675150] CPU: 0 PID: 15 Comm: cpuhp/0 Tainted: G        W  O      5.12.0-rc4+ #1
> [27169.686538] Hardware name:  , BIOS KpxxxFPGA 1P B600 V143 04/22/2021
> [27169.694884] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
> [27169.704199] pc : perf_pmu_migrate_context+0x98/0x38c
> [27169.713848] lr : perf_pmu_migrate_context+0x94/0x38c
> [27169.723069] sp : ffff80001020bc80
> [27169.727938] x29: ffff80001020bc80 x28: 0000000000000000
> [27169.737236] x27: 0000000000000001 x26: fffffbffeff951d8
> [27169.745245] x25: ffffb7ae1ce36fd0 x24: fffffbffeff95178
> [27169.753116] x23: ffff0821f6f82668 x22: 0000000000000001
> [27169.760949] x21: ffff80001020bd08 x20: fffffbffeffb5188
> [27169.768467] x19: fffffbffeffb5178 x18: 0000000000000020
> [27169.776699] x17: 0000000000000000 x16: 0000000000000000
> [27169.785042] x15: 0000000000000004 x14: ffff08208093d290
> [27169.793254] x13: 0000000000000000 x12: 0000497f0149bafe
> [27169.801390] x11: 01262d2f8bbfdccc x10: 3dc70ddec1e5f4f9
> [27169.808896] x9 : ffffb7ae1a7eb108 x8 : 0000000000000002
> [27169.817000] x7 : 0000000000000000 x6 : 000000000000000e
> [27169.824726] x5 : 0000000000000001 x4 : 0000000000000000
> [27169.832924] x3 : 0000000000000000 x2 : ffff082080a30e80
> [27169.841135] x1 : 0000000000000000 x0 : fffffbffeffb5188
> [27169.849059] Call trace:
> [27169.853177]  perf_pmu_migrate_context+0x98/0x38c
> [27169.862256]  hisi_hns3_pmu_offline_cpu+0x104/0x12c [hisi_hns3_pmu]
> [27169.873943]  cpuhp_invoke_callback+0x118/0x634
> [27169.882775]  cpuhp_thread_fun+0xe8/0x190
> [27169.890345]  smpboot_thread_fn+0x25c/0x290
> [27169.898241]  kthread+0x168/0x16c
> [27169.904178]  ret_from_fork+0x10/0x18
> [27169.911943] Code: 944beda1 aa1403e0 944bed9f f8460f5c (f9400394)
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: hisi: use cpuhp_state_remove_instance_nocalls() for hisi_hns3_pmu uninit process
      https://git.kernel.org/will/c/50b560783f7f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
