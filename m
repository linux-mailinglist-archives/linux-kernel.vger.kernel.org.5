Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEAF7AF05B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjIZQMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIZQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:12:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5200895;
        Tue, 26 Sep 2023 09:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695744764; x=1727280764;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hOPvrFuM7xzfXjh3YgK8hIYzaOkz35/zwI6nSX4tg+Q=;
  b=ZlWt+aM7u64wc7rBMEKJH3rqLeTXypdUslo1bcsENKKlxV6+MFRVP5j6
   YwngRbgqIbXWQBcIdbPnHzmzEiZtTabSXbZWVqx401KjHuY6A5854U1X0
   xAOnGViBgKq8Weve9OE4C0RlcFrgaB8YzfgFBB4D5srsWwrrfw/HdXOnM
   nmUrVkrQu1n+FUcgLkZql+RRfRTh5JknMQLWpqvesP4onenMBl0l+/iIW
   y9nXXl9mjH9NPw3SOOehGlxAij2+L6TFhK7GmJqC7VjNiH5XlX9oA5cpF
   SOfH3uQzSLSwv8rWdgPLvh+JniUAWKEq24REhNkafGFLJ8+cHafV3xdZT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="448097710"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="448097710"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819079424"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="819079424"
Received: from hhalmen-mobl.ger.corp.intel.com ([10.251.219.207])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:11:45 -0700
Date:   Tue, 26 Sep 2023 19:11:43 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH 11/11] platform/x86/intel/pmc: Add debug attribute for
 Die C6 counter
In-Reply-To: <20230922213032.1770590-12-david.e.box@linux.intel.com>
Message-ID: <65178530-1635-61c7-f7e2-ff3fb4d584d@linux.intel.com>
References: <20230922213032.1770590-1-david.e.box@linux.intel.com> <20230922213032.1770590-12-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023, David E. Box wrote:

