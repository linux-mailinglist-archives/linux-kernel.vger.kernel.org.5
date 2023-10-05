Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9F17BA3EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbjJEQAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbjJEP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:59:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1950B59E4;
        Thu,  5 Oct 2023 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696519195; x=1728055195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rHv1yZ3QlkVxPZXwJjb2AlmfazUnbbUhKxhZTvKFYsw=;
  b=bfB5r88Q3jWfIWKDXgq2nsB4B1n6slDoQDronDZAleA4utKiVc3pAMHc
   Fb4qrqW7MzH+uHR/PEV5sMKgJL4rQb3PCsUfnNQkDTEQ5iRPEJQdS4tZ7
   Vw7UIaNnEaRTbyWqHzEsuQ/poTUkj+tIaQrfpcNPnG8quXxUkU/abre05
   j/Lrq99CynT0/GDXUuTrVNTw4sV8JzzdIHGY8BQCn+ifirP+bN0TOptRa
   EgyZZABrN2WjJid9gU+76fEr7vRZpTJFx0CypY7KL00TrrUl3+NVOnkCX
   gkmcQ3nN7xhjcr+x58tVYoCi5XeeEFh2nRUiofmwyvJLP4Si7KNjMDr49
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="386358273"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="386358273"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 08:19:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875583433"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875583433"
Received: from yklum-mobl.gar.corp.intel.com (HELO intel.com) ([10.215.244.7])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 08:19:46 -0700
Date:   Thu, 5 Oct 2023 17:19:38 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v2 1/1] serial: 8250_bcm7271: Use
 devm_clk_get_optional_enabled()
Message-ID: <ZR7UCtRKrycMD5d5@ashyti-mobl2.lan>
References: <20231005124550.3607234-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005124550.3607234-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

[...]

> -	baud_mux_clk = devm_clk_get(dev, "sw_baud");
> -	if (IS_ERR(baud_mux_clk)) {
> -		if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER) {
> -			ret = -EPROBE_DEFER;
> -			goto release_dma;
> -		}
> -		dev_dbg(dev, "BAUD MUX clock not specified\n");
> -	} else {
> +	baud_mux_clk = devm_clk_get_optional_enabled(dev, "sw_baud");
> +	ret = PTR_ERR_OR_ZERO(baud_mux_clk);
> +	if (ret)
> +		goto release_dma;
> +	if (baud_mux_clk) {
>  		dev_dbg(dev, "BAUD MUX clock found\n");
> -		ret = clk_prepare_enable(baud_mux_clk);
> -		if (ret)
> -			goto release_dma;
> +
>  		priv->baud_mux_clk = baud_mux_clk;
>  		init_real_clk_rates(dev, priv);
>  		clk_rate = priv->default_mux_rate;
> +	} else {
> +		dev_dbg(dev, "BAUD MUX clock not specified\n");

little behavioral change here, but I don't think this is a
problem.

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com> 

Thanks,
Andi
