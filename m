Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4D67EDFC4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjKPL03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjKPL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:26:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA0C85
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:26:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B47BC433C7;
        Thu, 16 Nov 2023 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700133984;
        bh=91H4/KMPMkjTV+q/X6xZwFVszTpe0ikL12Gouw7eKGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKdL9HlGEpg2+x2JaPqMsP65qQ2zD0VpHPw/eWcBXd/31rSP0TT56j7WPO3yL31cI
         b4Gz5gT93Gy2DKQ2aw9u5kjKTrUfY9LkaoiL57bTne9851WEnssHXqclvRLTG1vZyJ
         h31dHdthwKqIKCmdIg0oy9snapn7Zdb3g7TZaY09AAdFGS9yj/F2XMV6pcm4//vGuv
         R+WmH/3Ne+Vx2DPowxrqJs6306RnsEUvKiakJgpia2dx/YIZvIxQL0a9EIqa1TGBxp
         p+OV10sluVANNKwC+M1k4jVaJyW0O8AOCUg5n4abq8p8QuM4enjY3yfVi29x4aZy55
         Do9ybUoDd8riA==
Date:   Thu, 16 Nov 2023 16:56:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     kishon@kernel.org, u.kleine-koenig@pengutronix.de,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] phy: mapphone-mdm6600: fix an error code problem in
 phy_mdm6600_device_power_on
Message-ID: <ZVX8W8+cM0U4j6Wh@matsya>
References: <20231020091413.205743-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020091413.205743-1-suhui@nfschina.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-23, 17:14, Su Hui wrote:
> When wait_for_completion_timeout() failed, error is assigned
> '-ETIMEDOUT'. But this error code is never used. Return '-ETIMEDOUT'
> directly to fix this problem.

Where is patch 2/2?
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> 
> I'm not sure that return directly is true or not, maybe need some 
> process before return directly.
> 
>  drivers/phy/motorola/phy-mapphone-mdm6600.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> index 1d567604b650..e84e3390bff0 100644
> --- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
> +++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> @@ -421,8 +421,8 @@ static int phy_mdm6600_device_power_on(struct phy_mdm6600 *ddata)
>  			dev_info(ddata->dev, "Powered up OK\n");
>  	} else {
>  		ddata->enabled = false;
> -		error = -ETIMEDOUT;
>  		dev_err(ddata->dev, "Timed out powering up\n");
> +		return -ETIMEDOUT;

>  	}
>  
>  	/* Reconfigure mode1 GPIO as input for OOB wake */
> -- 
> 2.30.2

-- 
~Vinod
