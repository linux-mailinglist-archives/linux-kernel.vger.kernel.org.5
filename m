Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5779F944
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjINEAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbjINEAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:00:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5907E4B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:00:16 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c1e780aa95so3628885ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694664016; x=1695268816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebM0c0pS7Yj9AcYD8iD0tO6tSr15uXr4K+UiJ03c4A8=;
        b=i5eoJQuLTt28JafLqM7yeHwq1skXkkJlm9ZUouVxHMjH5EDKKNaiE1fAGnA7VnlS6D
         0v8bjvnFR/LCWAhsAkWOmRlXyl7VpjTTqO7dmSpbC7Rbhk+eyoIa9SRj6EHKqPmJz0kQ
         QMe5/zyGQIqum2IQtpCJD1xUVZ+KpIii3Ta82n3Y/HgXhH1Qkn2q8nBO+GE+6y6YeblF
         gfoKqd6xW+1Nt71jF13QNQohlP4GMxX3l/VjFmsvyGyhPnfqa4I8Dn49UQ9wBMihN+xu
         zQzA5NXHCQNVxU/w7rFMpGWtGT4DX5WTIffLzgpvfaqQ+NkcQTOrJjqAJu6MJz6sqHG0
         3h9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694664016; x=1695268816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebM0c0pS7Yj9AcYD8iD0tO6tSr15uXr4K+UiJ03c4A8=;
        b=EcFYyoqLHnjq1BGsrrXsVe5d3pSFUFv3r04gPkot73OM1QUld6TmK3DVwvDsGQm5CH
         mxI2PgiRhXGbGOmOxp4Hznccfkq0juCwDjtxNGzSx54FtUjfrpEKNVSPUQOaTptdPoof
         7r+Y47WSo3vlG8ie05GYsp740m3R8GT3CncyhIROIUv4Gg96iv2W6za8RRnXZCwEphPP
         nqa6AHQLaz3JIpM6iPh+9OXj23wdae9e2GnenCBTnh/tUpEofeVbIcStLd1sQxpjOPCS
         7wzM3E2xsFLL0m/N8fyZQLilAshNDb0SZbM4v06a3l5fwQKOKWh8jgmN1tyw+/RkA2eg
         sYEg==
X-Gm-Message-State: AOJu0Yy8JA83A2bY7vjDbk/lw118A5G6N8ve9GZcDQHGp/gxIpKYzQ2r
        WUsbQEqVogpLY+a+PFW2a841qw==
X-Google-Smtp-Source: AGHT+IHRpSheJScTlD5DYKPkeJzbIF3TnBdI+/aU5C/ZTP3GhoZlMMrEUZqQA5E6VoUw3Qviqug/vw==
X-Received: by 2002:a17:902:be12:b0:1c4:abc:b84c with SMTP id r18-20020a170902be1200b001c40abcb84cmr917910pls.6.1694664016125;
        Wed, 13 Sep 2023 21:00:16 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([220.243.131.6])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d90300b001bc45408d26sm403681plz.36.2023.09.13.21.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 21:00:14 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     gregkh@linuxfoundation.org
Cc:     guojinhui.liam@bytedance.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, lkp@intel.com, rafael@kernel.org
Subject: Re: [PATCH v2] driver core: platform: set numa_node before platform_add_device()
Date:   Thu, 14 Sep 2023 12:00:07 +0800
Message-Id: <20230914040007.3196-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2023091351-clarify-prototype-710c@gregkh>
References: <2023091351-clarify-prototype-710c@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 06:37:03PM +0200, Greg KH wrote:
> On Wed, Sep 13, 2023 at 04:38:25PM +0800, guojinhui wrote:
> > From: "guojinhui" <guojinhui.liam@bytedance.com>
> > 
> > platform_add_device creates numa_node attribute of sysfs according to
> > whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
> > of the device before creating numa_node attribute of sysfs.
> > 
> > Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
> > Signed-off-by: guojinhui <guojinhui.liam@bytedance.com>
> > ---
> >  drivers/acpi/acpi_platform.c |  4 +---
> >  drivers/base/platform.c      | 13 +++++++++++++
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> > index 48d15dd785f6..adcbfbdc343f 100644
> > --- a/drivers/acpi/acpi_platform.c
> > +++ b/drivers/acpi/acpi_platform.c
> > @@ -178,11 +178,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
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
> > index 76bfcba25003..206dc7b020cd 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -795,6 +795,18 @@ void platform_device_unregister(struct platform_device *pdev)
> >  }
> >  EXPORT_SYMBOL_GPL(platform_device_unregister);
> >  
> > +#ifdef CONFIG_ACPI
> 
> #ifdef do not belong in .c files if at all possible.
> 
> Why can't this be an acpi call instead?  Why does this have to be in the
> driver core?  Platform drivers shouldn't know anything about acpi, this
> feels really odd.
> 
> > +static inline void platform_set_dev_node(struct platform_device *pdev)
> 
> Also, it's not "platform_set", it is acpi-specifc, right?  Again, the
> ACPI core should handle this for its ACPI-platform devices, the driver
> core shouldn't care at all.
> 
> thanks,
> 
> greg k-h
>

I agree with that. I will try to fix it in the ACPI code which call the platform function
soon.

thanks,

Jinhui Guo
