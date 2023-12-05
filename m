Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD696805C6B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346038AbjLERSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjLERSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:18:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E9C0;
        Tue,  5 Dec 2023 09:18:22 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="425085150"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="425085150"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:18:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841545261"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="841545261"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:18:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1rAZ3k-000000026Ns-2qE0;
        Tue, 05 Dec 2023 19:18:12 +0200
Date:   Tue, 5 Dec 2023 19:18:12 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <ZW9bVDLZl4-QLIbg@smile.fi.intel.com>
References: <20231205134223.17335-1-mitrutzceclan@gmail.com>
 <20231205134223.17335-2-mitrutzceclan@gmail.com>
 <CAHp75VeKhR5y4AB=L5VVSrm=13Ruw7e86m+K9m9t-LZg5puDow@mail.gmail.com>
 <e72085fd-3203-4166-afab-73707d27d174@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72085fd-3203-4166-afab-73707d27d174@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 06:12:18PM +0200, Ceclan Dumitru wrote:
> On 12/5/23 17:28, Andy Shevchenko wrote:
> >> +               ref_label = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_INT_REF];
> >> +
> >> +               fwnode_property_read_string(child, "adi,reference-select",
> >> +                                           &ref_label);
> >> +               ref_sel = match_string(ad7173_ref_sel_str,
> >> +                                      ARRAY_SIZE(ad7173_ref_sel_str), ref_label);
> >> +               if (ref_sel < 0) {
> > Can we use fwnode_property_match_property_string()?
> 
> fwnode_property_match_string() searches a given string in a device-tree
> string array and returns the index. I do not think that this function
> fits here as the DT attribute is a single string.

I'm not talking about that. I mentioned different API call.

/**
 * fwnode_property_match_property_string - find a property string value in an array and return index
 * @fwnode: Firmware node to get the property of
 * @propname: Name of the property holding the string value
 * @array: String array to search in
 * @n: Size of the @array
 *
 * Find a property string value in a given @array and if it is found return
 * the index back.
 *
 * Return: index, starting from %0, if the string value was found in the @array (success),
 *         %-ENOENT when the string value was not found in the @array,
 *         %-EINVAL if given arguments are not valid,
 *         %-ENODATA if the property does not have a value,
 *         %-EPROTO or %-EILSEQ if the property is not a string,
 *         %-ENXIO if no suitable firmware interface is present.
 */

-- 
With Best Regards,
Andy Shevchenko


