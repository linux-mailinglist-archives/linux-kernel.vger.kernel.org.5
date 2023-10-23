Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C8B7D3C33
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjJWQUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjJWQUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:20:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CF910C1;
        Mon, 23 Oct 2023 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698078003; x=1729614003;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0D3CVXkekRtSzI4lr010y+kTIzI/lk882TXt0PNNIrU=;
  b=NHcOgifmj3Tr49e+zDes/SXa1bXR73a9OHZo9fVETba6N1+3EPcXCqY3
   XZToFVOA5N2Hif4nIdPmj186hWqHr9pjfTSsyF9W1khYJoUrJlJcYUE2x
   oEbxXUhUIoJTxA6EJLoVUv5UjCHDlrL9EPQ47Cp2YnwY4EXzDrhPh+cXy
   FoN2njWeo6ZH1t8aW6eIiaDLQ12YRm19UKEhwISATIuD/qGI3Kl+XYAac
   lk1Fxl/iNyjxGWjV3pJuCVgnd9EGOqVr8ThDqfvfT3X/LtGxboy/mOKIU
   Xe2UyHy2AbuHs3ycrYP7zOaG0ewvL05ceHptVIZAi2372yBKaanIzeQTp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="389722555"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="389722555"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 09:20:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="734721455"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734721455"
Received: from foliveix-mobl5.amr.corp.intel.com ([10.251.211.194])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 09:20:01 -0700
Date:   Mon, 23 Oct 2023 19:19:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V4 14/17] platform/x86/intel/pmc: Retrieve LPM information
 using Intel PMT
In-Reply-To: <20231018231624.1044633-15-david.e.box@linux.intel.com>
Message-ID: <8bf3d9ae-2ece-3ee6-474d-4d89fc6bd430@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com> <20231018231624.1044633-15-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1315727662-1698078002=:1721"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1315727662-1698078002=:1721
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 18 Oct 2023, David E. Box wrote:

