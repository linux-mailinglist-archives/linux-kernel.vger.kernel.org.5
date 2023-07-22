Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239F275DDCB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 19:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGVR2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 13:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGVR2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 13:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A922E1FD9;
        Sat, 22 Jul 2023 10:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AE7060B84;
        Sat, 22 Jul 2023 17:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBC8C433C8;
        Sat, 22 Jul 2023 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690046903;
        bh=KMzhmApW6/yEiEqXAq4WtbLu2E37EJmOyP5KNF9Fgkc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U7+W2UGroXM6a0lIlbSpzuqi2agLuVQNSPXHMN+9NTjffBBTDkprIhT52v0Yprfy/
         3mzJs5TuIzmTmpjPBnOZTI8fNOnhj2yM1bbTTWv+v8OxXCSEXrXjGrMWQ1DyQ44hpF
         AowRIiNjMVitL/H337Dw3tAXO9S817V+eDfszwfDcHLbXq7k20TmSj7wpE8Im1tXyi
         LOvM7m1zbnOvbez2hy6kicuDWtBmgh4ftN+UpG21oZbh21dU9+YxbfJJMwKIfFJeUs
         7XOrBj5BA2AZGL9LnBR0yQ+o5zxhGuPBSZQ9S/dCpPju6gxvkFW8Fl9IRlW46ZAM+6
         5Ym890fApw0PQ==
Date:   Sat, 22 Jul 2023 18:28:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 3/8] iio: core: Switch to krealloc_array()
Message-ID: <20230722182820.28fb3115@jic23-huawei>
In-Reply-To: <20230721170022.3461-4-andriy.shevchenko@linux.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
        <20230721170022.3461-4-andriy.shevchenko@linux.intel.com>
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

On Fri, 21 Jul 2023 20:00:17 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Let the krealloc_array() copy the original data and
> check for a multiplication overflow.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4e45740331ee..6e28c2a3d223 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1465,7 +1465,7 @@ int iio_device_register_sysfs_group(struct iio_dev *indio_dev,
>  	const struct attribute_group **new, **old = iio_dev_opaque->groups;
>  	unsigned int cnt = iio_dev_opaque->groupcounter;
>  
> -	new = krealloc(old, sizeof(*new) * (cnt + 2), GFP_KERNEL);
> +	new = krealloc_array(old, cnt + 2, sizeof(*new), GFP_KERNEL);
>  	if (!new)
>  		return -ENOMEM;
>  
> @@ -1483,13 +1483,13 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	int i, ret = 0, attrcount, attrn, attrcount_orig = 0;
> +	struct attribute **attrs, **attr, *clk = NULL;
>  	struct iio_dev_attr *p;
> -	struct attribute **attr, *clk = NULL;
>  
>  	/* First count elements in any existing group */
> -	if (indio_dev->info->attrs) {
> -		attr = indio_dev->info->attrs->attrs;
> -		while (*attr++ != NULL)
> +	attrs = indio_dev->info->attrs ? indio_dev->info->attrs->attrs : NULL;
> +	if (attrs) {
> +		for (attr = attrs; *attr; attr++)
>  			attrcount_orig++;
>  	}
>  	attrcount = attrcount_orig;
> @@ -1521,20 +1521,14 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  	if (clk)
>  		attrcount++;
>  
> +	/* Copy across original attributes, and point to original binary attributes */
>  	iio_dev_opaque->chan_attr_group.attrs =
> -		kcalloc(attrcount + 1,
> -			sizeof(iio_dev_opaque->chan_attr_group.attrs[0]),
> -			GFP_KERNEL);
> +		krealloc_array(attrs, attrcount + 1, sizeof(*attrs), GFP_KERNEL);


I'm a little lost, but isn't this realloc()ing attrs, which should be provided
by drivers as constant if it is set to indio_dev->info->attrs->attrs? 

That seems unlikely to work correctly, but I may well have lost track of the
flow and attrs points somewhere else at this point.  I guess it might work
as the realloc code will detect it can't resize that array.

Feels wrong approach however.



>  	if (iio_dev_opaque->chan_attr_group.attrs == NULL) {
>  		ret = -ENOMEM;
>  		goto error_clear_attrs;
>  	}
> -	/* Copy across original attributes, and point to original binary attributes */
>  	if (indio_dev->info->attrs) {
> -		memcpy(iio_dev_opaque->chan_attr_group.attrs,
> -		       indio_dev->info->attrs->attrs,
> -		       sizeof(iio_dev_opaque->chan_attr_group.attrs[0])
> -		       *attrcount_orig);
>  		iio_dev_opaque->chan_attr_group.is_visible =
>  			indio_dev->info->attrs->is_visible;
>  		iio_dev_opaque->chan_attr_group.bin_attrs =