> Add a "die_c6_us_show" counter in debugs and add support for Meteor Lake.
> Reads the counter value using Intel Platform Monitoring Technology (PMT)
> driver API. This counter is useful for determining the idle residency of
> CPUs in the compute tile.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 55 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h |  4 ++
>  drivers/platform/x86/intel/pmc/mtl.c  | 32 ++++++++++++++++
>  3 files changed, 91 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index df2bcead1723..790ed9481529 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -27,6 +27,7 @@
>  #include <asm/tsc.h>
>  
>  #include "core.h"
> +#include "../pmt/telemetry.h"
>  
>  /* Maximum number of modes supported by platfoms that has low power mode capability */
>  const char *pmc_lpm_modes[] = {
> @@ -822,6 +823,48 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_req_regs);
>  
> +static unsigned int pmc_core_get_crystal_freq(void)
> +{
> +	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
> +
> +	if (boot_cpu_data.cpuid_level < 0x15)
> +		return 0;
> +
> +	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
> +
> +	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
> +	cpuid(0x15, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
> +
> +	if (ebx_numerator == 0 || eax_denominator == 0)
> +		return 0;
> +
> +	return ecx_hz;
> +}
> +
> +static int pmc_core_die_c6_us_show(struct seq_file *s, void *unused)
> +{
> +	struct pmc_dev *pmcdev = s->private;
> +	u64 die_c6_res, count;
> +	int ret;
> +
> +	if (!pmcdev->crystal_freq) {
> +		dev_warn_once(&pmcdev->pdev->dev, "%s: Bad crystal frequency\n",
> +			      __func__);

Don't use __func__.

> +		return -EINVAL;
> +	}
> +
> +	ret = pmt_telem_read(pmcdev->punit_ep, pmcdev->die_c6_offset,
> +			     &count, 1);
> +	if (ret)
> +		return ret;
> +
> +	die_c6_res = div64_u64(count * 1000000ULL, pmcdev->crystal_freq);

HZ_PER_MHZ ?

> +	seq_printf(s, "%llu\n", die_c6_res);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(pmc_core_die_c6_us);
> +
>  static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
>  {
>  	struct pmc_dev *pmcdev = s->private;
> @@ -1118,6 +1161,12 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>  				    pmcdev->dbgfs_dir, pmcdev,
>  				    &pmc_core_substate_req_regs_fops);
>  	}
> +
> +	if (pmcdev->has_die_c6) {
> +		debugfs_create_file("die_c6_us_show", 0444,
> +				    pmcdev->dbgfs_dir, pmcdev,
> +				    &pmc_core_die_c6_us_fops);
> +	}
>  }
>  
>  static const struct x86_cpu_id intel_pmc_core_ids[] = {
> @@ -1212,6 +1261,10 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
>  		pci_dev_put(pmcdev->ssram_pcidev);
>  		pci_disable_device(pmcdev->ssram_pcidev);
>  	}
> +
> +	if (pmcdev->punit_ep)
> +		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
> +
>  	platform_set_drvdata(pdev, NULL);
>  	mutex_destroy(&pmcdev->lock);
>  }
> @@ -1232,6 +1285,8 @@ static int pmc_core_probe(struct platform_device *pdev)
>  	if (!pmcdev)
>  		return -ENOMEM;
>  
> +	pmcdev->crystal_freq = pmc_core_get_crystal_freq();
> +
>  	platform_set_drvdata(pdev, pmcdev);
>  	pmcdev->pdev = pdev;
>  
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index 85b6f6ae4995..6d7673145f90 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -16,6 +16,8 @@
>  #include <linux/bits.h>
>  #include <linux/platform_device.h>
>  
> +struct telem_endpoint;
> +
>  #define SLP_S0_RES_COUNTER_MASK			GENMASK(31, 0)
>  
>  #define PMC_BASE_ADDR_DEFAULT			0xFE000000
> @@ -357,6 +359,7 @@ struct pmc {
>   * @devs:		pointer to an array of pmc pointers
>   * @pdev:		pointer to platform_device struct
>   * @ssram_pcidev:	pointer to pci device struct for the PMC SSRAM
> + * @crystal_freq:	crystal frequency from cpuid
>   * @dbgfs_dir:		path to debugfs interface
>   * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
>   *			used to read MPHY PG and PLL status are available
> @@ -374,6 +377,7 @@ struct pmc_dev {
>  	struct dentry *dbgfs_dir;
>  	struct platform_device *pdev;
>  	struct pci_dev *ssram_pcidev;
> +	unsigned int crystal_freq;
>  	int pmc_xram_read_bit;
>  	struct mutex lock; /* generic mutex lock for PMC Core */
>  
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index c2ac50cfdd51..d791d4894c9d 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -10,12 +10,17 @@
>  
>  #include <linux/pci.h>
>  #include "core.h"
> +#include "../pmt/telemetry.h"
>  
>  /* PMC SSRAM PMT Telemetry GUIDS */
>  #define SOCP_LPM_REQ_GUID	0x2625030
>  #define IOEM_LPM_REQ_GUID	0x4357464
>  #define IOEP_LPM_REQ_GUID	0x5077612
>  
> +/* Die C6 from PUNIT telemetry */
> +#define MTL_PMT_DMU_DIE_C6_OFFSET	15
> +#define MTL_PMT_DMU_GUID		0x1A067102
> +
>  static const u8 MTL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
>  
>  /*
> @@ -968,6 +973,32 @@ static struct pmc_info mtl_pmc_info_list[] = {
>  	{}
>  };
>  
> +static void mtl_punit_pmt_init(struct pmc_dev *pmcdev)
> +{
> +	struct telem_endpoint *ep;
> +	struct pci_dev *pcidev;
> +
> +	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(10, 0));
> +	if (!pcidev) {
> +		dev_err(&pmcdev->pdev->dev, "PUNIT PMT device not found.");
> +		return;
> +	}
> +
> +	ep = pmt_telem_find_and_register_endpoint(pcidev, MTL_PMT_DMU_GUID, 0);
> +	if (IS_ERR(ep)) {
> +		dev_err(&pmcdev->pdev->dev,
> +			"pmc_core: couldn't get DMU telem endpoint %ld",

Missing \n from this and the previous dev_err().

> +			PTR_ERR(ep));
> +		return;
> +	}
> +
> +	pci_dev_put(pcidev);
> +	pmcdev->punit_ep = ep;
> +
> +	pmcdev->has_die_c6 = true;
> +	pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
> +}
> +
>  #define MTL_GNA_PCI_DEV	0x7e4c
>  #define MTL_IPU_PCI_DEV	0x7d19
>  #define MTL_VPU_PCI_DEV	0x7d1d
> @@ -1030,6 +1061,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
>  	}
>  
>  	pmc_core_get_low_power_modes(pmcdev);
> +	mtl_punit_pmt_init(pmcdev);
>  
>  	/* Due to a hardware limitation, the GBE LTR blocks PC10
>  	 * when a cable is attached. Tell the PMC to ignore it.
> 

-- 
 i.

