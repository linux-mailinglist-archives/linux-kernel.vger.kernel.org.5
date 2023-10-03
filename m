Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8F7B66A4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjJCKo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjJCKoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:44:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E72B4;
        Tue,  3 Oct 2023 03:44:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98377c5d53eso128625266b.0;
        Tue, 03 Oct 2023 03:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696329854; x=1696934654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmEctcMUVbCclk9m0goiD7O58kPkk9ozB1JI3JI/hPI=;
        b=K1/kJY9K8EJ7fSrU72OqYrJhm2cJSz0s1997Vjw6C5j9evTc2EgmDcuklFCeQHV9xF
         imQQyAIEmf4xVeYFvJRMWKZzDaTqwaykb0fXY/vSEZCURwwRykkPimic2SogGh4dM30E
         1FoYt1yx60ot7ikxzE9rNXfmQExVSFreDLqzciiKGn6PqXXzaWTrxyc8GK9jqVtKJNgU
         op10bFM96uKVYJy1WK1+jqgs4BQqTzdwR7govo9UjYQMCfRyHSBYfcBzXXMBgRXVRk1X
         Ur5V+PGDCz2dmEEz39McVXZ9/HzADNTQ2Vx6HhOzePtLXQqpihWPCwS4w0rrKgsTPeA5
         y7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696329854; x=1696934654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmEctcMUVbCclk9m0goiD7O58kPkk9ozB1JI3JI/hPI=;
        b=YykS7G26Lmmb5+KbHJsnjc4arL1O3JUJRlKaVFoxPy2jLe8J0N7nHWnDjBoWsd803+
         C8xPyT4D80nffI32/CslYZMd2dCr/Iy/qDRkJmfKche+tiGOtgjL3NS1PWo8m4d1xyOD
         j6GdPM8EfxMT0yr5z46ZGqJh0uYm8ymF2X9MzWyxQ072LXCzYMffOjjFsOXNF+ZzUykh
         WYI9WyJK4zlHLXLiguku9wuqoCVXjGerx5V85f3YOxnY0Ll6yzxlmPkr4aMy4gHOtJNS
         5eDWMZDa7rg5mqPSEsZsrzArN6437A+kItsKUGI1qEIdQas17d6byjBA+mBB6Ccajt9Q
         PTfw==
X-Gm-Message-State: AOJu0Yx6YDwm+Asf92A7mJVMYtkW676yXLb6lSWU0IgnsRQgSBi7VX2s
        vGqqwC1T5eQzzZtbKY8Pr4gdMMrQ1AQ=
X-Google-Smtp-Source: AGHT+IGeoM+GI4kBmhQElhTrw5bnp/MJFivmYswqf/ln69nM1n6ZfvZtRodCaIcEDAax2e51jphWYw==
X-Received: by 2002:a17:907:75c6:b0:9b6:d9ae:402c with SMTP id jl6-20020a17090775c600b009b6d9ae402cmr919777ejc.61.1696329853452;
        Tue, 03 Oct 2023 03:44:13 -0700 (PDT)
Received: from skbuf ([188.25.255.218])
        by smtp.gmail.com with ESMTPSA id c20-20020a170906529400b0098d2d219649sm850616ejm.174.2023.10.03.03.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:44:13 -0700 (PDT)
Date:   Tue, 3 Oct 2023 13:44:10 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading
 for KSZ9477
Message-ID: <20231003104410.dhngn3vvdfdcurga@skbuf>
References: <20230922133108.2090612-1-lukma@denx.de>
 <20230926225401.bganxwmtrgkiz2di@skbuf>
 <20230928124127.379115e6@wsk>
 <20231003095832.4bec4c72@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003095832.4bec4c72@wsk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 09:58:32AM +0200, Lukasz Majewski wrote:
> I'm a bit puzzled with this patch series - will it be pulled directly
> to net-next [1] or is there any other (KSZ maintainer's?) tree to which
> it will be first pulled and then PR will be send to net-next?
> 
> Thanks in advance for the clarification.
> 
> Links:
> 
> [1] -
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/log/

No, there's no other tree than net-next. I see your patch was marked as
"Changes requested", let me see if I can transition it back to "Under review"
so that it gains the netdev maintainers' attention again:

https://patchwork.kernel.org/project/netdevbpf/cover/20230922133108.2090612-1-lukma@denx.de/

pw-bot: under-review
