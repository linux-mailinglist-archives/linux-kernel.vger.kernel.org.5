Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF7F7EE9FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345570AbjKPXey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjKPXev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:34:51 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773193;
        Thu, 16 Nov 2023 15:34:46 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5FC41C0004;
        Thu, 16 Nov 2023 23:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700177685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KOrBzSCE+eh9Zf6TrXB9Dgbvea0hhnEzWglyrJAmBhs=;
        b=ESddfoUe8EK3gDVj8NERUYEk64BQ3MDNN91alQ4bnCwFiSwDHdmAAA9Ow5QjrNQZ/pHbGw
        zCS6tmU640ykM3aPJ9OhQEJwODLaB9iCCoR5SZA/QymzxzC0rp1qEV8IfNR3ZLPyimJ2dK
        oS09th1DhyJm2FivC+oS8273wzVgaBbNHVOf4crHRv+LDIWc67lP76E0vpMhfGsuwov5Or
        vU30wQ4GxSUUR55vECViXfeU/PzHXWFSizsAzHkGqjXn7cAHVqZ83ryaJ6TiWbnXPObSH0
        nWE/5LeUPcXzkGSPeD8E8AXbdn9TWGU0lNzVgeFwSfZCB6K6BD42NmKaQiWG6g==
Date:   Fri, 17 Nov 2023 00:34:44 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, kernel@axis.com,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rtc: Add driver for Epson RX8111
Message-ID: <202311162334448082cd88@mail.local>
References: <cover.1692699931.git.waqar.hameed@axis.com>
 <7b856b74c4c0f8c6c539d7c692051c9203b103c0.1692699931.git.waqar.hameed@axis.com>
 <20231103225331f0fee24a@mail.local>
 <pndo7g67t59.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pndo7g67t59.fsf@axis.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2023 15:36:55+0100, Waqar Hameed wrote:
> 
> >> +#define RX8111_TIME_BUF_SZ (RX8111_REG_YEAR - RX8111_REG_SEC + 1)
> >> +#define RX8111_TIME_BUF_IDX(reg)                                               \
> >> +	({                                                                     \
> >> +		BUILD_BUG_ON_MSG(reg < RX8111_REG_SEC || reg > RX8111_REG_YEAR,\
> >> +				 "Invalid reg value");                         \
> >> +		(reg - RX8111_REG_SEC);                                        \
> >> +	})
> >
> > I don't feel like this is improving the legibility of the code. 
> 
> Sure, I just wanted to minimize `reg - RX8111_REG_SEC` expressions
> everywhere. I think it's a matter of taste here. I'll remove the
> macro `RX8111_TIME_BUF_IDX()` altogether.

Simply use offsets, using macro doesn't bring much as the rtc_tm member
name already carry the information.

> 
> 
> > Also, the BUILD_BUG_ON_MSG is never going to happen and doesn't
> > protect against a frequent issue.
> 
> Yeah, it's probably not that frequent. Just wanted to help the next
> person here :)


Well, regmap will do the checking at runtime which is probably enough.
> >
> >> +	if (ret) {
> >> +		dev_err(data->dev,
> >> +			"Could not disable extended functionality (%d)\n", ret);
> >
> > You should cut down on the number of message, this would be a bus error
> > and the user has no actual action after seeing the message.
> 
> True, will convert it to `dev_dbg()` then.

Just to be clear, this applies to most of the error messages.

> >> +static int rx8111_read_time(struct device *dev, struct rtc_time *tm)
> >> +{
> >> +	struct rx8111_data *data = dev_get_drvdata(dev);
> >> +	u8 buf[RX8111_TIME_BUF_SZ];
> >> +	unsigned int regval;
> >> +	int ret;
> >> +
> >> +	/* Check status. */
> >> +	ret = rx8111_read_vl_flag(data, &regval);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (regval) {
> >> +		dev_warn(data->dev,
> >> +			 "Low voltage detected, time is not reliable\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >
> > Should you check XST too? 
> 
> According to the datasheet
> (https://support.epson.biz/td/api/doc_check.php?dl=app_RX8111CE&lang=en),
> when the VLF bit is set, "Either power on reset _or_ X'tal oscillation
> stop is detected". It should therefore be sufficient to only check the
> VLF bit?
> 

Not sure it is, maybe the oscillator has an issue that is not voltage
related? Or maybe it has been stopped explicitly and never restarted
(like when setting the time and then you get a bus error).

> However, I do understand that it's maybe more "robust" to also check XST
> (and to be able to distinguish and report it). We could add that.
> 
> > And with this, using reg_field is worse.
> 
> Reading two fields in the same register with `reg_field` sure is worse.
> If we now also want to check XST, a better (usual) way is to do a
> `regmap_read()` and then `FIELD_GET()`. What do you think?

Yes, REG_FIELD is what I prefer.

> >> +	/* Start the clock. */
> >> +	ret = regmap_field_write(data->regfields[RX8111_REGF_STOP], 0);
> >> +	if (ret) {
> >> +		dev_err(data->dev, "Could not start the clock (%d)\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >
> > You definitively need to handle XST here too.
> 
> Do you mean to also clear XST the same way we clear VLF (before stopping
> the clock)?

Yes.

> >> +	case RTC_VL_CLR:
> >> +		return rx8111_clear_vl_flag(data);
> >
> > Do not allow userspace to clear VLF without setting the time.
> 
> Hm, makes sense. Let's remove it here (since we already clear it in
> `rx8111_set_time()`).
> 
> (I think I got "fooled" when doing a quick search and seeing some
> drivers allowing this. They sure are in the minority though...)

I think I removed most of those, the remaining one should be clearing a
bit that indicated low voltage and reduced functionality but not loss of
time/date which is right.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
