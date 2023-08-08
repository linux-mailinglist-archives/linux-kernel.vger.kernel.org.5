Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A132774785
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjHHTPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbjHHTPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:15:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEBF3C225;
        Tue,  8 Aug 2023 09:38:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c136ee106so857169766b.1;
        Tue, 08 Aug 2023 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691512678; x=1692117478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rw/U1juJW++TN/CPqRVhgWO7e9qZoHR3vAiibGfwoUg=;
        b=pWVIh58NFCf5ruJ4rs5GCaWSHk+ZnlAcZTqLCBEHNQsH5GUhqzLgJMn0kcFCwNAzir
         efjY6NHJR2wiNtBaCq6u34SvsxQ3VToBx4W9GnksZcvYJFqlgYQolantcczUXG994wdg
         3TMud+97Xv2M5SHUK68InQtpTnBB906i9O2svh7H8MZxELBNudugN1CPIFTj5d9xg9Au
         rvtgFNrqBlf7kRounGhphAzCoOhu1ac48UbF7mOLJN0ePoF098faqxZLkdGnJmGajXtQ
         6Y0Q0PDcFD4Z+OAhnW5d/1s13MR1Dm2yGHn+jipy9u9qbMW69hFGdWnK0FEQze8Pzs+6
         +wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512678; x=1692117478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rw/U1juJW++TN/CPqRVhgWO7e9qZoHR3vAiibGfwoUg=;
        b=VhtQqlxIdwKux0KUCrHJZVsyiy5yJHz6ypNY4PwhQEmnixFhBL9AkTMLdMGc5HlzW0
         xRNrm1nBcIGvjmiuU3kwFJMJk1xltSn3PXRDmNX8PKA0yJ7aTa9Ztjtq5MkynwZ7dlml
         d4HIokfptjoyeTaH2gNzKi2A9XFcdZx90ZZuhxDLGjoSSlQsK48Goyc9Lb3F1PSKIq9X
         TcapPB78EutUBKGJ4OfT3cIRKRSaYA8pYHGMqB8fBTvPO1GD9Gyr6gHWdJ2uBvEY26C/
         Myct23svfKj52jISPMWZGhtcMfCuFN8BxWkkfaOmYuEG7skYITMwnypSy5/+AGdyUKOK
         z5aw==
X-Gm-Message-State: AOJu0YwJZ7f88BVTIii6TE8HXicUxcQ4yHyKEDIvE3AvXEI+uhPjlK0A
        cq0Ptg7ogBKmHLiCwtN+lHXEqNKZLycRVDYN
X-Google-Smtp-Source: AGHT+IFP72Tw+xIhBH3OCKy8dTwEFRVt0e08PihUpstVfcRZiD1229U4loKm3Rco7giOl8WkyfhNTA==
X-Received: by 2002:a17:907:2c77:b0:978:acec:36b1 with SMTP id ib23-20020a1709072c7700b00978acec36b1mr10450643ejc.17.1691497030223;
        Tue, 08 Aug 2023 05:17:10 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id qo2-20020a170907212200b0099364d9f0e2sm6579767ejb.98.2023.08.08.05.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 05:17:09 -0700 (PDT)
Date:   Tue, 8 Aug 2023 15:17:07 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RESEND net-next 2/2] dt-bindings: net: dsa:
 mediatek,mt7530: document MDIO-bus
Message-ID: <20230808121707.chona7hakapp6whe@skbuf>
References: <6eb1b7b8dbc3a4b14becad15f0707d4f624ee18b.1691246461.git.daniel@makrotopia.org>
 <9aec0fe0cb676b76132c388bb3ead46f596a6e6e.1691246461.git.daniel@makrotopia.org>
 <dcb981b9-b435-c0e5-8e47-d66add207fdc@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcb981b9-b435-c0e5-8e47-d66add207fdc@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 11:15:15PM +0300, Arınç ÜNAL wrote:
> I don't see a reason to resubmit this without addressing the requested
> change.
> 
> > > Wouldn't we just skip the whole issue by documenting the need for defining all PHYs
> > > used on the switch when defining the MDIO bus?
> > 
> > Good idea, please do that.
> 
> https://lore.kernel.org/netdev/0f501bb6-18a0-1713-b08c-6ad244c022ec@arinc9.com/
> 
> Arınç

Arınç, where do you see that comment being added? AFAIU, it is a
characteristic of the generic __of_mdiobus_register() code to set
mdio->phy_mask = ~0, and nothing specific to the mt7530.
