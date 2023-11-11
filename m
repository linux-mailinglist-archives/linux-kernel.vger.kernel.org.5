Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF8C7E8A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 11:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjKKKpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 05:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjKKKpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 05:45:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6463AA6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 02:45:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01504C433C7;
        Sat, 11 Nov 2023 10:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699699520;
        bh=7QU9G6Pt0jobK5bptvySxSMCA2aLwKQOGddcVU+8egc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCxthHA8jUEej9Oo3FBMYJ3kt6G0T3Kq5fz4PKwPqLSij2agcf6zZojrd7bx4owJ/
         qt4/fG5YAvkQkG3ygL9Ye3O0OoROV4nlLAxFtOqWWh9QOs10AEHTJ3/pjJb4mfdG0i
         a8fl5ThCQAqozqwuWswYg5kJZe2jPwrJz94rgB+RMn8Ng5q8YFHHK3LzfP1VEuog/Z
         4v/oVTWIyqOGQYMMbW0/O/NYbQHO0mmt0mJloVGG7VNEQHFJfgtpigy9MuCMidaOkv
         EZC64C+T5BJnMEN5WV36bUClEvJGQxsgxedqJD5RiQL7j+jn27Wb/jUBKI6LDu0gi6
         Wt/+A30ao3y7w==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1r1lUK-0001L6-1z;
        Sat, 11 Nov 2023 11:45:16 +0100
Date:   Sat, 11 Nov 2023 11:45:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: dwc3: add device put function to decrement the
 ref-counted reference
Message-ID: <ZU9bPMHqz7Gj4rHj@hovoldconsulting.com>
References: <20231107091252.11783-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107091252.11783-1-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 05:12:51PM +0800, Stanley Chang wrote:
> When the function exits, the count should be decremented via
> platform_device_put and of_node_put.

This isn't really a self-contained commit message (and your use of
'count' is too vague). You're also changing two functions in two
different ways here.

> Fixes: 34c200483569 ("usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer driver")
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
>  drivers/usb/dwc3/dwc3-rtk.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-rtk.c b/drivers/usb/dwc3/dwc3-rtk.c
> index 590028e8fdcb..9d6f2a8bd6ce 100644
> --- a/drivers/usb/dwc3/dwc3-rtk.c
> +++ b/drivers/usb/dwc3/dwc3-rtk.c
> @@ -187,6 +187,7 @@ static enum usb_device_speed __get_dwc3_maximum_speed(struct device_node *np)
>  
>  	ret = match_string(speed_names, ARRAY_SIZE(speed_names), maximum_speed);
>  
> +	of_node_put(dwc3_np);

You're still leaking a reference in the of_property_read_string() error
path just above.

>  	return (ret < 0) ? USB_SPEED_UNKNOWN : ret;
>  }
>  
> @@ -339,6 +340,8 @@ static int dwc3_rtk_probe_dwc3_core(struct dwc3_rtk *rtk)
>  
>  	switch_usb2_role(rtk, rtk->cur_role);
>  
> +	platform_device_put(dwc3_pdev);
> +	of_node_put(dwc3_node);

Please keep the new line before return for readability.

>  	return 0;
>  
>  err_pdev_put:

Johan
