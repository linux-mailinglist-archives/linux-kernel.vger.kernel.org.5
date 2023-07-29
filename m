Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B205A767ED2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjG2LsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG2LsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:48:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB4D3580;
        Sat, 29 Jul 2023 04:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C006F60BA7;
        Sat, 29 Jul 2023 11:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42184C433C8;
        Sat, 29 Jul 2023 11:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690631297;
        bh=fOokmcypwHXt1MVBFRHJON7bgOFC378lqsy9wG3kr84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mQ02B9HNtqr3K8RLw+pz+hIlUHLEh3jCvMykxY6NiYN+rASPE71QOF62SxGa6FR2z
         qJx/o8mUs9BblyUig+tPS+D0q8rpK6Awmipljd48ku8Rm+Bue9Xrv9SwFQ943iqb1a
         YFqXH+g5/x0Jp/SGMlwu5LxSFo9PPZEftCS8DUiE34Uw0DRZg53wAVpq9npP5QBGNW
         ketx2gxu+VljOuow+1ym1miFZLxY2OXITR9fBHWHcLozwKHvKqmkieubqRdyMutTJH
         4XRxbpst5HX4GmZPzCgCfBi6Xoed96SGbTTqLYTHnU/F4hAzE8bFWBexNhejNHBUGm
         0zFrepheifHFA==
Date:   Sat, 29 Jul 2023 12:48:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 3/4] iio: core: Switch to krealloc_array()
Message-ID: <20230729124822.578d14cc@jic23-huawei>
In-Reply-To: <20230724110204.46285-4-andriy.shevchenko@linux.intel.com>
References: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
        <20230724110204.46285-4-andriy.shevchenko@linux.intel.com>
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

On Mon, 24 Jul 2023 14:02:03 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Let the krealloc_array() copy the original data and
> check for a multiplication overflow.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 118ca6b59504..13d6b6ac5ccf 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1474,7 +1474,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
>  	const struct attribute_group **new, **old = iio_dev_opaque->groups;
>  	unsigned int cnt = iio_dev_opaque->groupcounter;
>  
> -	new = krealloc(old, sizeof(*new) * (cnt + 2), GFP_KERNEL);
> +	new = krealloc_array(old, cnt + 2, sizeof(*new), GFP_KERNEL);
>  	if (!new)
>  		return -ENOMEM;
>  

