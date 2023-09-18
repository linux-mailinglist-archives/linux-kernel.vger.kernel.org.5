Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3946A7A49F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbjIRMmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbjIRMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:41:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EF9A8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:41:24 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1c337aeefbdso41515465ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695040884; x=1695645684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6c9PX8yXabbIMJYwi1Ux2aNFsK9GODhrWCXIJEdmKE=;
        b=FSCF67QCIeso9UQhXa+f5n6A7lAAt+PhPlGvpkECCVgwQECn0IzCcd11R0abqEJnSa
         SxPyTNZMMuBIxHYb3UKclZAXm6rKdr55ideJHlqHfufm0lBebnfnPPQvZNdTc+f5uSPk
         0x0hXVdB2hhGrFYnTjc9za/ZISs6sWuBn3QbLM5J2PZH7qyZmyWBiXJgS1GwJ6TRSzku
         9MJAX+3vXD46ijmg3mNJ94ePHNClXesgqrfK30e80O7so52VZyuV83BhfSNsFx2EaiMq
         LLkkd+cE0xJ1MZIIGuGw6s4ivRI4Ru8dX+8ZqwkmVXS1GEY04XuNXLEVPdh8SO+aVvv4
         6k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040884; x=1695645684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6c9PX8yXabbIMJYwi1Ux2aNFsK9GODhrWCXIJEdmKE=;
        b=PYzVL+mRDLalE34h//j8AYAnrHykhWLOG0mF8poKPV01dWta3gFc0t3B+zr8+O9Dxe
         FWC26kx6jWY5ZhRWf7OcvcST/sAfO5V1eRK8B3A9d/DXSLzAf8IVLkf3WeVmU21MSRg8
         m438Q3n1KApDLvRfWVybp2APGUBj/g+gyU6ovv49juM7R1YhdWjiq2riVVDqaufyYuAX
         UrakOLoMLoxydURz/R01E6PGpM3ne3C4Qrt91RwIM2qbjgvT7aSlhFcsQsOkNWwWgwh8
         V+CgOz4DH4uJUS0lMbCkU3GNSflkWwGKm41SIhEaOy2EZbRSPkbu8mXpGOBYBILwrm1Q
         RlnQ==
X-Gm-Message-State: AOJu0Yyo67kJRhJ1LR+2tQKVvK6fQwgMfO40bAcrswMHrZwh4qoPScD+
        d6mqzneLe/viJWOHShwhOiMTEewyluYfw2E/Xze1Tp7K
X-Google-Smtp-Source: AGHT+IGEVMEZGX80dFpMj07WX+94atLU4djAb7dj3TL73bAPqqjZOmqMbE1bMhUQb7AR8A+yw7ClQw==
X-Received: by 2002:a17:902:ced2:b0:1c3:92de:1b23 with SMTP id d18-20020a170902ced200b001c392de1b23mr10851182plg.59.1695040884228;
        Mon, 18 Sep 2023 05:41:24 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([203.208.189.9])
        by smtp.gmail.com with ESMTPSA id y15-20020a1709027c8f00b001bb99e188fcsm8195639pll.194.2023.09.18.05.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:41:23 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     rafael@kernel.org
Cc:     gregkh@linuxfoundation.org, guojinhui.liam@bytedance.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        lkp@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] driver core: platform: set numa_node before platform_add_device()
Date:   Mon, 18 Sep 2023 20:41:17 +0800
Message-Id: <20230918124117.187-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAJZ5v0j+L=a0UEiCEXUYDtvscaVF29FPro9FNupMkJ7do2eBGw@mail.gmail.com>
References: <CAJZ5v0j+L=a0UEiCEXUYDtvscaVF29FPro9FNupMkJ7do2eBGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sep 2023 12:30:58 +0200, Rafael J. Wysocki wrote:
> On Thu, Sep 14, 2023 at 11:32 PM Jinhui Guo
> <guojinhui.liam@bytedance.com> wrote:
> >
> > platform_add_device()
> 
> According to "git grep" this function is not present in 6.6-rc2.
> 
> If you mean platform_device_add(), please update the patch subject and
> changelog accordingly.
> 

This is my mistake, the function name was written wrong.
I will fix it in the next patch.

