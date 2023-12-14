Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5678138BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjLNRgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbjLNRgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:36:23 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9318A134;
        Thu, 14 Dec 2023 09:36:29 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Srfc62XW9z688KN;
        Fri, 15 Dec 2023 01:34:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id CC9911400DB;
        Fri, 15 Dec 2023 01:36:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 17:36:27 +0000
Date:   Thu, 14 Dec 2023 17:36:26 +0000
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
Subject: Re: [PATCH RFC v3 02/21] ACPI: processor: Add support for
 processors described as container packages
Message-ID: <20231214173626.00005062@Huawei.com>
In-Reply-To: <E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
        <E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
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

On Wed, 13 Dec 2023 12:49:21 +0000
Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:

> From: James Morse <james.morse@arm.com>
> 
> ACPI has two ways of describing processors in the DSDT. From ACPI v6.5,
> 5.2.12:
> 
> "Starting with ACPI Specification 6.3, the use of the Processor() object
> was deprecated. Only legacy systems should continue with this usage. On
> the Itanium architecture only, a _UID is provided for the Processor()
> that is a string object. This usage of _UID is also deprecated since it
> can preclude an OSPM from being able to match a processor to a
> non-enumerable device, such as those defined in the MADT. From ACPI
> Specification 6.3 onward, all processor objects for all architectures
> except Itanium must now use Device() objects with an _HID of ACPI0007,
> and use only integer _UID values."
> 
> Also see https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#declaring-processors
> 
> Duplicate descriptions are not allowed, the ACPI processor driver already
> parses the UID from both devices and containers. acpi_processor_get_info()
> returns an error if the UID exists twice in the DSDT.
> 
> The missing probe for CPUs described as packages creates a problem for
> moving the cpu_register() calls into the acpi_processor driver, as CPUs
> described like this don't get registered, leading to errors from other
> subsystems when they try to add new sysfs entries to the CPU node.
> (e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)
> 
> To fix this, parse the processor container and call acpi_processor_add()
> for each processor that is discovered like this. The processor container
> handler is added with acpi_scan_add_handler(), so no detach call will
> arrive.
> 
> Qemu TCG describes CPUs using processor devices in a processor container.
> For more information, see build_cpus_aml() in Qemu hw/acpi/cpu.c and
> https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#processor-container-device
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
> Outstanding comments:
>  https://lore.kernel.org/r/20230914145353.000072e2@Huawei.com
Looks like you resolved those (were all patch description things).

So I'm happy.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

J
>  https://lore.kernel.org/r/50571c2f-aa3c-baeb-3add-cd59e0eddc02@redhat.com
> ---
>  drivers/acpi/acpi_processor.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 4fe2ef54088c..6a542e0ce396 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -626,9 +626,31 @@ static struct acpi_scan_handler processor_handler = {
>  	},
>  };
>  
> +static acpi_status acpi_processor_container_walk(acpi_handle handle,
> +						 u32 lvl,
> +						 void *context,
> +						 void **rv)
> +{
> +	struct acpi_device *adev;
> +	acpi_status status;
> +
> +	adev = acpi_get_acpi_dev(handle);
> +	if (!adev)
> +		return AE_ERROR;
> +
> +	status = acpi_processor_add(adev, &processor_device_ids[0]);
> +	acpi_put_acpi_dev(adev);
> +
> +	return status;
> +}
> +
>  static int acpi_processor_container_attach(struct acpi_device *dev,
>  					   const struct acpi_device_id *id)
>  {
> +	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, dev->handle,
> +			    ACPI_UINT32_MAX, acpi_processor_container_walk,
> +			    NULL, NULL, NULL);
> +
>  	return 1;
>  }
>  

