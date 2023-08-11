Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1304B7786EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjHKFUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjHKFUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:20:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67339B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:20:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so14996685e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691731215; x=1692336015;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHN6nCsindmvZSmW+Ost0OAJtww0JSFN6IJG/A95yG8=;
        b=v0oTBmkA30g63g+zrXaH+kC255DqRrabdvs7JqZ9wTjTPt81N83qGEDoJw976hJ8wn
         TFY4fW8brmtxQXBe9fMyLnuGq5Cql7ArRzf7XS1iueDKNkGUHcEAdOzNktX9C7Bek1WL
         Pqp3Hu87Z9vuU++K3QmFZ7J9z0eUE6AaMWi2k2PEXBwJ00+h5Fk4hYnCJgKqafYDl+XC
         MdHOXg53C7xL480FEeAuVPkzCMwqNLFtPnRNOMqLLfDfyhufgNebnLe+nfAjA9hSnLZL
         /MuX5JTomrHDcUG1O4x5jlDdwWK/Ic3Vh1NB2yM7TZGeP38uZmxKhbsDqYAJ2R8LQ5SY
         dv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691731215; x=1692336015;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHN6nCsindmvZSmW+Ost0OAJtww0JSFN6IJG/A95yG8=;
        b=e5EmeXWXU8tvunCgs2x9/MFMZ+Hc3VAstdhSVHD1FB/5t9MNi55oy0y7nZvtIBJgS7
         J9ndUDXnLh1UecvfMsEdVnQdiK0h7AP5WeOC+XG0xb1UV/OkdaznyKkxWyCo7fE9sb8n
         stJSI3QWEEjp9HyCbEKcizaOFCy4PYX/Xn0mzwQSo0w9gnts6qf5fvrMosR6iYKoHbK8
         T+BFRJmxspJSZhvWKyeRG6vzOUuz4AAZ5THsFjRN35lj0dpQ1o7I2OcWypPnybpk4z6W
         gXxlc9b7F55c5ElCuWMVNc1H0WwJDXhPxH33HnCRBDLFoQkcBRyma+13JVqF/JuPkVZm
         kisQ==
X-Gm-Message-State: AOJu0Yyvj25nQmSL7Rg7cpCjMgRwrqfYs17ADMNTBeIdhGqzAfcYobO7
        MTipTyxk/NXtiazEBs2RDa4LjA==
X-Google-Smtp-Source: AGHT+IFYOi7MjNr25x0oxodE8rfqcV/8fg2eV6bH03ZaZGO+V393IALekROo8p9DYd5efNxF6gZHyQ==
X-Received: by 2002:a05:600c:249:b0:3fe:15e7:c8a1 with SMTP id 9-20020a05600c024900b003fe15e7c8a1mr683291wmj.16.1691731214921;
        Thu, 10 Aug 2023 22:20:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t16-20020a05600001d000b00317b5c8a4f1sm4152202wrx.60.2023.08.10.22.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 22:20:14 -0700 (PDT)
Date:   Fri, 11 Aug 2023 08:20:11 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: sim: simplify code with cleanup helpers
Message-ID: <2444c3ff-eaf3-4cb9-851b-8e92156128b0@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809131442.25524-2-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-sim-simplify-code-with-cleanup-helpers/20230809-211601
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230809131442.25524-2-brgl%40bgdev.pl
patch subject: [PATCH 2/2] gpio: sim: simplify code with cleanup helpers
config: i386-randconfig-m021-20230809 (https://download.01.org/0day-ci/archive/20230811/202308110253.R2TUMfFr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308110253.R2TUMfFr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202308110253.R2TUMfFr-lkp@intel.com/

smatch warnings:
drivers/gpio/gpio-sim.c:1472 gpio_sim_config_make_device_group() warn: possible memory leak of 'dev'

vim +/dev +1472 drivers/gpio/gpio-sim.c

cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1460  static struct config_group *
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1461  gpio_sim_config_make_device_group(struct config_group *group, const char *name)
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1462  {
c7a663cdcfc698 Bartosz Golaszewski 2023-08-09  1463  	struct gpio_sim_device *dev __free(kfree) = NULL;
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1464  	int id;
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1465  
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1466  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1467  	if (!dev)
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1468  		return ERR_PTR(-ENOMEM);
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1469  
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1470  	id = ida_alloc(&gpio_sim_ida, GFP_KERNEL);
c7a663cdcfc698 Bartosz Golaszewski 2023-08-09  1471  	if (id < 0)
cb8c474e79be45 Bartosz Golaszewski 2021-12-07 @1472  		return ERR_PTR(id);

kfree(dev);

cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1473  
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1474  	config_group_init_type_name(&dev->group, name,
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1475  				    &gpio_sim_device_config_group_type);
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1476  	dev->id = id;
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1477  	mutex_init(&dev->lock);
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1478  	INIT_LIST_HEAD(&dev->bank_list);
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1479  
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1480  	dev->bus_notifier.notifier_call = gpio_sim_bus_notifier_call;
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1481  	init_completion(&dev->probe_completion);
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1482  
c7a663cdcfc698 Bartosz Golaszewski 2023-08-09  1483  	return &no_free_ptr(dev)->group;
cb8c474e79be45 Bartosz Golaszewski 2021-12-07  1484  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

