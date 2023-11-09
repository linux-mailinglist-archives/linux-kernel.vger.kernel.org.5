Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B14E7E64E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjKIIGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjKIIGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:06:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7BC269F;
        Thu,  9 Nov 2023 00:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699517200; x=1731053200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lOWmxm9+hlLDd/bFPxc4FNd/WQuv+HVFpFCjdXz4HsU=;
  b=LUG5/aWxtxElw7HN3Rn/DrqERPwX84v8HkNLsdp1BbC4mvocCsT2AcxN
   k3jap7iYSBo1vKEdc834meV7gEY2+VVe1tSEaYKxNzW+IbD41IxZBE25t
   f84r67nl75ys1qcDNaAGc8+m5oz0ZwqX8GZhuWstHiujTitY24aj01cGF
   HR3z/2e5NTV6w7cFdTtAzbukVVnzkloxjm99kDBTqFfj/kiJAR/Zadh+w
   HbdHd4Uc8cDMk3J/cAvwaHloobxkxxUvOiupRyaYBNcM0izKxyx6DSM+/
   DtDVVrel9d61YjHf5YDSi+SLDWfS/tEoRYqxNAauRH6eMNBmf+K0hz7uy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="392811257"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="392811257"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 00:06:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="11068757"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 09 Nov 2023 00:06:37 -0800
Date:   Thu, 9 Nov 2023 16:05:01 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, michal.simek@amd.com, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nava kishore Manne <nava.manne@xilinx.com>
Subject: Re: [PATCH] fpga: zynq: Fix incorrect variable type
Message-ID: <ZUySrZ4Cc/qdzWXX@yilunxu-OptiPlex-7050>
References: <20231109062823.3268724-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109062823.3268724-1-nava.kishore.manne@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 11:58:23AM +0530, Nava kishore Manne wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> zynq_fpga_has_sync () API is expecting "u8 *" but the
> formal parameter that was passed is of type "const char *".
> To fix this issue cast the const char pointer to u8 pointer.

Any error log found? I assume this is just implicit cast and doesn't
worth a fix.

Thanks,
Yilun

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/zynq-fpga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 96611d424a10..988853137ac6 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -275,7 +275,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>  
>  	/* don't globally reset PL if we're doing partial reconfig */
>  	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> -		if (!zynq_fpga_has_sync(buf, count)) {
> +		if (!zynq_fpga_has_sync((u8 *)buf, count)) {
>  			dev_err(&mgr->dev,
>  				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swapped .bin file\n");
>  			err = -EINVAL;
> -- 
> 2.25.1
> 
