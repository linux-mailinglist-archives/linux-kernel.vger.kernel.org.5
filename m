Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638FD767BE4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 05:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbjG2DY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 23:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjG2DYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 23:24:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4CD449F;
        Fri, 28 Jul 2023 20:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F09FD6222E;
        Sat, 29 Jul 2023 03:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42532C433C8;
        Sat, 29 Jul 2023 03:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690601062;
        bh=tzfcUMEsa6qQ3o+p2fOHRdgvjlj355uXQFWaq1QTbSE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YvSvOZkrek1REnM9fDfijfiR2/AE4KfpZjQz1Gl4oP/IBugrHC5t34NkCQ6Baaa1m
         aBsODnWMsRcrNXY1lf28f1PgcZBkbDM62klUilbvt+8FYAZZZYhDXg4JaXhWWPhvVg
         RZpMDY7X87vdrA+CW6rOjpJTi673600W3fYH7LBHvfquaYeHF07KCe8ooNk8xUn6WH
         tdCgzChxunNraBaZQM/xavUivUDHH415YNZsBc0JMjtSm6ZJZy8ML8CpDtMK9Sff0K
         U/qyJZ2lpqBVld9+myN0ZXbFDHAAWkGTWiMzufrIakCnHc7InWTkN+nrDPaRE0fW8R
         v2AWidsuYSwqg==
Message-ID: <f4bb6c51f66325c388a43b9336ffa45b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <vnps4c6o6nsvazyggdqhhqedwsf7vrucc2kpiwpuozi7e2e7tc@celmt367ov73>
References: <20230612033904.34921-1-zhanglibing@cdjrlc.com> <0dc9409b662180ed29cbc281f0f076b7@208suo.com> <fcd37e67fba625da304fdaf07e0ab0db@208suo.com> <CAMuHMdX0xP5Gugo7uF5Wqk9_ny6-4fOWYRm41KicOo26kC6m+g@mail.gmail.com> <nt6kbounehvfqo4hpfj3wbr7baukuhr22dafvoykgyehs4imsp@pc6bajyo6ugn> <CAMuHMdUHDK9CCJPoMgLQBrXjk9VWszYF17dUU=9JtQ8XX=QAPA@mail.gmail.com> <2xp54apmm6o5np34obv5muus5d2lpoo7fn6ozuzzj6p4f2whot@c3pji7twevci> <vnps4c6o6nsvazyggdqhhqedwsf7vrucc2kpiwpuozi7e2e7tc@celmt367ov73>
Subject: Re: [PATCH] clk: baikal-t1: Using div64_ Ul replaces do_ Div() function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     wuyonggang001@208suo.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Serge Semin <fancer.lancer@gmail.com>
Date:   Fri, 28 Jul 2023 20:24:19 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge Semin (2023-07-27 05:28:47)
> On Mon, Jul 24, 2023 at 05:11:23PM +0300, Serge Semin wrote:
> > On Mon, Jul 24, 2023 at 03:38:49PM +0200, Geert Uytterhoeven wrote:
> > > > >
> > > > > Likewise.
> > > >
> > > > Right. This will also break the driver.
>=20
> No news from Yonggang meanwhile the patch will certainly break the
> driver. Is it still possible to drop it from the clk-cleanup and
> clk-next branches then before it gets to the mainline kernel?
>=20

I've dropped it.
