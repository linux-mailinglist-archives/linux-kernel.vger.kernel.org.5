Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BB97A551E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjIRVfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIRVfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:35:00 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C18E;
        Mon, 18 Sep 2023 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1695072893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBjUrTB1h6HTKFJu/vUBibZ6e10SxFFPD/tWImLBD8M=;
        b=aQOTQq7w9HVWKEl0ATGzAh6PQ68Fgak1vuBqlFH2PMpa73jk/hz3ktOCyM6KqF5vPaQVDD
        T6WzM8kGPKD3VyhTy/yiueGnkmcvCz7ayvx/2IyJrx3Ju0jTaZirSFgcSwh14GGtU1Lc5R
        h1botIamZ9WUbqAXcIve+PAvDpwEJos=
Message-ID: <0d6b0159552b10548391a9bd88449d12c13fdcd6.camel@crapouillou.net>
Subject: Re: [RFC PATCH v2 3/9] drm/panel: nv3052c: Sleep for 150ms after
 reset
From:   Paul Cercueil <paul@crapouillou.net>
To:     John Watts <contact@jookia.org>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Sep 2023 23:34:51 +0200
In-Reply-To: <ZQi8Z45VCqr-GqN6@titan>
References: <20230918125853.2249187-1-contact@jookia.org>
         <20230918125853.2249187-4-contact@jookia.org>
         <7fc1ca68-ca7c-59b2-0b70-27bc34d83cee@quicinc.com> <ZQi4fFZ0VnsUIiXO@titan>
         <4d2079d66249a7052acded0abf30169a4e95d151.camel@crapouillou.net>
         <ZQi8Z45VCqr-GqN6@titan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 19 septembre 2023 =C3=A0 07:08 +1000, John Watts a =C3=A9crit=C2=
=A0:
> On Mon, Sep 18, 2023 at 11:01:15PM +0200, Paul Cercueil wrote:
> > The datasheet does say a 5ms sleep time is necesary after a reset.
> > I
> > assume the 120ms delay you quote is when a *software* reset is
> > performed in Sleep-out mode. The code here does a hard-reset.
> >=20
> > Cheers,
> > -Paul
>=20
> Hello Paul,
>=20
> Section 7.3 of the data sheet (AC characteristic) says that the reset
> can take
> up to 120ms to complete if the reset is applied during sleep out
> mode.
>=20
> John.

The driver is guaranteed to always reset the panel in sleep-in mode -
as long as the panel was off when the driver started.

What I'd suggest if you really need to support a case where the panel
was enabled by the bootloader, is to read the 0x0a register after
enabling the regulator to read the mode, and sleep 120ms if it was in
sleep-out mode.

But that's only if it's a case that you can test with. I won't accept a
patch that makes sense on the surface if it addresses a corner case
that nobody ever tested for.

For what I know, this patch just adds a huge delay to panel boot-up for
all existing users for no valid reason.

Cheers,
-Paul
