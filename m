Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4B57EFB49
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjKQWVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQWVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:21:51 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59494D4D;
        Fri, 17 Nov 2023 14:21:47 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0457960002;
        Fri, 17 Nov 2023 22:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700259705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+XRMcZX0l03AC5u4LRSmNZEIVypqySKCEXV2aTX1bg=;
        b=Vodl7YicdQp6H8eKKBzX+WV5WOiJ29HWHexR5suyxhKzXzzboMec5CMbwVlUuAQGlHH+i0
        w51lGEaddRZ3lekpEtUWIS4mAhBMr1w1ChRqkC7VJ+h3PjPDa6/LdLvAd1cNFur7MRHjsG
        lweLsQcNTO/qSS3AU6US/VgJy0UOjdwslNZCO8nqjZbf/NkkBqJYP3SusgO3BGTrqSl0Mx
        Uog+HRbihWzsCIQdH3P1iIXsBrhBFzyvO823q9gMTL4oCXekEr1B7Bc8VUygeUQWUrTKf1
        OjNeikDCgkvIpkq1f5bpEM5l8WMmRtTaG5dh670mEIv+QCFeuz+RrSCqvog9eg==
Date:   Fri, 17 Nov 2023 23:21:44 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Carlos Menin <menin@carlosaurelio.net>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sergio Prado <sergio.prado@e-labworks.com>
Subject: Re: [PATCH v2 1/2] rtc: add pcf85053a
Message-ID: <2023111722214402006513@mail.local>
References: <20231103125106.78220-1-menin@carlosaurelio.net>
 <20231103142822abbca0ed@mail.local>
 <ZUf_3TAZh1bpVOVt@arch-bow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUf_3TAZh1bpVOVt@arch-bow>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2023 17:49:33-0300, Carlos Menin wrote:
> > > +static int pcf85053a_rtc_check_reliability(struct device *dev, u8 status_reg)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	if (status_reg & REG_STATUS_CIF) {
> > > +		dev_warn(dev, "tamper detected,"
> > > +			 " date/time is not reliable\n");
> > You should not split strings. Also, I don't think most of the messages
> > are actually useful as the end user doesn't have any specific action
> > after seeing it. You should probably drop them.
> > 
> 
> About the usefullness of the message, do this apply to this CIF related
> message or also to the other two flags?

This actually applies to all the messages of the driver, they will add
to the size of the kernel then slow the boot time so please have a
careful look at the usefulness of messages. You may consider swtching
them to dev_dbg.

> > > +	tm->tm_year = buf[REG_YEARS];
> > > +	/* adjust for 1900 base of rtc_time */
> > > +	tm->tm_year += 100;
> > > +
> > > +	tm->tm_wday = (buf[REG_WEEKDAYS] - 1) & 7; /* 1 - 7 */
> > > +	tm->tm_sec = buf[REG_SECS];
> > > +	tm->tm_min = buf[REG_MINUTES];
> > > +	tm->tm_hour = buf[REG_HOURS];
> > > +	tm->tm_mday = buf[REG_DAYS];
> > > +	tm->tm_mon = buf[REG_MONTHS] - 1; /* 1 - 12 */
> > 
> > Those comments are not useful.
> > 
> 
> I Will improve them to explain why I am offsetting the register value.

I don't think this is necessary, most of the drivers are doing it so
this is expected.

> > > +static struct attribute *pcf85053a_attrs_flags[] = {
> > > +	&dev_attr_rtc_fail.attr,
> > > +	&dev_attr_oscillator_fail.attr,
> > > +	&dev_attr_rtc_clear.attr,
> > > +	0,
> > > +};
> > 
> > Don't add undocumented sysfs files. Also, You must not allow userspace
> > to clear those flags without setting the time properly.
> > 
> 
> Should the flags be cleared only by setting the time, or is there
> another acceptable method? What would be the correct way to let
> userspace read those flags?

The RTC_VL_READ ioctl will allow reading the flags from userspace. For
the flags that monitor the validity of the time and date, they must only
be cleared when the time and date is known to be good s only when
setting the time.

> > > +}
> > > +
> > > +static void pcf85053a_set_low_jitter(struct device *dev, u8 *reg_ctrl)
> > > +{
> > > +	bool val;
> > > +	u8 regval;
> > > +
> > > +	val = of_property_read_bool(dev->of_node, "nxp,low-jitter-mode");
> > 
> > Bool properties don't work well with RTC because with this, there is now
> > way to enable the normal mode.
> > 
> 
> Wouldn't the absence of the property enable normal mode? Or I am missing
> something?

RTC have a greater lifetime than the linux system so you must have a way
to indicate that you don't want to change the configuration for example
if it has been set from the bootloader or at the factory.

Regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
