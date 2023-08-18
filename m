Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45497780CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377309AbjHRNvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377474AbjHRNvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:51:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1318B44AA;
        Fri, 18 Aug 2023 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692366646; x=1723902646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jK3rLN4QoYs7BnTEcvIivUoNPLOsFPYLk4t2kVLNIn0=;
  b=JRr6Sb1V8EjmZLIAsebTAbzIxXLqkX85dBdbk8K0NNBpR08i0wwZtSqB
   IGl9OUfK0xwzJ0q9cH60F9t/0ovpfpxa+kmT8KCD4KXEWJKwLn9kCId7j
   FKf4Vc/Ti+bq1qPC+PbgGr5V7SewqpQcnhnj2pp/nyXvVKrqR/sdD4B4f
   JfG8j9Cu5de6VG5ObNJCD2sCBXQ4sIzBUq1qY9E3FI/gUR3+5n0fRWkp3
   aTS53LCqUqXkvsKw0Cnt+AumaJ5J2jC7erIHv9yOGYuhkS7EWYHwJS/TE
   NXo6+Yk+QbtPXtXaXoF0nwFx3ye0p50ir7wDe5OxWBprxkYoUoGb6tYLy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="459457309"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="459457309"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 06:50:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="908888610"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="908888610"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 18 Aug 2023 06:50:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWzs7-00AYtj-1Y;
        Fri, 18 Aug 2023 16:50:39 +0300
Date:   Fri, 18 Aug 2023 16:50:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, sumitg@nvidia.com,
        arnd@arndb.de, pshete@nvidia.co, digetx@gmail.com,
        petlozup@nvidia.com, windhl@126.com, frank.li@vivo.com,
        robh@kernel.org, stefank@nvidia.com, pdeschrijver@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] soc/tegra: fuse: Add function to register nvmem
Message-ID: <ZN93L/9vBdBvZMA9@smile.fi.intel.com>
References: <20230818093028.7807-1-kkartik@nvidia.com>
 <20230818093028.7807-3-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093028.7807-3-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:00:24PM +0530, Kartik wrote:
> Add helper function tegra_fuse_nvmem_register() to register
> Tegra Fuse nvmem and use it in tegra_fuse_probe(). So, this can be
> shared between device-tree and ACPI probe, which is to be introduced
> later.

...

> +	fuse->nvmem = devm_nvmem_register(dev, &nvmem);
> +	if (IS_ERR(fuse->nvmem)) {

> +		err = PTR_ERR(fuse->nvmem);
> +		dev_err(dev, "failed to register NVMEM device: %d\n",
> +			err);
> +		return err;

		return dev_err_probe();

> +	}
> +
> +	return 0;
> +}

...

Seems it comes from the original code, so consider this as a suggestion for
an additional improvement.

-- 
With Best Regards,
Andy Shevchenko


