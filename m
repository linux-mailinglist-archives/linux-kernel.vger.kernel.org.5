Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6B57E5A01
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjKHP3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKHP3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:29:42 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5C91AE;
        Wed,  8 Nov 2023 07:29:40 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c41e95efcbso1058036566b.3;
        Wed, 08 Nov 2023 07:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699457379; x=1700062179; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JuE+60U9sEilVHPc1zpDguttRx4Q8ddccApuMyrDFe8=;
        b=IEwE80n2J/lz8i0LzpXcuHMIsolw5ZpUSFmHzMwgH7qDAcfTyJhHaaKTuvVGyUL/MN
         Ni6dnM8BRs8ox8j2C8oz0ybTaboE/Q3O7t4POUMeF9E5OVqpfJQuhnQ0VNK11u2aXovD
         ERNdNhH9FEia8f3vPMlKAfFCNpT1nkefQcbNkCQn5iT7W+TnZNoEZnscsbVbNqcsQts4
         dLbt7u6meQu9jm9sb7j8rOckcnlBFV+dO/ETyZVO9tAiQQ+b0MX1uGnad/QP/DGpPoEH
         l3kqPE/rhlDD6RbYb7yeuXNi7LvZ2jinIzYRDpgvSwyoUGg1O6dR9eeCW9zthrFhPaE+
         1d5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699457379; x=1700062179;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JuE+60U9sEilVHPc1zpDguttRx4Q8ddccApuMyrDFe8=;
        b=cLc5Y5CpiCK19exbVnpzaxq+wdUNM4aMELwOhxAinyo1a0I7NUADZuEnJDtm7uEsr6
         y29rLq6oFLpVyT+W1YWD/0mGnvcVNfrEO0Py/Yu1R8xSuZq+VCrpe5S7nVOlB4zUekTT
         b2xr3lwC80c+ttbB6Z0xPdr+rySS/GNrmaKETYtJCi/IM2sFWv9XKnkM/xbCZAu3opvV
         H0wHg7eqP+uW/Vowy/evSmMWdRnVuxt8eGHzmCkKv+H+HZMlplAQocIR6KZjAffGDGLy
         GP6iOn0LjbAskBh+HXv99Mt0hGYutLhkp6rhVIt91XH1YtIH0LN4YUipDYXAyhur+82T
         FpWQ==
X-Gm-Message-State: AOJu0YyQ1P9113GHV76xAS+IYycs8Nt3NGFbRGnT9h7fydunUCWLXb0R
        XdhnV6vO1khtnkbgH10+Vyk=
X-Google-Smtp-Source: AGHT+IHJv/o0Vaa5FYD3PJhUXLZWmPuYLAh9tWhFxO/oJdOnwqmEe7x83UwC3rtJ0WNfn76O0P4SFQ==
X-Received: by 2002:a17:906:7944:b0:9ad:eb9c:dd00 with SMTP id l4-20020a170906794400b009adeb9cdd00mr1776076ejo.12.1699457378911;
        Wed, 08 Nov 2023 07:29:38 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id b20-20020a170906491400b009b65a834dd6sm1202731ejq.215.2023.11.08.07.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:29:38 -0800 (PST)
Date:   Wed, 8 Nov 2023 17:29:36 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/4] net: ethernet: cortina: Fix MTU max setting
Message-ID: <20231108152936.hkd2g2o2hwqhg5is@skbuf>
References: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
 <20231107-gemini-largeframe-fix-v3-1-e3803c080b75@linaro.org>
 <20231108142640.tmly4ifgsoeo7m3e@skbuf>
 <CACRpkdZ0zH6i8xuZGXq2VEd7brp-dmY89KXmKfxMTk=9eX1EQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZ0zH6i8xuZGXq2VEd7brp-dmY89KXmKfxMTk=9eX1EQw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 03:37:28PM +0100, Linus Walleij wrote:
> On Wed, Nov 8, 2023 at 3:26 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Tue, Nov 07, 2023 at 10:54:26AM +0100, Linus Walleij wrote:
> 
> > > The RX max frame size is over 10000 for the Gemini ethernet,
> > > but the TX max frame size is actually just 2047 (0x7ff after
> > > checking the datasheet). Reflect this in what we offer to Linux,
> > > cap the MTU at the TX max frame minus ethernet headers.
> > >
> > > Use the BIT() macro for related bit flags so these TX settings
> > > are consistent.
> >
> > What does this second paragraph intend to say? The patch doesn't use the
> > BIT() macro.
> 
> Ah it's a leftover from v1 where I did some unrelated cleanup using
> BIT() but Andrew remarked on it so I dropped it.
> 
> Maybe this twoliner in the commit message can be deleted when
> applying?

I think it's better if you do it, there are some more minor fixups which
you could bundle up with a new series.
