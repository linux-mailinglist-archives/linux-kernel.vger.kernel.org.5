Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558AF805354
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347000AbjLELsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345186AbjLELsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:48:24 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E102C3;
        Tue,  5 Dec 2023 03:48:30 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso1921804e87.0;
        Tue, 05 Dec 2023 03:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701776908; x=1702381708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iMgwW6vx/jK9Cw7fgT+rzd5j+aMjeAnF9YT/yUvZ84M=;
        b=XSBLIp2RSjF6XwEtydIhkQJXJBcqQSnxabC7VI7NgbKZ/4XuU9bIRLw6cIkGbaReBg
         F8lSDS99M+EGGDNQoTlqSuNHo1yHmzKwcQZ21STiXbr6wDTxhri5BzVmgyrRxNrKQBG5
         QsxjWVG0CH8i2I9o7kcgZ7VrQoD41lqccOjDwWj0M9e9adnoOBFmWzR6cUNFf0i44/Am
         PzbBlFXU7C5GOJ3pfez+34+mSGjvIhimYSxfLKaTUbGpgDoIn4DGEdAjZTFWcpGaj2/+
         vUbEn9/zlgBa64f/nvzkKLSYl71h8JaD7gyq7mEUYvwHmU/bbhCBfPN2V3NB6CkW8LYc
         WGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701776908; x=1702381708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMgwW6vx/jK9Cw7fgT+rzd5j+aMjeAnF9YT/yUvZ84M=;
        b=qbxDmOecutAV4gpHWVSj5FehG9BI53Nx1rTOD4FP/ZLU8v/RDRo0uMCEz0l1lMEOnL
         CgM0NK4Y0RAgrkRqQavA0bOfPXLRsk7WU/TxcJyjnPJAHHWqeDS2EaCKC5BeTishlFEv
         D9AfHhpJxXZyJSy7k4edgKJBuNyPSrhP7OQogmRWJ5vLe0RFjZAx7M+GI319nsLqaT9d
         3wbEgfpM1RWMLkGM9uLEgdHvSh70tZH0xc95MkK2pZFtF2BzDDhi9GRPVcGOtQlADJJ0
         9fqnpuuYcylowmkuIEEjmSbF4oynX998iK9y+hdP9o1+yoB2UE5RJ/KLbkckrGNelLeD
         feVQ==
X-Gm-Message-State: AOJu0YyMujdJ2rv3S45+QZwPccR5YRbELB86fWHwIHUr5SuQqtt/4DZ2
        a39d7l8L+kYtDDNavKKD5gw=
X-Google-Smtp-Source: AGHT+IE4QS2OUuOuA8w6IIfWCOOlZexYeQ2PWBcGw2WPfl/X1e0YgNE9s7aTbsrFGohK/qiG1pBTFg==
X-Received: by 2002:a05:6512:230a:b0:50b:e92c:de18 with SMTP id o10-20020a056512230a00b0050be92cde18mr925702lfu.22.1701776907951;
        Tue, 05 Dec 2023 03:48:27 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q13-20020a19430d000000b0050be813bf9dsm1000150lfa.183.2023.12.05.03.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:48:27 -0800 (PST)
Date:   Tue, 5 Dec 2023 14:48:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/16] net: pcs: xpcs: Move native device ID
 macro to linux/pcs/pcs-xpcs.h
Message-ID: <syr55e2c7izap6fc2yzmz6gyzcybmmxe3dyjoxencb2tylss2p@tpu2pfh33ked>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
 <20231205103559.9605-6-fancer.lancer@gmail.com>
 <ZW7/TrtSols1igy/@shell.armlinux.org.uk>
 <bas6l42vk2zzrwo22ss7fuganf4ekvhtvkb32duydjise7ui3o@o4f3rbcpokur>
 <ZW8ICvzwIHJhoV9U@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW8ICvzwIHJhoV9U@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 11:22:50AM +0000, Russell King (Oracle) wrote:
> On Tue, Dec 05, 2023 at 02:14:34PM +0300, Serge Semin wrote:
> > On Tue, Dec 05, 2023 at 10:45:34AM +0000, Russell King (Oracle) wrote:
> > > On Tue, Dec 05, 2023 at 01:35:26PM +0300, Serge Semin wrote:
> > > > Generic MDIO-device driver will support setting a custom device ID for the
> > > > particular MDIO-device.
> > > 
> > > Why future tense? I don't see anything later in this patch set adding
> > > this.
> > 
> > After the next patch is applied
> > [PATCH net-next 10/16] net: pcs: xpcs: Add generic DW XPCS MDIO-device support
> > the DW XPCS driver _will_ support setting custom IDs based on the
> > platform data and the DT compatibles.
> 

> What is confusing is that the sentence makes it sound like it's some
> generic driver that can be used for any PCS, whereas in reality it is
> _this_ XPCS driver which is not generic.
> 
> "This driver will support setting a custom device ID in a future patch."
> or explicitly state the summary line of the patch concerned so one can
> refer to it. Future references are difficult to find whether they're in
> email and especially once they're merged into git.

Ok. I'll convert the patch log to be less confusing. As I already said
to Vladimir writing sometimes overcomplicated messages my eternal
problem.

> 
> > It can be used for instance to
> > fix the already available SJ1105 and SJ1110 MDIO bus implementations,
> > so instead of substituting the XPCS IDs on the PHYSID CSR reads the
> > driver could just pass the device ID and PMA ID via the device
> > platform data.
> > 
> > If my patch log text looks unclear anyway, just say so. I'll change it
> > accordingly. I guess it would be enough to say that moving is required
> > just to collect all the IDs in a single place.
> 

> You need to adjust your attitude - I did exactly that. There was
> something which I didn't understand, so I raised the issue. Sorry
> for spotting a problem, but do you always get arsey when a reviewer
> picks up on something wrong? If that's your attitude, then for this
> entire series: NAK.

I'm sorry if what I wrote sounded like I was arsey. I didn't mean it
at all, really. By this sentence:

> I guess it would be enough to say that moving is required
> just to collect all the IDs in a single place.

I meant that _I_ should have just stated in the log message that
moving was required to collect all the IDs in a single place. The
rest of the text was redundant and caused confusion what you pointed
out to.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
