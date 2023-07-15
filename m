Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE97549BD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGOPWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjGOPWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:22:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C201992;
        Sat, 15 Jul 2023 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689434563; x=1720970563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SUVKaRn0EetS21UjHdG0XXTYcT66tXRO0Nj2bfVFtYU=;
  b=CS4b2HzEmkYBkpV/t4RfXzvTm98ce6ujuEvsqvtfuUAKvyovtVzlL9ea
   qvN4yaDAsI0M0JSM2ftGg2GnstKLHuqz/exP38j/N+Fzyz3f3nTE6TbuO
   nCPLhi9VyIr7jOQMAobeDuwonDoFVukSqUymlqbUes4AqqnaTjsTuvSIj
   4E/sTTldPbK1ARGrHCIlBsj5gtqXXLhh5IVfSeMkXUsxIOBqeXO+C+CXr
   kxruCtwPEVmx1SiBo/d7jZVO0zC1HdTVEyyKF27+C3V2VlGRiJeqIAC3U
   m03z+nywx4HS2kTF/nJyKYmLdy5BT853Fgjx/wbB/M5JjYvgtnyOs651e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="364540286"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="364540286"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 08:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10772"; a="792716448"
X-IronPort-AV: E=Sophos;i="6.01,208,1684825200"; 
   d="scan'208";a="792716448"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jul 2023 08:22:40 -0700
Date:   Sat, 15 Jul 2023 23:21:06 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v9 1/4] fpga: add an initial KUnit suite for the FPGA
 Manager
Message-ID: <ZLK5Yq4u4CPPZCR1@yilunxu-OptiPlex-7050>
References: <20230713162731.211669-1-marpagan@redhat.com>
 <20230713162731.211669-2-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713162731.211669-2-marpagan@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-13 at 18:27:28 +0200, Marco Pagani wrote:
> The suite tests the basic behaviors of the FPGA Manager including
> programming using a single contiguous buffer and a scatter gather table.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fpga-mgr-test.c | 329 +++++++++++++++++++++++++++++
>  1 file changed, 329 insertions(+)
>  create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
> 
> diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
> new file mode 100644
> index 000000000000..9f797986737a
> --- /dev/null
> +++ b/drivers/fpga/tests/fpga-mgr-test.c
> @@ -0,0 +1,329 @@
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
> +			goto out;

break, and remove the label.

> +		}
> +	}
> +
> +out:
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
> + * Check the image data. As with, op_parse_header do not return an error code
                                   ^
                            As with op_parse_header,

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
> +			goto out;

Ditto

> +		}
> +	}
> +
> +out:
> +	return 0;
> +}
> +
> +/*
> + * Check the image data, but first skip the header since write_sg will get
> + * the whole image in sg_table. As with op_write, do not return an error code

To make people find the reason easily, still say "As with op_parse_header", 

> + * if the image check fails.
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
> -- 
> 2.41.0
> 
