Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70C175E0A3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjGWJOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWJOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888A511A;
        Sun, 23 Jul 2023 02:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C32760C6E;
        Sun, 23 Jul 2023 09:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC31C433C8;
        Sun, 23 Jul 2023 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690103659;
        bh=+HiYmb3h6MjhbT0M83KKrszck2MUxAywWJQFxYWzduY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u/vBOnMYY9aGHrBSD4Y2xHMZyluT+RndYR5GuYg353tsVQ/PZF08s4Ds2c1QppbUL
         xmzk+zi5xtAi9YNEawzqGEqvy8CRxlhwRuRieSoU4T7xsDgyEg8STaZoPhxm1qjktO
         azMZQoHgtLLJlSlBy0P+3jvSJx+LHC/LxS0GNHWMq+fxnDFjMX/T0QylG4FMkIvkL3
         d2yhSIXDEb/UZbvvzEPeSrWqFicf5EHMExjFgOvCmiiOXMEN17pQNxomOmR94HzhVb
         32OlwySTBZfFxHmbgyzvFxlo2KnyHqMe//1WwuY60d1U/pUlXzJx89yvvJWGPS6SqJ
         UjqZFvHL3lZHw==
Date:   Sun, 23 Jul 2023 10:14:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 4/8] iio: core: Use min() instead of min_t() to make
 code more robust
Message-ID: <20230723101416.398589b3@jic23-huawei>
In-Reply-To: <20230721170022.3461-5-andriy.shevchenko@linux.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
        <20230721170022.3461-5-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 20:00:18 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> min() has strict type checking and preferred over min_t() for
> unsigned types to avoid overflow. Here it's unclear why min_t()
> was chosen since both variables are of the same type. In any
> case update to use min().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to give it a quick sanity check.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 6e28c2a3d223..78cc67efa490 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -389,7 +389,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
>  	char buf[80];
>  	int ret;
>  
> -	count = min_t(size_t, count, (sizeof(buf)-1));
> +	count = min(count, sizeof(buf) - 1);
>  	if (copy_from_user(buf, userbuf, count))
>  		return -EFAULT;
>  

