Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A362A7EB2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjKNPD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKNPDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:03:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB490114;
        Tue, 14 Nov 2023 07:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699974232; x=1731510232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sLIb3XBGDWt+FTuW5YUujWG/H36LyRAUk5Z37b8RGNE=;
  b=azjs8j0lWq2Nz+plsJNVko24jKU8hnIUASNAsVcxEA36m6v72XxV02NO
   itEePFCafObq/OfPlwzF3BivXtyuyY/CIP+Tt3PmQCuFgiapVQnvUQeTu
   ErZ6FEhfJ0dN3aqj3n2OJvR+BeDgj64g3FVIFZaiVHBGfWNCyrxUwsvTr
   f+LATkYnVLsFC+v3JU54bKxZ/SFMPLzx35iAlf2AGl7YKUJ4zzjZi1Uys
   9a5LVS0AJUt4XvLce7MX2J6TNZc9fOHwJZ34NOc5JhaaklIfXxSb5eAwG
   xekCVWbArpGe5Yz3pJw//vaYRDEs9azKzponmV0g1h4EHzuiffuotcfhx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370866541"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="370866541"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 07:03:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="835051505"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="835051505"
Received: from mylly.fi.intel.com (HELO [10.237.72.161]) ([10.237.72.161])
  by fmsmga004.fm.intel.com with ESMTP; 14 Nov 2023 07:03:48 -0800
Message-ID: <b71367f0-d51e-486e-979b-9172b85c7f7d@linux.intel.com>
Date:   Tue, 14 Nov 2023 17:03:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/25] i2c: designware: Remove ->disable() callback
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
References: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
 <20231110182304.3894319-19-andriy.shevchenko@linux.intel.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20231110182304.3894319-19-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 20:11, Andy Shevchenko wrote:
> Commit 90312351fd1e ("i2c: designware: MASTER mode as separated driver")
> introduced ->disable() callback but there is no real use for it. Both
> i2c-designware-master.c and i2c-designware-slave.c set it to the same
> i2c_dw_disable() and scope is inside the same kernel module.
> 
> That said, replace the callback by explicitly calling the i2c_dw_disable().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/i2c/busses/i2c-designware-core.h    | 2 --
>   drivers/i2c/busses/i2c-designware-master.c  | 1 -
>   drivers/i2c/busses/i2c-designware-pcidrv.c  | 4 ++--
>   drivers/i2c/busses/i2c-designware-platdrv.c | 4 ++--
>   drivers/i2c/busses/i2c-designware-slave.c   | 3 +--
>   5 files changed, 5 insertions(+), 9 deletions(-)
> 
Hmm... no report from kernel test robot but I'm getting build error 
below after this patch when driver (and I2C core) is built as module.

CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_DESIGNWARE_PCI=m
CONFIG_SPI_DESIGNWARE=m

   CC [M]  drivers/i2c/busses/i2c-designware-common.o
   CC [M]  drivers/i2c/busses/i2c-designware-master.o
   CC [M]  drivers/i2c/busses/i2c-designware-slave.o
   CC [M]  drivers/i2c/busses/i2c-designware-platdrv.o
   CC [M]  drivers/i2c/busses/i2c-designware-baytrail.o
   CC [M]  drivers/i2c/busses/i2c-designware-pcidrv.o
   LD [M]  drivers/i2c/busses/i2c-designware-platform.o
   LD [M]  drivers/i2c/busses/i2c-designware-pci.o
   LD [M]  drivers/i2c/busses/i2c-designware-core.o
   MODPOST Module.symvers
ERROR: modpost: "i2c_dw_disable" 
[drivers/i2c/busses/i2c-designware-platform.ko] undefined!
ERROR: modpost: "i2c_dw_disable" 
[drivers/i2c/busses/i2c-designware-pci.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** [/workdisk/linux/linux/Makefile:1863: modpost] Error 2
make: *** [Makefile:234: __sub-make] Error 2
