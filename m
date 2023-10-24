Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2D17D5990
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbjJXRPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbjJXRPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23350122
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698167671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPe5sErz69Kanovy14RWE3IYDmvNX5JNjcUdys3uWXo=;
        b=DQaYIuB5oRvbhx4YevecFIbP1LwVtO/3i++W7pM1FACItia0zBwUdvor4NfEyFISXZw+ja
        0t5iybFVjfKVUMtNDOGl+9U3TOxWcxNk2y5vTbukfC0xS72tTNSvn5iBkTeAiWVdhouUg+
        npIUfbSsK4P1yo9qeff7JSdTOSITA6E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-gM8BjP2PNh6CKggNWV5v8Q-1; Tue, 24 Oct 2023 13:14:29 -0400
X-MC-Unique: gM8BjP2PNh6CKggNWV5v8Q-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-778a738a523so653239585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698167669; x=1698772469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPe5sErz69Kanovy14RWE3IYDmvNX5JNjcUdys3uWXo=;
        b=dy5aLlCTG35ielnC5BYO34+J1rzh1MB5pfA4f7SzsDZq4U5YL6j2nXicSdcq3CRkAw
         36NowApP2APukMGzacPvzIQwPmVXPpEahCyiEm0VyCcUkd3ovBjtsSSSJKpXqV0D5n1t
         ftDUBMovML6mbkSJGEcZS357z3pGmNnbltznpwsyh2DZlBzhg/jHWwRZK3QYx6nyKW+A
         xn50juT4y55CV1VOsSpL1sjqYUNGwEFsXmACAMWBmvdZpgOQxuF0pQiUSk8OSDjOdOXy
         RQaZPi69kpl3P4N6iGCmgiK6nmBUhOshtxe4I6KDXwF/pVeOu+28rQ+H/LASXFN+3WrF
         RoCw==
X-Gm-Message-State: AOJu0Yz2RidqOsk5/gl24PlC7ERW80eBGb8NC1I5Krj4gRId5JeQr4kE
        FK+eNjmW9BoERhQKuqjmhnWDyiTu9NkPJglZnRxRz9ocTjzYobbXdL9Mfo4qy05AoQ0e+Mu+HXJ
        kM0SNBj9k6U+7uHZV2i6Hz5g=
X-Received: by 2002:a05:620a:75a:b0:778:9407:7fb2 with SMTP id i26-20020a05620a075a00b0077894077fb2mr13324449qki.22.1698167669448;
        Tue, 24 Oct 2023 10:14:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIdhxuxEfCx3j4I0HFbiJ43lsMpJusnNEfPAwg87n/MZ5TveZd/Xx4uN8x1QmqfRHILmwhjA==
X-Received: by 2002:a05:620a:75a:b0:778:9407:7fb2 with SMTP id i26-20020a05620a075a00b0077894077fb2mr13324432qki.22.1698167669139;
        Tue, 24 Oct 2023 10:14:29 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id o8-20020a05620a2a0800b0077263636a95sm3570561qkp.93.2023.10.24.10.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 10:14:28 -0700 (PDT)
Message-ID: <789aaf2b-4d68-4128-b8ff-c1ba4849e141@redhat.com>
Date:   Tue, 24 Oct 2023 19:14:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/test: add a test suite for GEM objects backed by
 shmem
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20231023164541.92913-1-marpagan@redhat.com>
 <zakappnhljtx3axi2ovvis3evhju4cwqrena7j6gqn5kjdjtsb@mgrhkn5oboid>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <zakappnhljtx3axi2ovvis3evhju4cwqrena7j6gqn5kjdjtsb@mgrhkn5oboid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-24 11:23, Maxime Ripard wrote:
