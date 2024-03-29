Return-Path: <linux-kernel+bounces-125168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D66892190
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEE1288E89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3194154736;
	Fri, 29 Mar 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="duVhGNeq"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4514A85298
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729424; cv=none; b=ei4v5zQopBLGBrIf0Hf3xrIa2C7I0SdSFrV3MEqToUQN5AFc1CBZZ0nmMTzjX/+j6zX9qaa4L5QwJKfNWX83nQ9el0U0sYnDAqYU+3UrMv39W0WBUSJeNWaPUApVVOyXyROd/BGINUSfBjbWJ8Z9pqejF3pswj6X6Mwgy14nr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729424; c=relaxed/simple;
	bh=hnr5VJeKVb/XJj+Pu7r4ZWUHA5D3fNPK71h3si4hbpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHpnslXOgpgiehrttAvWIDbEX8FsH109VOHvjOtT9t/ZiJYk9RTGSZHJQy6xOgyy2ybESYOsWjLiQwtvbgsVPJ4magoS3PhenGMsjBzgliBcuDgfnTxchEg8Va1ZZzKnPYYHcv2OrFLHzJeV3JMxUgxds02eVB2GN283Eh8wMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=duVhGNeq; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 29 Mar 2024 09:23:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711729419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xbxFMR4Dp4nHhYuSHrXuG22aSt+5HA+RqxLpyhQUnSk=;
	b=duVhGNeqbNfXW93isgDW5kdw0SzrlIUcsvaqs9Egon4o+bnSgTVht3iZEkf8rSQZ8Sfhkg
	VnoxVZ55HCSdqhqjgo3UjCQ61r9aZeEPIekN7qYVNqLmS/ymKwUXW4tNdDRPDhfvv9GUQe
	Sk8tnfFe9PbuhfhQ5JPNYTs0di2+vGM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: tests: use KUnit devices instead of platform
 devices
Message-ID: <20240329162323.6kj6vspb4gwacxos@4VRSMR2-DT.corp.robot.car>
References: <20240327120818.148430-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327120818.148430-1-marpagan@redhat.com>
X-Migadu-Flow: FLOW_OUT


On Wed, Mar 27, 2024 at 01:08:17PM +0100, Marco Pagani wrote:
> KUnit now provides helper functions to create fake devices, so use them
> instead of relying on platform devices.
> 
> Other changes: remove an unnecessary white space in the fpga region suite.
> 
Reviewed-by: Russ Weight <russ.weight@linux.dev>

> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fpga-bridge-test.c | 33 ++++++++++-----------
>  drivers/fpga/tests/fpga-mgr-test.c    | 16 +++++------
>  drivers/fpga/tests/fpga-region-test.c | 41 +++++++++++++--------------
>  3 files changed, 44 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
> index 1d258002cdd7..2f7a24f23808 100644
> --- a/drivers/fpga/tests/fpga-bridge-test.c
> +++ b/drivers/fpga/tests/fpga-bridge-test.c
> @@ -7,8 +7,8 @@
>   * Author: Marco Pagani <marpagan@redhat.com>
>   */
>  
> +#include <kunit/device.h>
>  #include <kunit/test.h>
> -#include <linux/device.h>
>  #include <linux/fpga/fpga-bridge.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
> @@ -19,7 +19,7 @@ struct bridge_stats {
>  
>  struct bridge_ctx {
>  	struct fpga_bridge *bridge;
> -	struct platform_device *pdev;
> +	struct device *dev;
>  	struct bridge_stats stats;
>  };
>  
> @@ -43,30 +43,31 @@ static const struct fpga_bridge_ops fake_bridge_ops = {
>  /**
>   * register_test_bridge() - Register a fake FPGA bridge for testing.
>   * @test: KUnit test context object.
> + * @dev_name: name of the kunit device to be registered
>   *
>   * Return: Context of the newly registered FPGA bridge.
>   */
> -static struct bridge_ctx *register_test_bridge(struct kunit *test)
> +static struct bridge_ctx *register_test_bridge(struct kunit *test, const char *dev_name)
>  {
>  	struct bridge_ctx *ctx;
>  
>  	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
>  
> -	ctx->pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
> +	ctx->dev = kunit_device_register(test, dev_name);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->dev);
>  
> -	ctx->bridge = fpga_bridge_register(&ctx->pdev->dev, "Fake FPGA bridge", &fake_bridge_ops,
> +	ctx->bridge = fpga_bridge_register(ctx->dev, "Fake FPGA bridge", &fake_bridge_ops,
>  					   &ctx->stats);
>  	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
>  
>  	return ctx;
>  }
>  
> -static void unregister_test_bridge(struct bridge_ctx *ctx)
> +static void unregister_test_bridge(struct kunit *test, struct bridge_ctx *ctx)
>  {
>  	fpga_bridge_unregister(ctx->bridge);
> -	platform_device_unregister(ctx->pdev);
> +	kunit_device_unregister(test, ctx->dev);
>  }
>  
>  static void fpga_bridge_test_get(struct kunit *test)
> @@ -74,10 +75,10 @@ static void fpga_bridge_test_get(struct kunit *test)
>  	struct bridge_ctx *ctx = test->priv;
>  	struct fpga_bridge *bridge;
>  
> -	bridge = fpga_bridge_get(&ctx->pdev->dev, NULL);
> +	bridge = fpga_bridge_get(ctx->dev, NULL);
>  	KUNIT_EXPECT_PTR_EQ(test, bridge, ctx->bridge);
>  
> -	bridge = fpga_bridge_get(&ctx->pdev->dev, NULL);
> +	bridge = fpga_bridge_get(ctx->dev, NULL);
>  	KUNIT_EXPECT_EQ(test, PTR_ERR(bridge), -EBUSY);
>  
>  	fpga_bridge_put(ctx->bridge);
> @@ -105,19 +106,19 @@ static void fpga_bridge_test_get_put_list(struct kunit *test)
>  	int ret;
>  
>  	ctx_0 = test->priv;
> -	ctx_1 = register_test_bridge(test);
> +	ctx_1 = register_test_bridge(test, "fpga-bridge-test-dev-1");
>  
>  	INIT_LIST_HEAD(&bridge_list);
>  
>  	/* Get bridge 0 and add it to the list */
> -	ret = fpga_bridge_get_to_list(&ctx_0->pdev->dev, NULL, &bridge_list);
> +	ret = fpga_bridge_get_to_list(ctx_0->dev, NULL, &bridge_list);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
>  
>  	KUNIT_EXPECT_PTR_EQ(test, ctx_0->bridge,
>  			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
>  
>  	/* Get bridge 1 and add it to the list */
> -	ret = fpga_bridge_get_to_list(&ctx_1->pdev->dev, NULL, &bridge_list);
> +	ret = fpga_bridge_get_to_list(ctx_1->dev, NULL, &bridge_list);
>  	KUNIT_EXPECT_EQ(test, ret, 0);
>  
>  	KUNIT_EXPECT_PTR_EQ(test, ctx_1->bridge,
> @@ -141,19 +142,19 @@ static void fpga_bridge_test_get_put_list(struct kunit *test)
>  
>  	KUNIT_EXPECT_TRUE(test, list_empty(&bridge_list));
>  
> -	unregister_test_bridge(ctx_1);
> +	unregister_test_bridge(test, ctx_1);
>  }
>  
>  static int fpga_bridge_test_init(struct kunit *test)
>  {
> -	test->priv = register_test_bridge(test);
> +	test->priv = register_test_bridge(test, "fpga-bridge-test-dev-0");
>  
>  	return 0;
>  }
>  
>  static void fpga_bridge_test_exit(struct kunit *test)
>  {
> -	unregister_test_bridge(test->priv);
> +	unregister_test_bridge(test, test->priv);
>  }
>  
>  static struct kunit_case fpga_bridge_test_cases[] = {
> diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
> index 6acec55b60ce..125b3a4d43c6 100644
> --- a/drivers/fpga/tests/fpga-mgr-test.c
> +++ b/drivers/fpga/tests/fpga-mgr-test.c
> @@ -7,8 +7,8 @@
>   * Author: Marco Pagani <marpagan@redhat.com>
>   */
>  
> +#include <kunit/device.h>
>  #include <kunit/test.h>
> -#include <linux/device.h>
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/module.h>
>  #include <linux/scatterlist.h>
> @@ -40,7 +40,7 @@ struct mgr_stats {
>  struct mgr_ctx {
>  	struct fpga_image_info *img_info;
>  	struct fpga_manager *mgr;
> -	struct platform_device *pdev;
> +	struct device *dev;
>  	struct mgr_stats stats;
>  };
>  
> @@ -194,7 +194,7 @@ static void fpga_mgr_test_get(struct kunit *test)
>  	struct mgr_ctx *ctx = test->priv;
>  	struct fpga_manager *mgr;
>  
> -	mgr = fpga_mgr_get(&ctx->pdev->dev);
> +	mgr = fpga_mgr_get(ctx->dev);
>  	KUNIT_EXPECT_PTR_EQ(test, mgr, ctx->mgr);
>  
>  	fpga_mgr_put(ctx->mgr);
> @@ -284,14 +284,14 @@ static int fpga_mgr_test_init(struct kunit *test)
>  	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
>  
> -	ctx->pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
> +	ctx->dev = kunit_device_register(test, "fpga-manager-test-dev");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->dev);
>  
> -	ctx->mgr = devm_fpga_mgr_register(&ctx->pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
> +	ctx->mgr = devm_fpga_mgr_register(ctx->dev, "Fake FPGA Manager", &fake_mgr_ops,
>  					  &ctx->stats);
>  	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
>  
> -	ctx->img_info = fpga_image_info_alloc(&ctx->pdev->dev);
> +	ctx->img_info = fpga_image_info_alloc(ctx->dev);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->img_info);
>  
>  	test->priv = ctx;
> @@ -304,7 +304,7 @@ static void fpga_mgr_test_exit(struct kunit *test)
>  	struct mgr_ctx *ctx = test->priv;
>  
>  	fpga_image_info_free(ctx->img_info);
> -	platform_device_unregister(ctx->pdev);
> +	kunit_device_unregister(test, ctx->dev);
>  }
>  
>  static struct kunit_case fpga_mgr_test_cases[] = {
> diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
> index baab07e3fc59..bcf0651df261 100644
> --- a/drivers/fpga/tests/fpga-region-test.c
> +++ b/drivers/fpga/tests/fpga-region-test.c
> @@ -7,12 +7,12 @@
>   * Author: Marco Pagani <marpagan@redhat.com>
>   */
>  
> +#include <kunit/device.h>
>  #include <kunit/test.h>
>  #include <linux/fpga/fpga-bridge.h>
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/fpga/fpga-region.h>
>  #include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/types.h>
>  
>  struct mgr_stats {
> @@ -26,11 +26,11 @@ struct bridge_stats {
>  
>  struct test_ctx {
>  	struct fpga_manager *mgr;
> -	struct platform_device *mgr_pdev;
> +	struct device *mgr_dev;
>  	struct fpga_bridge *bridge;
> -	struct platform_device *bridge_pdev;
> +	struct device *bridge_dev;
>  	struct fpga_region *region;
> -	struct platform_device *region_pdev;
> +	struct device *region_dev;
>  	struct bridge_stats bridge_stats;
>  	struct mgr_stats mgr_stats;
>  };
> @@ -91,7 +91,7 @@ static void fpga_region_test_class_find(struct kunit *test)
>  	struct test_ctx *ctx = test->priv;
>  	struct fpga_region *region;
>  
> -	region = fpga_region_class_find(NULL, &ctx->region_pdev->dev, fake_region_match);
> +	region = fpga_region_class_find(NULL, ctx->region_dev, fake_region_match);
>  	KUNIT_EXPECT_PTR_EQ(test, region, ctx->region);
>  
>  	put_device(&region->dev);
> @@ -108,7 +108,7 @@ static void fpga_region_test_program_fpga(struct kunit *test)
>  	char img_buf[4];
>  	int ret;
>  
> -	img_info = fpga_image_info_alloc(&ctx->mgr_pdev->dev);
> +	img_info = fpga_image_info_alloc(ctx->mgr_dev);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
>  
>  	img_info->buf = img_buf;
> @@ -148,32 +148,30 @@ static int fpga_region_test_init(struct kunit *test)
>  	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
>  
> -	ctx->mgr_pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mgr_pdev);
> +	ctx->mgr_dev = kunit_device_register(test, "fpga-manager-test-dev");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mgr_dev);
>  
> -	ctx->mgr = devm_fpga_mgr_register(&ctx->mgr_pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
> -					  &ctx->mgr_stats);
> +	ctx->mgr = devm_fpga_mgr_register(ctx->mgr_dev, "Fake FPGA Manager",
> +					  &fake_mgr_ops, &ctx->mgr_stats);
>  	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
>  
> -	ctx->bridge_pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO,
> -							   NULL, 0);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->bridge_pdev);
> +	ctx->bridge_dev = kunit_device_register(test, "fpga-bridge-test-dev");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->bridge_dev);
>  
> -	ctx->bridge = fpga_bridge_register(&ctx->bridge_pdev->dev, "Fake FPGA Bridge",
> +	ctx->bridge = fpga_bridge_register(ctx->bridge_dev, "Fake FPGA Bridge",
>  					   &fake_bridge_ops, &ctx->bridge_stats);
>  	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
>  
>  	ctx->bridge_stats.enable = true;
>  
> -	ctx->region_pdev = platform_device_register_simple("region_pdev", PLATFORM_DEVID_AUTO,
> -							   NULL, 0);
> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_pdev);
> +	ctx->region_dev = kunit_device_register(test, "fpga-region-test-dev");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_dev);
>  
>  	region_info.mgr = ctx->mgr;
>  	region_info.priv = ctx->bridge;
>  	region_info.get_bridges = fake_region_get_bridges;
>  
> -	ctx->region = fpga_region_register_full(&ctx->region_pdev->dev, &region_info);
> +	ctx->region = fpga_region_register_full(ctx->region_dev, &region_info);
>  	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->region));
>  
>  	test->priv = ctx;
> @@ -186,18 +184,17 @@ static void fpga_region_test_exit(struct kunit *test)
>  	struct test_ctx *ctx = test->priv;
>  
>  	fpga_region_unregister(ctx->region);
> -	platform_device_unregister(ctx->region_pdev);
> +	kunit_device_unregister(test, ctx->region_dev);
>  
>  	fpga_bridge_unregister(ctx->bridge);
> -	platform_device_unregister(ctx->bridge_pdev);
> +	kunit_device_unregister(test, ctx->bridge_dev);
>  
> -	platform_device_unregister(ctx->mgr_pdev);
> +	kunit_device_unregister(test, ctx->mgr_dev);
>  }
>  
>  static struct kunit_case fpga_region_test_cases[] = {
>  	KUNIT_CASE(fpga_region_test_class_find),
>  	KUNIT_CASE(fpga_region_test_program_fpga),
> -
>  	{}
>  };
>  
> 
> base-commit: b1a91ca25f15b6d7b311de4465854a5981dee3d3
> -- 
> 2.44.0
> 

