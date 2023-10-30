Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B227DB5FF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjJ3JTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjJ3JTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:19:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E154AA7;
        Mon, 30 Oct 2023 02:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698657578; x=1730193578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fyIMF6N+1ePKlbVBfoyWa6vLLpP4q55GWPlHPlpHeeM=;
  b=hIajnS0M1EbShPOqH37y7u7Qb1+H9XfZklzwvWujMyDuSEBICWZDxZUU
   w+VjdbwS0O93yWnsYpMutMg1SHk9iWnKqf80AI3kZ4OJhwAABFEzkRctY
   5N9GBDmW8UI0qP6epyctDeGSBqrakqmEVECeHoKHJ4YmnyFc83yxwKDfE
   gjcMXRec/F0/Bs265y3iO3l/fGfz/vT1Y/sJGAuTZ5N+zHhrjRpPZPIQx
   eWx9luZgU0Vged67J7IU/BI9LoNPFklnO77VqvMN/OB0m73bkPp4gou7C
   5RI53Hnm1UTjTPNSXy3tprZEPjTR3ik1G9L+nNORa1KMbpoh+SMWA176P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="904238"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="904238"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 02:19:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="1091571992"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="1091571992"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga005.fm.intel.com with SMTP; 30 Oct 2023 02:19:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 30 Oct 2023 11:19:33 +0200
Date:   Mon, 30 Oct 2023 11:19:33 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Abdel Alkuor <abdelalkuor@geotab.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: typec: tps6598x: Fix a memory leak in an error
 handling path
Message-ID: <ZT91JeJPKdKNy6Ih@kuha.fi.intel.com>
References: <23168336f18a9f6cb1a5b47130fc134dc0510d7f.1698648980.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23168336f18a9f6cb1a5b47130fc134dc0510d7f.1698648980.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 07:56:40AM +0100, Christophe JAILLET wrote:
> All error handling end to the error handling path, except these ones.
> Go to 'release_fw' as well here, otherwise 'fw' is leaking.
> 
> Fixes: 7e7a3c815d22 ("USB: typec: tps6598x: Add TPS25750 support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tipd/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 0e867f531d34..b0184be06c3d 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -968,16 +968,17 @@ static int tps25750_start_patch_burst_mode(struct tps6598x *tps)
>  	ret = of_property_match_string(np, "reg-names", "patch-address");
>  	if (ret < 0) {
>  		dev_err(tps->dev, "failed to get patch-address %d\n", ret);
> -		return ret;
> +		goto release_fw;
>  	}
>  
>  	ret = of_property_read_u32_index(np, "reg", ret, &addr);
>  	if (ret)
> -		return ret;
> +		goto release_fw;
>  
>  	if (addr == 0 || (addr >= 0x20 && addr <= 0x23)) {
>  		dev_err(tps->dev, "wrong patch address %u\n", addr);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto release_fw;
>  	}
>  
>  	bpms_data.addr = (u8)addr;
> -- 
> 2.34.1

-- 
heikki
