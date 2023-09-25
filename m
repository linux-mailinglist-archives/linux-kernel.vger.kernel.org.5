Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997037ACDA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjIYBlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjIYBlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:41:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0BE8;
        Sun, 24 Sep 2023 18:41:45 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rv5C61j4JzrSwG;
        Mon, 25 Sep 2023 09:39:30 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 09:41:42 +0800
Message-ID: <d557b4ee-4b3a-8747-bdda-0ed480212a63@huawei.com>
Date:   Mon, 25 Sep 2023 09:41:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v10 3/4] fpga: add an initial KUnit suite for the FPGA
 Region
Content-Language: en-US
To:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
References: <20230718130304.87048-4-marpagan@redhat.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230718130304.87048-4-marpagan@redhat.com>
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



On 1970/1/1 8:00, Marco Pagani wrote:
> The suite tests the basic behaviors of the FPGA Region including
> the programming and the function for finding a specific region.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  drivers/fpga/tests/fpga-region-test.c | 211 ++++++++++++++++++++++++++
>  1 file changed, 211 insertions(+)
>  create mode 100644 drivers/fpga/tests/fpga-region-test.c
> 
> diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
> new file mode 100644
> index 000000000000..9f9d50ee7871
> --- /dev/null
> +++ b/drivers/fpga/tests/fpga-region-test.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the FPGA Region
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/fpga/fpga-bridge.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/fpga/fpga-region.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +struct mgr_stats {
> +	u32 write_count;
> +};
> +
> +struct bridge_stats {
> +	bool enable;
> +	u32 cycles_count;
> +};
> +
> +struct test_ctx {
> +	struct fpga_manager *mgr;
> +	struct platform_device *mgr_pdev;
> +	struct fpga_bridge *bridge;
> +	struct platform_device *bridge_pdev;
> +	struct fpga_region *region;
> +	struct platform_device *region_pdev;
> +	struct bridge_stats bridge_stats;
> +	struct mgr_stats mgr_stats;
> +};
> +
> +static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +
> +	stats->write_count++;
> +
> +	return 0;
> +}
> +
> +/*
> + * Fake FPGA manager that implements only the write op to count the number
> + * of programming cycles. The internals of the programming sequence are
> + * tested in the Manager suite since they are outside the responsibility
> + * of the Region.
> + */
> +static const struct fpga_manager_ops fake_mgr_ops = {
> +	.write = op_write,
> +};
> +
> +static int op_enable_set(struct fpga_bridge *bridge, bool enable)
> +{
> +	struct bridge_stats *stats = bridge->priv;
> +
> +	if (!stats->enable && enable)
> +		stats->cycles_count++;
> +
> +	stats->enable = enable;
> +
> +	return 0;
> +}
> +
> +/*
> + * Fake FPGA bridge that implements only enable_set op to count the number
> + * of activation cycles.
> + */
> +static const struct fpga_bridge_ops fake_bridge_ops = {
> +	.enable_set = op_enable_set,
> +};
> +
> +static int fake_region_get_bridges(struct fpga_region *region)
> +{
> +	struct fpga_bridge *bridge = region->priv;
> +
> +	return fpga_bridge_get_to_list(bridge->dev.parent, region->info, &region->bridge_list);
> +}
> +
> +static int fake_region_match(struct device *dev, const void *data)
> +{
> +	return dev->parent == data;
> +}
> +
> +static void fpga_region_test_class_find(struct kunit *test)
> +{
> +	struct test_ctx *ctx = test->priv;
> +	struct fpga_region *region;
> +
> +	region = fpga_region_class_find(NULL, &ctx->region_pdev->dev, fake_region_match);
> +	KUNIT_EXPECT_PTR_EQ(test, region, ctx->region);
> +}
> +
> +/*
> + * FPGA Region programming test. The Region must call get_bridges() to get
> + * and control the bridges, and then the Manager for the actual programming.
> + */
> +static void fpga_region_test_program_fpga(struct kunit *test)
> +{
> +	struct test_ctx *ctx = test->priv;
> +	struct fpga_image_info *img_info;
> +	char img_buf[4];
> +	int ret;
> +
> +	img_info = fpga_image_info_alloc(&ctx->mgr_pdev->dev);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
> +
> +	img_info->buf = img_buf;
> +	img_info->count = sizeof(img_buf);
> +
> +	ctx->region->info = img_info;
> +	ret = fpga_region_program_fpga(ctx->region);

modprobe fpga-region-test and the below null-ptr-deref occurs.It seems
that ctx->region->dev is NULL and the region->dev need
to be assigned.

     general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
     KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
     CPU: 3 PID: 1887 Comm: kunit_try_catch Tainted: G                 N
6.6.0-rc2+ #49
     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.15.0-1 04/01/2014
     RIP: 0010:fpga_region_program_fpga+0xfb/0x390 [fpga_region]
     Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 73 02 00 00 48 b8 00
00 00 00 00 fc ff df 48 8b 5b 68 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80>
3c 02 00 0f 85 5a 02 00 00 48 8b 7b 10 e8 62 df 14 e1 84 c0 0f
     RSP: 0018:ffff88810f6b7db0 EFLAGS: 00010202
     RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff83f6a490
     RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000010
     RBP: ffff888108b99000 R08: 0000000000000001 R09: ffffed1021173207
     R10: ffff888108b9903b R11: ffff88810f6b7a18 R12: ffff888108b992e0
     R13: ffff888106d28828 R14: ffff888108b99000 R15: ffff888106d28828
     FS:  0000000000000000(0000) GS:ffff888119d80000(0000)
knlGS:0000000000000000
     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     CR2: 00007faa013c1000 CR3: 000000010d6e5005 CR4: 0000000000770ee0
     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
     PKRU: 55555554
     Call Trace:
      <TASK>
      ? die_addr+0x3d/0xa0
      ? exc_general_protection+0x144/0x220
      ? asm_exc_general_protection+0x22/0x30
      ? kobject_get+0x50/0xe0
      ? fpga_region_program_fpga+0xfb/0x390 [fpga_region]
      fpga_region_test_program_fpga+0x17e/0x580 [fpga_region_test]
      ? fake_region_match+0x50/0x50 [fpga_region_test]
      ? try_to_wake_up+0x151/0x13e0
      ? fpga_region_test_exit+0x130/0x130 [fpga_region_test]
      ? __sched_text_end+0xa/0xa
      ? kunit_try_run_case_cleanup+0xe0/0xe0
      kunit_generic_run_threadfn_adapter+0x4a/0x90
      ? kunit_try_catch_throw+0x80/0x80
      kthread+0x2b5/0x380
      ? kthread_complete_and_exit+0x20/0x20
      ret_from_fork+0x2d/0x70
      ? kthread_complete_and_exit+0x20/0x20
      ret_from_fork_asm+0x11/0x20
      </TASK>
     Modules linked in: fpga_region_test(+) fpga_region fpga_bridge fpga_mgr
     Dumping ftrace buffer:
        (ftrace buffer empty)
     ---[ end trace 0000000000000000 ]---
     RIP: 0010:fpga_region_program_fpga+0xfb/0x390 [fpga_region]
     Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 73 02 00 00 48 b8 00
00 00 00 00 fc ff df 48 8b 5b 68 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80>
3c 02 00 0f 85 5a 02 00 00 48 8b 7b 10 e8 62 df 14 e1 84 c0 0f
     RSP: 0018:ffff88810f6b7db0 EFLAGS: 00010202
     RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff83f6a490
     RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000010
     RBP: ffff888108b99000 R08: 0000000000000001 R09: ffffed1021173207
     R10: ffff888108b9903b R11: ffff88810f6b7a18 R12: ffff888108b992e0
     R13: ffff888106d28828 R14: ffff888108b99000 R15: ffff888106d28828
     FS:  0000000000000000(0000) GS:ffff888119d80000(0000)
knlGS:0000000000000000
     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     CR2: 00007faa013c1000 CR3: 000000010d6e5005 CR4: 0000000000770ee0
     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
     PKRU: 55555554
     Kernel panic - not syncing: Fatal exception
     Dumping ftrace buffer:
        (ftrace buffer empty)
     Kernel Offset: disabled
     Rebooting in 1 seconds..

    Fixes: 64a5f972c93d ("fpga: add an initial KUnit suite for the FPGA
Region")
    Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>

> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_EQ(test, 1, ctx->mgr_stats.write_count);
> +	KUNIT_EXPECT_EQ(test, 1, ctx->bridge_stats.cycles_count);
> +
> +	fpga_bridges_put(&ctx->region->bridge_list);
> +
> +	ret = fpga_region_program_fpga(ctx->region);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_EQ(test, 2, ctx->mgr_stats.write_count);
> +	KUNIT_EXPECT_EQ(test, 2, ctx->bridge_stats.cycles_count);
> +
> +	fpga_bridges_put(&ctx->region->bridge_list);
> +
> +	fpga_image_info_free(img_info);
> +}
> +
> +/*
> + * The configuration used in this test suite uses a single bridge to
> + * limit the code under test to a single unit. The functions used by the
> + * Region for getting and controlling bridges are tested (with a list of
> + * multiple bridges) in the Bridge suite.
> + */
> +static int fpga_region_test_init(struct kunit *test)
> +{
> +	struct test_ctx *ctx;
> +	struct fpga_region_info region_info = { 0 };
> +
> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +
> +	ctx->mgr_pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mgr_pdev);
> +
> +	ctx->mgr = devm_fpga_mgr_register(&ctx->mgr_pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
> +					  &ctx->mgr_stats);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
> +
> +	ctx->bridge_pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO,
> +							   NULL, 0);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->bridge_pdev);
> +
> +	ctx->bridge = fpga_bridge_register(&ctx->bridge_pdev->dev, "Fake FPGA Bridge",
> +					   &fake_bridge_ops, &ctx->bridge_stats);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
> +
> +	ctx->bridge_stats.enable = true;
> +
> +	ctx->region_pdev = platform_device_register_simple("region_pdev", PLATFORM_DEVID_AUTO,
> +							   NULL, 0);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_pdev);
> +
> +	region_info.mgr = ctx->mgr;
> +	region_info.priv = ctx->bridge;
> +	region_info.get_bridges = fake_region_get_bridges;
> +
> +	ctx->region = fpga_region_register_full(&ctx->region_pdev->dev, &region_info);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->region));
> +
> +	test->priv = ctx;
> +
> +	return 0;
> +}
> +
> +static void fpga_region_test_exit(struct kunit *test)
> +{
> +	struct test_ctx *ctx = test->priv;
> +
> +	fpga_region_unregister(ctx->region);
> +	platform_device_unregister(ctx->region_pdev);
> +
> +	fpga_bridge_unregister(ctx->bridge);
> +	platform_device_unregister(ctx->bridge_pdev);
> +
> +	platform_device_unregister(ctx->mgr_pdev);
> +}
> +
> +static struct kunit_case fpga_region_test_cases[] = {
> +	KUNIT_CASE(fpga_region_test_class_find),
> +	KUNIT_CASE(fpga_region_test_program_fpga),
> +
> +	{}
> +};
> +
> +static struct kunit_suite fpga_region_suite = {
> +	.name = "fpga_mgr",
> +	.init = fpga_region_test_init,
> +	.exit = fpga_region_test_exit,
> +	.test_cases = fpga_region_test_cases,
> +};
> +
> +kunit_test_suite(fpga_region_suite);
> +
> +MODULE_LICENSE("GPL");
