Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BF77D967F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345756AbjJ0LYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0LYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:24:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECA31B3;
        Fri, 27 Oct 2023 04:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698405853; x=1729941853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KPmjQF1ZqvViT3kYc13mgp+PgobpjuMwTCfo1SiwZS0=;
  b=Kg+TQ4V+AfOC6Akm/AQ4y1qlN55ete+A+hA6aMOuw9bHcDwMarLJQZ4b
   r1GPGzCVmKG9G9YRWTfMa6wyp/q8KXXxO3EeihB/+nnU/TPLELWdMuJcO
   lQBJBArceU2oSAbf4T16r1AlfbC6r9c+r0VPQBEdicBIX0E31KpqDxPVV
   PEe2labQHIrkJqG0TP2eecUS9C3pKqEwSJg9poMXJ3l1D7z/UuR7JdBtR
   MAgJhb79nHz8T/ji8MDpvUA+qpdMvLXXsztK3bUnUJR3ERmappG1m8BA6
   celE8GulBfRFSsyuvF36IxoarP9G4p1+LQR63V3hCowGnNLcA3KZyMYDc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="367967798"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="367967798"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="794549216"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="794549216"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:24:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qwKwh-0000000984N-25aY;
        Fri, 27 Oct 2023 14:24:07 +0300
Date:   Fri, 27 Oct 2023 14:24:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        lh xu <xulh0829@gmail.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH V3 3/6] pinctrl: sprd: Move common and misc offset
 parameters to private data
Message-ID: <ZTud17B4VeASo0os@smile.fi.intel.com>
References: <20231027071426.17724-1-Linhua.xu@unisoc.com>
 <20231027071426.17724-4-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027071426.17724-4-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 03:14:23PM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> For UNISOC pin controller, the offset values of the common
> register and misc register will be different. So add SoC
> structure in sprd_pinctrl_of_match() and parse it in sprd-pinctrl_core.

...

> +	priv_data = of_device_get_match_data(&pdev->dev);
> +	if (!priv_data)
> +		return -EINVAL;

I believe there is the idea to make that API local to the device property core,
so use device_get_match_data() instead.

-- 
With Best Regards,
Andy Shevchenko


