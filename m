Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7E677AAA9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 20:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjHMSxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 14:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjHMSxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 14:53:46 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE41E6F;
        Sun, 13 Aug 2023 11:53:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99d90ffed68so271077166b.0;
        Sun, 13 Aug 2023 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691952826; x=1692557626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4Z7LcreDG3zwCCg78hju/7pGf4/EBg9+ueP2NNKdtQ=;
        b=RZgjxTB+DrIzRXIoMgo97E0Wkr8GL6dTfpikw9hAguNjLfjlPwT8qvbJ1+npNuN12C
         +uVlR8cUV7Jed86xWbFLBmMS5NSO/Zx+ZzYLTC4KjGheMTL+1bNseQQM9komo8t//4TE
         Pdi70Z+Acqtw2QgsSJYadWDW3fg32SkGmILDYJqFiIS6v2TUVa0d6ASgH34SwgdZZTti
         tR+uWTa4am6mAGGgjxJYmkmePsyjJ+t/rd+FEOgiWVZAVk4Tmgn8LyyVeivviDS1iSiR
         7xcAi3J8xqU0imr8ppfztlxwDLlPiVhWEAjJWKTsnch0TKU9STH7BagFVGNayLWXgHg9
         xCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691952826; x=1692557626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4Z7LcreDG3zwCCg78hju/7pGf4/EBg9+ueP2NNKdtQ=;
        b=fkriz4zNt+s6I8Lyr+l8w5oQ2BUC66tExoTiHPN/XhBSbKl1CccnFreAm4cQ8wY5yl
         SmnI2DsLPUohy1plYaYDkb0QTbhllVziXPcON6GpHbNecft9uoDpWfkvk+7AgbbSoSWm
         tEvDerz313z685p1I53ZaXTuAIlzQT9amStQuapT4vBbwaK5e/DJwV6Ra5PNFZRDceFJ
         BQgfnl0GoKJ+QS/CGxbswbwtUMbmBWpFaTDcIiW8zoeC6out/3AGJcXwwl0U3EvY8rMo
         15UmDJuVfT9FE0IRV3tTvMet9e3jdPl//rV7+v+3ZsGUkx0AMLRP7Kdw4txwKkG306CD
         ecrw==
X-Gm-Message-State: AOJu0YwDeq0NVzHcijuklvCeL0BFKzNKw0F9hlIt5Xd8x8vFB4Cpn+t3
        Nl4vSVh2PkNYpeoduCgb2fk=
X-Google-Smtp-Source: AGHT+IFs45U93JwGuiqG/i1JuDDNpE44Fitb2zbYbkTwAUxtEd2yLV3tWxDXN9t/aEVpAMIGCl5Pzw==
X-Received: by 2002:a17:907:7e84:b0:966:1bf2:2af5 with SMTP id qb4-20020a1709077e8400b009661bf22af5mr10686610ejc.22.1691952825534;
        Sun, 13 Aug 2023 11:53:45 -0700 (PDT)
Received: from skbuf ([188.27.184.148])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090613c800b00992bea2e9d2sm4787423ejc.62.2023.08.13.11.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 11:53:45 -0700 (PDT)
Date:   Sun, 13 Aug 2023 21:53:43 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Alfred Lee <l00g33k@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        sgarzare@redhat.com, AVKrasnov@sberdevices.ru
Subject: Re: [PATCH v2 net] net: dsa: mv88e6xxx: Wait for EEPROM done before
 HW reset
Message-ID: <20230813185343.rxkdcrvbpoap3gx4@skbuf>
References: <20230811232832.24321-1-l00g33k@gmail.com>
 <20230813105804.2r4zdr6dyqe5dsrf@skbuf>
 <dc56700c-8617-44de-8285-720e1514ebc9@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc56700c-8617-44de-8285-720e1514ebc9@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 05:09:14PM +0200, Andrew Lunn wrote:
> On Sun, Aug 13, 2023 at 01:58:04PM +0300, Vladimir Oltean wrote:
> > Hi Alfred,
> > 
> > On Fri, Aug 11, 2023 at 04:28:32PM -0700, Alfred Lee wrote:
> > > If the switch is reset during active EEPROM transactions, as in
> > > just after an SoC reset after power up, the I2C bus transaction
> > > may be cut short leaving the EEPROM internal I2C state machine
> > > in the wrong state.  When the switch is reset again, the bad
> > > state machine state may result in data being read from the wrong
> > > memory location causing the switch to enter unexpect mode
> > > rendering it inoperational.
> > > 
> > > Fixes: 8abbffd27ced ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
> > > Signed-off-by: Alfred Lee <l00g33k@gmail.com>
> > > ---
> > 
> > I don't think you understand the meaning of the Fixes: tag.
> 
> The subject looks correct, but the hash is wrong. The correct hash is
> a3dcb3e7e70c72a68a79b30fc3a3adad5612731c.
> 
> Fixes: a3dcb3e7e70c ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
> 
>        Andrew

Ok. I didn't notice the "before" vs "after". But the patch still needs
to be resubmitted with the right Fixes: tag.
