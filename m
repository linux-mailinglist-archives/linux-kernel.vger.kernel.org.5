Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A746C799E7E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 15:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbjIJNYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjIJNYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 09:24:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE05919C;
        Sun, 10 Sep 2023 06:23:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF705C433C8;
        Sun, 10 Sep 2023 13:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694352238;
        bh=12JqMZHClo+KlBJTFlRRKcJ0JuLAxCgVjgJpVqsCm4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Clf/DsiOnm7APNEVzCSVQnRNKn9T1MW6axyzn9beM+/M1sxZQKZDWVu/e10Mnx29F
         y+/6LcQpulvbIU96PoQENGTvFF1XFl9cHKG8O6y8qAlcGeYbZyzk04ZGWtXAIngwHs
         AAHgOTXScdcN/VMbkTOc0NGSvO8d8Ugpk9FQaTABowvi1W1Hk4LICvbN24j2tKdE3I
         4DOU1TnsdaVUQq1s13duFPlXMuUf+dTD13tpH43HlpWn6VBKDIG/zKg1O+A744FYXQ
         IlbRNuvBM4+IJPUZ2kelq6FUsNcMGSzl2BhjE04Kl4tiXKy+YS1M7q96XktGz6ovwu
         tirRqOAESz4Zw==
Date:   Sun, 10 Sep 2023 14:23:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 06/12] iio: core: Use min() instead of
 min_t() to make code more robust
Message-ID: <20230910142354.28bd2c8d@jic23-huawei>
In-Reply-To: <20230909004115.3581195-6-sashal@kernel.org>
References: <20230909004115.3581195-1-sashal@kernel.org>
        <20230909004115.3581195-6-sashal@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Sep 2023 20:41:09 -0400
Sasha Levin <sashal@kernel.org> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [ Upstream commit cb1d17535061ca295903f97f5cb0af9db719c02c ]
> 
> min() has strict type checking and preferred over min_t() for
> unsigned types to avoid overflow. Here it's unclear why min_t()
> was chosen since both variables are of the same type. In any
> case update to use min().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Link: https://lore.kernel.org/r/20230721170022.3461-5-andriy.shevchenko@linux.intel.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Whilst this was a good cleanup set from Andy, I don't think there was
any suggestion that it actually fixed any bugs?

As such I'd consider these (harmless) noise for stable.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 97b7266ee0ffa..12d73ebcadfa3 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -328,7 +328,7 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
>  	char buf[80];
>  	int ret;
>  
> -	count = min_t(size_t, count, (sizeof(buf)-1));
> +	count = min(count, sizeof(buf) - 1);
>  	if (copy_from_user(buf, userbuf, count))
>  		return -EFAULT;
>  

