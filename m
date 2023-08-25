Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F97787ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjHYEA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240875AbjHYD7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:59:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474661FE6;
        Thu, 24 Aug 2023 20:59:51 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RX5j84zBhzNn8Z;
        Fri, 25 Aug 2023 11:56:12 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 11:59:47 +0800
Message-ID: <a29d4ef5-fba2-b1f4-9c48-5c125dbe0e27@huawei.com>
Date:   Fri, 25 Aug 2023 11:59:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/2] ACPI: NFIT: Fix incorrect calculation of idt size
Content-Language: en-US
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>, <rafael@kernel.org>
CC:     <liwei391@huawei.com>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230817091124.915407-1-liaoyu15@huawei.com>
From:   Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <20230817091124.915407-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A kindly ping, any comment on this?

Best regards,
Yu


On 2023/8/17 17:11, Yu Liao wrote:
> acpi_nfit_interleave's field 'line_offset' is switched to flexible array [1],
> but sizeof_idt() still calculates the size in the form of 1-element array.
> 
> Therefore, fix incorrect calculation in sizeof_idt().
> 
> [1] https://lore.kernel.org/lkml/2652195.BddDVKsqQX@kreacher/
> 
> Fixes: 2a5ab99847bd ("ACPICA: struct acpi_nfit_interleave: Replace 1-element array with flexible array")
> Cc: stable@vger.kernel.org # v6.4+
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 07204d482968..305f590c54a8 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -855,7 +855,7 @@ static size_t sizeof_idt(struct acpi_nfit_interleave *idt)
>  {
>  	if (idt->header.length < sizeof(*idt))
>  		return 0;
> -	return sizeof(*idt) + sizeof(u32) * (idt->line_count - 1);
> +	return sizeof(*idt) + sizeof(u32) * idt->line_count;
>  }
>  
>  static bool add_idt(struct acpi_nfit_desc *acpi_desc,

