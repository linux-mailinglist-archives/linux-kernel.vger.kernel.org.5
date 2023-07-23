Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910D575E0B5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGWJXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGWJXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:23:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A01A1;
        Sun, 23 Jul 2023 02:23:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DD8B60C70;
        Sun, 23 Jul 2023 09:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2802BC433CA;
        Sun, 23 Jul 2023 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690104215;
        bh=mAwywMcPI4ambiKlJ8RwQkwJADEyYv0oTSApNmrgDhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XVGudBlN2TPPnvRg8HBMle9q1tlfuLKgFDl4bGWeWWzRoo3FKdPZ+F6Y7k+gGdFH2
         EnZYNyXQLEF7esKEywXa993fc8y8w+/cjDf+xL6wRvyikUItLSWbXrROM1imOlfhDb
         +RolmxObbTqaLHgxd8f40rq5xpjdw6ura7rlcBGTfJVCJqscQJaqN2D2Pkyto+Rfq5
         KQjkFLs0gUEQcZc1hMAgvwyr81o7tcly4KMYEIITxBcO1IpsN4SjjGOPYw0t5DTCxp
         Uhy5rXGJKcPEeXBNn8vKWvvCOz6taxop7e4VuGVrKAMRhfFeuwJb5Rxu+AKbCPhPUv
         7M7fsdCHm+tPg==
Date:   Sun, 23 Jul 2023 10:23:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 7/8] iio: core: Move initcalls closer to the
 respective calls
Message-ID: <20230723102335.6df07e6d@jic23-huawei>
In-Reply-To: <20230721170022.3461-8-andriy.shevchenko@linux.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
        <20230721170022.3461-8-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 20:00:21 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Move subsys_initcall() and module_exit() closer to the respective calls.

Why? For this particular set of macros I can see advantages to them being
near the code and to them being in a fairly predictable location (end of
file).

I think the patch description should make the why argument. 

Jonathan


> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a9b9804097ab..5c9c68d69fc6 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -354,6 +354,7 @@ static int __init iio_init(void)
>  error_nothing:
>  	return ret;
>  }
> +subsys_initcall(iio_init);
>  
>  static void __exit iio_exit(void)
>  {
> @@ -362,6 +363,7 @@ static void __exit iio_exit(void)
>  	bus_unregister(&iio_bus_type);
>  	debugfs_remove(iio_debugfs_dentry);
>  }
> +module_exit(iio_exit);
>  
>  #if defined(CONFIG_DEBUG_FS)
>  static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
> @@ -2118,9 +2120,6 @@ int iio_device_get_current_mode(struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL_GPL(iio_device_get_current_mode);
>  
> -subsys_initcall(iio_init);
> -module_exit(iio_exit);
> -
>  MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
>  MODULE_DESCRIPTION("Industrial I/O core");
>  MODULE_LICENSE("GPL");

