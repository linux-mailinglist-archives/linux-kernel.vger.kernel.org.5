Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21B07D5C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344257AbjJXUKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjJXUKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:10:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D4610D4;
        Tue, 24 Oct 2023 13:10:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53e3e7e478bso7431537a12.0;
        Tue, 24 Oct 2023 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698178229; x=1698783029; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ar3CnIJ1N2v0I7C2pDqg8bJ0YINWAGgGOzL56NqRgo=;
        b=iZaXkvcoDXxETwUj/GEyw5jTCQ7tVqOJ3cfPAYgmA00UzZirxe+v2SZZPqawcLFleg
         relSH/C1zwlaFX/wZRxMvxTNhk0CKMdrefaG6fywrwPVj7evOiJzrO8heUe9kqlqfGDc
         J1WmGKDXpQDmegamhejJGvUz72ZRIyTv81l/8qE/49yqVszhpC+VzbX/siiqISh4ZrFB
         u62da2MMrwFA6g/xeBice9rGC1WWPhYf/N9O2ZF7LdWdrb23zDpDhslUrLYo82hgD8YC
         l64LDaCZL1uuyibw+8dN6imBsjntROc3G8ZFy9IQS9NHjPBR6JHGLyR7dqad6qdCIc7O
         T2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698178229; x=1698783029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ar3CnIJ1N2v0I7C2pDqg8bJ0YINWAGgGOzL56NqRgo=;
        b=tOp8AYmHn+JHwu0Fig9TpRqgh23tX57RYpQNnfStLBpbV8DFineqTh7d41Fvgrwvfu
         g99ElRFh0U8sZrAWbU/Ad1UI6LmspjBzfCdmvDpgnxP5uAx2pR74/+hjCAn+jwdgtNzJ
         yub+GMsVKHmbeB3VyqrGMrkM1YfTSPRnAO/z12pIHeiPgah1RAeErhh4LxGcbKXlguOr
         RohG/Ylz/hv42u+RJWiuvzcg4cIX4XDWu3Yua/OmP+n26UJkat28lcS3mHscrHKaNfKN
         cYUwckC3Vaw4rRiVhvEbN0W5cwuvYtIPjhFV2tGMgcBrh0upMWDe16KgXiKUdz7MW8L6
         U96Q==
X-Gm-Message-State: AOJu0YwACepTNJLGluUFY0wsjYUTDYb9LQoc/zXLWSYFy++jAKVkf2Rq
        dYAKLAQpN+ISpijLzYDTPY8=
X-Google-Smtp-Source: AGHT+IFZsFH9P806y7I1lRK9IkmMq3xFSSSiGqkY/fcApj4usFhdR0Vw4L24m+7Glh1hc3mdq0FfjA==
X-Received: by 2002:a05:6402:35d2:b0:533:9df5:ede with SMTP id z18-20020a05640235d200b005339df50edemr9651760edc.14.1698178228555;
        Tue, 24 Oct 2023 13:10:28 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id h12-20020aa7de0c000000b0053e43492ef1sm8234010edv.65.2023.10.24.13.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 13:10:27 -0700 (PDT)
Date:   Tue, 24 Oct 2023 23:10:24 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH net-next v6 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
Message-ID: <20231024201024.6cyoqy5vbctbgtfe@skbuf>
References: <20231024-marvell-88e6152-wan-led-v6-0-993ab0949344@linaro.org>
 <20231024-marvell-88e6152-wan-led-v6-1-993ab0949344@linaro.org>
 <169815156038.3447619.17571704457000261488.robh@kernel.org>
 <CACRpkdZMSfKYaXR9NWpvca094=Prc6N8ZfR+QMcfS6VQ-prQRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZMSfKYaXR9NWpvca094=Prc6N8ZfR+QMcfS6VQ-prQRA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 03:18:13PM +0200, Linus Walleij wrote:
> On Tue, Oct 24, 2023 at 2:48 PM Rob Herring <robh@kernel.org> wrote:
> > On Tue, 24 Oct 2023 11:24:53 +0200, Linus Walleij wrote:
> > > Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> > > a DSA switch node need to have a ports or ethernet-ports
> > > subnode, and that is actually required, so add requirements
> > > using oneOf.
> > >
> > > Suggested-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> > ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:5: [warning] wrong indentation: expected 6 but found 4 (indentation)
> > ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:5: [warning] wrong indentation: expected 6 but found 4 (indentation)
> 
> Oh yeah Krzysztof actually explained to me why these have to have
> two spaces extra.
> 
> Oh well I just keep hitting the robot for testing this.
> 
> Yours,
> Linus Walleij

FWIW, we have a rule in Documentation/process/maintainer-netdev.rst to
not repost more frequently than once every 24 hours. Unfortunately I
don't have a huge review capacity right now, so in my case it could
probably take even a bit more than that. But it's a bit unpleasant that
I left some feedback on v4, you posted v5 yesterday and since then we're
now at v7, only for me to find that I need to repeat my v4 feedback.
