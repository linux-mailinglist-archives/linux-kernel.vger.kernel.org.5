Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36277ACD9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjIYBhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIYBhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:37:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D931BCA;
        Sun, 24 Sep 2023 18:37:00 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rv55f6G5cz15NKS;
        Mon, 25 Sep 2023 09:34:46 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 09:36:58 +0800
Message-ID: <4d51e87f-830a-adae-d6f7-6aed9433fdc6@huawei.com>
Date:   Mon, 25 Sep 2023 09:36:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v10 1/4] fpga: add an initial KUnit suite for the FPGA
 Manager
Content-Language: en-US
To:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
References: <20230718130304.87048-2-marpagan@redhat.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230718130304.87048-2-marpagan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1970/1/1 8:00, Marco Pagani wrote:
> The suite tests the basic behaviors of the FPGA Manager including
> programming using a single contiguous buffer and a scatter gather table.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fpga-mgr-test.c | 327 +++++++++++++++++++++++++++++
>  1 file changed, 327 insertions(+)
>  create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
> 
> diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
> new file mode 100644
> index 000000000000..6acec55b60ce
> --- /dev/null
> +++ b/drivers/fpga/tests/fpga-mgr-test.c
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the FPGA Manager
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/device.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/module.h>
> +#include <linux/scatterlist.h>
> +#include <linux/types.h>
> +
> +#define HEADER_FILL		'H'
> +#define IMAGE_FILL		'P'
> +#define IMAGE_BLOCK		1024
> +
> +#define HEADER_SIZE		IMAGE_BLOCK
> +#define IMAGE_SIZE		(IMAGE_BLOCK * 4)
> +
> +struct mgr_stats {
> +	bool header_match;
> +	bool image_match;
> +	u32 seq_num;
> +	u32 op_parse_header_seq;
> +	u32 op_write_init_seq;
> +	u32 op_write_seq;
> +	u32 op_write_sg_seq;
> +	u32 op_write_complete_seq;
> +	enum fpga_mgr_states op_parse_header_state;
> +	enum fpga_mgr_states op_write_init_state;
> +	enum fpga_mgr_states op_write_state;
> +	enum fpga_mgr_states op_write_sg_state;
> +	enum fpga_mgr_states op_write_complete_state;
> +};
> +
> +struct mgr_ctx {
> +	struct fpga_image_info *img_info;
> +	struct fpga_manager *mgr;
> +	struct platform_device *pdev;
> +	struct mgr_stats stats;
> +};
> +
> +/**
> + * init_test_buffer() - Allocate and initialize a test image in a buffer.
> + * @test: KUnit test context object.
> + * @count: image size in bytes.
> + *
> + * Return: pointer to the newly allocated image.
> + */
> +static char *init_test_buffer(struct kunit *test, size_t count)
> +{
> +	char *buf;
> +
> +	KUNIT_ASSERT_GE(test, count, HEADER_SIZE);
> +
> +	buf = kunit_kzalloc(test, count, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> +
> +	memset(buf, HEADER_FILL, HEADER_SIZE);
> +	memset(buf + HEADER_SIZE, IMAGE_FILL, count - HEADER_SIZE);
> +
> +	return buf;
> +}
> +
> +/*
> + * Check the image header. Do not return an error code if the image check fails
> + * since, in this case, it is a failure of the FPGA manager itself, not this
> + * op that tests it.
> + */
> +static int op_parse_header(struct fpga_manager *mgr, struct fpga_image_info *info,
> +			   const char *buf, size_t count)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +	size_t i;
> +
> +	stats->op_parse_header_state = mgr->state;
> +	stats->op_parse_header_seq = stats->seq_num++;
> +
> +	/* Set header_size and data_size for later */
> +	info->header_size = HEADER_SIZE;
> +	info->data_size = info->count - HEADER_SIZE;
> +
> +	stats->header_match = true;
> +	for (i = 0; i < info->header_size; i++) {
> +		if (buf[i] != HEADER_FILL) {
> +			stats->header_match = false;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int op_write_init(struct fpga_manager *mgr, struct fpga_image_info *info,
> +			 const char *buf, size_t count)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +
> +	stats->op_write_init_state = mgr->state;
> +	stats->op_write_init_seq = stats->seq_num++;
> +
> +	return 0;
> +}
> +
> +/*
> + * Check the image data. As with op_parse_header, do not return an error code
> + * if the image check fails.
> + */
> +static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +	size_t i;
> +
> +	stats->op_write_state = mgr->state;
> +	stats->op_write_seq = stats->seq_num++;
> +
> +	stats->image_match = true;
> +	for (i = 0; i < count; i++) {
> +		if (buf[i] != IMAGE_FILL) {
> +			stats->image_match = false;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Check the image data, but first skip the header since write_sg will get
> + * the whole image in sg_table. As with op_parse_header, do not return an
> + * error code if the image check fails.
> + */
> +static int op_write_sg(struct fpga_manager *mgr, struct sg_table *sgt)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +	struct sg_mapping_iter miter;
> +	char *img;
> +	size_t i;
> +
> +	stats->op_write_sg_state = mgr->state;
> +	stats->op_write_sg_seq = stats->seq_num++;
> +
> +	stats->image_match = true;
> +	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> +
> +	if (!sg_miter_skip(&miter, HEADER_SIZE)) {
> +		stats->image_match = false;
> +		goto out;
> +	}
> +
> +	while (sg_miter_next(&miter)) {
> +		img = miter.addr;
> +		for (i = 0; i < miter.length; i++) {
> +			if (img[i] != IMAGE_FILL) {
> +				stats->image_match = false;
> +				goto out;
> +			}
> +		}
> +	}
> +out:
> +	sg_miter_stop(&miter);
> +	return 0;
> +}
> +
> +static int op_write_complete(struct fpga_manager *mgr, struct fpga_image_info *info)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +
> +	stats->op_write_complete_state = mgr->state;
> +	stats->op_write_complete_seq = stats->seq_num++;
> +
> +	return 0;
> +}
> +
> +/*
> + * Fake FPGA manager that implements all ops required to check the programming
> + * sequence using a single contiguous buffer and a scatter gather table.
> + */
> +static const struct fpga_manager_ops fake_mgr_ops = {
> +	.skip_header = true,
> +	.parse_header = op_parse_header,
> +	.write_init = op_write_init,
> +	.write = op_write,
> +	.write_sg = op_write_sg,
> +	.write_complete = op_write_complete,
> +};
> +
> +static void fpga_mgr_test_get(struct kunit *test)
> +{
> +	struct mgr_ctx *ctx = test->priv;
> +	struct fpga_manager *mgr;
> +
> +	mgr = fpga_mgr_get(&ctx->pdev->dev);
> +	KUNIT_EXPECT_PTR_EQ(test, mgr, ctx->mgr);


modprobe fpga-mgr-test and then the below null-ptr-deref occurs.
It seems that ctx->pdev->dev->driver is NULL and the pdev->dev need
to be associated with a platform driver.

     general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
     KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
     CPU: 4 PID: 1866 Comm: kunit_try_catch Tainted: G                 N
6.6.0-rc2+ #49
     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.15.0-1 04/01/2014
     RIP: 0010:fpga_mgr_get+0x87/0xd0 [fpga_mgr]
     Code: 48 8d 7b 68 48 89 fa 48 c1 ea 03 80 3c 02 00 75 59 48 b8 00
00 00 00 00 fc ff df 48 8b 5b 68 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80>
3c 02 00 75 33 48 8b 7b 10 e8 7a 43 1a e1 84 c0 74 08 4c 89 e0
     RSP: 0018:ffff8881054cfe18 EFLAGS: 00010202
     RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff83f6a96c
     RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000010
     RBP: ffff88810d185808 R08: 0000000000000001 R09: ffffed1020d107ca
     R10: ffff888106883e53 R11: ffff8881054cfa50 R12: ffff88810d185800
     R13: ffff888106408520 R14: ffff88810683f5a8 R15: ffff888105e4b080
     FS:  0000000000000000(0000) GS:ffff888119e00000(0000)
knlGS:0000000000000000
     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     CR2: 00007f537e5ed8a0 CR3: 0000000005086001 CR4: 0000000000770ee0
     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
     PKRU: 55555554
     Call Trace:
      <TASK>
      ? die_addr+0x3d/0xa0
      ? exc_general_protection+0x144/0x220
      ? asm_exc_general_protection+0x22/0x30
      ? kobject_put+0x5c/0x310
      ? fpga_mgr_get+0x87/0xd0 [fpga_mgr]
      ? fpga_mgr_get+0x28/0xd0 [fpga_mgr]
      fpga_mgr_test_get+0xb4/0x1b0 [fpga_mgr_test]
      ? platform_device_register_resndata.constprop.0+0xc0/0xc0
[fpga_mgr_test]
      ? fpga_mgr_test_lock+0x1f0/0x1f0 [fpga_mgr_test]
      ? __sched_text_end+0xa/0xa
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
     Modules linked in: fpga_mgr_test(+) fpga_mgr
     Dumping ftrace buffer:
        (ftrace buffer empty)
     ---[ end trace 0000000000000000 ]---
     RIP: 0010:fpga_mgr_get+0x87/0xd0 [fpga_mgr]
     Code: 48 8d 7b 68 48 89 fa 48 c1 ea 03 80 3c 02 00 75 59 48 b8 00
00 00 00 00 fc ff df 48 8b 5b 68 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80>
3c 02 00 75 33 48 8b 7b 10 e8 7a 43 1a e1 84 c0 74 08 4c 89 e0
     RSP: 0018:ffff8881054cfe18 EFLAGS: 00010202
     RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff83f6a96c
     RDX: 0000000000000002 RSI: 0000000000000004 RDI: 0000000000000010
     RBP: ffff88810d185808 R08: 0000000000000001 R09: ffffed1020d107ca
     R10: ffff888106883e53 R11: ffff8881054cfa50 R12: ffff88810d185800
     R13: ffff888106408520 R14: ffff88810683f5a8 R15: ffff888105e4b080
     FS:  0000000000000000(0000) GS:ffff888119e00000(0000)
knlGS:0000000000000000
     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     CR2: 00007f537e5ed8a0 CR3: 0000000005086001 CR4: 0000000000770ee0
     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
     PKRU: 55555554
     Kernel panic - not syncing: Fatal exception
     Dumping ftrace buffer:
        (ftrace buffer empty)
     Kernel Offset: disabled
     Rebooting in 1 seconds..

    Fixes: ccbc1c302115 ("fpga: add an initial KUnit suite for the FPGA
Manager")
    Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>

> +
> +	fpga_mgr_put(ctx->mgr);
> +}
> +
> +static void fpga_mgr_test_lock(struct kunit *test)
> +{
> +	struct mgr_ctx *ctx = test->priv;
> +	int ret;
> +
> +	ret = fpga_mgr_lock(ctx->mgr);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	ret = fpga_mgr_lock(ctx->mgr);
> +	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
> +
> +	fpga_mgr_unlock(ctx->mgr);
> +}
> +
> +/* Check the programming sequence using an image in a buffer */
> +static void fpga_mgr_test_img_load_buf(struct kunit *test)
> +{
> +	struct mgr_ctx *ctx = test->priv;
> +	char *img_buf;
> +	int ret;
> +
> +	img_buf = init_test_buffer(test, IMAGE_SIZE);
> +
> +	ctx->img_info->count = IMAGE_SIZE;
> +	ctx->img_info->buf = img_buf;
> +
> +	ret = fpga_mgr_load(ctx->mgr, ctx->img_info);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_TRUE(test, ctx->stats.header_match);
> +	KUNIT_EXPECT_TRUE(test, ctx->stats.image_match);
> +
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_parse_header_state, FPGA_MGR_STATE_PARSE_HEADER);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_state, FPGA_MGR_STATE_WRITE_INIT);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_state, FPGA_MGR_STATE_WRITE);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_state, FPGA_MGR_STATE_WRITE_COMPLETE);
> +
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_seq, ctx->stats.op_parse_header_seq + 1);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_seq, ctx->stats.op_parse_header_seq + 2);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_seq, ctx->stats.op_parse_header_seq + 3);
> +}
> +
> +/* Check the programming sequence using an image in a scatter gather table */
> +static void fpga_mgr_test_img_load_sgt(struct kunit *test)
> +{
> +	struct mgr_ctx *ctx = test->priv;
> +	struct sg_table *sgt;
> +	char *img_buf;
> +	int ret;
> +
> +	img_buf = init_test_buffer(test, IMAGE_SIZE);
> +
> +	sgt = kunit_kzalloc(test, sizeof(*sgt), GFP_KERNEL);
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	sg_init_one(sgt->sgl, img_buf, IMAGE_SIZE);
> +
> +	ctx->img_info->sgt = sgt;
> +
> +	ret = fpga_mgr_load(ctx->mgr, ctx->img_info);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_TRUE(test, ctx->stats.header_match);
> +	KUNIT_EXPECT_TRUE(test, ctx->stats.image_match);
> +
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_parse_header_state, FPGA_MGR_STATE_PARSE_HEADER);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_state, FPGA_MGR_STATE_WRITE_INIT);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_sg_state, FPGA_MGR_STATE_WRITE);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_state, FPGA_MGR_STATE_WRITE_COMPLETE);
> +
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_seq, ctx->stats.op_parse_header_seq + 1);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_sg_seq, ctx->stats.op_parse_header_seq + 2);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_seq, ctx->stats.op_parse_header_seq + 3);
> +
> +	sg_free_table(ctx->img_info->sgt);
> +}
> +
> +static int fpga_mgr_test_init(struct kunit *test)
> +{
> +	struct mgr_ctx *ctx;
> +
> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +
> +	ctx->pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
> +
> +	ctx->mgr = devm_fpga_mgr_register(&ctx->pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
> +					  &ctx->stats);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
> +
> +	ctx->img_info = fpga_image_info_alloc(&ctx->pdev->dev);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->img_info);
> +
> +	test->priv = ctx;
> +
> +	return 0;
> +}
> +
> +static void fpga_mgr_test_exit(struct kunit *test)
> +{
> +	struct mgr_ctx *ctx = test->priv;
> +
> +	fpga_image_info_free(ctx->img_info);
> +	platform_device_unregister(ctx->pdev);
> +}
> +
> +static struct kunit_case fpga_mgr_test_cases[] = {
> +	KUNIT_CASE(fpga_mgr_test_get),
> +	KUNIT_CASE(fpga_mgr_test_lock),
> +	KUNIT_CASE(fpga_mgr_test_img_load_buf),
> +	KUNIT_CASE(fpga_mgr_test_img_load_sgt),
> +	{}
> +};
> +
> +static struct kunit_suite fpga_mgr_suite = {
> +	.name = "fpga_mgr",
> +	.init = fpga_mgr_test_init,
> +	.exit = fpga_mgr_test_exit,
> +	.test_cases = fpga_mgr_test_cases,
> +};
> +
> +kunit_test_suite(fpga_mgr_suite);
> +
> +MODULE_LICENSE("GPL");
