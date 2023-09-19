Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB667A661D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjISOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjISOEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:04:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233C69E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:03:34 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1c44c7dbaf9so31366875ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695132213; x=1695737013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGKaBfgAzKyjrsd37PzrpzEGRPcEqD4NHE8jZQ/sN64=;
        b=dF4gcx/rjUnzsPUCKvK/rBv6vBwUjBNTtp3MAbDlD1QncZ3uIVTojshkI+luGdshWT
         QXJ/6oL7R0HmtcO/2/Ox1WpJmpLS+j6u4GU/W+ubZryREQWmXURh3HmnRQBgWXUUI2nV
         +9b2QfxcdRkd7ZolSLWK69C7lFBHP8hUZqiRRuog8BkQmHmwzkIYCS7aCzszRBhFdUM8
         6SpVYShU+FRz76IXx3K3DdwsPeGIXFqL78Mm5QllzWbgTCP5nfFL8tfLajQDLCDn4+sy
         ocaaQ+A4zGdelfRuWMND6e2zoX3eoURSfVFias8pfvo2fRmwcLzhywoM996aeyVgXqfJ
         BHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695132213; x=1695737013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGKaBfgAzKyjrsd37PzrpzEGRPcEqD4NHE8jZQ/sN64=;
        b=InRWLEt39PDWibRUYtf8f7Jx4kW2OgfQiwgFwJJrsygAemLNER2EVswLTOTEsxbU2t
         KUfk/Wd+7Mmt2YsCkSMmwxnC39HqlFo+8l99j8xtLQ+XMZhhNJspSavJl4OM4ndmsYAK
         Ntyu/Ej6Ca1mtewtUsdb603P9hoqKjkc2fhul5lMX1BU4RhIfMqlmhe1LszKYv/9jxeZ
         QFYN7RAoS9zsR3WtCUAd/Ttd6hM56tl6iWdO//XRJd8OdNVEo5qVS4rMh1QFsJY9BGON
         bSs/MCGODeEk3BJLGAFs4/q6oHQE5Cj3GHRc6mYyjlbATrCvDdd4sbbSj+tEbm0GClRo
         D4wg==
X-Gm-Message-State: AOJu0YzdhTBeS9GiuwBLMZi+u4ee8cMUnXqoOQHMQTUBAYKm2gb4CxqV
        E0BVSD+WGigLmDZ+TciF9VyD5A==
X-Google-Smtp-Source: AGHT+IGT7Zs0cLemloqBlKtGqgrUVk9OTYclF54fusyIyKf45/F8+fX3Xp34BoUQLJMPZvDfD4C+LA==
X-Received: by 2002:a17:903:2352:b0:1c3:aee0:7d27 with SMTP id c18-20020a170903235200b001c3aee07d27mr14931263plh.24.1695132213521;
        Tue, 19 Sep 2023 07:03:33 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([203.208.189.14])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001bda30ecaa6sm10090285plg.51.2023.09.19.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:03:33 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     gregkh@linuxfoundation.org
Cc:     guojinhui.liam@bytedance.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, lkp@intel.com, rafael@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v7] driver core: platform: set numa_node before platform_device_add()
Date:   Tue, 19 Sep 2023 22:03:26 +0800
Message-Id: <20230919140326.597-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2023091942-punk-naturist-8028@gregkh>
References: <2023091942-punk-naturist-8028@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 14:12:20 +0200, Greg KH wrote:
> On Tue, Sep 19, 2023 at 08:03:41PM +0800, Jinhui Guo wrote:
> > Setting the devices' numa_node needs to be done in
> > platform_device_register_full(), because that's where the
> > platform device object is allocated.
> > 
> > Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> > Cc: stable@vger.kernel.org
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> The test robot did not report the original problem, that was a problem
> with your potential change.
> 
> > Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
> 
> Likewise, this is not a real issue, it was a problem with your previous
> submission.
>

Thanks, I will fix it.
 
> > Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> > ---
> > V6 -> V7
> >   1. Fix bug directly by adding numa_node to struct
> >      platform_device_info (suggested by Rafael J. Wysocki).
> >   2. Remove reviewer name.
> > 
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
> >   Refactor code to be an ACPI function call (suggested by Greg Kroah-Hartman).
> > 
> > V2 -> V3:
> >   Fix Signed-off name.
> > 
> > V1 -> V2:
> >   Fix compile error without enabling CONFIG_ACPI.
> > ---
> > 
> >  drivers/acpi/acpi_platform.c    |  5 ++---
> >  drivers/base/platform.c         |  4 ++++
> >  include/linux/platform_device.h | 26 ++++++++++++++++++++++++++
> >  3 files changed, 32 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> > index 48d15dd785f6..1ae7449f70dc 100644
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -168,6 +168,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
> >  	pdevinfo.num_res = count;
> >  	pdevinfo.fwnode = acpi_fwnode_handle(adev);
> >  	pdevinfo.properties = properties;
> > +	platform_devinfo_set_node(&pdevinfo, acpi_get_node(adev->handle));
> >  
> >  	if (acpi_dma_supported(adev))
> >  		pdevinfo.dma_mask = DMA_BIT_MASK(32);
> > @@ -178,11 +179,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
> >  	if (IS_ERR(pdev))
> >  		dev_err(&adev->dev, "platform device creation failed: %ld\n",
> >  			PTR_ERR(pdev));
> > -	else {
> > -		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
> > +	else
> >  		dev_dbg(&adev->dev, "created platform device %s\n",
> >  			dev_name(&pdev->dev));
> > -	}
> >  
> >  	kfree(resources);
> >  
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 76bfcba25003..c733bfb26149 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -808,6 +808,7 @@ struct platform_device *platform_device_register_full(
> >  {
> >  	int ret;
> >  	struct platform_device *pdev;
> > +	int numa_node = platform_devinfo_get_node(pdevinfo);
> >  
> >  	pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
> >  	if (!pdev)
> > @@ -841,6 +842,9 @@ struct platform_device *platform_device_register_full(
> >  			goto err;
> >  	}
> >  
> > +	if (numa_node >= 0)
> > +		set_dev_node(&pdev->dev, numa_node);
> 
> Why not just always set it?  Why check?  Would that matter?
> 

I think it is better to add a check here, because we cannot be sure that the caller
will pass the correct parameters. If the caller pass pdevinfo->numa_node == -1, we
will get -2 here, but many check for numa_node just determine whether it is NUMA_NO_NODE.

> 
> > +
> >  	ret = platform_device_add(pdev);
> >  	if (ret) {
> >  err:
> > diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> > index 7a41c72c1959..78e11b79f1af 100644
> > --- a/include/linux/platform_device.h
> > +++ b/include/linux/platform_device.h
> > @@ -132,10 +132,36 @@ struct platform_device_info {
> >  		u64 dma_mask;
> >  
> >  		const struct property_entry *properties;
> > +
> > +#ifdef CONFIG_NUMA
> > +		int numa_node;	/* NUMA node this platform device is close to plus 1 */
> > +#endif
> 
> Why #ifdef?
> 

If CONFIG_NUMA=n, numa_node will be useless.

> And why an int?
> 

Keep the same as it in `struct device`.

> And why +1?
> 

Because not all the drivers will set numa_node, they just initialize `struct platform_device_info`
to zero.

> And what do you mean by "close to"?
> 
> And why would a platform device care about a numa node?  These are
> devices that should NEVER care about numa things as they are not on a
> real bus, or should care about performance things.  If they are, then
> the device is on the wrong bus, right?
> 
> What device are you having numa problems with?  Why would acpi devices
> care?
> 
> The node number in the device itself should be all that you need here,
> no need to duplicate it, right?
> 

1. "close to" may be better replaced with "proximity", indicates the proximity numa node of the device.

2. Some platform devices like accelerator in arm, they would be treated as platform devices. If we can
   get its proximity numa node through sysfs, we can bind its memory access to specify numa node, it
   will improve the performance for the app.

```
+--------+
| accel1 |    
+--------+
   |AXI (interconnect)
+--------+
| node1  |
+--------+
```

3. We can get numa node from struct device, but for platform device, it does not expose to userspace.
   And we just use `struct platform_device_info` to pass the numa node to `struct device`.

> thanks,
> 
> greg k-h
>

thanks,

Jinhui Guo 
