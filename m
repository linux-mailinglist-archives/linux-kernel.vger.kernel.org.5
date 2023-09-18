Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B08A7A4CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjIRPkE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 11:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIRPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:40:01 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EF7CF7;
        Mon, 18 Sep 2023 08:38:27 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-797ea09af91so27346439f.1;
        Mon, 18 Sep 2023 08:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051237; x=1695656037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFE3SOieeOg7U2cFR/e5C3Az7OsuKy0SX2uLUyU2L9I=;
        b=KzuuybhJ/GNbrQIPkvQBI87ganokPfJJLFlAxD2NLdcVKjeo/WN1b+4L0ChCHPmS4q
         Aw1buvCKmBzRZuiNoZghTnjT2K6+8eG3UI9nJyxbLQSI9lJRZoJ3Le+Zoo3hnW3Rsw0q
         xEe8rGQnLRZRz4WjtM7bjSsqmhnxfgY+1+0kyyYZds2CmYihbTMKtoLaED51wFSK0ssH
         bRvRQZd34xmXoHCxABAjr+vVtRT4UgnJzqlug2XMBeP40KE9RCSnjMjBBW1Hl8yxPMn0
         9L9Y49djGIXidd6D4e7iOAxq4rwMdqhUdcdrBMWznQili55qry75lTEsp8M/ncEMorIk
         54cw==
X-Gm-Message-State: AOJu0YzdhWNuViL9syYm3pblU/5o5I/u/lJq2zgdZO6NUhVSGFmjN7/c
        hVi3lDP0afWa+gNWPsPD8KN106yl3U9+mbBSPu3pvssurGc=
X-Google-Smtp-Source: AGHT+IESVVkxXNkZBZ+zrTkkHPrBUBVokeQRifMlvtY58nf40YU40O+NE8GM5f1jlNZedx/2FFLkI968pQ4cLx2okKA=
X-Received: by 2002:a4a:d38e:0:b0:573:764b:3b8d with SMTP id
 i14-20020a4ad38e000000b00573764b3b8dmr8216476oos.0.1695049777925; Mon, 18 Sep
 2023 08:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0j+L=a0UEiCEXUYDtvscaVF29FPro9FNupMkJ7do2eBGw@mail.gmail.com>
 <20230918124117.187-1-guojinhui.liam@bytedance.com>
In-Reply-To: <20230918124117.187-1-guojinhui.liam@bytedance.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Sep 2023 17:09:27 +0200
Message-ID: <CAJZ5v0jWhC-poYDtemW36Nqm+0ADsG7=wBCUerWJWzQMv-zM2g@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: set numa_node before platform_add_device()
To:     Jinhui Guo <guojinhui.liam@bytedance.com>
Cc:     rafael@kernel.org, gregkh@linuxfoundation.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, lkp@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 2:41 PM Jinhui Guo <guojinhui.liam@bytedance.com> wrote:
>
> On Mon, 18 Sep 2023 12:30:58 +0200, Rafael J. Wysocki wrote:
> > On Thu, Sep 14, 2023 at 11:32 PM Jinhui Guo
> > <guojinhui.liam@bytedance.com> wrote:
> > >
> > > platform_add_device()
> >
> > According to "git grep" this function is not present in 6.6-rc2.
> >
> > If you mean platform_device_add(), please update the patch subject and
> > changelog accordingly.
> >
>
> This is my mistake, the function name was written wrong.
> I will fix it in the next patch.
>
> > > creates the numa_node attribute of sysfs according
> > > to whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
> > > of device before creating numa_node attribute of sysfs.
> >
> > It would be good to also say that this needs to be done in
> > platform_device_register_full(), because that's where the platform
> > device object is allocated.
> >
>
> Thaks for your suggestion. I will modify my decription soon.
>
> > However, what about adding the NUMA node information to pdevinfo?  It
> > would be more straightforward to handle it then AFAICS.
> >
>
> I have tried three potential solutions to fix the bug:
> 1. The first one is what the current patch do.
>
> 2. Add a new function interface only for acpi_create_platform_device() call.
>    But the code will be a bit redundant.
>
> 3. Add an member "numa_node" in `struct platform_device_info`, just as what
>    `struct device` done:
>
> ```
> struct platform_device_info {
>         ...;
> #ifdef CONFIG_NUMA
>         int             numa_node;
> #endif
> ```
>
> But not all the call to platform_device_register_full() would set numa_node,
> and many of them use ` memset(&pdevinfo, 0, sizeof(pdevinfo));` to initialize
> `struct platform_device_info`. It could initialize numa_node to zero and
> result in wrong numa_node information in sysfs.

Well, platform_device_register_full() need not take that value as the
numa node number directly.  It may, for example, take the number from
pdevinfo, subtract 1 from it and use the result of that as the numa
node number, if not negative.
