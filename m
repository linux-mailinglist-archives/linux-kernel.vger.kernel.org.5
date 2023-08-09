Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24527766CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjHIR7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjHIR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:59:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225AA1736;
        Wed,  9 Aug 2023 10:59:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB04864362;
        Wed,  9 Aug 2023 17:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F65C433C7;
        Wed,  9 Aug 2023 17:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691603989;
        bh=212JSj0ldyl9eOSzdc/UjKowkgzQsvjsWBwyjn429qA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CJ2iXFR63LOoxYi9NIzlKOPV00krK0s1vc1TBUdf5I9/j5yCNYTY27/jzd0BOoKok
         Sp6R6/bJDIs36lsgjtfFBPiTwtljOVkTAlkQfT0jbOYmeP6MGDFHsKCewMaDKMA5p+
         cI76Qi4mToukDI2xzn77qgZO9p2fZECGOuI+YN5R6RtwGvk6R1zoGSPvb1Y0DLCzQn
         dqSs2zIpCd4TrF+apU+qJ7YlidXgMKtpipZjONpCqSiGWAB2fiA4XwCiLF6UogDkha
         0YC29wuUDVH0Gg6j5S6dpVMHHSH3RHxww6a8WfylKdsZ42MDgTzBGj7QqHhKe5/MRe
         uB1Sn8s9IT/XA==
Date:   Wed, 9 Aug 2023 18:59:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 2/6] device property: Add
 fwnode_property_match_property_string()
Message-ID: <20230809185944.1ae78e34@jic23-huawei>
In-Reply-To: <20230808162800.61651-3-andriy.shevchenko@linux.intel.com>
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
        <20230808162800.61651-3-andriy.shevchenko@linux.intel.com>
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

On Tue,  8 Aug 2023 19:27:56 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Sometimes the users want to match the single value string property
> against an array of predefined strings. Create a helper for them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/property.c  | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/property.h | 12 ++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 3bb9505f1631..8f8e2a6816bc 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -498,6 +498,41 @@ int fwnode_property_match_string(const struct fwnode_handle *fwnode,
>  }
>  EXPORT_SYMBOL_GPL(fwnode_property_match_string);
>  
> +/**
> + * fwnode_property_match_property_string - find a property string value in an array and return index
> + * @fwnode: Firmware node to get the property of
> + * @propname: Name of the property holding the string value
> + * @array: String array to search in
> + * @n: Size of the @array
> + *
> + * Find a property string value in a given @array and if it is found return
> + * the index back.
> + *
> + * Return: index, starting from %0, if the string value was found in the @array (success),
> + *	   %-ENOENT when the string value was not found in the @array,
> + *	   %-EINVAL if given arguments are not valid,
> + *	   %-ENODATA if the property does not have a value,
> + *	   %-EPROTO or %-EILSEQ if the property is not a string,
> + *	   %-ENXIO if no suitable firmware interface is present.
> + */
> +int fwnode_property_match_property_string(const struct fwnode_handle *fwnode,
> +	const char *propname, const char * const *array, size_t n)

Hi Andy,

Whilst I'm not 100% sold on adding ever increasing complexity to what we
match, this one feels like a common enough thing to be worth providing.

Looking at the usecases I wonder if it would be better to pass in
an unsigned int *ret which is only updated on a match?

That way the common properties approach of not checking the return value
if we have an optional property would apply.

e.g. patch 3 would end up with a block that looks like:

	st->input_mode = ADMV1014_IQ_MODE;
	device_property_match_property_string(&spi->dev, "adi,input-mode",
					      input_mode_names,
					      ARRAY_SIZE(input_mode_names),
					      &st->input_mode);

Only neat and tidy if the thing being optionally read into is an unsigned int
though (otherwise you still need a local variable)

Jonathan


> +{
> +	const char *string;
> +	int ret;
> +
> +	ret = fwnode_property_read_string(fwnode, propname, &string);
> +	if (ret)
> +		return ret;
> +
> +	ret = match_string(array, n, string);
> +	if (ret < 0)
> +		ret = -ENOENT;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_property_match_property_string);
> +
>  /**
>   * fwnode_property_get_reference_args() - Find a reference with arguments
>   * @fwnode:	Firmware node where to look for the reference
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 8c3c6685a2ae..11f3ad6814f2 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -97,6 +97,18 @@ static inline bool device_is_compatible(const struct device *dev, const char *co
>  	return fwnode_device_is_compatible(dev_fwnode(dev), compat);
>  }
>  
> +int fwnode_property_match_property_string(const struct fwnode_handle *fwnode,
> +					  const char *propname,
> +					  const char * const *array, size_t n);
> +
> +static inline
> +int device_property_match_property_string(const struct device *dev,
> +					  const char *propname,
> +					  const char * const *array, size_t n)
> +{
> +	return fwnode_property_match_property_string(dev_fwnode(dev), propname, array, n);
> +}
> +
>  int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
>  				       const char *prop, const char *nargs_prop,
>  				       unsigned int nargs, unsigned int index,

