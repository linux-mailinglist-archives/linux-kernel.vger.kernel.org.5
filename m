Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D39D7D7E07
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjJZIEK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 04:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZIEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:04:08 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643ACAC;
        Thu, 26 Oct 2023 01:04:06 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7af52ee31so4622797b3.2;
        Thu, 26 Oct 2023 01:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698307445; x=1698912245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB0o43vI8z74zHN6iTW8mGP9lEUheGzyrHw+L3QBcAU=;
        b=JeA1TQpH5XF6GXKsOr36H4iFgCCgLV0o7V3peAva9X6sAt9c/S5O7CK77q5k9bcO+J
         HICNMC2D+8nua+W28UGgzdIlEieu4Qqw2OYxXHbCY4DKj/W8CCAjuxVrqwYaoyAibF3h
         P7FehwUNz7ZRxVK/2Byjov9+KsdTjSPT0P5+W2y6ll8NV/msn7MdGGNY4YDPqusf+l4X
         nBCb4zvcwfYoiQk9B+ILLKkaz3p2rp91/kFyjRhWw7gw64/E+tBlaTFfOnjX97PhCYs9
         FaYKQ9dnCWeXDwLWhSVhHKWZJUWocnn88Iw006zchI72uKmZkaPVuL6v1lJCTztHxcBR
         RIQA==
X-Gm-Message-State: AOJu0YyB//pSvqqNTPaLeJfpxgFrr+UEmLDEhh+XOUom2c1wr9TZjxB1
        rnlpuQv7jq6TE2POMSzDXbcdSv1w5gGsrQ==
X-Google-Smtp-Source: AGHT+IE9ex1R+42ZVJcYrtkyoj3B4oqnZd2OfHE5JGCl6BPlE6pkYARcDhF/dg4Cg2aLDESbuS4wCQ==
X-Received: by 2002:a81:48ca:0:b0:5a7:c973:c82 with SMTP id v193-20020a8148ca000000b005a7c9730c82mr18888071ywa.13.1698307445417;
        Thu, 26 Oct 2023 01:04:05 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id j143-20020a819295000000b005a8a7d4f9a5sm5745999ywg.28.2023.10.26.01.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 01:04:05 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a7af52ee31so4622687b3.2;
        Thu, 26 Oct 2023 01:04:04 -0700 (PDT)
X-Received: by 2002:a0d:e84b:0:b0:589:8b55:f7f7 with SMTP id
 r72-20020a0de84b000000b005898b55f7f7mr17337962ywe.39.1698307444821; Thu, 26
 Oct 2023 01:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231026063941.1882023-1-peng.fan@oss.nxp.com>
 <CAMuHMdUA_OOvQmkZXn21pxC=nTw6wHQZp1P8mNjTca65+KjxAQ@mail.gmail.com> <DU0PR04MB9417B338597E78EA51B7F6DF88DDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417B338597E78EA51B7F6DF88DDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Oct 2023 10:03:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXR1K9+HsJcq+E=BLJpNpgF2vgYY0kv2_2H85oGq6wpXQ@mail.gmail.com>
Message-ID: <CAMuHMdXR1K9+HsJcq+E=BLJpNpgF2vgYY0kv2_2H85oGq6wpXQ@mail.gmail.com>
Subject: Re: [PATCH] clk: clk-conf: bypass setting rate/parent if already same
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "clement.leger@bootlin.com" <clement.leger@bootlin.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "pure.logic@nexus-software.ie" <pure.logic@nexus-software.ie>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "absahu@codeaurora.org" <absahu@codeaurora.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Thu, Oct 26, 2023 at 10:01 AM Peng Fan <peng.fan@nxp.com> wrote:
> > Subject: Re: [PATCH] clk: clk-conf: bypass setting rate/parent if already same
> > On Thu, Oct 26, 2023 at 8:35 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > If the original rate and parent is already the same as what users
> > > wanna to configure through assigned clock rate and parent, there is no
> > > need to configure them again which may cause more cpu cycles or more
> > > SCMI RPC calls.
> > >
> > > So check the rate and parent first, and bypass when the original rate
> > > and parent are same as requested by device tree node.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>

> >     /**
> >      * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
> >      *                This is only valid once the clock source has been enabled.
> >      * @clk: clock source
> >      */
> >
> > So at least the second part is not guaranteed to work?
>
> I am not sure, but seems there is no clk enabled check in clk_get_rate
> function.

There is indeed no such check.  On most hardware, clk_get_rate()
works fine when the clock is disabled, but that is not guaranteed to
work everywhere.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
