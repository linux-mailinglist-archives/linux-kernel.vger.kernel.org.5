Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B9A7F7107
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbjKXKPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbjKXKPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:15:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B9B10EC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700820918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTq8+kCBsRfezDZUZNy6OCUhutJdQNVSX6U8E7Z+Kf8=;
        b=H8SXOa1DZZrG4peNW1udGd6J1/1yVoM/VXhGpTWXfyW7P2P04cKxDwd3MlzjWLv37/IUNV
        cL9j95QSFw9iKLNFnBI4adDWjNslv16iMGojyg3MZn78msSLb2Jo36qosQst3NXG2XKIFU
        oO1ciD50bXExse8KAPfCUZ2MwsS34uE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-kaSLlEMlN5CmXp-iQS3y5g-1; Fri, 24 Nov 2023 05:15:16 -0500
X-MC-Unique: kaSLlEMlN5CmXp-iQS3y5g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77d5e048522so193642585a.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700820916; x=1701425716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTq8+kCBsRfezDZUZNy6OCUhutJdQNVSX6U8E7Z+Kf8=;
        b=Xomrk2AHrdVPdxlXvShmnA2+pmCmV5kw9Se42RAEpAWcKMQ+NDNkD9DxnqWbxBMNEP
         NDiaUfsXyNr1RVwpYrXdoiog5PBs6ySJimPrQNbx671FnFzP01kp/mM/o5JLMgQdusT0
         XvK/6cqGW91PfncM3p04eSZub+XrcZ5yaN8XNUHl+Qye7adqJFEE6ndMXSczOz9kc0J+
         I5VZCbya1GvOCijWYwTE7YMnGOly90TMn9ueS5HNqc/Hk0Z3XOBchk6TRlSQCNRjmZI/
         gRG5ZKiAFfGZ2Lq2od33enMNYFihp2cOyDWkCx705eiJVE1xlpuYYvB47jeDbRhx+FqW
         eKVA==
X-Gm-Message-State: AOJu0Yzb00QWcpD15jjwNgXCGFCwjFqz3Bs2BbMLPXa+kk/bCMzs6VlM
        hcmktuumC+o/lYU72Ce4zOuWKwczvrmHKrk1PvT0QXBHIR7UpS91hdVHQK/KKL59FEsVfIuzpW1
        K6MU3Sq4t0xVOEE0oYEvbFzg=
X-Received: by 2002:a05:620a:294b:b0:774:d3f:c78c with SMTP id n11-20020a05620a294b00b007740d3fc78cmr2910549qkp.72.1700820916395;
        Fri, 24 Nov 2023 02:15:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3RJxpHx9XF5gTOs5+1q6RlhTFoQIQfE2hazERkN73qvfSSfainOz1S68urbbGGyVvjNRErA==
X-Received: by 2002:a05:620a:294b:b0:774:d3f:c78c with SMTP id n11-20020a05620a294b00b007740d3fc78cmr2910528qkp.72.1700820916165;
        Fri, 24 Nov 2023 02:15:16 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id b20-20020a05620a0cd400b00774830b40d4sm1131051qkj.47.2023.11.24.02.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 02:15:15 -0800 (PST)
Message-ID: <9fb1cd9d-89cb-4f45-9d0c-9f0102e000e6@redhat.com>
Date:   Fri, 24 Nov 2023 11:15:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/test: add a test suite for GEM objects backed by
 shmem
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20231123100147.212645-1-marpagan@redhat.com>
 <dkh6t5cya7tw4wz5aqrgvnqqnyzzgvbyvezxexy6pyspju5qbd@cdl4vvs7kvnt>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <dkh6t5cya7tw4wz5aqrgvnqqnyzzgvbyvezxexy6pyspju5qbd@cdl4vvs7kvnt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-24 09:49, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Nov 23, 2023 at 11:01:46AM +0100, Marco Pagani wrote:
>> +static int drm_gem_shmem_test_init(struct kunit *test)
>> +{
>> +	struct device *dev;
>> +	struct fake_dev {
>> +		struct drm_device drm_dev;
>> +	} *fdev;
>> +
> 
> [...]
> 
>> +
>> +	/*
>> +	 * The DRM core will automatically initialize the GEM core and create
>> +	 * a DRM Memory Manager object which provides an address space pool
>> +	 * for GEM objects allocation.
>> +	 */
>> +	fdev = drm_kunit_helper_alloc_drm_device(test, dev, struct fake_dev,
>> +						 drm_dev, DRIVER_GEM);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdev);
> 
> Sorry I missed it earlier, but you don't need the intermediate structure
> if you use
> 
> struct drm_device *drm;
> 
> drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0, DRIVER_GEM);
> KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>

I prefer to use drm_kunit_helper_alloc_drm_device() with the intermediate
structure. It makes the code clearer, in my opinion. Initially, when
developing the suite, I was using __drm_kunit_helper_alloc_drm_device()
as most test suites do, but I feel the list of arguments including
"sizeof(*drm), 0," is less straightforward to understand.

Thanks,
Marco

