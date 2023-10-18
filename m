Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62227CD994
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjJRKuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRKur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:50:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185FAFE;
        Wed, 18 Oct 2023 03:50:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S9SKr581Xz67gZw;
        Wed, 18 Oct 2023 18:50:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 11:50:39 +0100
Date:   Wed, 18 Oct 2023 11:50:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/pmu: Ensure put_device on pmu devices
Message-ID: <20231018115038.0000433d@Huawei.com>
In-Reply-To: <20231016-pmu-unregister-fix-v1-1-1e2eb2fa3c69@intel.com>
References: <20231016-pmu-unregister-fix-v1-1-1e2eb2fa3c69@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 16:25:05 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> The following kmemleaks were detected when removing the cxl module
> stack:
> 
> unreferenced object 0xffff88822616b800 (size 1024):
> ...
>   backtrace:
>     [<00000000bedc6f83>] kmalloc_trace+0x26/0x90
>     [<00000000448d1afc>] devm_cxl_pmu_add+0x3a/0x110 [cxl_core]
>     [<00000000ca3bfe16>] 0xffffffffa105213b
>     [<00000000ba7f78dc>] local_pci_probe+0x41/0x90
>     [<000000005bb027ac>] pci_device_probe+0xb0/0x1c0
> ...
> unreferenced object 0xffff8882260abcc0 (size 16):
> ...
>   hex dump (first 16 bytes):
>     70 6d 75 5f 6d 65 6d 30 2e 30 00 26 82 88 ff ff  pmu_mem0.0.&....
>   backtrace:
> ...
>     [<00000000152b5e98>] dev_set_name+0x43/0x50
>     [<00000000c228798b>] devm_cxl_pmu_add+0x102/0x110 [cxl_core]
>     [<00000000ca3bfe16>] 0xffffffffa105213b
>     [<00000000ba7f78dc>] local_pci_probe+0x41/0x90
>     [<000000005bb027ac>] pci_device_probe+0xb0/0x1c0
> ...
> unreferenced object 0xffff8882272af200 (size 256):
> ...
>   backtrace:
>     [<00000000bedc6f83>] kmalloc_trace+0x26/0x90
>     [<00000000a14d1813>] device_add+0x4ea/0x890
>     [<00000000a3f07b47>] devm_cxl_pmu_add+0xbe/0x110 [cxl_core]
>     [<00000000ca3bfe16>] 0xffffffffa105213b
>     [<00000000ba7f78dc>] local_pci_probe+0x41/0x90
>     [<000000005bb027ac>] pci_device_probe+0xb0/0x1c0
> ...
> 
> devm_cxl_pmu_add() correctly registers a device remove function but it
> only calls device_del() which is only part of device unregistration.
> 
> Properly call device_unregister() to free up the memory associated with
> the device.
> 
> Fixes: 1ad3f701c399 ("cxl/pci: Find and register CXL PMU devices")
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Oops.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pmu.c b/drivers/cxl/core/pmu.c
> index 7684c843e5a5..5d8e06b0ba6e 100644
> --- a/drivers/cxl/core/pmu.c
> +++ b/drivers/cxl/core/pmu.c
> @@ -23,7 +23,7 @@ const struct device_type cxl_pmu_type = {
>  
>  static void remove_dev(void *dev)
>  {
> -	device_del(dev);
> +	device_unregister(dev);
>  }
>  
>  int devm_cxl_pmu_add(struct device *parent, struct cxl_pmu_regs *regs,
> 
> ---
> base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
> change-id: 20231016-pmu-unregister-fix-345480926a58
> 
> Best regards,

