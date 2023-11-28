Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C89E7FB260
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343767AbjK1HMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjK1HMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:12:06 -0500
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 394C4182
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:12:11 -0800 (PST)
X-IronPort-AV: E=Sophos;i="6.04,233,1695657600"; 
   d="scan'208";a="97503624"
From:   sparkhuang <huangshaobo3@xiaomi.com>
To:     <vnkgutta@codeaurora.org>
CC:     <alexander.deucher@amd.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <jshriram@codeaurora.org>,
        <linux-kernel@vger.kernel.org>, <psodagud@codeaurora.org>,
        <tsoni@codeaurora.org>
Subject: Re: [PATCH] driver core: platform: Fix the usage of platform device name(pdev->name)
Date:   Mon, 27 Nov 2023 23:12:07 -0800
Message-ID: <1701155527-2697-1-git-send-email-huangshaobo3@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555978589-4998-1-git-send-email-vnkgutta@codeaurora.org>
References: <1555978589-4998-1-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.237.8.18]
X-ClientProxiedBy: bj-mbx11.mioffice.cn (10.237.8.131) To BJ-MBX01.mioffice.cn
 (10.237.8.121)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 05:16:29PM -0700, Venkata Narendra Kumar Gutta wrote:
> Platform core is using pdev->name as the platform device name to do
> the binding of the devices with the drivers. But, when the platform
> driver overrides the platform device name with dev_set_name(),
> the pdev->name is pointing to a location which is freed and becomes
> an invalid parameter to do the binding match.
>
> use-after-free instance:
>
> [   33.325013] BUG: KASAN: use-after-free in strcmp+0x8c/0xb0
> [   33.330646] Read of size 1 at addr ffffffc10beae600 by task modprobe
> [   33.339068] CPU: 5 PID: 518 Comm: modprobe Tainted:
>                       G S      W  O      4.19.30+ #3
> [   33.346835] Hardware name: MTP (DT)
> [   33.350419] Call trace:
> [   33.352941]  dump_backtrace+0x0/0x3b8
> [   33.356713]  show_stack+0x24/0x30
> [   33.360119]  dump_stack+0x160/0x1d8
> [   33.363709]  print_address_description+0x84/0x2e0
> [   33.368549]  kasan_report+0x26c/0x2d0
> [   33.372322]  __asan_report_load1_noabort+0x2c/0x38
> [   33.377248]  strcmp+0x8c/0xb0
> [   33.380306]  platform_match+0x70/0x1f8
> [   33.384168]  __driver_attach+0x78/0x3a0
> [   33.388111]  bus_for_each_dev+0x13c/0x1b8
> [   33.392237]  driver_attach+0x4c/0x58
> [   33.395910]  bus_add_driver+0x350/0x560
> [   33.399854]  driver_register+0x23c/0x328
> [   33.403886]  __platform_driver_register+0xd0/0xe0

We also encountered the same problem, is there any solution?

> So, use dev_name(&pdev->dev), which fetches the platform device name from
> the kobject(dev->kobj->name) of the device instead of the pdev->name.
>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  drivers/base/platform.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index dab0a5a..0e23aa2 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -888,7 +888,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
>       if (len != -ENODEV)
>               return len;
>
> -     len = snprintf(buf, PAGE_SIZE, "platform:%s\n", pdev->name);
> +     len = snprintf(buf, PAGE_SIZE, "platform:%s\n", dev_name(&pdev->dev));
>
>       return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
>  }
> @@ -964,7 +964,7 @@ static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
>               return rc;
>
>       add_uevent_var(env, "MODALIAS=%s%s", PLATFORM_MODULE_PREFIX,
> -                     pdev->name);
> +                     dev_name(&pdev->dev));
>       return 0;
>  }
>
> @@ -973,7 +973,7 @@ static const struct platform_device_id *platform_match_id(
>                       struct platform_device *pdev)
>  {
>       while (id->name[0]) {
> -             if (strcmp(pdev->name, id->name) == 0) {
> +             if (strcmp(dev_name(&pdev->dev), id->name) == 0) {
>                       pdev->id_entry = id;
>                       return id;
>               }
> @@ -1017,7 +1017,7 @@ static int platform_match(struct device *dev, struct device_driver *drv)
>               return platform_match_id(pdrv->id_table, pdev) != NULL;
>
>       /* fall-back to driver name match */
> -     return (strcmp(pdev->name, drv->name) == 0);
> +     return (strcmp(dev_name(&pdev->dev), drv->name) == 0);
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>

