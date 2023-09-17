Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89447A3688
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 18:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjIQQY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 12:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjIQQYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 12:24:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BC9131
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 09:24:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD511C433C7;
        Sun, 17 Sep 2023 16:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694967882;
        bh=x/KCXyBRbWjiPXZK4Pl2NG7NFg623HRFzxPQK131EHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVkvnBgvVX3wnfIA/CgdWTBsIJM22hply72nxSabdldgmRZZQ24OmH5eiKxifJEz0
         3V3kNZGVfVqaopFdRfrq1IoBPO+tn5SBzwSY5ZVVy5i2tg+3ww+hU1Lky1hfFCien/
         q2AZGf7ZyMifimFQz3wY+JmHsFzCHTls7t/e7nSk=
Date:   Sun, 17 Sep 2023 18:24:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vme_user: Replace strcpy with strscpy
Message-ID: <2023091756-pastel-ipad-6cd7@gregkh>
References: <20230917154302.913956-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917154302.913956-1-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 05:43:02PM +0200, Jonathan Bergh wrote:
> Replace strcpy with strscpy as preferred by checkpatch in vme_fake.c to
> prevent warnings.
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/staging/vme_user/vme_fake.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
> index 9bcb89a84d53..0cf5700e151f 100644
> --- a/drivers/staging/vme_user/vme_fake.c
> +++ b/drivers/staging/vme_user/vme_fake.c
> @@ -1093,7 +1093,7 @@ static int __init fake_init(void)
>  	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
>  			(unsigned long) fake_bridge);
>  
> -	strcpy(fake_bridge->name, driver_name);
> +	strscpy(fake_bridge->name, driver_name, sizeof(fake_bridge->name));

If it were this easy, we would have swept the tree and done so, right?
Are you sure this is correct?  If so, please document exactly why it is
correct in the changelog text when you resend this.

thanks,

greg k-h
