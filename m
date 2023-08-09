Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7997766EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjHISDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjHISDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:03:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8802111;
        Wed,  9 Aug 2023 11:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55D20643B0;
        Wed,  9 Aug 2023 18:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B6EC433C9;
        Wed,  9 Aug 2023 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691604182;
        bh=rPL3CLW5XuFRA39bX+QGXMYR05A+1pGnImddf5wGUCE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BBVzXWQHKu1WI7BUZSyUq4RygUDDCn2Ynwrw/QQ4B6iSmvfMMvCmZNQGKWvt9WWXk
         TXhNXYQ97qc/qgVsNns+eO0xxDrsGM+l+cnwEWlkANhqOOWT9b5W+/MzBKM3re5UIH
         w2/5uecoFeYuoQYwHJu/IqLtoA9McZPQXxnGdT026XdOqYctlg6ISQBt+JRcwHBntT
         DNt0F4zG3BGdiJavlJs47IOb3rnWoFFrK3PieDkSTGCd6zCKZanOhLFbYhcHsVox2I
         bmWGCvR6ElObEHmCmF5cXoiznRdLgeNFsYX3gT/iqewhVn1dMxKIlAnFrKXdKZNgCT
         k2QV2n/L7KVkg==
Date:   Wed, 9 Aug 2023 19:02:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <20230809190257.67602e55@jic23-huawei>
In-Reply-To: <ZNM1AYMB3RGRWp7C@gmail.com>
References: <20230808110432.240773-1-marcus.folkesson@gmail.com>
        <20230808110432.240773-4-marcus.folkesson@gmail.com>
        <ZNJP6xpOvRJigtMx@smile.fi.intel.com>
        <ZNM1AYMB3RGRWp7C@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 08:41:05 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> > ...
> >   
> > > +#define MCP3910_OFFCAL(x)		(MCP3910_REG_OFFCAL_CH0 + x * 6)  
> > 
> > Inconsistent macro implementation, i.e. you need to use (x).  
> 
> Sorry, I do not get you
> 
> 
> [...]
> 
> > > +static int mcp3910_get_osr(struct mcp3911 *adc, int *val)
> > > +{
> > > +	int ret, osr;  
> > 
> > Strictly speaking osr can't be negative, otherwise it's a UB below.
> > 
> > 	u32 osr = FIELD_GET(MCP3910_CONFIG0_OSR, *val);
> > 	int ret;
> > 
> > and why val is int?  
> 
> I will change val to u32 for *_get_osr(), *_set_osr() and *_set_scale().
> 
> [...]
> 
> > > +	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))  
> > 
> > This also becomes shorter.
> > 
> > One trick to make it even shorter:
> > 
> > 	if (device_property_present(dev, "microchip,data-ready-hiz"))  
> 
> Thank you, I wasn't aware of device_property_present().

I know the read_bool function is direct equivalent of this but where a property
is a flag, it feels more natural to me to check it with that one.
read_present() feels more appropriate for where you want to know a more
complex property is present.

Doesn't matter that much either way however so up to you.

> 
> [...]
> 
> >   
> > > +	dev_dbg(&spi->dev, "use device address %i\n", adc->dev_addr);  
> > 
> > Is it useful?  
> 
> Yes, I think so.
> 
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >   
> 
> Best regards,
> Marcus Folkesson