> Hi Marco,
> 
> On Mon, Oct 23, 2023 at 06:45:40PM +0200, Marco Pagani wrote:
>> This patch introduces an initial KUnit test suite for GEM objects
>> backed by shmem buffers.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/gpu/drm/Kconfig                    |   1 +
>>  drivers/gpu/drm/tests/Makefile             |   3 +-
>>  drivers/gpu/drm/tests/drm_gem_shmem_test.c | 303 +++++++++++++++++++++
>>  3 files changed, 306 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/gpu/drm/tests/drm_gem_shmem_test.c
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index 3eee8636f847..f0a77e3e04d7 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -84,6 +84,7 @@ config DRM_KUNIT_TEST
>>  	select DRM_EXPORT_FOR_TESTS if m
>>  	select DRM_KUNIT_TEST_HELPERS
>>  	select DRM_EXEC
>> +	select DRM_GEM_SHMEM_HELPER
> 
> I know that DRM_EXEC already stands out, but these should be ordered
> alphabetically, so it should be before DRM_KUNIT_TEST_HELPERS.
> 
>>  	default KUNIT_ALL_TESTS
>>  	help
>>  	  This builds unit tests for DRM. This option is not useful for
>> diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
>> index ba7baa622675..b8227aab369e 100644
>> --- a/drivers/gpu/drm/tests/Makefile
>> +++ b/drivers/gpu/drm/tests/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
>>  	drm_plane_helper_test.o \
>>  	drm_probe_helper_test.o \
>>  	drm_rect_test.o	\
>> -	drm_exec_test.o
>> +	drm_exec_test.o \
>> +	drm_gem_shmem_test.o
> 
> Ditto.
>

Right, I'll sort them alphabetically for v2.

>>  CFLAGS_drm_mm_test.o := $(DISABLE_STRUCTLEAK_PLUGIN)
>> diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
>> new file mode 100644
>> index 000000000000..0bf6727f08d2
>> --- /dev/null
>> +++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
>> @@ -0,0 +1,303 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * KUnit test suite for GEM objects backed by shmem buffers
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#include <linux/dma-buf.h>
>> +#include <linux/iosys-map.h>
>> +#include <linux/sizes.h>
>> +
>> +#include <kunit/test.h>
>> +
>> +#include <drm/drm_device.h>
>> +#include <drm/drm_drv.h>
>> +#include <drm/drm_gem.h>
>> +#include <drm/drm_gem_shmem_helper.h>
>> +#include <drm/drm_kunit_helpers.h>
>> +
>> +#define TEST_SIZE		SZ_1M
>> +#define TEST_BYTE		0xae
>> +
>> +struct fake_dev {
>> +	struct drm_device drm_dev;
>> +	struct device *dev;
>> +};
>> +
>> +/* Test creating a shmem GEM object */
>> +static void drm_gem_shmem_test_obj_create(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +	KUNIT_ASSERT_EQ(test, shmem->base.size, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_NULL(test, shmem->base.filp);
>> +	KUNIT_ASSERT_NOT_NULL(test, shmem->base.funcs);
>> +
>> +	drm_gem_shmem_free(shmem);
>> +}
>> +
>> +/* Test creating a private shmem GEM object from a scatter/gather table */
> 
> Thanks for documenting those tests. I believe we should also document
> what we expect from the test: should the test succeed? fail? if it
> fails, what is the cause of failure?
> 
> Based on the following test, I think something like the following would
> be good:
> 
> Test that creating a private shmem GEM object from a previously
> allocated sg_table succeeds and is properly initialized
> 
> Feel free to change it to something else if you find something missing.
>

Sounds good to me. I'll improve the documentation for v2.

>> +static void drm_gem_shmem_test_obj_create_private(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	struct drm_gem_object *gem_obj;
>> +	struct dma_buf buf_mock;
>> +	struct dma_buf_attachment attach_mock;
>> +	struct sg_table *sgt;
>> +	char *buf;
>> +	int ret;
>> +
>> +	/* Create a mock scatter/gather table */
>> +	buf = kunit_kzalloc(test, TEST_SIZE, GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, buf);
>> +
>> +	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, sgt);
>> +
>> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +	sg_init_one(sgt->sgl, buf, TEST_SIZE);
>> +
>> +	/* Init a mock DMA-BUF */
>> +	buf_mock.size = TEST_SIZE;
>> +	attach_mock.dmabuf = &buf_mock;
>> +
>> +	gem_obj = drm_gem_shmem_prime_import_sg_table(&fdev->drm_dev, &attach_mock, sgt);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, gem_obj);
>> +	KUNIT_ASSERT_EQ(test, gem_obj->size, TEST_SIZE);
>> +	KUNIT_ASSERT_NULL(test, gem_obj->filp);
>> +	KUNIT_ASSERT_NOT_NULL(test, gem_obj->funcs);
>> +
>> +	shmem = to_drm_gem_shmem_obj(gem_obj);
>> +	KUNIT_ASSERT_PTR_EQ(test, shmem->sgt, sgt);
>> +
>> +	/* The scatter/gather table is freed by drm_gem_shmem_free */
>> +	drm_gem_shmem_free(shmem);
>> +}
> 
> KUNIT_ASSERT_* will stop the execution of the test on failure, you
> should probably use a bit more of KUNIT_EXPECT_* calls otherwise you'll
> leak resources.
> 
> You also probably want to use a kunit_action to clean up and avoid that
> whole discussion
>

