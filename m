Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E3B7F32FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjKUP7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjKUP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:59:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C59139
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:59:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60753C433C7;
        Tue, 21 Nov 2023 15:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700582384;
        bh=7alg8Jssc6aLWxzZ/btEFQ1RxP33y9So0lktKPqsofc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azyVEQtOmYL3DB78Wk7B7eQK86ZySqQvGSLDDKTwOXVphW6gKwb8fW3CGLcqisf3K
         v4AN65UjwS/q4Rh0y2ZZ7pZkRyiUHas3NmS9S1VXCrFTVLmYyQHJME5R8lBeN9PdaI
         b2UYPF/aGQ8R9HKtypIdQW3cr2RecvaMunW4An0AMtihAC0VUixc+dEADNBEpQXluK
         NRZGcgVo41ZuhElOkKXxEVIRqeY4tEWKcqS6+TeLRMfJNDL/t4KhKY0gHLXIh4Y97I
         lTjQ+E8zYhbHCTD0OGsrmtJuy+QFaAX5eF642wweyo9/zwi3ZeDIeUN2ajDspVUJ7f
         OCmTIbtVhkw+Q==
Date:   Tue, 21 Nov 2023 15:59:38 +0000
From:   Will Deacon <will@kernel.org>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        ardb@kernel.org, mark.rutland@arm.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 6/6] perf: arm_cspmu: drop redundant
 acpi_dev_uid_to_integer()
Message-ID: <20231121155937.GD1938@willie-the-truck>
References: <20231121103829.10027-1-raag.jadav@intel.com>
 <20231121103829.10027-7-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121103829.10027-7-raag.jadav@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:08:29PM +0530, Raag Jadav wrote:
> Now that we have _UID matching support for integer types, we can use
> acpi_dev_hid_uid_match() for it.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 2cc35dded007..50b89b989ce7 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1108,7 +1108,6 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
>  
>  static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
>  {
> -	u64 acpi_uid;
>  	struct device *cpu_dev;
>  	struct acpi_device *acpi_dev;
>  
> @@ -1118,8 +1117,7 @@ static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
>  
>  	acpi_dev = ACPI_COMPANION(cpu_dev);
>  	while (acpi_dev) {
> -		if (acpi_dev_hid_uid_match(acpi_dev, ACPI_PROCESSOR_CONTAINER_HID, NULL) &&
> -		    !acpi_dev_uid_to_integer(acpi_dev, &acpi_uid) && acpi_uid == container_uid)
> +		if (acpi_dev_hid_uid_match(acpi_dev, ACPI_PROCESSOR_CONTAINER_HID, container_uid))
>  			return 0;
>  
>  		acpi_dev = acpi_dev_parent(acpi_dev);
> -- 
> 2.17.1

Acked-by: Will Deacon <will@kernel.org>

Will
