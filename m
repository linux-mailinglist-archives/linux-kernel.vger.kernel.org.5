Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B97DB611
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjJ3JYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjJ3JYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:24:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA4AA7;
        Mon, 30 Oct 2023 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698657880; x=1730193880;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PzE2WjM3liPGYO4o8GBic2JxQGQnXqgby3fh52nVXJs=;
  b=ZyQF/E7jh92Gm5qSZWfhxFK5qzB6Cy3bAmEM/bh7kXNkXxnvrE/2qw5s
   KaT1XuX+LXv3dRNJ4RwRK90h4rDrzQyXF6Se/lNWcuZAXtXUMIOgyPYGr
   9eGk6hBoCk4orm1qzdLJNXgrG0yKGi0DCPtdTF1LtdrbVzBmRv6sH2ogX
   STkVvhLDJLjq3gFpUJUel6wrBPE2QK34afRsc7xb0iKl4r7SUZ3syC5GC
   xYBOyaiA9FNujfKxb1DxLEBvuHib5c2qbz0HcBDwDONByxahHKFpRAj0q
   p+OSZ9rVniUytYcy3bqX4tphKjkZQIfGL6qgp89/2NgXr0XU4lfgQmM5q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373090942"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373090942"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 02:24:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="710050263"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="710050263"
Received: from sgruszka-mobl.ger.corp.intel.com ([10.252.50.181])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 02:24:36 -0700
Date:   Mon, 30 Oct 2023 11:24:30 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Hasemeyer <markhas@chromium.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1] platform/x86/amd/pmc: Get smu version before reading
 dram size
In-Reply-To: <20231027212916.1035991-1-markhas@chromium.org>
Message-ID: <2b8335a7-4b9b-825-c1b8-84158aaf2c42@linux.intel.com>
References: <20231027212916.1035991-1-markhas@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2023, Mark Hasemeyer wrote:

> Calls to amd_pmc_get_dram_size can fail because the function assumes smu

Always use () after function names, thank you.

> version information has already been read when it hasn't. The smu
> version is lazily read as opposed to being read at probe because it is
> slow and increases boot time.
> 
> Read the smu version information if it has not been read yet.
> 
> Link: https://lore.kernel.org/all/a3ee6577-d521-6d18-0a15-2f97d6f8ac3a@amd.com/
> Fixes: be8325fb3d8c ("platform/x86/amd: pmc: Get STB DRAM size from PMFW")
> Cc: stable@vger.kernel.org # 6.5.x
> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> ---
> 
>  drivers/platform/x86/amd/pmc/pmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index cd6ac04c1468..f668eddbc5d5 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -970,6 +970,11 @@ static int amd_pmc_get_dram_size(struct amd_pmc_dev *dev)
>  
>  	switch (dev->cpu_id) {
>  	case AMD_CPU_ID_YC:
> +		if (!dev->major) {
> +			ret = amd_pmc_get_smu_version(dev);
> +			if (ret)
> +				goto err_dram_size;
> +		}
>  		if (!(dev->major > 90 || (dev->major == 90 && dev->minor > 39))) {
>  			ret = -EINVAL;
>  			goto err_dram_size;
> 

Hi,

Thank you for your patch. This has already come up but no acceptable patch 
has emerged since. Please see this thread for what needs to be done if you 
want to provide one (or maybe Shyam already has one which has just not 
been sent out yet):

https://lore.kernel.org/platform-driver-x86/3b224c62-a1d8-41bd-aced-5825f5f20e66@amd.com/

(Since this dram size is on an init path that always needs SMU version, 
the SMU version can just be called by the init unconditonally rather than 
adding more of this lazy initialization everywhere).


-- 
 i.