You are right. I slightly prefer using KUnit expectations (unless actions
are strictly necessary) since I feel using actions makes test cases a bit
less straightforward to understand. Is this okay for you?

>> +
>> +/* Test pinning backing pages */
>> +static void drm_gem_shmem_test_pin_pages(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	int i, ret;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +	KUNIT_ASSERT_NULL(test, shmem->pages);
>> +	KUNIT_ASSERT_EQ(test, shmem->pages_use_count, 0);
>> +
>> +	ret = drm_gem_shmem_pin(shmem);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +	KUNIT_ASSERT_NOT_NULL(test, shmem->pages);
>> +	KUNIT_ASSERT_EQ(test, shmem->pages_use_count, 1);
>> +
>> +	for (i = 0; i < (shmem->base.size >> PAGE_SHIFT); i++)
>> +		KUNIT_ASSERT_NOT_NULL(test, shmem->pages[i]);
>> +
>> +	drm_gem_shmem_unpin(shmem);
>> +	KUNIT_ASSERT_NULL(test, shmem->pages);
>> +	KUNIT_ASSERT_EQ(test, shmem->pages_use_count, 0);
>> +
>> +	drm_gem_shmem_free(shmem);
>> +}
>> +
>> +/* Test creating a virtual mapping */
>> +static void drm_gem_shmem_test_vmap(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	struct iosys_map map;
>> +	int ret, i;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +	KUNIT_ASSERT_NULL(test, shmem->vaddr);
>> +	KUNIT_ASSERT_EQ(test, shmem->vmap_use_count, 0);
>> +
>> +	ret = drm_gem_shmem_vmap(shmem, &map);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +	KUNIT_ASSERT_NOT_NULL(test, shmem->vaddr);
>> +	KUNIT_ASSERT_EQ(test, shmem->vmap_use_count, 1);
>> +	KUNIT_ASSERT_FALSE(test, iosys_map_is_null(&map));
>> +
>> +	iosys_map_memset(&map, 0, TEST_BYTE, TEST_SIZE);
>> +	for (i = 0; i < TEST_SIZE; i++)
>> +		KUNIT_ASSERT_EQ(test, iosys_map_rd(&map, i, u8), TEST_BYTE);
>> +
>> +	drm_gem_shmem_vunmap(shmem, &map);
>> +	KUNIT_ASSERT_NULL(test, shmem->vaddr);
>> +	KUNIT_ASSERT_EQ(test, shmem->vmap_use_count, 0);
>> +
>> +	drm_gem_shmem_free(shmem);
>> +}
>> +
>> +/* Test exporting a scatter/gather table */
>> +static void drm_gem_shmem_test_get_pages_sgt(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	struct sg_table *sgt;
>> +	struct scatterlist *sg;
>> +	unsigned int si, len = 0;
>> +	int ret;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +
>> +	ret = drm_gem_shmem_pin(shmem);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	sgt = drm_gem_shmem_get_sg_table(shmem);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
>> +	KUNIT_ASSERT_NULL(test, shmem->sgt);
>> +
>> +	for_each_sgtable_sg(sgt, sg, si) {
>> +		KUNIT_ASSERT_NOT_NULL(test, sg);
>> +		len += sg->length;
>> +	}
>> +	KUNIT_ASSERT_GE(test, len, TEST_SIZE);
>> +
>> +	kfree(sgt);
>> +	drm_gem_shmem_free(shmem);
>> +}
>> +
>> +/* Test exporting a scatter/gather pinned table for PRIME */
>> +static void drm_gem_shmem_test_get_sg_table(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	struct sg_table *sgt;
>> +	struct scatterlist *sg;
>> +	unsigned int si, len = 0;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +
>> +	sgt = drm_gem_shmem_get_pages_sgt(shmem);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
>> +	KUNIT_ASSERT_PTR_EQ(test, sgt, shmem->sgt);
>> +
>> +	for_each_sgtable_sg(sgt, sg, si) {
>> +		KUNIT_ASSERT_NOT_NULL(test, sg);
>> +		len += sg->length;
>> +	}
>> +	KUNIT_ASSERT_GE(test, len, TEST_SIZE);
>> +
>> +	/* The scatter/gather table is freed by drm_gem_shmem_free */
>> +	drm_gem_shmem_free(shmem);
>> +}
>> +
>> +/* Test updating madvise status */
>> +static void drm_gem_shmem_test_madvise(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	int ret;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +	KUNIT_ASSERT_EQ(test, shmem->madv, 0);
>> +
>> +	ret = drm_gem_shmem_madvise(shmem, 1);
>> +	KUNIT_ASSERT_TRUE(test, ret);
>> +	KUNIT_ASSERT_EQ(test, shmem->madv, 1);
>> +
>> +	ret = drm_gem_shmem_madvise(shmem, -1);
>> +	KUNIT_ASSERT_FALSE(test, ret);
>> +	KUNIT_ASSERT_EQ(test, shmem->madv, -1);
>> +
>> +	ret = drm_gem_shmem_madvise(shmem, 0);
>> +	KUNIT_ASSERT_FALSE(test, ret);
>> +	KUNIT_ASSERT_EQ(test, shmem->madv, -1);
>> +
>> +	drm_gem_shmem_free(shmem);
>> +}
>> +
>> +/* Test purging */
>> +static void drm_gem_shmem_test_purge(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +	struct drm_gem_shmem_object *shmem;
>> +	struct sg_table *sgt;
>> +	int ret;
>> +
>> +	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
>> +
>> +	ret = drm_gem_shmem_is_purgeable(shmem);
>> +	KUNIT_ASSERT_FALSE(test, ret);
>> +
>> +	ret = drm_gem_shmem_madvise(shmem, 1);
>> +	KUNIT_ASSERT_TRUE(test, ret);
>> +
>> +	sgt = drm_gem_shmem_get_pages_sgt(shmem);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
>> +
>> +	ret = drm_gem_shmem_is_purgeable(shmem);
>> +	KUNIT_ASSERT_TRUE(test, ret);
>> +
>> +	drm_gem_shmem_purge(shmem);
>> +	KUNIT_ASSERT_TRUE(test, ret);
>> +
>> +	drm_gem_shmem_free(shmem);
>> +}
>> +
>> +static int drm_gem_shmem_test_init(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev;
>> +	struct device *dev;
>> +
>> +	/* Allocate a parent device */
>> +	dev = drm_kunit_helper_alloc_device(test);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
>> +
>> +	/*
>> +	 * The DRM core will automatically initialize the GEM core and create
>> +	 * a DRM Memory Manager object which provides an address space pool
>> +	 * for GEM objects allocation.
>> +	 */
>> +	fdev = drm_kunit_helper_alloc_drm_device(test, dev, struct fake_dev,
>> +						 drm_dev, DRIVER_GEM);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdev);
>> +
>> +	fdev->dev = dev;
>> +	test->priv = fdev;
>> +
>> +	return 0;
>> +}
>> +
>> +static void drm_gem_shmem_test_exit(struct kunit *test)
>> +{
>> +	struct fake_dev *fdev = test->priv;
>> +
>> +	drm_kunit_helper_free_device(test, fdev->dev);
>> +}
> 
> You don't need to call drm_kunit_helper_free_device() anymore
> 
> Maxime

Right. Initially, I accidentally used an older tree that did not include
commit 4f2b0b583baa4. I'll remove the whole exit function for v2.


Thanks,
Marco

