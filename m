Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09398138FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjLNRnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:43:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DEFCF;
        Thu, 14 Dec 2023 09:43:41 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SrfmQ0L9Sz6K7F2;
        Fri, 15 Dec 2023 01:41:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 83E611400DB;
        Fri, 15 Dec 2023 01:43:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 17:43:38 +0000
Date:   Thu, 14 Dec 2023 17:43:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC:     <linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
        <linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
        <linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <jianyong.wu@arm.com>, <justin.he@arm.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 07/21] ACPI: Rename acpi_processor_hotadd_init
 and remove pre-processor guards
Message-ID: <20231214174337.000042a4@Huawei.com>
In-Reply-To: <E1rDOgN-00DvkE-D8@rmk-PC.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
        <E1rDOgN-00DvkE-D8@rmk-PC.armlinux.org.uk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 12:49:47 +0000
Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:

> From: James Morse <james.morse@arm.com>
> 
> acpi_processor_hotadd_init() will make a CPU present by mapping it
> based on its hardware id.
> 
> 'hotadd_init' is ambiguous once there are two different behaviours
> for cpu hotplug. This is for toggling the _STA present bit. Subsequent
> patches will add support for toggling the _STA enabled bit, named
> acpi_processor_make_enabled().
> 
> Rename it acpi_processor_make_present() to make it clear this is
> for CPUs that were not previously present.
> 
> Expose the function prototypes it uses to allow the preprocessor
> guards to be removed. The IS_ENABLED() check will let the compiler
> dead-code elimination pass remove this if it isn't going to be
> used.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
> Outstanding comments:
>  https://lore.kernel.org/r/20230914151720.00007105@Huawei.com

If it's not caused a build warning yet, chances are high this is fine.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  https://lore.kernel.org/r/b8f430c1-c30f-191f-18c6-f750fa6ba476@redhat.com
>   For this comment, we use IS_ENABLED() in multiple places in the kernel in
>   this way, and it isn't a problem.
> ---
>  drivers/acpi/acpi_processor.c | 14 +++++---------
>  include/linux/acpi.h          |  2 --
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index c8e960ff0aca..26e3efb74614 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -183,13 +183,15 @@ static void __init acpi_pcc_cpufreq_init(void) {}
>  #endif /* CONFIG_X86 */
>  
>  /* Initialization */
> -#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
> -static int acpi_processor_hotadd_init(struct acpi_processor *pr)
> +static int acpi_processor_make_present(struct acpi_processor *pr)
>  {
>  	unsigned long long sta;
>  	acpi_status status;
>  	int ret;
>  
> +	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
> +		return -ENODEV;
> +
>  	if (invalid_phys_cpuid(pr->phys_id))
>  		return -ENODEV;
>  
> @@ -223,12 +225,6 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>  	cpu_maps_update_done();
>  	return ret;
>  }
> -#else
> -static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
> -{
> -	return -ENODEV;
> -}
> -#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
>  
>  static int acpi_processor_get_info(struct acpi_device *device)
>  {
> @@ -335,7 +331,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	 *  because cpuid <-> apicid mapping is persistent now.
>  	 */
>  	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
> -		int ret = acpi_processor_hotadd_init(pr);
> +		int ret = acpi_processor_make_present(pr);
>  
>  		if (ret)
>  			return ret;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 36071bc11acd..19d009ca9e7a 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -301,12 +301,10 @@ static inline int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
>  }
>  #endif
>  
> -#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
>  /* Arch dependent functions for cpu hotplug support */
>  int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
>  		 int *pcpu);
>  int acpi_unmap_cpu(int cpu);
> -#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
>  
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>  int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);

