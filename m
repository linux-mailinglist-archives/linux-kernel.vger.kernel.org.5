Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11067ACD94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjIYBbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIYBbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:31:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD19C6;
        Sun, 24 Sep 2023 18:31:03 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rv4x50X9LzMlpr;
        Mon, 25 Sep 2023 09:27:21 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 09:31:00 +0800
Message-ID: <f2b30203-1a67-4533-eddc-b380044e2e68@huawei.com>
Date:   Mon, 25 Sep 2023 09:31:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v10 2/4] fpga: add an initial KUnit suite for the FPGA
 Bridge
Content-Language: en-US
To:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
References: <20230718130304.87048-1-marpagan@redhat.com>
 <20230718130304.87048-3-marpagan@redhat.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230718130304.87048-3-marpagan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/18 21:03, Marco Pagani wrote:
> The suite tests the basic behaviors of the FPGA Bridge including
> the functions that operate on a list of bridges.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  drivers/fpga/tests/fpga-bridge-test.c | 175 ++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 drivers/fpga/tests/fpga-bridge-test.c
> 
> diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
> new file mode 100644
> index 000000000000..1d258002cdd7
> --- /dev/null
> +++ b/drivers/fpga/tests/fpga-bridge-test.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the FPGA Bridge
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/device.h>
> +#include <linux/fpga/fpga-bridge.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +
> +struct bridge_stats {
> +	bool enable;
> +};
> +
> +struct bridge_ctx {
> +	struct fpga_bridge *bridge;
> +	struct platform_device *pdev;
> +	struct bridge_stats stats;
> +};
> +
> +static int op_enable_set(struct fpga_bridge *bridge, bool enable)
> +{
> +	struct bridge_stats *stats = bridge->priv;
> +
> +	stats->enable = enable;
> +
> +	return 0;
> +}
> +
> +/*
> + * Fake FPGA bridge that implements only the enable_set op to track
> + * the state.
> + */
> +static const struct fpga_bridge_ops fake_bridge_ops = {
> +	.enable_set = op_enable_set,
> +};
> +
> +/**
> + * register_test_bridge() - Register a fake FPGA bridge for testing.
> + * @test: KUnit test context object.
> + *
> + * Return: Context of the newly registered FPGA bridge.
> + */
> +static struct bridge_ctx *register_test_bridge(struct kunit *test)
> +{
> +	struct bridge_ctx *ctx;
> +
> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +
> +	ctx->pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
> +
> +	ctx->bridge = fpga_bridge_register(&ctx->pdev->dev, "Fake FPGA bridge", &fake_bridge_ops,
> +					   &ctx->stats);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
> +
> +	return ctx;
> +}
> +
> +static void unregister_test_bridge(struct bridge_ctx *ctx)
> +{
> +	fpga_bridge_unregister(ctx->bridge);
> +	platform_device_unregister(ctx->pdev);
> +}
> +
> +static void fpga_bridge_test_get(struct kunit *test)
> +{
> +	struct bridge_ctx *ctx = test->priv;
> +	struct fpga_bridge *bridge;
> +
> +	bridge = fpga_bridge_get(&ctx->pdev->dev, NULL);
> +	KUNIT_EXPECT_PTR_EQ(test, bridge, ctx->bridge);
> +
> +	bridge = fpga_bridge_get(&ctx->pdev->dev, NULL);
> +	KUNIT_EXPECT_EQ(test, PTR_ERR(bridge), -EBUSY);
> +
> +	fpga_bridge_put(ctx->bridge);
> +}


modprobe fpga-bridge-test and then the below null-ptr-deref occurs.
It seems that ctx->pdev->dev->driver is NULL and the pdev->dev need
to be associated with a platform driver.

     general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
     KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
     CPU: 7 PID: 1864 Comm: kunit_try_catch Tainted: G                 N
6.6.0-rc2+ #49
     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.15.0-1 04/01/2014
     RIP: 0010:__fpga_bridge_get+0xca/0x160 [fpga_bridge]
     Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 86 00 00 00 48 b8 00
00 00 00 00 fc ff df 48 8b 5b 68 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80>
3c 02 00 75 71 48 8b 7b 10 e8 a7 5e 1a e1 84 c0 74 34 66 90 48
     RSP: 0018:ffff888106b0fe08 EFLAGS: 00010202
     RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8409be0f
     RDX: 0000000000000002 RSI: 0000000000000008 RDI: 0000000000000010
     RBP: ffff8881011bc008 R08: 0000000000000001 R09: ffffed1020d61fb3
     R10: ffff888106b0fd9f R11: ffff888106b0f850 R12: ffff8881011bc000
     R13: ffff8881011bc2e8 R14: ffff888104b675a8 R15: ffff88810868b080
     FS:  0000000000000000(0000) GS:ffff888119f80000(0000)
