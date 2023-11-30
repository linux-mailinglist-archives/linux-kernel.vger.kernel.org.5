Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0057FF2C4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346050AbjK3Oob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjK3Oo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:44:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5B493
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701355476; x=1732891476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QHhP3rK7xvF2dxKYGJ733/CnziXsZ0+hcVS42FWQ11s=;
  b=mcsjg5+HBsNwIv/nOJNhc6SDxuW/f/07XE6EOCS5380ctu0BQll1W37b
   GEDOPk5aiBR9PGPgn0mSPQOAGjnOLsjTlp9gAKUGsCjNrs4ka2dJ5EF4F
   +CIkzlpRMGLQRN5sN8KWyDeBbqW9/m0n9lUVKnIk7pCkQ2z2Xr2C7vkCD
   9ihF9+/EV1akX0j7MCcu0XQ7LQiMnByZq+tK5mK2oMFlBX6zzyLOqvSHA
   6/y8vyfxI3kfqVzLt14j0ff8SNI6ftKNlYwRf1SyMjB2EVqDBSek96bI3
   17Uk+uqcfprL70ywQHWU+fKSLyEIHu6+4XaXCqnxe+aQShJEg0crPYJNJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="392196898"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="392196898"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:44:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="887262414"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="887262414"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga002.fm.intel.com with SMTP; 30 Nov 2023 06:44:34 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 30 Nov 2023 16:44:33 +0200
Date:   Thu, 30 Nov 2023 16:44:33 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Don't fail probe on success of
 pci_alloc_irq_vectors()
Message-ID: <ZWif0YQ/5EFbrA2X@kuha.fi.intel.com>
References: <20231130143206.1475831-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130143206.1475831-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:32:06PM +0200, Andy Shevchenko wrote:
> The pci_alloc_irq_vectors() returns a positive number on success.
> Hence we have to filter the negative numbers for error condition.
> Update the check accordingly.
> 
> Fixes: e6951fb78787 ("mfd: intel-lpss: Use PCI APIs instead of dereferencing")
> Reported-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for the quick fix.

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/mfd/intel-lpss-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
> index 8f5e10817a9c..4621d3950b8f 100644
> --- a/drivers/mfd/intel-lpss-pci.c
> +++ b/drivers/mfd/intel-lpss-pci.c
> @@ -44,7 +44,7 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
>  		return ret;
>  
>  	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_LEGACY);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	info = devm_kmemdup(&pdev->dev, data, sizeof(*info), GFP_KERNEL);

thanks,

-- 
heikki
