Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54A98076E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442599AbjLFRsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjLFRsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:48:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1619D122
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:48:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C504C433C7;
        Wed,  6 Dec 2023 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701884910;
        bh=b+oE6WsHAnybfoP/OnxbwTMatDU+zF/XLbHsR/CzzPg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DPSyVPjn+clKvT2z6WZzk3hL6nRgad2xpb/ZK4qhPoA0rRfFFTmK/PwBscyB9/GGI
         Lk28pcZ5K9zcqfLY+Y6/qbS/y/gnm29uMvwdr+50JMtRK2IMZ/RWSml3ByNiYs4rOV
         VwU+0vVMKXtKfBYId7Mx/cHkagMcExZrQG2/bn22btiRSo+rgNs8D7IGdkpWFXS35H
         Nn5FXqfzHolu7igyMSyYCyqXCvQLuz9vLCJ5IdYL7aS/ljsJwwgDKD5r43MEE26Ztk
         q+9UeKFiy4cLyjlk48+B6lPcARiUN7joF1QuGIdEE2VehctlPiydE9bmwf2XrH6X2u
         W0SoSDdMpIKhg==
Date:   Wed, 6 Dec 2023 17:48:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ceclan Dumitru <mitrutzceclan@gmail.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20231206174817.2bc4f39f@jic23-huawei>
In-Reply-To: <ZW9bVDLZl4-QLIbg@smile.fi.intel.com>
References: <20231205134223.17335-1-mitrutzceclan@gmail.com>
        <20231205134223.17335-2-mitrutzceclan@gmail.com>
        <CAHp75VeKhR5y4AB=L5VVSrm=13Ruw7e86m+K9m9t-LZg5puDow@mail.gmail.com>
        <e72085fd-3203-4166-afab-73707d27d174@gmail.com>
        <ZW9bVDLZl4-QLIbg@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2023 19:18:12 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Dec 05, 2023 at 06:12:18PM +0200, Ceclan Dumitru wrote:
> > On 12/5/23 17:28, Andy Shevchenko wrote:  
> > >> +               ref_label = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_INT_REF];
> > >> +
> > >> +               fwnode_property_read_string(child, "adi,reference-select",
> > >> +                                           &ref_label);
> > >> +               ref_sel = match_string(ad7173_ref_sel_str,
> > >> +                                      ARRAY_SIZE(ad7173_ref_sel_str), ref_label);
> > >> +               if (ref_sel < 0) {  
> > > Can we use fwnode_property_match_property_string()?  
> > 
> > fwnode_property_match_string() searches a given string in a device-tree
> > string array and returns the index. I do not think that this function
> > fits here as the DT attribute is a single string.  
> 
> I'm not talking about that. I mentioned different API call.
> 
> /**
>  * fwnode_property_match_property_string - find a property string value in an array and return index
>  * @fwnode: Firmware node to get the property of
>  * @propname: Name of the property holding the string value
>  * @array: String array to search in
>  * @n: Size of the @array
>  *
>  * Find a property string value in a given @array and if it is found return
>  * the index back.
>  *
>  * Return: index, starting from %0, if the string value was found in the @array (success),
>  *         %-ENOENT when the string value was not found in the @array,
>  *         %-EINVAL if given arguments are not valid,
>  *         %-ENODATA if the property does not have a value,
>  *         %-EPROTO or %-EILSEQ if the property is not a string,
>  *         %-ENXIO if no suitable firmware interface is present.
>  */
> 
Which is in the togreg branch of iio.git (was a patch from Andy that I've queued up)

Jonathan


