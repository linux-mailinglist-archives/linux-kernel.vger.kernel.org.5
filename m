Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AB778A085
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 19:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjH0RgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 13:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjH0Rfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 13:35:55 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C618CF4;
        Sun, 27 Aug 2023 10:35:53 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-d7481bc4d6fso2510000276.2;
        Sun, 27 Aug 2023 10:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693157753; x=1693762553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHRJyx7j7BhNrqT0LEFiRvYT/7EP1f7+a5goYW9ZPlQ=;
        b=RqXchjQi9yl1fewbsZSVO18bmqNCA8yVXVt4+XX7Z7LK4mwNSbgU9jEFwTzV+2ycSA
         OrN824x7+fFyG4kiIqpTEDvbC524lW4SJUDzKxEWpD1La5ylozDQbtHbmtHo3OwtQYlf
         mxAMsCVxKlxWDGuahz8+ONEFPFYUqFreSKPC5opYU4Eeu76suhcp+TGyggfsALyWZRUz
         DlBEG+dZQF5kM6oqHFXSmge2JFMaj6V3IyiwWPF/UPZgoGwktqqZX5IcDj/3KGRMF62E
         fytoly1D6G8fSXc+3Z5nXfNcfBRIHqQ3aRSgnwS9cdy/sVsFrZoQMSXQe4CjLUrCnfel
         AR9g==
X-Gm-Message-State: AOJu0Yw12RMLKVKkunwEDRlv5fsV4e/Pl+uwD5LM0ICM8FR73ks0cYLn
        oyp3CVDDNja5EZcJ7zHEdV/bn8D0fhdptJC6Qtk=
X-Google-Smtp-Source: AGHT+IFJ1JezbeXTpjjF0OoeKFxHC2a61ED9VzkqbhoT8LTwdtSmsZCpkyXrM/VyazMaxfjC0Yfep1dd4tZSMKxYXzE=
X-Received: by 2002:a25:830d:0:b0:d78:69ad:cffa with SMTP id
 s13-20020a25830d000000b00d7869adcffamr6115368ybk.42.1693157752891; Sun, 27
 Aug 2023 10:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230827134150.2918-1-jszhang@kernel.org> <20230827134150.2918-2-jszhang@kernel.org>
 <ZOtWmedBsa6wQQ6+@shell.armlinux.org.uk>
In-Reply-To: <ZOtWmedBsa6wQQ6+@shell.armlinux.org.uk>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Sun, 27 Aug 2023 19:35:41 +0200
Message-ID: <CANBLGcyfxNSgNjNvU1_N2ZC5q1YjqDjS69E7grbfCYM7bmm=-g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: stmmac: dwmac-starfive: improve error
 handling during probe
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Samin Guo <samin.guo@starfivetech.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2023 at 15:59, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Sun, Aug 27, 2023 at 09:41:49PM +0800, Jisheng Zhang wrote:
> > After stmmac_probe_config_dt() succeeds, when error happens later,
> > stmmac_remove_config_dt() needs to be called for proper error handling.
>
> Have you thought about converting to use devm_stmmac_probe_config_dt()
> which will call stmmac_remove_config_dt() if the probe fails or when
> the device is unbound?

+1. Using devm_stmmac_probe_config_dt() seems like a better solution.

> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
