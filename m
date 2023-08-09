Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3C8776B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjHIVzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjHIVzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:55:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A530A6;
        Wed,  9 Aug 2023 14:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30072611E6;
        Wed,  9 Aug 2023 21:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4C7C433C7;
        Wed,  9 Aug 2023 21:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691618142;
        bh=GBr8tP2xiR6kjAiKJjegxph8j+qf/XK7FEXmUzHGfvw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cNf7z67Owtgupg9IttvWd1t/X9qF1l4mmgKeGs80EmheYnbCsDypIuDu+/DnNuqty
         Na93XYJKdBf21P3iZrhKeUwCmgYbeSTujeGxg5zL8ImEby++YRSud1bhw06ozyo4PD
         cffqsGTr86j+OM74cHhsE7xMFsjXxJz0en4E2AyYuncRb2dvCXL7d+t8RJCjTDKeZz
         2iG5B+WpdmkHNLkVORs/VCg9y/42ynvS2csdXDKMIMY5SnQAq4QzpTF5ZXcMSjYfJT
         ihcq2nvjzDbP+YGCA7d6rRnfoyUeLRG8AHF9cWkq0dqtx2StELpz9LbyPwp7sZhZqK
         duFuLxyVUAxnQ==
Message-ID: <0dde6d95f4e92da68ad3a3122056bfbd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jpm3xoea9.fsf@starbuckisacylon.baylibre.com>
References: <20230731042807.1322972-1-wenst@chromium.org> <1jpm3xoea9.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH] clk: meson: meson8b: Simplify notifier clock lookup
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 09 Aug 2023 14:55:40 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2023-08-08 06:21:46)
>=20
> On Mon 31 Jul 2023 at 12:27, Chen-Yu Tsai <wenst@chromium.org> wrote:
> > @@ -3847,9 +3846,7 @@ static void __init meson8b_clkc_init_common(struc=
t device_node *np,
> >        * tricky programming sequence will be handled by the forthcoming
> >        * coordinated clock rates mechanism once that feature is release=
d.
> >        */
> > -     notifier_clk_name =3D clk_hw_get_name(&meson8b_cpu_scale_out_sel.=
hw);
> > -     notifier_clk =3D __clk_lookup(notifier_clk_name);
> > -     ret =3D clk_notifier_register(notifier_clk, &meson8b_cpu_nb_data.=
nb);
> > +     ret =3D clk_notifier_register(meson8b_cpu_scale_out_sel.hw.clk, &=
meson8b_cpu_nb_data.nb);
>=20
> Hi Chen-Yu,
>=20
> Your patch seems valid, as CCF stands right now.
>=20
> However, I believe there is a will to drop the 'struct clk' instance that
> automatically gets created with each 'struct clk_hw'. This change would
> not help going in this direction
>=20

Yes. Use clk_hw_get_clk() here, or introduce a
clk_hw_notifier_register() API that does that automatically. We will
have to put the clk on unregister path as well though, so maybe struct
clk_notifier needs to be extended to store the clk_hw pointer. The
notifier code kinda needs an overhaul to be clk_hw/clk_core aware. I
think it predates the introduction of struct clk_core? It's a bunch of
work I've been putting off.
