Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07845802745
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 21:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjLCU1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 15:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjLCU1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 15:27:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD978B8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 12:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701635225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pYTrpCRDHy3pVYrmuekoON7KTgLSFaRDili/ZX0QPtg=;
        b=PXp7JWwFelrplehkPZ5O6j3mtYAB7pTDMkbGjthX2rk7g8Ah69Gc/k5rdGMFrpXFSbG7jB
        VeeQmV64/mkoHfWHe4DfonTOI7NGIWYuKYSd1JDWGo3LXK4Rf3PG/O3+E7k0B9QNc1/+Pj
        gEBVYNBvIl2nPh6OX6FUQdPp9a4iTRg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-oTgG0_iMPhWJ8v5pdZTMRg-1; Sun, 03 Dec 2023 15:27:04 -0500
X-MC-Unique: oTgG0_iMPhWJ8v5pdZTMRg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c0329d868so13740865e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 12:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701635223; x=1702240023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYTrpCRDHy3pVYrmuekoON7KTgLSFaRDili/ZX0QPtg=;
        b=BNFJE5oNp/kbmPBh8u5igZfrH4LiZYr7suIGbrEd0RZ4nT0KoEkJWkgPXRBKaBqs1a
         wTRJk204TwQyVY7VV60qWBnLb5ZxlDKcJr8fXp9zEJWaP78ejU5hWt0+wMsBcqtWKMcs
         vudCOwIDPrSruDRe1LALhAby9Jn2kKfXinmltKpR9XnAgf38VShfBML/atLBPea/U0vV
         HG451zrrFpozkIcA3efbhkGb8o6IVE93RntxKxI9csl46SvQezggoMnR5NTy7LiD71+b
         4OUVMQ0heSnAP57XNNi7sJ6IMfNsRPzBA1d+IyMhG201ZI2FNKK8mKJmGtEXSY1JJd8x
         J+Vg==
X-Gm-Message-State: AOJu0Yx1FJJqSGrNPaOFO9Mm9C0PmIklaUWd+PGLK37CXXfUZh+jUsC8
        Qg01XAXyRt+b2LKQuCM5Ac4up44x5FZfkT6RHUIdlypUuCiqNmV5qCzxDQsTzvBuCTXTE/n/nA/
        QOJI4VyuHgEVAh2I7bx393MCp
X-Received: by 2002:a05:600c:2218:b0:40c:9a7:5253 with SMTP id z24-20020a05600c221800b0040c09a75253mr579770wml.127.1701635223362;
        Sun, 03 Dec 2023 12:27:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGAC1lOWZDli3AMMFaxArgBcn7hOengWBWj6AEgPzfyNKh9vOJsJOrQiMQn4CXrHnXOLSBIQ==
X-Received: by 2002:a05:600c:2218:b0:40c:9a7:5253 with SMTP id z24-20020a05600c221800b0040c09a75253mr579767wml.127.1701635222966;
        Sun, 03 Dec 2023 12:27:02 -0800 (PST)
Received: from redhat.com ([2.55.57.48])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d490a000000b003333c06fa79sm4270161wrq.71.2023.12.03.12.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 12:27:02 -0800 (PST)
Date:   Sun, 3 Dec 2023 15:26:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Gonglei <arei.gonglei@huawei.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/crypto/virtio/virtio_crypto_common.h:116:13: warning:
 variable 'cpu' set but not used
