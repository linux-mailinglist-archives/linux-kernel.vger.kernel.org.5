Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D559D80BB14
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjLJNca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJNc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:32:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D64CDF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 05:32:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47975C433C8;
        Sun, 10 Dec 2023 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702215154;
        bh=648SWHIYNJDT/+aiucrXnkcL7Mil/8x5gJTHL49sKWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pMDWKvtF+c+gtQLFvWS7ZcoEriiLmbqJDSvCnPeAuqmNmIs6jVsQrCrFItuDo+o0u
         XKsWQeK2qjQInSI+oT9SGX2cLtX8onqoETF2EldZuU1uWUOgjP3UF3Uvb2ztp0VXvr
         qlVlrvRGYbtkzSR6q5N+s/0710ZAiGWs1KywxDmJK9XnWlFkMaPh4T1hI8uGj2OIWO
         DrQmxNzCxuAtMjk9z4H/nertu0v9pHWH952DH3W3rkkUoKWVeI6yFK/Fcq08gbQUrk
         puPyFEDILYjoqEHwz0Gdw8CFwo11Act6UIVgJ/1GMEW4f3jl7mBhqPF+VnE3Q6Fnsc
         jodWG3KoIWGxg==
Date:   Sun, 10 Dec 2023 13:32:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: fix memleak in iio_device_register_sysfs
Message-ID: <20231210133228.5fd425ea@jic23-huawei>
In-Reply-To: <20231208073119.29283-1-dinghao.liu@zju.edu.cn>
References: <20231208073119.29283-1-dinghao.liu@zju.edu.cn>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Fri,  8 Dec 2023 15:31:19 +0800
Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> When iio_device_register_sysfs_group() fails, we should
> free iio_dev_opaque->chan_attr_group.attrs to prevent
> potential memleak.
> 
> Fixes: 32f171724e5c ("iio: core: rework iio device group creation")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Hi.

Looks good to me, but I'd like to leave this one on the list a little
longer to see if anyone else has comments.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index c77745b594bd..e6d3d07a4c83 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1581,10 +1581,13 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  	ret = iio_device_register_sysfs_group(indio_dev,
>  					      &iio_dev_opaque->chan_attr_group);
>  	if (ret)
> -		goto error_clear_attrs;
> +		goto error_free_chan_attrs;
>  
>  	return 0;
>  
> +error_free_chan_attrs:
> +	kfree(iio_dev_opaque->chan_attr_group.attrs);
> +	iio_dev_opaque->chan_attr_group.attrs = NULL;
>  error_clear_attrs:
>  	iio_free_chan_devattr_list(&iio_dev_opaque->channel_attr_list);
>  

