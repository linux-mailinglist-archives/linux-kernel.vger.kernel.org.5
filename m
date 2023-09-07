Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CD179761D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjIGQBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242716AbjIGP71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:59:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2558469F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:49:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c7912416bso1206361f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101669; x=1694706469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xeGzb3Erff18jo9CQXt1zkXNyc0LLxENLPAQOePXlG4=;
        b=nCIJGbJda6s3OUkC3L3kfYqUaOLEBxYrxHCTO3s04RFpZ9zzEu+mFPLmf0kI4GawWl
         +RzmKmijbPEkFB4cV4c2nWqQuQjdcbXYsL1wdCqsgy+yJD8inOnDl+RSFKZP2zWfYDu9
         7Rp9G6gDl4+JSxTuR3VJdhc57zPBFxlMKDl6FgrtK854U31RhGDNOapE3SRBU9gw7Iuw
         MJ4j42dtl5Yo10d5ZcRg+LwBX4ttsNjVMHo+mq37dzYUEHTj5qQ1930sKZqKF8CUZwL8
         zvz3vj2+1kMFh1yQi6WQTDjv5O+InIpKQ1t4+gDLiP9zlO4nmZJS2MhCFM+0ZL7fezSZ
         V1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101669; x=1694706469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xeGzb3Erff18jo9CQXt1zkXNyc0LLxENLPAQOePXlG4=;
        b=Is3YM7hqBkL4JACwqo8mlT6wYrQos4RZ8lp4g82E1N9VJReL0JvbO/vPl7kkcRQVxb
         uJIrnALgMCpsjUN3dIXZYmwWd82aaGVOfo6Rir2tWk10ILrdQJpTUhjq03gdtkEF9Iko
         7S6k7CbUaZkr3lJ4Yz8/svEGtG7+3goYyvfjbrF8ThcJ9iTDrvC1nBD9LXwCp4urPk1U
         qjIEUh+8uHVbC+CUKcom7azil2wXyDARZGPc9Xv4E2APDi/0auNEa3Nnvy0CQi0Llwm3
         w5qHvh7dI3dKpH6Iwer4AXjVIBoSbJBQQILiIQaJVe8ZZ3ZFm+MDS5aBrSqXBrmTJ0+a
         TCew==
X-Gm-Message-State: AOJu0YzvtTbgnTrYKZTKM1I895pJQTTG+/AOJUW7X4490i9GLPxFoi1W
        ttShRlApYHjB47VyZ1lPGd7rYL047CAaj4sPWj0=
X-Google-Smtp-Source: AGHT+IGY0h7WcTk6nrH2GKB5AeQw5TEuZroHYOktVcTxrpTsoqZptvoAwNyaRLvYhuRDptYyw9C0/g==
X-Received: by 2002:a5d:4651:0:b0:317:e08b:7b1d with SMTP id j17-20020a5d4651000000b00317e08b7b1dmr4125801wrs.11.1694080996869;
        Thu, 07 Sep 2023 03:03:16 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q20-20020a056000137400b003142c85fbcdsm22997110wrz.11.2023.09.07.03.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 03:03:16 -0700 (PDT)
