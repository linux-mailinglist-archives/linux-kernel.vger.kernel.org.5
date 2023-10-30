Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC187DB896
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjJ3K7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJ3K7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FF8A2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698663511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+PBWmUbR3sC5ly5YhdtKnx9vXPHu8wxlK1hmeHOwoTA=;
        b=H8G2jdsCMKkVs0lmZkunDaEaF73K0VLs47TLjtVnD1Cb3h+gKuJfrJ/pZBBwB2iGnqKrjv
        tfsqN44tKc8q4sLObV0Q5Mv4FKDcBraEYoVKWilsbQTHx35eD0i/3eMeqv7sLE14proI91
        rN2WE5/6XQR41hBJ2gQH4+1HamTBV/E=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-s-5iplMrOc63X53X7QHRMA-1; Mon, 30 Oct 2023 06:58:25 -0400
X-MC-Unique: s-5iplMrOc63X53X7QHRMA-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6c638c29c8eso5994075a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698663504; x=1699268304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PBWmUbR3sC5ly5YhdtKnx9vXPHu8wxlK1hmeHOwoTA=;
        b=XgJPEY4fJHpOZv3FO+HVNRHjkke2M6H1hUKxS9KaWtrofq5OV+cv7kSlaDpx2CaItu
         JWZsmzgoKo4xEJ+HeBkQaxsT8xySe9DMTMwGvgUl+kcgO4ObvNScz/dZv+VKQJneCzhV
         VKdo7B7knJl779g11zRT3g1acji2OBZML84KoPGWwJXgwl4VVFdOAWo5ZFF4zaFy/EhR
         H5+BtdcVpdb/cQZVwihtpK0e52Ld7kZzsFK81vE4qrFVQyCsBauy8WHPtR0HGCFct+n5
         IJ81errdqHLlCbLs2cByAGE1Ewp9xMfjzk2Y58fYqApKZcgX8bfzsGOOK2g237GRpedC
         X5JA==
X-Gm-Message-State: AOJu0YyK3rRTwDqPHuTX9BHk4NVXSw4KtFkEFpwhrl1tqpkN9FIdrNfs
        3qeW5p83LnrS0TfQu348DQc1v0+WX9xCCDxpC5ApW/ui3PvIXLlIEfz/wlLRqOw/WW7KutHzaDw
        YO8Rd6eyl80YCdF3xJu4IQFQ=
X-Received: by 2002:a9d:6d18:0:b0:6ce:1fa7:fa0c with SMTP id o24-20020a9d6d18000000b006ce1fa7fa0cmr8683364otp.30.1698663504517;
        Mon, 30 Oct 2023 03:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu6BwiXbOB8s1m8hT2wDWqkeq2lBLOskZFayAv354TSc3UCfCP1zlE33ygttQji/mUn8ANgg==
X-Received: by 2002:a9d:6d18:0:b0:6ce:1fa7:fa0c with SMTP id o24-20020a9d6d18000000b006ce1fa7fa0cmr8683353otp.30.1698663504286;
        Mon, 30 Oct 2023 03:58:24 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id q6-20020a05622a030600b004180fdcb482sm3304799qtw.81.2023.10.30.03.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 03:58:23 -0700 (PDT)
Message-ID: <3e32dbc2-c93f-45a1-a872-4e1798141a70@redhat.com>
Date:   Mon, 30 Oct 2023 11:58:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/test: add a test suite for GEM objects backed by
 shmem
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
 <789aaf2b-4d68-4128-b8ff-c1ba4849e141@redhat.com>
 <bychwi46hiqd34ch2f2ikvcijnq3hxvqudycsja5mawng46gyx@cq7wwxozv4si>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <bychwi46hiqd34ch2f2ikvcijnq3hxvqudycsja5mawng46gyx@cq7wwxozv4si>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-25 10:43, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Oct 24, 2023 at 07:14:25PM +0200, Marco Pagani wrote:
