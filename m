Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CFA7A4C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjIRPcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjIRPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:32:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49170CEB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:27:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c1ff5b741cso43352645ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695050707; x=1695655507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pudypFwSwvYWUA8GZ6yWJQWZyEDdbHX7BphECmHVSNw=;
        b=QimgOvFpmjMbI25FGHNAb4EU9OVm5BesSOwBaeQKNXBzh9Cs/0fA2EuSCY61vT2b0a
         1zy1Kk9k8hr3gXUcQUnLqiRc7O1m9ZmlK7AsY6WGx1Aur2wQ+CS4AP9wPKKS5jpExQ5B
         TYwiAf1fO5Xu5OF4g+CoIAekC9V3R0kg62t6c4ZGaezkMxnw4blt8t+3X+nlUnIDsdST
         jjHsI9Y2nc1zs+U7ZhP2mdLjpjrgAs5vxAZaTKnwLVYh09Qt9A7AEdEE/KFkYleapepA
         v28t0TYarg3nWTK5MgjqNI9EQQrEpsR7VOZJM5Rlmq/zUktlD7/43nZ7l1q1szbD2XkZ
         pprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050707; x=1695655507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pudypFwSwvYWUA8GZ6yWJQWZyEDdbHX7BphECmHVSNw=;
        b=CEanrjCuf0B63SIf+kB0SubqcXzHA9K4BvlYs6qwM+jv17Xk0GjbzZ9YUOo0bfTsrx
         +C53iB+3l9lzFOsRfLLcSlHTEuauwz60ePMTU7eL3FgNCsi+KV5NyDs1T/2qt9UAn8ms
         UEKsC8yPp6kv2acEeo8J01CfKS+xhBk4IWoTdv3LakUmXSXCx+hpqRcT9+ngZb26plWa
         AQZF7TmkZY4WPMYh4cOL6UENdsxFIWQ3LRLgHDhGNsHcQ8QvjUJn7lCycN5XMb2NxNHD
         qJe8c+E5FWYKWKVbvkeJGLBXxa+fwuyw6cBtS/89z8/Ze/IYbXMCY0p3a/uGWKYpjjnl
         /P5Q==
X-Gm-Message-State: AOJu0Ywg97LEZVLIZHth6sLq/nrndEsMakT41U/C2jwnKIhZukmBr3uq
        YjMzzrs8dr6aiuwb64YO+xqJ3w==
X-Google-Smtp-Source: AGHT+IExjXc7IVtiPsvm4aeJW5nIUZKxHF7MeFoJNQs3pxieErXLk9RYT1n73k5aZDfIEpUzQJO4bQ==
X-Received: by 2002:a17:903:60e:b0:1c4:6cc2:a27e with SMTP id kg14-20020a170903060e00b001c46cc2a27emr4245837plb.69.1695050707125;
        Mon, 18 Sep 2023 08:25:07 -0700 (PDT)
Received: from PF2LML5M-SMJ.lan ([103.175.14.91])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001b9ecee459csm3031991pld.34.2023.09.18.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:25:06 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     rafael@kernel.org
Cc:     guojinhui.liam@bytedance.com, gregkh@linuxfoundation.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        lkp@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v6] driver core: platform: set numa_node before platform_device_add()
Date:   Mon, 18 Sep 2023 23:25:02 +0800
Message-Id: <20230918152502.316-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230918134527.252-1-guojinhui.liam@bytedance.com>
References: <20230918134527.252-1-guojinhui.liam@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Sep 18, 2023 at 3:46 PM Jinhui Guo <guojinhui.liam@bytedance.com> wrote:
> >
> > Setting the devices' numa_node needs to be done in
> > platform_device_register_full(), because that's where the
> > platform device object is allocated.
> >
> > Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> > Cc: stable@vger.kernel.org
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> No, I haven't given you this tag.
> 
> I don't think that Greg has given you the one above either.
> 
> Please don't add tage that you haven't received to your patches,
> because they are not applicable with incorrect tags.
>

I appologize to it. I just misunderstand what it means. I will drop it out soon.
 
> > Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> > ---
> > V5 -> V6:
> >   1. Update subject to correct function name platform_device_add().
> >   2. Provide a more clear and accurate description of the changes
> >      made in commit (suggested by Rafael J. Wysocki).
> >   3. Add reviewer name.
> >
> > V4 -> V5:
> >   Add Cc: stable line and changes from the previous submited patches.
> >
> > V3 -> V4:
> >   Refactor code to be an ACPI function call.
> >
> > V2 -> V3:
> >   Fix Signed-off name.
> >
> > V1 -> V2:
> >   Fix compile error without enabling CONFIG_ACPI.
> > ---
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
