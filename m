Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCF07A1E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjIOMTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjIOMTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:19:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2852719;
        Fri, 15 Sep 2023 05:18:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso257633266b.1;
        Fri, 15 Sep 2023 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694780314; x=1695385114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ymd4KNlOZU8aSyQl8RdaNXFFLMRuv3B/W9dK3PdwrAc=;
        b=Qe5yvcctpK8hnDXGJ38jjgWhYV3v6RHDBdkO0nF+YfXq9PVr2coBoL1FC1m5/scEMy
         kXZprRpqwBOBy9juoUxif8pQmYdS+3deoC/o6xWlVE2b9WX0rd/djE34sJbP30twJdX0
         ThL3bCpth/VDFUywk9+StI7RWYrw8fZJNZ2bDhfUWuKaEL+qMHgw/q2LOu2RDxdSXJ0v
         hCFQCMPO8MH1sJru57MCWGzLclxerTHHT+ohIpAoum6vVjNqlqYF6E2OcBdhnVdP2RCu
         Wj+VwU2p0zurszdRvhzpcB5D9DEClPLYCQ8NLclB2EpM77LwiS1Ha1KvmDe9o+u7uy2o
         tJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780314; x=1695385114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ymd4KNlOZU8aSyQl8RdaNXFFLMRuv3B/W9dK3PdwrAc=;
        b=k1/IAAqTulY0jt4i/1kr2oPXExlBqXGmc5ktHdKcSc+boXeR79Dpf5/Cb0IfYQY2fr
         A9aR0VuAyOr5KWHeV5WfWC/EgCWVvSmvU+urk2fCvwUnixYtzqbVMkcMyE8f5PnpM5Xc
         f14yXnBQq8yhkurkdZdIC/UAluBKfLyOe3mmMpb0BetEZ7cTtu4jCoinK3XHVox2087w
         39imdzquJCjEYiDGH+SH7huBiNAKMokHsvkAMayyth/SQIpv//TalWVg14AlSoUxFdlu
         o/KNIgqPVOZyZIJ5Kc0AsU3vV6NnOMs0eS8PiV+HSDsjdXBbY9jgSLyPkIkL/AE0MO1O
         +iRA==
X-Gm-Message-State: AOJu0Ywc402qpgR3Q++1GqVTulpHJJLtuuWq1xkmG9rjvxopW+V5tPyU
        zOvqNC57T8Vi2692LyQ3OF0=
X-Google-Smtp-Source: AGHT+IGIM8mfUCVD2aaq64c6QqJ77AiQF4lLWq19si18HJ2jdi75s8K70DPYuygwVCGIEpJnXsYbrA==
X-Received: by 2002:a17:906:535d:b0:9a1:fb4c:3b65 with SMTP id j29-20020a170906535d00b009a1fb4c3b65mr1141593ejo.14.1694780313700;
        Fri, 15 Sep 2023 05:18:33 -0700 (PDT)
Received: from skbuf ([188.26.56.202])
        by smtp.gmail.com with ESMTPSA id x7-20020a170906134700b009a0955a7ad0sm2335355ejb.128.2023.09.15.05.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:18:33 -0700 (PDT)
Date:   Fri, 15 Sep 2023 15:18:30 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Message-ID: <20230915121830.tmzuxthup7rzewhv@skbuf>
References: <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
 <20230911225126.rk23g3u3bzo3agby@skbuf>
 <036c0763-f1b2-49ff-bc82-1ff16eec27ab@arinc9.com>
 <20230912193450.h5s6miubag46z623@skbuf>
 <6cec079e-991e-4222-a76d-d6156de0daca@arinc9.com>
 <20230913074231.5azwxqjuv2wp5nik@skbuf>
 <ZQHcV5DUfcCYkkTi@shell.armlinux.org.uk>
 <ZQNLkiAt4jOjojRf@shell.armlinux.org.uk>
 <ZQNL0Vy3kMbWlNFl@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQNL0Vy3kMbWlNFl@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Thu, Sep 14, 2023 at 07:07:13PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 14, 2023 at 07:06:11PM +0100, Russell King (Oracle) wrote:
> > On Wed, Sep 13, 2023 at 04:59:19PM +0100, Russell King (Oracle) wrote:
> > > On Wed, Sep 13, 2023 at 10:42:31AM +0300, Vladimir Oltean wrote:
> > > > On Wed, Sep 13, 2023 at 08:52:37AM +0300, Arınç ÜNAL wrote:
> > > > > One more thing, I don't recall phy-mode being required to be defined for
> > > > > user ports as it will default to GMII. I don't believe this is the same
> > > > > case for shared ports so phy-mode is required only for them?
> > > > 
> > > > phy-mode is not strictly required, but I think there is a strong
> > > > preference to set it. IIRC, when looking at the DSA device trees, there
> > > > was no case where phy-mode would be absent on CPU/DSA ports if the other
> > > > link properties were also present, so we required it too. There were no
> > > > complaints in 1 year since dsa_shared_port_validate_of() is there. The
> > > > requirement can be relaxed to just a warning and no error in the kernel,
> > > > and the removal of "required" in the schema, if it helps making it
> > > > common with user ports.
> > > 
> > > However, phylink pretty much requires phy-mode to be specified to be
> > > something sane for shared ports, so I wouldn't be in favour of relaxing
> > > the checkinng in dsa_shared_port_validate_of()... not unless you're
> > > now going to accept the approach I originally proposed to have DSA
> > > drivers tell the core (and thus phylink) what phy-mode and other link
> > > parameters should be used when they are missing from DT.
> > 
> > You mean the approach that I picked up using software nodes that got
> > thrown out by the software node people? That approach that I picked
> > up from you and tried to get merged?
> > 
> > No, that's not going to happen, and it's not a question of whether
> > _I_ am going to accept that approach or not. So don't throw that
> > back on me, please.
> > 
> > If this is something that we want to solve, we need to stop being so
> > devisive (your language above is so) and try to come up with a
> > solution that is acceptable to everyone... the swnode approach
> > doesn't seem to be it.
> 
> Oh dear. I must be going mad!

So first things first: I am not advocating for making phy-mode fully
optional in the sense that you say (if absent, then write non-OF code
through which DSA infers the phy-mode from drivers). I'm happy with the
current form of the code.

I was just trying to add some nuance to this bizarre aspect signalled by
Arınç - phy-mode is not required for user ports, presumably because when
it is absent, user ports will default to GMII. That isn't an intrinsic
feature of user ports, but rather of having a phydev, and so, because
DSA/CPU ports can also have a phydev, logically it means that phy-mode
can also be omitted in that particular case, with the same result.

Our missing_phy_mode check from dsa_shared_port_validate_of() is theoretically
more restrictive than it needs to be, because it artificially prohibits
that behavior, and it results in an inexplicable difference in the phylink
dt-bindings for user vs shared ports. So that's where my relaxation
proposal came from: we could make missing_phy_mode non-fatal, and that
would permit the configurations which can work to work, and the ones
which can't work will fail elsewhere. Just like for the user ports.

Where I wasn't absolutely clear is that I don't want Arınç to change any
of that. Right now, on DSA shared ports, phy-mode is required and on user
ports it isn't. The difference is a bit strange (arbitrary considering
the example above) and should maybe be settled at some point in the
future, but for now, the dt-bindings should document it like that.
