Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC3784D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjHVXBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjHVXBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C409E45;
        Tue, 22 Aug 2023 16:01:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF30E638D1;
        Tue, 22 Aug 2023 23:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F8AC433D9;
        Tue, 22 Aug 2023 23:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692745306;
        bh=5nZO/EA7xNC0zbfhm7E3kKtBi2sQs7kn8lqJX9i1moQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kFfl8kbg4KZrdf2pK6oqno0lo1RVgBYPaJ1Ry7rEJ9uMjKXAx9MB/UJjCxwjzJALQ
         +TJR+zwHTTmUxWnGdWIT4ef8SdHbpRLYrck6r7+hRLfGlbLe0A7HxHMk+ZCbTw4QZm
         J6cauK3lLaooPguYa79+YfdehebtYPe1lBj9ViSkx55KLHcUsrJt+JUZhXr+fDtB2Y
         fCrldC8dH8GeFYAS0JVNlgYsevE/DxAV8A5OhwJ9kC7wt5SQO0KLPGWbYOBr/XUXwO
         MNi9GHujl40bkvfxlwevKlKa/zu70Frt82S8JiZBE4BXi8RHL4wXiAf+Xv6bBi/7E1
         F60zLZ3oI2A6Q==
Message-ID: <ff6a9b1567e0a36fd0a7ae628d2d92d4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8cfd376d48d63670882b8079c411d605@208suo.com>
References: <20230721011303.4303-1-xujianghui@cdjrlc.com> <8cfd376d48d63670882b8079c411d605@208suo.com>
Subject: Re: [PATCH] clk: keystone: sci-clk: fix application of sizeof to pointer
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     kristo@kernel.org, mturquette@baylibre.com, nm@ti.com,
        ssantosh@kernel.org, sunran001@208suo.com
Date:   Tue, 22 Aug 2023 16:01:43 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting sunran001@208suo.com (2023-07-20 18:14:19)
> ./drivers/clk/keystone/sci-clk.c:390:8-14: ERROR: application of sizeof
> to pointer
>=20
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/clk/keystone/sci-clk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/keystone/sci-clk.c=20
> b/drivers/clk/keystone/sci-clk.c
> index 6c1df4f11536..2c68c1e09d1f 100644
> --- a/drivers/clk/keystone/sci-clk.c
> +++ b/drivers/clk/keystone/sci-clk.c
> @@ -389,7 +389,7 @@ static struct clk_hw *sci_clk_get(struct=20
> of_phandle_args *clkspec, void *data)
>         key.clk_id =3D clkspec->args[1];
>=20
>         clk =3D bsearch(&key, provider->clocks, provider->num_clocks,

Huh? I see 'provider->clocks' is struct sci_clk_provider::clocks which
is of type 'struct sci_clk **'. It looks like each element in the array
is a 'struct sci_clk *', so if we want to silence the coccinelle warning
perhaps this should change to sizeof(*clk). Certainly we don't want to
change it to be the sizeof(struct sci_clk) though. Does changing the
sizeof() to deref the pointer work to silence the error?

> -                     sizeof(clk), _cmp_sci_clk);
> +                     sizeof(**clk), _cmp_sci_clk);
