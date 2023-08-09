Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045EB7768D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjHITg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjHITg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:36:56 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4186AFE;
        Wed,  9 Aug 2023 12:36:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0116E0002;
        Wed,  9 Aug 2023 19:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691609813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kPW09UgKy6OANt/oXizeTaW2z/JDlSP2rAujG/yz74A=;
        b=DoqQ00h4N3l8g82I0ZotMLLrmV7473F2CyG7q/pznoEogewJrHwAkvN1zwBTHDr2r2X3pY
        z56QJ9ivJ/1lakTN8M+qJDTvNIYTtgroEgjI7nO/4NULO4bInyb8umVaWQi5K+9I+I/sRA
        U4j0JGmVFKcOaEvdJQzvqo8QXzvhk+9ubmU7BPDe1b5HfUgj2di7T8SQ2my0//xOnxVCE2
        7DvgyRj/UEerXl44O9lmj/PVzlrx7Xz4sZOKFXD5SVudeu7UXzAYIDP16+3/4llE1EH9If
        wSXKimT3fE4W06XQeoXRb/EtbNYTy9ubL3zZG9NCjfkMrsWcRLCV5WxHPvm/MQ==
Date:   Wed, 9 Aug 2023 21:36:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mia Lin <mimi05633@gmail.com>, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com, openbmc@lists.ozlabs.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rtc: nuvoton: Compatible with NCT3015Y-R and
 NCT3018Y-R
Message-ID: <202308091936514bb18c4e@mail.local>
References: <20230809095112.2836-1-mimi05633@gmail.com>
 <20230809095112.2836-3-mimi05633@gmail.com>
 <50bedd75-bcd6-d7bc-26c0-b8c00f99779a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50bedd75-bcd6-d7bc-26c0-b8c00f99779a@linaro.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 16:29:33+0200, Krzysztof Kozlowski wrote:
> On 09/08/2023 11:51, Mia Lin wrote:
> > -	flags = NCT3018Y_BIT_TWO;
> > -	err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> > -	if (err < 0) {
> > -		dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
> > -		return err;
> > +	flags = i2c_smbus_read_byte_data(client, NCT3018Y_REG_PART);
> > +	if (flags < 0) {
> > +		dev_dbg(&client->dev, "%s: read error\n", __func__);
> > +		return flags;
> > +	} else if (flags & NCT3018Y_REG_PART_NCT3018Y) {
> > +		if (!(flags & data->part_number))
> > +			dev_warn(&client->dev, "%s: part_num=0x%x but NCT3018Y_REG_PART=0x%x\n",
> > +				 __func__, data->part_number, flags);
> > +		flags = NCT3018Y_BIT_HF;
> > +		err = i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flags);
> > +		if (err < 0) {
> > +			dev_dbg(&client->dev, "Unable to write NCT3018Y_REG_CTRL\n");
> > +			return err;
> > +		}
> > +	} else if (flags & NCT3018Y_REG_PART_NCT3015Y) {
> > +		if (!(flags & data->part_number))
> > +			dev_warn(&client->dev, "%s: part_num=0x%x but NCT3018Y_REG_PART=0x%x\n",
> > +				 __func__, data->part_number, flags);
> 
> I don't think this is correct. Kernel's job is not to verify the DT...
> and why would it verify the device based on DT? You have here device
> detection so use it directly without this dance of comparing with
> compatible/match data.
> 

I fully agree here, either you trust your DT or the device ID but do not
use both.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