knlGS:0000000000000000
     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     CR2: 00007fad255ed8a0 CR3: 0000000005086006 CR4: 0000000000770ee0
     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
     PKRU: 55555554
     Call Trace:
      <TASK>
      ? die_addr+0x3d/0xa0
      ? exc_general_protection+0x144/0x220
      ? asm_exc_general_protection+0x22/0x30
      ? mutex_trylock+0xcf/0x150
      ? __fpga_bridge_get+0xca/0x160 [fpga_bridge]
      ? __fpga_bridge_get+0x4e/0x160 [fpga_bridge]
      fpga_bridge_test_get+0xb0/0x240 [fpga_bridge_test]
      ? _raw_spin_lock_irqsave+0x8d/0xe0
      ? op_enable_set+0x90/0x90 [fpga_bridge_test]
      ? __sched_text_end+0xa/0xa
      ? fpga_bridge_test_init+0x12/0x50 [fpga_bridge_test]
      ? kunit_try_run_case+0xdd/0x250
      ? kunit_try_run_case_cleanup+0xe0/0xe0
      kunit_generic_run_threadfn_adapter+0x4a/0x90
      ? kunit_try_catch_throw+0x80/0x80
      kthread+0x2b5/0x380
      ? kthread_complete_and_exit+0x20/0x20
      ret_from_fork+0x2d/0x70
      ? kthread_complete_and_exit+0x20/0x20
      ret_from_fork_asm+0x11/0x20
      </TASK>
     Modules linked in: fpga_bridge_test(+) fpga_bridge
     Dumping ftrace buffer:
        (ftrace buffer empty)
     ---[ end trace 0000000000000000 ]---
     RIP: 0010:__fpga_bridge_get+0xca/0x160 [fpga_bridge]
     Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 86 00 00 00 48 b8 00
00 00 00 00 fc ff df 48 8b 5b 68 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80>
3c 02 00 75 71 48 8b 7b 10 e8 a7 5e 1a e1 84 c0 74 34 66 90 48
     RSP: 0018:ffff888106b0fe08 EFLAGS: 00010202
     RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff8409be0f
     RDX: 0000000000000002 RSI: 0000000000000008 RDI: 0000000000000010
     RBP: ffff8881011bc008 R08: 0000000000000001 R09: ffffed1020d61fb3
     R10: ffff888106b0fd9f R11: ffff888106b0f850 R12: ffff8881011bc000
     R13: ffff8881011bc2e8 R14: ffff888104b675a8 R15: ffff88810868b080
     FS:  0000000000000000(0000) GS:ffff888119f80000(0000)
knlGS:0000000000000000
     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     CR2: 00007fad255ed8a0 CR3: 0000000005086006 CR4: 0000000000770ee0
     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
     PKRU: 55555554
     Kernel panic - not syncing: Fatal exception
     Dumping ftrace buffer:
        (ftrace buffer empty)
     Kernel Offset: disabled
     Rebooting in 1 seconds..

    Fixes: 9e6823481e5f ("fpga: add an initial KUnit suite for the FPGA
Bridge")
    Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>

> +
> +static void fpga_bridge_test_toggle(struct kunit *test)
> +{
> +	struct bridge_ctx *ctx = test->priv;
> +	int ret;
> +
> +	ret = fpga_bridge_disable(ctx->bridge);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_FALSE(test, ctx->stats.enable);
> +
> +	ret = fpga_bridge_enable(ctx->bridge);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_TRUE(test, ctx->stats.enable);
> +}
> +
> +/* Test the functions for getting and controlling a list of bridges */
> +static void fpga_bridge_test_get_put_list(struct kunit *test)
> +{
> +	struct list_head bridge_list;
> +	struct bridge_ctx *ctx_0, *ctx_1;
> +	int ret;
> +
> +	ctx_0 = test->priv;
> +	ctx_1 = register_test_bridge(test);
> +
> +	INIT_LIST_HEAD(&bridge_list);
> +
> +	/* Get bridge 0 and add it to the list */
> +	ret = fpga_bridge_get_to_list(&ctx_0->pdev->dev, NULL, &bridge_list);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_PTR_EQ(test, ctx_0->bridge,
> +			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
> +
> +	/* Get bridge 1 and add it to the list */
> +	ret = fpga_bridge_get_to_list(&ctx_1->pdev->dev, NULL, &bridge_list);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_PTR_EQ(test, ctx_1->bridge,
> +			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
> +
> +	/* Disable an then enable both bridges from the list */
> +	ret = fpga_bridges_disable(&bridge_list);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_FALSE(test, ctx_0->stats.enable);
> +	KUNIT_EXPECT_FALSE(test, ctx_1->stats.enable);
> +
> +	ret = fpga_bridges_enable(&bridge_list);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_TRUE(test, ctx_0->stats.enable);
> +	KUNIT_EXPECT_TRUE(test, ctx_1->stats.enable);
> +
> +	/* Put and remove both bridges from the list */
> +	fpga_bridges_put(&bridge_list);
> +
> +	KUNIT_EXPECT_TRUE(test, list_empty(&bridge_list));
> +
> +	unregister_test_bridge(ctx_1);
> +}
> +
> +static int fpga_bridge_test_init(struct kunit *test)
> +{
> +	test->priv = register_test_bridge(test);
> +
> +	return 0;
> +}
> +
> +static void fpga_bridge_test_exit(struct kunit *test)
> +{
> +	unregister_test_bridge(test->priv);
> +}
> +
> +static struct kunit_case fpga_bridge_test_cases[] = {
> +	KUNIT_CASE(fpga_bridge_test_get),
> +	KUNIT_CASE(fpga_bridge_test_toggle),
> +	KUNIT_CASE(fpga_bridge_test_get_put_list),
> +	{}
> +};
> +
> +static struct kunit_suite fpga_bridge_suite = {
> +	.name = "fpga_bridge",
> +	.init = fpga_bridge_test_init,
> +	.exit = fpga_bridge_test_exit,
> +	.test_cases = fpga_bridge_test_cases,
> +};
> +
> +kunit_test_suite(fpga_bridge_suite);
> +
> +MODULE_LICENSE("GPL");
