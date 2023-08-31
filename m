Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27F378E760
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbjHaHuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjHaHui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:50:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDDB1A3;
        Thu, 31 Aug 2023 00:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D229B81EB8;
        Thu, 31 Aug 2023 07:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3360DC433C8;
        Thu, 31 Aug 2023 07:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693468232;
        bh=yiK7ddQSuH1wu0GKPZBV9qs6zZpG0I5W+zci47S+VGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BF3d4Wat/r3WwYPaUzFqkwKC/673CvZo6KpL2VlaokCRWxLIxWJowpxCkFDjwUpks
         lvyTB0HYi2dioWVyg5xYIahUXWYE6ztzjQZnz/Ry0tAxXQrXp/u2a+zvciTydFM/TR
         AgVepKKQGu7D6Fcmgu86qsK9nJaK6+MI7N2+zrYw=
Date:   Thu, 31 Aug 2023 09:50:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] driver base: slience unused warning
Message-ID: <2023083124-gigolo-clutch-fae9@gregkh>
References: <20230831073654.1713710-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230831073654.1713710-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 03:36:55PM +0800, Su Hui wrote:
> Avoid unused warning with gcc and W=1 option.
> 
> drivers/base/module.c:36:6: error:
> variable ‘no_warn’ set but not used [-Werror=unused-but-set-variable]
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/base/module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/module.c b/drivers/base/module.c
> index 46ad4d636731..10494336d601 100644
> --- a/drivers/base/module.c
> +++ b/drivers/base/module.c
> @@ -33,7 +33,7 @@ static void module_create_drivers_dir(struct module_kobject *mk)
>  void module_add_driver(struct module *mod, struct device_driver *drv)
>  {
>  	char *driver_name;
> -	int no_warn;
> +	int __maybe_unused no_warn;

But no_warn is being used in this file, it's being set but not read
which is ok.  That's a real use, so this change really isn't correct,
sorry.

greg k-h