>>>> +static void drm_gem_shmem_test_obj_create_private(struct kunit *test)
>>>> +{
>>>> +	struct fake_dev *fdev = test->priv;
>>>> +	struct drm_gem_shmem_object *shmem;
>>>> +	struct drm_gem_object *gem_obj;
>>>> +	struct dma_buf buf_mock;
>>>> +	struct dma_buf_attachment attach_mock;
>>>> +	struct sg_table *sgt;
>>>> +	char *buf;
>>>> +	int ret;
>>>> +
>>>> +	/* Create a mock scatter/gather table */
>>>> +	buf = kunit_kzalloc(test, TEST_SIZE, GFP_KERNEL);
>>>> +	KUNIT_ASSERT_NOT_NULL(test, buf);
>>>> +
>>>> +	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
>>>> +	KUNIT_ASSERT_NOT_NULL(test, sgt);
>>>> +
>>>> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
>>>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>>>> +	sg_init_one(sgt->sgl, buf, TEST_SIZE);
>>>> +
>>>> +	/* Init a mock DMA-BUF */
>>>> +	buf_mock.size = TEST_SIZE;
>>>> +	attach_mock.dmabuf = &buf_mock;
>>>> +
>>>> +	gem_obj = drm_gem_shmem_prime_import_sg_table(&fdev->drm_dev, &attach_mock, sgt);
>>>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, gem_obj);
>>>> +	KUNIT_ASSERT_EQ(test, gem_obj->size, TEST_SIZE);
>>>> +	KUNIT_ASSERT_NULL(test, gem_obj->filp);
>>>> +	KUNIT_ASSERT_NOT_NULL(test, gem_obj->funcs);
>>>> +
>>>> +	shmem = to_drm_gem_shmem_obj(gem_obj);
>>>> +	KUNIT_ASSERT_PTR_EQ(test, shmem->sgt, sgt);
>>>> +
>>>> +	/* The scatter/gather table is freed by drm_gem_shmem_free */
>>>> +	drm_gem_shmem_free(shmem);
>>>> +}
>>>
>>> KUNIT_ASSERT_* will stop the execution of the test on failure, you
>>> should probably use a bit more of KUNIT_EXPECT_* calls otherwise you'll
>>> leak resources.
>>>
>>> You also probably want to use a kunit_action to clean up and avoid that
>>> whole discussion
>>>
>>
>> You are right. I slightly prefer using KUnit expectations (unless actions
>> are strictly necessary) since I feel using actions makes test cases a bit
>> less straightforward to understand. Is this okay for you?
> 
> I disagree. Actions make it easier to reason about, even when comparing
> assertion vs expectation
> 
> Like, for the call to sg_alloc_table and
> drm_gem_shmem_prime_import_sg_table(), the reasonable use of assert vs
> expect would be something like:
> 
> sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
> KUNIT_ASSERT_NOT_NULL(test, sgt);
> 
> ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> KUNIT_ASSERT_EQ(test, ret, 0);
> 
> /*
>  * Here, it's already not super clear whether you want to expect vs
>  * assert. expect will make you handle the failure case later, assert will
>  * force you to call kfree on sgt. Both kind of suck in their own ways.
>  */
> 
> sg_init_one(sgt->sgl, buf, TEST_SIZE);
> 
> gem_obj = drm_gem_shmem_prime_import_sg_table(&fdev->drm_dev, &attach_mock, sgt);
> KUNIT_ASSERT_NOT_ERR_OR_NULL(test, gem_obj);
> 
> /*
>  * If the assert fails, we forgot to call sg_free_table(sgt) and kfree(sgt).
>  */
> 
> KUNIT_EXPECT_EQ(test, gem_obj->size, TEST_SIZE);
> KUNIT_EXPECT_NULL(test, gem_obj->filp);
> KUNIT_EXPECT_NOT_NULL(test, gem_obj->funcs);
> 
> /*
>  * And here we have to handle the case where the expectation was wrong,
>  * but the test still continued.
>  */
> 
> But if you're not using an action, you still have to call kfree(sgt),
> which means that you might still
> 
> shmem = to_drm_gem_shmem_obj(gem_obj);
> KUNIT_ASSERT_PTR_EQ(test, shmem->sgt, sgt);
> 
> /*
>  * If the assertion fails, we now have to call drm_gem_shmem_free(shmem)
>  */
> 
> /* The scatter/gather table is freed by drm_gem_shmem_free */
> drm_gem_shmem_free(shmem);
> 
> /* everything's fine now */
> 
> The semantics around drm_gem_shmem_free make it a bit convoluted, but
> doing it using goto/labels, plus handling the assertions and error
> reporting would be difficult.
> 
> Using actions, we have:
> 
> sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
> KUNIT_ASSERT_NOT_NULL(test, sgt);
> 
> ret = kunit_add_action_or_reset(test, kfree_wrapper, sgt);
> KUNIT_ASSERT_EQ(test, ret, 0);
> 
> ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> KUNIT_ASSERT_EQ(test, ret, 0);
> 
> ret = kunit_add_action_or_reset(test, sg_free_table_wrapper, sgt);
> KUNIT_ASSERT_EQ(test, ret, 0);
> 
> sg_init_one(sgt->sgl, buf, TEST_SIZE);
> 
> gem_obj = drm_gem_shmem_prime_import_sg_table(&fdev->drm_dev, &attach_mock, sgt);
> KUNIT_ASSERT_NOT_ERR_OR_NULL(test, gem_obj);
> KUNIT_EXPECT_EQ(test, gem_obj->size, TEST_SIZE);
> KUNIT_EXPECT_NULL(test, gem_obj->filp);
> KUNIT_EXPECT_NOT_NULL(test, gem_obj->funcs);
> 
> /* drm_gem_shmem_free will free the struct sg_table itself */
> kunit_remove_action(test, sg_free_table_wrapper, sgt);
> kunit_remove_action(test, kfree_wrapper, sgt);

I agree that using actions makes error handling cleaner. However, I still
have some concerns about the additional complexity that actions introduce.
For instance, I feel these two lines make the testing harness more complex
without asserting any additional property of the component under test. 

In some sense, I wonder if it is worth worrying about memory leaks when
a test case fails. At that point, the system is already in an inconsistent
state due to a bug in the component under test, so it is unsafe to continue
anyway.

> 
> shmem = to_drm_gem_shmem_obj(gem_obj);
> KUNIT_ASSERT_PTR_EQ(test, shmem->sgt, sgt);
> 
> ret = kunit_add_action_or_reset(test, drm_gem_shmem_free_wrapper, shmem);
> KUNIT_ASSERT_EQ(test, ret, 0);
> 
> The last one is arguable, but for the previous ones it makes error
> handling much more convenient and easy to reason about.
> 
> The wrappers are also a bit inconvenient to use, but it's mostly there
> to avoid a compiler warning at the moment.
> 
> This patch will help hopefully:
> https://lore.kernel.org/linux-kselftest/20230915050125.3609689-1-davidgow@google.com/
> 
> Maxime

Thanks,
Marco

