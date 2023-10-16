Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEA37CB6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 01:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjJPXKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 19:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJPXKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 19:10:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D70C95;
        Mon, 16 Oct 2023 16:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2Anr2/GmGSzWfCGVwKHjuVuOk2nbIkJ1M98MBriCLDc=; b=A/wtu3H9krJKQy0XwnSN8+Ct6t
        FiULbN6ucAcsx2f6Ry6afN9TQViPSiOzT5MI6q6+WJDfJ6BUrfOS6FxpaotnrAQsEF1//Vd6YRuy4
        /F/MLXX/I2OJ/sj4DLrBzEhLwJqpmVZkYNhAj2GeYAy0OfB1mFjJ3fRgo8A2qmTAVuOe1DrvOL4M2
        bx7z6zxDna5MlhPMexoNkXGYaZBjnVA/ZcFR0wx0UR4yTSbe48RslDBmvAU5OOMoyOsUsAYwyXQ0j
        PrjluEdp5mWBD8Vsx7eKoBvO8jVTYGbOSFm7Be7wSr0HmqtYPszQtL1L58YEyi/TRAmSniFwpX/HS
        8iU5blag==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qsWil-00AoSx-0a;
        Mon, 16 Oct 2023 23:09:59 +0000
Message-ID: <afd142a2-1fa0-46b9-8b2d-7652d41d3ab8@infradead.org>
Date:   Mon, 16 Oct 2023 16:09:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Fix dependency of SMC on ISM
To:     Gerd Bayer <gbayer@linux.ibm.com>, wenjia@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        netdev@vger.kernel.org, raspl@linux.ibm.com, sfr@canb.auug.org.au,
        alibuda@linux.alibaba.com, wintera@linux.ibm.com,
        guwen@linux.alibaba.com, tonylu@linux.alibaba.com,
        jaka@linux.ibm.com
References: <d9a2d47d-c8bd-cf17-83e0-d9b82561a594@linux.ibm.com>
 <20231006125847.1517840-1-gbayer@linux.ibm.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231006125847.1517840-1-gbayer@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

On 10/6/23 05:58, Gerd Bayer wrote:
> When the SMC protocol is built into the kernel proper while ISM is
> configured to be built as module, linking the kernel fails due to
> unresolved dependencies out of net/smc/smc_ism.o to
> ism_get_smcd_ops, ism_register_client, and ism_unregister_client
> as reported via the linux-next test automation (see link).
> This however is a bug introduced a while ago.
> 
> Correct the dependency list in ISM's and SMC's Kconfig to reflect the
> dependencies that are actually inverted. With this you cannot build a
> kernel with CONFIG_SMC=y and CONFIG_ISM=m. Either ISM needs to be 'y',
> too - or a 'n'. That way, SMC can still be configured on non-s390
> architectures that do not have (nor need) an ISM driver.
> 
> Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-next/d53b5b50-d894-4df8-8969-fd39e63440ae@infradead.org/
> Co-developed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

With this patch, ISM can be build without SMC being enabled.

This leads to some build warnings:

../drivers/s390/net/ism_drv.c:572:12: warning: 'ism_get_local_gid' defined but not used [-Wunused-function]
  572 | static u64 ism_get_local_gid(struct ism_dev *ism)
      |            ^~~~~~~~~~~~~~~~~
../drivers/s390/net/ism_drv.c:506:12: warning: 'ism_get_chid' defined but not used [-Wunused-function]
  506 | static u16 ism_get_chid(struct ism_dev *ism)
      |            ^~~~~~~~~~~~
../drivers/s390/net/ism_drv.c:432:12: warning: 'ism_signal_ieq' defined but not used [-Wunused-function]
  432 | static int ism_signal_ieq(struct ism_dev *ism, u64 rgid, u32 trigger_irq,
      |            ^~~~~~~~~~~~~~
../drivers/s390/net/ism_drv.c:292:12: warning: 'ism_query_rgid' defined but not used [-Wunused-function]
  292 | static int ism_query_rgid(struct ism_dev *ism, u64 rgid, u32 vid_valid,
      |            ^~~~~~~~~~~~~~

> ---
>  drivers/s390/net/Kconfig | 2 +-
>  net/smc/Kconfig          | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> index 74760c1a163b..4902d45e929c 100644
> --- a/drivers/s390/net/Kconfig
> +++ b/drivers/s390/net/Kconfig
> @@ -102,7 +102,7 @@ config CCWGROUP
>  
>  config ISM
>  	tristate "Support for ISM vPCI Adapter"
> -	depends on PCI && SMC
> +	depends on PCI
>  	default n
>  	help
>  	  Select this option if you want to use the Internal Shared Memory
> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
> index 1ab3c5a2c5ad..746be3996768 100644
> --- a/net/smc/Kconfig
> +++ b/net/smc/Kconfig
> @@ -2,6 +2,7 @@
>  config SMC
>  	tristate "SMC socket protocol family"
>  	depends on INET && INFINIBAND
> +	depends on m || ISM != m
>  	help
>  	  SMC-R provides a "sockets over RDMA" solution making use of
>  	  RDMA over Converged Ethernet (RoCE) technology to upgrade

-- 
~Randy