Date:   Thu, 7 Sep 2023 13:03:14 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, kernel@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v16 15/20] drm/shmem-helper: Add memory shrinker
Message-ID: <55952e5b-8c55-4888-ba22-eda33525c3b9@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230903170736.513347-16-dmitry.osipenko@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Osipenko/drm-shmem-helper-Fix-UAF-in-error-path-when-freeing-SGT-of-imported-GEM/20230904-011037
base:   linus/master
patch link:    https://lore.kernel.org/r/20230903170736.513347-16-dmitry.osipenko%40collabora.com
patch subject: [PATCH v16 15/20] drm/shmem-helper: Add memory shrinker
config: x86_64-randconfig-161-20230907 (https://download.01.org/0day-ci/archive/20230907/202309070814.jyGJOJzY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230907/202309070814.jyGJOJzY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202309070814.jyGJOJzY-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/drm_gem_shmem_helper.c:733 drm_gem_shmem_fault() error: we previously assumed 'shmem->pages' could be null (see line 724)

vim +733 drivers/gpu/drm/drm_gem_shmem_helper.c

2194a63a818db7 Noralf Trønnes  2019-03-12  702  static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
2194a63a818db7 Noralf Trønnes  2019-03-12  703  {
2194a63a818db7 Noralf Trønnes  2019-03-12  704  	struct vm_area_struct *vma = vmf->vma;
2194a63a818db7 Noralf Trønnes  2019-03-12  705  	struct drm_gem_object *obj = vma->vm_private_data;
2194a63a818db7 Noralf Trønnes  2019-03-12  706  	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
2194a63a818db7 Noralf Trønnes  2019-03-12  707  	loff_t num_pages = obj->size >> PAGE_SHIFT;
d611b4a0907cec Neil Roberts    2021-02-23  708  	vm_fault_t ret;
2194a63a818db7 Noralf Trønnes  2019-03-12  709  	struct page *page;
11d5a4745e00e7 Neil Roberts    2021-02-23  710  	pgoff_t page_offset;
2c607edf57db6a Dmitry Osipenko 2023-09-03  711  	bool pages_unpinned;
2c607edf57db6a Dmitry Osipenko 2023-09-03  712  	int err;
11d5a4745e00e7 Neil Roberts    2021-02-23  713  
11d5a4745e00e7 Neil Roberts    2021-02-23  714  	/* We don't use vmf->pgoff since that has the fake offset */
11d5a4745e00e7 Neil Roberts    2021-02-23  715  	page_offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
2194a63a818db7 Noralf Trønnes  2019-03-12  716  
21aa27ddc58269 Dmitry Osipenko 2023-05-30  717  	dma_resv_lock(shmem->base.resv, NULL);
2194a63a818db7 Noralf Trønnes  2019-03-12  718  
2c607edf57db6a Dmitry Osipenko 2023-09-03  719  	/* Sanity-check that we have the pages pointer when it should present */
2c607edf57db6a Dmitry Osipenko 2023-09-03  720  	pages_unpinned = (shmem->evicted || shmem->madv < 0 ||
2c607edf57db6a Dmitry Osipenko 2023-09-03  721  			  !refcount_read(&shmem->pages_use_count));
2c607edf57db6a Dmitry Osipenko 2023-09-03  722  	drm_WARN_ON_ONCE(obj->dev, !shmem->pages ^ pages_unpinned);
2c607edf57db6a Dmitry Osipenko 2023-09-03  723  
2c607edf57db6a Dmitry Osipenko 2023-09-03 @724  	if (page_offset >= num_pages || (!shmem->pages && !shmem->evicted)) {
                                                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Should this be || instead of &&?  (The other thing that people do is
add "!shmem->evicted" for readability even though it doesn't need to be
checked.  So maybe that's the issue, but the checker assumes it needs to
be checked).

d611b4a0907cec Neil Roberts    2021-02-23  725  		ret = VM_FAULT_SIGBUS;
d611b4a0907cec Neil Roberts    2021-02-23  726  	} else {
2c607edf57db6a Dmitry Osipenko 2023-09-03  727  		err = drm_gem_shmem_swapin_locked(shmem);

Or maybe it's because the kbuild bot can't use the cross function db
and shmem->pages is assigned here?

2c607edf57db6a Dmitry Osipenko 2023-09-03  728  		if (err) {
2c607edf57db6a Dmitry Osipenko 2023-09-03  729  			ret = VM_FAULT_OOM;
2c607edf57db6a Dmitry Osipenko 2023-09-03  730  			goto unlock;
2c607edf57db6a Dmitry Osipenko 2023-09-03  731  		}
2c607edf57db6a Dmitry Osipenko 2023-09-03  732  
11d5a4745e00e7 Neil Roberts    2021-02-23 @733  		page = shmem->pages[page_offset];
                                                                       ^^^^^^^^^^^^
Unchecked dereference

2194a63a818db7 Noralf Trønnes  2019-03-12  734  
8b93d1d7dbd578 Daniel Vetter   2021-08-12  735  		ret = vmf_insert_pfn(vma, vmf->address, page_to_pfn(page));
d611b4a0907cec Neil Roberts    2021-02-23  736  	}
d611b4a0907cec Neil Roberts    2021-02-23  737  
2c607edf57db6a Dmitry Osipenko 2023-09-03  738  unlock:
21aa27ddc58269 Dmitry Osipenko 2023-05-30  739  	dma_resv_unlock(shmem->base.resv);
d611b4a0907cec Neil Roberts    2021-02-23  740  
d611b4a0907cec Neil Roberts    2021-02-23  741  	return ret;
2194a63a818db7 Noralf Trønnes  2019-03-12  742  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

