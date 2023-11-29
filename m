Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32807FD8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjK2Nvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjK2Nvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:51:51 -0500
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28B7CE;
        Wed, 29 Nov 2023 05:51:57 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.subdimension.ro (Postfix) with ESMTPSA id 69B1828EE6F;
        Wed, 29 Nov 2023 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
        s=skycaves; t=1701265915;
        bh=uvNPKH/HkMehqSkicatMT25AWwf9jXqH853dzUzJVoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FNI4lN1jDG9U/Ou85SXKAxLh+wUsuBGK+zDp14jamvc8hzBWfFBVGCLwH+dQfK3QM
         w48RmsNERSN3A4drgjPrKsZqebogbEp1XiEUOaA07kgr1KW0O4aRHhNYOrvWNY5tsJ
         ctbLeJN9J+m2SyWBLmXOrAUVA5Ikn/wlVv0WKxMY=
Date:   Wed, 29 Nov 2023 15:51:54 +0200
From:   Petre Rodan <petre.rodan@subdimension.ro>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v5 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <ZWdB-vU2MAptRk8d@sunspire>
References: <20231129070452.1521-1-petre.rodan@subdimension.ro>
 <ZWcUPkzfGqxYsysp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWcUPkzfGqxYsysp@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

thank you for the code review.

On Wed, Nov 29, 2023 at 12:36:46PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 29, 2023 at 09:04:49AM +0200, Petre Rodan wrote:
> ...
> 
> > +		for (index = 0; index < ARRAY_SIZE(hsc_range_config); index++) {
> > +			if (strncmp(hsc_range_config[index].triplet,
> > +				    triplet,
> > +				    HSC_PRESSURE_TRIPLET_LEN - 1) == 0) {
> > +				hsc->pmin = hsc_range_config[index].pmin;
> > +				hsc->pmax = hsc_range_config[index].pmax;
> > +				found = 1;
> > +				break;
> > +			}
> > +		}
> > +		if (hsc->pmin == hsc->pmax || !found)
> > +			return dev_err_probe(dev, -EINVAL,
> > +				"honeywell,pressure-triplet is invalid\n");
> 
> This one is important. I think I told already twice that this is NIH
> device_property_match_property_string(). Please, use this API directly.

let me see if we are on the same frequency.

you told me to use match_string/sysfs_match_string.
using any of those assume having the strings in an array, which means I have to
 clutter the code with 242 extra lines in order to split up hsc_range_config:

enum hsc_variants {
    HSC001BA = 0,
    HSC1_6BA = 1,
    [ .. 115 lines skipped ]
    HSC150PG = 117,
}

static const char * const hsc_triplet_variants[] = {
	[HSC001BA] = "001BA",
	[HSC1_6BA] = "1.6BA",
	[ .. 115 lines skipped ]
	[HSC150PG] = "150PG",
};

and change my structure to

static const struct hsc_range_config hsc_range_config[] = {
	[HSC001BA] = { .pmin = 0, .pmax = 100000 },
	[ .. 117 lines skipped ]
};

just to have the privilege of using match_string() on hsc_triplet_variants.
now, which is worse for maintenance? a handful of lines of code that do a
loop of strncmp or the clutter depicted above?

I can go either way, but I want to make sure you see where this leads.

> > +#ifndef _HSC030PA_H
> > +#define _HSC030PA_H
> 
> > +#include <linux/mutex.h>
> 
> > +#include <linux/property.h>
> 
> Is not used here.

ok.
since we are here, can you please tell me how is mutex.h used outside of hsc030pa.c where it was included previously?

cheers,
peter

-- 
petre rodan