> From: Xi Pardee <xi.pardee@intel.com>
> 
> On supported platforms, the low power mode (LPM) requirements for entering
> each idle substate are described in Platform Monitoring Technology (PMT)
> telemetry entries. Provide a function for platform code to attempt to find
> and read the requirements from the telemetry entries.
> 
> Signed-off-by: Xi Pardee <xi.pardee@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V4 - no change
> 
> V3 - no change
> 
> V2 - remove extra parens
> 
>  drivers/platform/x86/intel/pmc/core.h       |   3 +
>  drivers/platform/x86/intel/pmc/core_ssram.c | 135 ++++++++++++++++++++
>  2 files changed, 138 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index edaa70067e41..85b6f6ae4995 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -320,6 +320,7 @@ struct pmc_reg_map {
>  	const u32 lpm_status_offset;
>  	const u32 lpm_live_status_offset;
>  	const u32 etr3_offset;
> +	const u8  *lpm_reg_index;
>  };
>  
>  /**
> @@ -329,6 +330,7 @@ struct pmc_reg_map {
>   *			specific attributes
>   */
>  struct pmc_info {
> +	u32 guid;
>  	u16 devid;
>  	const struct pmc_reg_map *map;
>  };
> @@ -486,6 +488,7 @@ extern const struct pmc_bit_map *mtl_ioem_lpm_maps[];
>  extern const struct pmc_reg_map mtl_ioem_reg_map;
>  
>  extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
> +extern int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev);
>  extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
>  
>  int pmc_core_resume_common(struct pmc_dev *pmcdev);
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
> index 936aa0d5f452..f007964156bc 100644
> --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> @@ -24,6 +24,140 @@
>  #define SSRAM_IOE_OFFSET	0x68
>  #define SSRAM_DEVID_OFFSET	0x70
>  
> +/* PCH query */
> +#define LPM_HEADER_OFFSET	1
> +#define LPM_REG_COUNT		28
> +#define LPM_MODE_OFFSET		1
> +
> +static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *map)
> +{
> +	for (; list->map; ++list)
> +		if (list->map == map)
> +			return list->guid;
> +
> +	return 0;
> +}
> +
> +static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
> +{
> +	struct telem_endpoint *ep;
> +	const u8 *lpm_indices;
> +	int num_maps, mode_offset = 0;
> +	int ret, mode, i;
> +	int lpm_size;
> +	u32 guid;
> +
> +	lpm_indices = pmc->map->lpm_reg_index;
> +	num_maps = pmc->map->lpm_num_maps;
> +	lpm_size = LPM_MAX_NUM_MODES * num_maps;
> +
> +	guid = pmc_core_find_guid(pmcdev->regmap_list, pmc->map);
> +	if (!guid)
> +		return -ENXIO;
> +
> +	ep = pmt_telem_find_and_register_endpoint(pmcdev->ssram_pcidev, guid, 0);
> +	if (IS_ERR(ep)) {
> +		dev_dbg(&pmcdev->pdev->dev, "couldn't get telem endpoint %ld",
> +			PTR_ERR(ep));
> +		return -EPROBE_DEFER;
> +	}
> +
> +	pmc->lpm_req_regs = devm_kzalloc(&pmcdev->pdev->dev,
> +					 lpm_size * sizeof(u32),
> +					 GFP_KERNEL);
> +	if (!pmc->lpm_req_regs) {
> +		ret = -ENOMEM;
> +		goto unregister_ep;
> +	}
> +
> +	/*
> +	 * PMC Low Power Mode (LPM) table
> +	 *
> +	 * In telemetry space, the LPM table contains a 4 byte header followed
> +	 * by 8 consecutive mode blocks (one for each LPM mode). Each block
> +	 * has a 4 byte header followed by a set of registers that describe the
> +	 * IP state requirements for the given mode. The IP mapping is platform
> +	 * specific but the same for each block, making for easy analysis.
> +	 * Platforms only use a subset of the space to track the requirements
> +	 * for their IPs. Callers provide the requirement registers they use as
> +	 * a list of indices. Each requirement register is associated with an
> +	 * IP map that's maintained by the caller.
> +	 *
> +	 * Header
> +	 * +----+----------------------------+----------------------------+
> +	 * |  0 |      REVISION              |      ENABLED MODES         |
> +	 * +----+--------------+-------------+-------------+--------------+
> +	 *
> +	 * Low Power Mode 0 Block
> +	 * +----+--------------+-------------+-------------+--------------+
> +	 * |  1 |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
> +	 * +----+--------------+-------------+-------------+--------------+
> +	 * |  2 |           LPM0 Requirements 0                           |
> +	 * +----+---------------------------------------------------------+
> +	 * |    |                  ...                                    |
> +	 * +----+---------------------------------------------------------+
> +	 * | 29 |           LPM0 Requirements 27                          |
> +	 * +----+---------------------------------------------------------+
> +	 *
> +	 * ...
> +	 *
> +	 * Low Power Mode 7 Block
> +	 * +----+--------------+-------------+-------------+--------------+
> +	 * |    |     SUB ID   |     SIZE    |   MAJOR     |   MINOR      |
> +	 * +----+--------------+-------------+-------------+--------------+
> +	 * | 60 |           LPM7 Requirements 0                           |
> +	 * +----+---------------------------------------------------------+
> +	 * |    |                  ...                                    |
> +	 * +----+---------------------------------------------------------+
> +	 * | 87 |           LPM7 Requirements 27                          |
> +	 * +----+---------------------------------------------------------+
> +	 *
> +	 */
> +	mode_offset = LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
> +	pmc_for_each_mode(i, mode, pmcdev) {
> +		u32 *req_offset = pmc->lpm_req_regs + (mode * num_maps);
> +		int m;
> +
> +		for (m = 0; m < num_maps; m++) {
> +			u8 sample_id = lpm_indices[m] + mode_offset;
> +
> +			ret = pmt_telem_read32(ep, sample_id, req_offset, 1);
> +			if (ret) {
> +				dev_err(&pmcdev->pdev->dev,
> +					"couldn't read Low Power Mode requirements: %d\n", ret);
> +				devm_kfree(&pmcdev->pdev->dev, pmc->lpm_req_regs);
> +				goto unregister_ep;
> +			}
> +			++req_offset;
> +		}
> +		mode_offset += LPM_REG_COUNT + LPM_MODE_OFFSET;
> +	}
> +
> +unregister_ep:
> +	pmt_telem_unregister_endpoint(ep);
> +
> +	return ret;
> +}
> +
> +int pmc_core_ssram_get_lpm_reqs(struct pmc_dev *pmcdev)
> +{
> +	int ret, i;
> +
> +	if (!pmcdev->ssram_pcidev)
> +		return -ENODEV;
> +
> +	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
> +		if (!pmcdev->pmcs[i])
> +			continue;
> +
> +		ret = pmc_core_get_lpm_req(pmcdev, pmcdev->pmcs[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static void
>  pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
>  {
> @@ -215,3 +349,4 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
>  	return ret;
>  }
>  MODULE_IMPORT_NS(INTEL_VSEC);
> +MODULE_IMPORT_NS(INTEL_PMT_TELEMETRY);
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1315727662-1698078002=:1721--
