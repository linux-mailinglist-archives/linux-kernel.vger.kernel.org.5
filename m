Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231ED7CD58B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjJRHjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJRHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:39:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8C3C6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:39:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A6FC433C7;
        Wed, 18 Oct 2023 07:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697614769;
        bh=DOT4lFyDPmpnV7LNhAX7vgMrRhFylHUDm7eC6XlMQpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKJRBP7Q5AOj9uas6TiNVEJ9C23ujJ3Kex45bw9Z6aFY4gjGyQhNR0H4MT3MsV5Sy
         tmiV7HymHdsavP/YUqVOk966+Onn9lOXY0D90rRxPzdcDkUsB+a03nK0NJAw6S0bji
         uwqHVfm2PDZET7joHbpeaf66KjSQzSO8tnU9Ko9w=
Date:   Wed, 18 Oct 2023 09:39:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     gustavo@embeddedor.com, outreachy@lists.linux.dev,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: replace strcpy with strscpy
Message-ID: <2023101844-phoniness-gory-635a@gregkh>
References: <ZS+Jb2rQWbOIIQ42@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS+Jb2rQWbOIIQ42@lab-ubuntu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:29:51AM +0300, Calvince Otieno wrote:
> Checkpatch suggests using strscpy() instead of strncpy().
> 
> The advantages of strscpy() are that it always adds a NUL terminator
> and prevents read overflows if the source string is not properly
> terminated. One potential disadvantage is that it doesn't zero pad the
> string like strncpy() does.
> 
> In this code, strscpy() and strncpy() are equivalent and do not affect
> runtime behavior. strscpy() simply copies the known string value of the
> variable driver_name into the fake_bridge->name variable, which also
> has a fixed size.
> 
> While using strscpy() does not address any bugs, it is considered a better
> practice and aligns with checkpatch recommendations.
> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---
>  drivers/staging/vme_user/vme_fake.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
> index 0e02c194298d..09b05861017a 100644
> --- a/drivers/staging/vme_user/vme_fake.c
> +++ b/drivers/staging/vme_user/vme_fake.c
> @@ -67,6 +67,7 @@ struct fake_driver {
>  	unsigned long long lm_base;
>  	u32 lm_aspace;
>  	u32 lm_cycle;
> +
>  	void (*lm_callback[4])(void *);
>  	void *lm_data[4];

Why did you make this extra line change?

>  	struct tasklet_struct int_tasklet;
> @@ -1091,7 +1092,7 @@ static int __init fake_init(void)
>  	tasklet_init(&fake_device->int_tasklet, fake_VIRQ_tasklet,
>  		     (unsigned long)fake_bridge);
>  
> -	strcpy(fake_bridge->name, driver_name);
> +	strscpy(fake_bridge->name, driver_name, sizeof(fake_bridge->name))

Are you sure this change is identical?  You need to document how you
have proved that.

thanks,

greg k-h