Message-ID: <20231203152646-mutt-send-email-mst@kernel.org>
References: <202312040315.kPrI1OCE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312040315.kPrI1OCE-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 03:55:43AM +0800, kernel test robot wrote:
> Hi Gonglei,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
> commit: dbaf0624ffa57ae6e7d87a823185ccd9a7852d3c crypto: add virtio-crypto driver
> date:   7 years ago
> config: x86_64-randconfig-015-20231011 (https://download.01.org/0day-ci/archive/20231204/202312040315.kPrI1OCE-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231204/202312040315.kPrI1OCE-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312040315.kPrI1OCE-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/crypto/virtio/virtio_crypto_algs.c:28:
>    drivers/crypto/virtio/virtio_crypto_common.h: In function 'virtio_crypto_get_current_node':
> >> drivers/crypto/virtio/virtio_crypto_common.h:116:13: warning: variable 'cpu' set but not used [-Wunused-but-set-variable]
>      116 |         int cpu, node;
>          |             ^~~
> --
>    In file included from drivers/crypto/virtio/virtio_crypto_core.c:25:
>    drivers/crypto/virtio/virtio_crypto_common.h: In function 'virtio_crypto_get_current_node':
> >> drivers/crypto/virtio/virtio_crypto_common.h:116:13: warning: variable 'cpu' set but not used [-Wunused-but-set-variable]
>      116 |         int cpu, node;
>          |             ^~~
>    In file included from drivers/crypto/virtio/virtio_crypto_core.c:20:
>    drivers/crypto/virtio/virtio_crypto_core.c: At top level:
>    include/linux/module.h:132:13: warning: 'init_module' specifies less restrictive attribute than its target 'virtio_crypto_driver_init': 'cold' [-Wmissing-attributes]
>      132 |         int init_module(void) __attribute__((alias(#initfn)));
>          |             ^~~~~~~~~~~
>    include/linux/device.h:1463:1: note: in expansion of macro 'module_init'
>     1463 | module_init(__driver##_init); \
>          | ^~~~~~~~~~~
>    include/linux/virtio.h:190:9: note: in expansion of macro 'module_driver'
>      190 |         module_driver(__virtio_driver, register_virtio_driver, \
>          |         ^~~~~~~~~~~~~
>    drivers/crypto/virtio/virtio_crypto_core.c:471:1: note: in expansion of macro 'module_virtio_driver'
>      471 | module_virtio_driver(virtio_crypto_driver);
>          | ^~~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/virtio.h:8,
>                     from include/linux/virtio_config.h:6,
>                     from drivers/crypto/virtio/virtio_crypto_core.c:21:
>    drivers/crypto/virtio/virtio_crypto_core.c:471:22: note: 'init_module' target declared here
>      471 | module_virtio_driver(virtio_crypto_driver);
>          |                      ^~~~~~~~~~~~~~~~~~~~
>    include/linux/device.h:1459:19: note: in definition of macro 'module_driver'
>     1459 | static int __init __driver##_init(void) \
>          |                   ^~~~~~~~
>    drivers/crypto/virtio/virtio_crypto_core.c:471:1: note: in expansion of macro 'module_virtio_driver'
>      471 | module_virtio_driver(virtio_crypto_driver);
>          | ^~~~~~~~~~~~~~~~~~~~
>    include/linux/module.h:138:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'virtio_crypto_driver_exit': 'cold' [-Wmissing-attributes]
>      138 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
>          |              ^~~~~~~~~~~~~~
>    include/linux/device.h:1468:1: note: in expansion of macro 'module_exit'
>     1468 | module_exit(__driver##_exit);
>          | ^~~~~~~~~~~
>    include/linux/virtio.h:190:9: note: in expansion of macro 'module_driver'
>      190 |         module_driver(__virtio_driver, register_virtio_driver, \
>          |         ^~~~~~~~~~~~~
>    drivers/crypto/virtio/virtio_crypto_core.c:471:1: note: in expansion of macro 'module_virtio_driver'
>      471 | module_virtio_driver(virtio_crypto_driver);
>          | ^~~~~~~~~~~~~~~~~~~~
>    drivers/crypto/virtio/virtio_crypto_core.c:471:22: note: 'cleanup_module' target declared here
>      471 | module_virtio_driver(virtio_crypto_driver);
>          |                      ^~~~~~~~~~~~~~~~~~~~
>    include/linux/device.h:1464:20: note: in definition of macro 'module_driver'
>     1464 | static void __exit __driver##_exit(void) \
>          |                    ^~~~~~~~
>    drivers/crypto/virtio/virtio_crypto_core.c:471:1: note: in expansion of macro 'module_virtio_driver'
>      471 | module_virtio_driver(virtio_crypto_driver);
>          | ^~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/cpu +116 drivers/crypto/virtio/virtio_crypto_common.h
> 
>    113	
>    114	static inline int virtio_crypto_get_current_node(void)
>    115	{
>  > 116		int cpu, node;
>    117	
>    118		cpu = get_cpu();
>    119		node = topology_physical_package_id(cpu);
>    120		put_cpu();
>    121	
>    122		return node;
>    123	}
>    124	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Seems easy to fix. Gonglei?

-- 
MST

