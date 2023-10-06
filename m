Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DD37BB518
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjJFK0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjJFK0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:26:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED15A9F;
        Fri,  6 Oct 2023 03:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696588006; x=1728124006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZVPvPZRxzRz0ksW6rc30qBzXzbjux6vaBQWDRBKTb50=;
  b=SlGvvXLOsV0gzkUcbF1OZAKECQ3AsZgkVCkXiX0424CTuTGbWD//7lN2
   pqSCzxq9u9mt8S7mkrTO4ei7PZKG4cdVu4mDNtjS11vDdHnITfrM2f5Uo
   vHiDHSruWl1YDCgXaUeiHUjfoPWY6j3qIP3Tw4ZAENoQfYXI4V9TXXVBQ
   50y9EmVNZfMaHYGnc4CH4OG8Xk+yfONK58wy3iFA5Gimp94JWnQvWtfFd
   VySLW0Si6F2E1ZOSvm8zwPjVz/rbyZrdzVl04Ix4Q8iafMJnq7HaSd+uP
   ok4Lu/MTHgIA/Ejk4xtdTmUs4fo6J77T4jy2c1Ve5VJj1/JdBZYm8rX/y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="450217627"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="450217627"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 03:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="895835929"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="895835929"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2023 03:25:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D92EE4F4; Fri,  6 Oct 2023 13:26:41 +0300 (EEST)
Date:   Fri, 6 Oct 2023 13:26:41 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1 2/2] pinctrl: cherryview: Simplify code with cleanup
 helpers
Message-ID: <20231006102641.GZ3208943@black.fi.intel.com>
References: <20231006094033.3082468-1-andriy.shevchenko@linux.intel.com>
 <20231006094033.3082468-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231006094033.3082468-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 12:40:33PM +0300, Andy Shevchenko wrote:
> @@ -1119,28 +1099,26 @@ static struct pinctrl_desc chv_pinctrl_desc = {
>  static int chv_gpio_get(struct gpio_chip *chip, unsigned int offset)
>  {
>  	struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
> -	unsigned long flags;
>  	u32 ctrl0, cfg;
>  
> -	raw_spin_lock_irqsave(&chv_lock, flags);
> -	ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
> -	raw_spin_unlock_irqrestore(&chv_lock, flags);
> +	scoped_guard(raw_spinlock_irqsave, &chv_lock)
> +		ctrl0 = chv_readl(pctrl, offset, CHV_PADCTRL0);
>  
>  	cfg = ctrl0 & CHV_PADCTRL0_GPIOCFG_MASK;
>  	cfg >>= CHV_PADCTRL0_GPIOCFG_SHIFT;
>  
>  	if (cfg == CHV_PADCTRL0_GPIOCFG_GPO)
>  		return !!(ctrl0 & CHV_PADCTRL0_GPIOTXSTATE);
> +

Unrelated whitespace change.

Otherwise looks good,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
