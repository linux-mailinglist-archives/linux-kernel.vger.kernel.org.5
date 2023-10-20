Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59B07D11DB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377646AbjJTOvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377633AbjJTOux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:50:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA591D6D;
        Fri, 20 Oct 2023 07:50:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SBnYr3rjkz6K7HY;
        Fri, 20 Oct 2023 22:50:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 20 Oct
 2023 15:50:42 +0100
Date:   Fri, 20 Oct 2023 15:50:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC:     Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH] parisc: simplify smp_prepare_boot_cpu()
Message-ID: <20231020155041.00006a0a@Huawei.com>
In-Reply-To: <E1qtqkk-00AJHA-1u@rmk-PC.armlinux.org.uk>
References: <E1qtqkk-00AJHA-1u@rmk-PC.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Fri, 20 Oct 2023 15:45:30 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> smp_prepare_boot_cpu() reads the cpuid of the first CPU, printing a
> message to state which processor booted, and setting it online and
> present.
> 
> This cpuid is retrieved from per_cpu(cpu_data, 0).cpuid, which is
> initialised in arch/parisc/kernel/processor.c:processor_probe() thusly:
> 
> 	p = &per_cpu(cpu_data, cpuid);
> ...
> 	p->cpuid = cpuid;	/* save CPU id */
> 
> Consequently, the cpuid retrieved seems to be guaranteed to also be
> zero, meaning that the message printed in this boils down to:
> 
> 	pr_info("SMP: bootstrap CPU ID is 0\n");
> 
> Moreover, since kernel/cpu.c::boot_cpu_init() already sets CPU 0 to
> be present and online, there is no need to do this again in
> smp_prepare_boot_cpu().
> 
> Remove this code, and simplify the printk().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

LGTM, but trivial comment inline.

> ---
>  arch/parisc/kernel/smp.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
> index 2019c1f04bd0..989efc8c67a5 100644
> --- a/arch/parisc/kernel/smp.c
> +++ b/arch/parisc/kernel/smp.c
> @@ -404,13 +404,8 @@ static int smp_boot_one_cpu(int cpuid, struct task_struct *idle)
>  
>  void __init smp_prepare_boot_cpu(void)
>  {
> -	int bootstrap_processor = per_cpu(cpu_data, 0).cpuid;
> -
>  	/* Setup BSP mappings */

Given it's not doing any such thing, I think you should also drop the comment.

> -	printk(KERN_INFO "SMP: bootstrap CPU ID is %d\n", bootstrap_processor);
> -
> -	set_cpu_online(bootstrap_processor, true);
> -	set_cpu_present(bootstrap_processor, true);
> +	pr_info("SMP: bootstrap CPU ID is 0\n");
>  }
>  
>  

