Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33347D0654
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346856AbjJTB4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346840AbjJTB4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:56:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37FBD52
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A437AC433C8;
        Fri, 20 Oct 2023 01:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697766957;
        bh=TfoVQ04V/DyH8idpHC0lkA7yHOCLnTARSYc6R2lyKg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIm4hX1qfoL/lUHYOi8BOgAZAnZLnfHF6RPhX/EoK7TJSahGp8oBq/ONeFLaHjInK
         WNAwRoxTo3IQEMqKklwVL8j2MdBo8zZ3p1o8WetIbc8v6p7U2KFowsojHO/LTe9QJO
         pLwZ24G6YPugyDyLOnsSM76+TlLhS3HS2yJcoC2EdyExNz334wSYAICYxkYOXM0KDw
         Ek5u0vEFY6+kYxaHw4wU45Sm4dNH9eHlWNz6dwuLyVELheqJ4m4ff9XDumhuGtUSLo
         en5DXKhlip/aIZZH8LqqkeyXAfWRtu54Yk7OpRKxrcXOCxigZebX/VbdLW4VSBajQV
         mrQXaD3OAdxyQ==
Date:   Fri, 20 Oct 2023 09:55:47 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: Fix unused ci_hdrc_usb2_of_match warning
 for !CONFIG_OF
Message-ID: <20231020015547.GA1119400@nchen-desktop>
References: <20231019183015.841460-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019183015.841460-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-19 13:30:15, Rob Herring wrote:
> Commit 14485de431b0 ("usb: Use device_get_match_data()") dropped the
> unconditional use of ci_hdrc_usb2_of_match resulting in this warning:
> 
> drivers/usb/chipidea/ci_hdrc_usb2.c:41:34: warning: unused variable 'ci_hdrc_usb2_of_match' [-Wunused-const-variable]
> 
> The fix is to drop of_match_ptr() which is not necessary because DT is
> always used for this driver.
> 
> Fixes: 14485de431b0 ("usb: Use device_get_match_data()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310131627.M43j234A-lkp@intel.com/
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Peter Chen <peter.chen@kernel.org>

> ---
>  drivers/usb/chipidea/ci_hdrc_usb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
> index 180a632dd7ba..97379f653b06 100644
> --- a/drivers/usb/chipidea/ci_hdrc_usb2.c
> +++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
> @@ -119,7 +119,7 @@ static struct platform_driver ci_hdrc_usb2_driver = {
>  	.remove_new = ci_hdrc_usb2_remove,
>  	.driver	= {
>  		.name		= "chipidea-usb2",
> -		.of_match_table	= of_match_ptr(ci_hdrc_usb2_of_match),
> +		.of_match_table	= ci_hdrc_usb2_of_match,
>  	},
>  };
>  module_platform_driver(ci_hdrc_usb2_driver);
> -- 
> 2.42.0
> 

-- 

Thanks,
Peter Chen
