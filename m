Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732A078E7AB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbjHaILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjHaILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:11:32 -0400
X-Greylist: delayed 61702 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Aug 2023 01:11:08 PDT
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1EFE6B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8AD9BCE2027
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B099C433CA;
        Thu, 31 Aug 2023 08:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693469436;
        bh=YAI6qYnjH3vfvo54KtkH4Odr45kzDIg5aSgSmiETKbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oNVzvrzTHz99ZAPhxJJIuKG7qZKcm1Vdu2usOoXJCrJRzp97c7ciJph1P8vVd6o9X
         /DLtinpdWCX+TSmMaezw6Jtj01U7QB0UetvkIeX5D2NOWrqIuA/Bh8ZtTo2lvxL1Q+
         LKtNaQmFWRudits9t2tHc61KjKeUpgSYMgu3wbkA=
Date:   Thu, 31 Aug 2023 10:10:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Yang <yiyang13@huawei.com>
Cc:     akpm@linux-foundation.org, machel@vivo.com, mhiramat@kernel.org,
        ast@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: error-inject: fix error check for
 debugfs_create_file()
Message-ID: <2023083151-random-karma-fa97@gregkh>
References: <20230831075653.238562-1-yiyang13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831075653.238562-1-yiyang13@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 03:56:53PM +0800, Yi Yang wrote:
> The debugfs_create_file() function returns error pointers, it never
> returns NULL, we need to check the return value correctly to avoid
> debugfs_remove() is not called.
> 
> Fixes: 540adea3809f ("error-injection: Separate error-injection from kprobe")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
>  lib/error-inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/error-inject.c b/lib/error-inject.c
> index 887acd9a6ea6..8bcdea5229eb 100644
> --- a/lib/error-inject.c
> +++ b/lib/error-inject.c
> @@ -219,7 +219,7 @@ static int __init ei_debugfs_init(void)
>  	dir = debugfs_create_dir("error_injection", NULL);
>  
>  	file = debugfs_create_file("list", 0444, dir, NULL, &ei_fops);
> -	if (!file) {
> +	if (IS_ERR(file)) {

As it is obvious this check has never failed, please just don't check
this at all, it's fine to never check the return value of this function.

thanks,

greg k-h