> > creates the numa_node attribute of sysfs according
> > to whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
> > of device before creating numa_node attribute of sysfs.
> 
> It would be good to also say that this needs to be done in
> platform_device_register_full(), because that's where the platform
> device object is allocated.
> 

Thaks for your suggestion. I will modify my decription soon.

> However, what about adding the NUMA node information to pdevinfo?  It
> would be more straightforward to handle it then AFAICS.
> 

I have tried three potential solutions to fix the bug:
1. The first one is what the current patch do.

2. Add a new function interface only for acpi_create_platform_device() call.
   But the code will be a bit redundant.

3. Add an member "numa_node" in `struct platform_device_info`, just as what
   `struct device` done:

```
struct platform_device_info {
	...;
#ifdef CONFIG_NUMA
	int		numa_node;
#endif
```

But not all the call to platform_device_register_full() would set numa_node,
and many of them use ` memset(&pdevinfo, 0, sizeof(pdevinfo));` to initialize
`struct platform_device_info`. It could initialize numa_node to zero and
result in wrong numa_node information in sysfs.

```
struct platform_device *platform_device_register_full(
		const struct platform_device_info *pdevinfo) {
	...;
	/*
	 * (1) It will initialize numa_node in `struct device` to NUMA_NO_NODE.
	 *     NUMA_NO_NODE is -1.
	 */
	pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
	...;
	/*
	 * (2) If we add set_dev_node() here, we have to make sure pdevinfo->numa_node
	 *     is correct. But It is difficult to do so, especially drivers don't want to
	 *     set numa_node. Instead of initializing pdevinfo->numa_node to NUMA_NO_NODE,
	 *     they are accustomed to memset `struct platform_device_info` to be zero.
	 */
	set_dev_node(&pdev->dev, pdevinfo->numa_node);
	...;
	/*
	 * (3) The sysfs attribute numa_node will create here.
	 */
	ret = platform_device_add(pdev);
	...;
}
```

> > Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> > Cc: stable@vger.kernel.org
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
> > Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> > ---
> > V4 -> V5: Add Cc: stable line and changes from the previous submited
> > patches
> > V3 -> V4: Refactor code to be an ACPI function call
> > V2 -> V3: Fix Signed-off name
> > V1 -> V2: Fix compile error without enabling CONFIG_ACPI
> >
> >  drivers/acpi/acpi_platform.c | 4 +---
> >  drivers/base/platform.c      | 1 +
> >  include/linux/acpi.h         | 5 +++++
> >  3 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> > index 48d15dd785f6..adcbfbdc343f 100644
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -178,11 +178,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
> >         if (IS_ERR(pdev))
> >                 dev_err(&adev->dev, "platform device creation failed: %ld\n",
> >                         PTR_ERR(pdev));
> > -       else {
> > -               set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
> > +       else
> >                 dev_dbg(&adev->dev, "created platform device %s\n",
> >                         dev_name(&pdev->dev));
> > -       }
> >
> >         kfree(resources);
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 76bfcba25003..35c891075d95 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -841,6 +841,7 @@ struct platform_device *platform_device_register_full(
> >                         goto err;
> >         }
> >
> > +       set_dev_node(&pdev->dev, ACPI_NODE_GET(ACPI_COMPANION(&pdev->dev)));
> >         ret = platform_device_add(pdev);
> >         if (ret) {
> >  err:
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index a73246c3c35e..6a349d53f19e 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -477,6 +477,10 @@ static inline int acpi_get_node(acpi_handle handle)
> >         return 0;
> >  }
> >  #endif
> > +
> > +#define ACPI_NODE_GET(adev) ((adev) && (adev)->handle ? \
> > +       acpi_get_node((adev)->handle) : NUMA_NO_NODE)
> > +
> >  extern int pnpacpi_disabled;
> >
> >  #define PXM_INVAL      (-1)
> > @@ -770,6 +774,7 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
> >  #define ACPI_COMPANION_SET(dev, adev)  do { } while (0)
> >  #define ACPI_HANDLE(dev)               (NULL)
> >  #define ACPI_HANDLE_FWNODE(fwnode)     (NULL)
> > +#define ACPI_NODE_GET(adev)            NUMA_NO_NODE
> >
> >  #include <acpi/acpi_numa.h>
> >
> > --
> > 2.20.1
> >

Thanks,

Jinhui Guo
