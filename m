Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC0D7F9C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjK0JS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjK0JRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:17:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D671FDC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:14:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041C3C433C9;
        Mon, 27 Nov 2023 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701076449;
        bh=DHYCKu65cSstrrIdF03A4jEuXB7unahDVkMh4BL9CKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iN6sC3MpQfNv1EpyQZFoONrjp7xB5wX6a+Sw/vFi7bp4VixpXh+W7T+K/LJN368B8
         vkCRmVZK29aFqSS5l0/xLkmSZPLZjziFso+Y2B+TA8gWzd2SgXs8MJ8i12YJdl2gG+
         wCqJ/FoXjxUh0shL+N0HFe3IsWd7tojKz3xJtFMQQTOWd2gKZjg7QVOVawgRP34u3L
         5M79xYmtT2661AW36XyfZn2Nx4nGOLQ1egjMfdGA97EaT8132TY9EgmnCK287O5p1T
         d02Sp7ll+uCOdd/qwnIKE3wc7wB9uWpm4IbmxYxAZmiEkz2Y3E5rIrvfvjh6KvA1VG
         0+RL+lmVV/56Q==
Date:   Mon, 27 Nov 2023 09:14:03 +0000
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andy.shevchenko@gmail.com, kernel@sberdevices.ru,
        rockosov@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v4 06/11] leds: aw200xx: add delay after software reset
Message-ID: <20231127091403.GF1470173@google.com>
References: <20231121202835.28152-1-ddrokosov@salutedevices.com>
 <20231121202835.28152-7-ddrokosov@salutedevices.com>
 <20231123163816.GG1354538@google.com>
 <20231124093722.picykrqaewxlxa7h@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124093722.picykrqaewxlxa7h@CAB-WSD-L081021>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023, Dmitry Rokosov wrote:

> Hello Lee,
> 
> Thank you for the detailed review!
> 
> Please find my answer below.
> 
> On Thu, Nov 23, 2023 at 04:38:16PM +0000, Lee Jones wrote:
> > On Tue, 21 Nov 2023, Dmitry Rokosov wrote:
> > 
> > > From: George Stark <gnstark@salutedevices.com>
> > > 
> > > According to datasheets of aw200xx devices software reset takes at
> > > least 1ms so add delay after reset before issuing commands to device.
> > 
> > Are you able to use an auto-correct tool to sharpen the grammar a little?
> > 
> > > Signed-off-by: George Stark <gnstark@salutedevices.com>
> > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > ---
> > >  drivers/leds/leds-aw200xx.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
> > > index 4bce5e7381c0..bb17e48b3e2a 100644
> > > --- a/drivers/leds/leds-aw200xx.c
> > > +++ b/drivers/leds/leds-aw200xx.c
> > > @@ -321,6 +321,9 @@ static int aw200xx_chip_reset(const struct aw200xx *const chip)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	/* according to datasheet software reset takes at least 1ms */
> > 
> > Please start sentences with an uppercase char.
> > 
> > "According to the datasheet, software resets take at least 1ms"
> >               ^                            ^     ^
> > 
> 
> Here it's only one 'software reset' mentioned.

That's okay.  The English is still 100% valid, since this describes them
happening more than once; say per week, per year, per lifetime of the
H/W or some such.  If you *really* want to describe one reset happening
once, ever, then you can say "a software reset takes".

> > > +	fsleep(1000);
> > > +
> > >  	regcache_mark_dirty(chip->regmap);
> > >  	return regmap_write(chip->regmap, AW200XX_REG_FCD, AW200XX_FCD_CLEAR);
> > >  }

-- 
Lee Jones [李琼斯]
