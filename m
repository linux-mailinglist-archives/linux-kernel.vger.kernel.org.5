Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931A37D005A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbjJSRTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjJSRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:19:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAACCF;
        Thu, 19 Oct 2023 10:19:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso14195246a12.3;
        Thu, 19 Oct 2023 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697735959; x=1698340759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kuVTxDXsD5zLqnlIbrRzu0NzyI0nKgFfjwxin/PFwlU=;
        b=ku1mMqYloz5mUBTRrXbNrE7DHw23gB1v7mpQhrMI6W32f2y4TM8ctFbxFcY4sDMAfj
         sxZhXXgaYwa3GZPLmMApDObsKfxDOhx0lAhKkKiu+9/RVU5OHSTQWp+j/XiSCR+C/h5Z
         0TBaysj/6dD2UWVkgmAVTSkbfjKxS/MHtQySVaItGcGHY43I0nuknng4O9mMp0mBoYeF
         FpDer/brljutb5y3kYvYXOurpqzPzIYqQeg7iiIApu7uyEzCadLlJhfsI9lw450IosIy
         iUFvZdEhOwPV0OIRBf9pUn3TzxJHb7meENGjvYfF7qYr/L3iUgBYSheKxOD0oI4Z2ziS
         XXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697735959; x=1698340759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuVTxDXsD5zLqnlIbrRzu0NzyI0nKgFfjwxin/PFwlU=;
        b=PGkZkhlLsGHwnoqMIbSqzuq52d4iWP6H0QhlRafdRT0FZNAB7Y8AJ124bkal7Wvp1k
         GVhLWFauUqp7NqiQpnp4iOnQbaoc024ykb02cpUHAsxlvvn5j+EbOgtOIUbhi6kDcQEP
         FsbeRP47aCjl+S0c2x2IsimCZVk13lWq1hYEQhIF6zjO56+aDfRpwE3jwTVWs45rMTdN
         GZ9y1+6aG6p78b02Q+XML7lOfRN2Lm1au0fH1qmUkHd17LZIqF9hO4Lp0cbsT68dgdVA
         QF5SHqxSiF76500N4y/QsyD3UUi7+g+zjYR6gGzksjS+dqHo3q4J+UwLBcFr1USRgc3Z
         avyA==
X-Gm-Message-State: AOJu0YwPHqJ3CuJ85QdVTqX6++Q/3pnnZ2U+C/eXXftlWqITyhcFfOec
        0H+oXBPUE3wTlKs4+vCL4ac=
X-Google-Smtp-Source: AGHT+IGhfVwmPgjwxlHZqbpAewteoE+DkWqCmtTGfr9oV2jyUKq+NC85tBuQJGggMWKJhJhDvj3OMQ==
X-Received: by 2002:a05:6402:27ca:b0:53e:f321:e6fd with SMTP id c10-20020a05640227ca00b0053ef321e6fdmr2359570ede.9.1697735959051;
        Thu, 19 Oct 2023 10:19:19 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id ee16-20020a056402291000b0053e8f1f79afsm4810370edb.30.2023.10.19.10.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:19:18 -0700 (PDT)
Date:   Thu, 19 Oct 2023 20:19:16 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 7/9] net: dsa: microchip: Add error handling
 for ksz_switch_macaddr_get()
Message-ID: <20231019171916.nu4aptbxl6owg2gi@skbuf>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-8-o.rempel@pengutronix.de>
 <20231019171308.tpjdevvnrqhly6cu@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019171308.tpjdevvnrqhly6cu@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:13:08PM +0300, Vladimir Oltean wrote:
> On Thu, Oct 19, 2023 at 02:28:48PM +0200, Oleksij Rempel wrote:
> > Enhance the ksz_switch_macaddr_get() function to handle errors that may
> > occur during the call to ksz_write8(). Specifically, this update checks
> > the return value of ksz_write8(), which may fail if regmap ranges
> > validation is not passed and returns the error code.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > ---
> >  drivers/net/dsa/microchip/ksz_common.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> > index 7b05de6fe987..79052a54880c 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > @@ -3612,7 +3612,7 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
> >  	struct ksz_switch_macaddr *switch_macaddr;
> >  	struct ksz_device *dev = ds->priv;
> >  	const u16 *regs = dev->info->regs;
> > -	int i;
> > +	int i, ret;
> >  
> >  	/* Make sure concurrent MAC address changes are blocked */
> >  	ASSERT_RTNL();
> > @@ -3639,8 +3639,11 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
> >  	dev->switch_macaddr = switch_macaddr;
> >  
> >  	/* Program the switch MAC address to hardware */
> > -	for (i = 0; i < ETH_ALEN; i++)
> > -		ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
> > +	for (i = 0; i < ETH_ALEN; i++) {
> > +		ret = ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> I understand that you intend the error to be fatal, but this leaks memory and a refcount.

I didn't estimate correctly what would happen.

If ksz_write8() fails as you say, we will leave behind the reference to
dev->switch_macaddr, which points to valid memory. Which means that the
second time around, the call to ksz_switch_macaddr_get() will succeed,
because the driver thinks that the address has been programmed to
hardware, and it is unaware of the previous failure. But it will not
work. Am I correct?

If so, it needs to tear down properly, because if ksz_switch_macaddr_get()
fails once to write to hardware, it should fail always.
