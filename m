Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D876759EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGSTkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSTka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:40:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA2C11C;
        Wed, 19 Jul 2023 12:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CFE2617F4;
        Wed, 19 Jul 2023 19:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69EFC433C7;
        Wed, 19 Jul 2023 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689795628;
        bh=EXBuHUSa0yoSSKIi58cyfyt8k6/rczE7CI5TV0Q9sbw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=f5KXu4u18pX8w/bhoDCQEU/VXLVOFDy+kF4NEaBkkFZABXeZ8jy1BL1S787JwxTwv
         rKhEOnhsY4ZkAnKE+PGC1Cx8tiA1n58V9nnDl7IOeR7eeJiOQvk3ZM8ibD26xhC+nD
         whoGLUIpr2YAiXQaS7fo2g+6ssJYS4wEOve7uGVH5vo9glYucZqXKgA9VEbfNRlh1t
         KW3v52Yx/bm74MaVXnAhALXkw4wpJYB9Ap4mGoqE2sNLorFDNkBBDISObAy1BCIECE
         mcYk8QHU7dMdxWKaAitMdNPINI0BmLQQdK765y8qDO9kwkxXN6BpwNw6vo/GeiYEeL
         4tl/Gn0p63HAw==
Message-ID: <25fd7919e449d2a6ffe69c8cb50ba34c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230719074251.1219089-1-wenst@chromium.org>
References: <20230719074251.1219089-1-wenst@chromium.org>
Subject: Re: [PATCH] clk: mediatek: mt8183: Add back SSPM related clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Wed, 19 Jul 2023 12:40:26 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2023-07-19 00:42:50)
> This reverts commit 860690a93ef23b567f781c1b631623e27190f101.
>=20
> On the MT8183, the SSPM related clocks were removed claiming a lack of
> usage. This however causes some issues when the driver was converted to
> the new simple-probe mechanism. This mechanism allocates enough space
> for all the clocks defined in the clock driver, not the highest index
> in the DT binding. This leads to out-of-bound writes if their are holes
> in the DT binding or the driver (due to deprecated or unimplemented
> clocks). These errors can go unnoticed and cause memory corruption,
> leading to crashes in unrelated areas, or nothing at all. KASAN will
> detect them.
>=20
> Add the SSPM related clocks back to the MT8183 clock driver to fully
> implement the DT binding. The SSPM clocks are for the power management
> co-processor, and should never be turned off. They are marked as such.
>=20
> Fixes: 3f37ba7cc385 ("clk: mediatek: mt8183: Convert all remaining clocks=
 to common probe")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-fixes
