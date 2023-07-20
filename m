Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA775B147
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjGTOcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjGTOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:32:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635AF26AB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E876161B18
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ECEC433C8;
        Thu, 20 Jul 2023 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689863518;
        bh=iPzNO7X2MelLib6Lb/uO/HfywfFgfsM7P7t9oYBcocw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIKNiOaYaB3xNyyN+i4yiw2xluhjenAUgXe1hgcwgz3Ois7iJ1bI3JyQzdPM6QPNY
         bBi6kNe91a7vfiiL/ZOQfXORatu/gF5BST35i7h2HF1ju0mBju7YmSUxgNnua/nZaN
         Ljj0Y78y7dtm0d4n3ncxLvKnCutFxsPBvs46KXqUmSu6sNINjqE037wycAJvZJ355t
         QVXWn+y3sfbZLEwuLmThrIa4MLiJ/Y4ftWqkQiKxEMu9udajVL0XuOUYaWF63bf99r
         mLRLVY6yFBkdIhpR8REPCxJFhnsi69LJlr1ShqoN/5Up3o/ejnDxgLk/3Uh+BR+Gpk
         gMgPojUMIGWpQ==
Date:   Thu, 20 Jul 2023 15:31:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Traceback with CONFIG_REGMAP_KUNIT=y+CONFIG_DEBUG_ATOMIC_SLEEP=y
Message-ID: <055f2564-551d-4b5f-a6e3-d54ae104d5c9@sirena.org.uk>
References: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
 <336fc14e-f734-49ea-97ce-802f03fa4422@kadam.mountain>
 <198c4edf-045c-8d85-1d5c-018378eeb490@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RcGRkRsZXz5WkioE"
Content-Disposition: inline
In-Reply-To: <198c4edf-045c-8d85-1d5c-018378eeb490@roeck-us.net>
X-Cookie: Ginger snap.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RcGRkRsZXz5WkioE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 07:26:54AM -0700, Guenter Roeck wrote:
> On 7/20/23 01:50, Dan Carpenter wrote:

> > +++ b/drivers/base/regmap/regcache-rbtree.c
> > @@ -187,7 +187,7 @@ static int regcache_rbtree_init(struct regmap *map)
> >   	int i;
> >   	int ret;
> > -	map->cache = kmalloc(sizeof *rbtree_ctx, GFP_KERNEL);
> > +	map->cache = kmalloc(sizeof *rbtree_ctx, map->alloc_flags);

> Yes, that might work as well (and after looking more deeply into the code
> I wondered why it wasn't used in the first place).

> Based on Mark's feedback I submitted
> https://lore.kernel.org/lkml/20230720032848.1306349-1-linux@roeck-us.net/
> Sorry, I forgot to copy you on that one.

> Mark, please let me know what you prefer.

They're both independently fine, but I wouldn't expect anything that's
running in atomic context to be actually using dynamic allocations.

--RcGRkRsZXz5WkioE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5RVkACgkQJNaLcl1U
h9D+Kwf+NSCwI48CLb02RZFr30GHsVnyIpKqqE8nqAfh9M9pIqR7ebMwxAFr6zxG
6RYvZovr2Qsd4dXvUJfjxwnhaaRQCIE2/vmEkACi/mXZupMn/E1lYlOxqMCaQ8zD
/ZSXmGXgdXdrIEfRU0DbOeLA/YXr1txOMyHonP6lKpILYGFby9Zi2XKUzVBxwSAE
z7D7eUVtMq4m6tLUs/+ORalpBNi65l2PBxhDsWhHt5yVWMs5PTHzjKB33cobOZ6v
gC2++BxCEUMYrFYdj0P2ylpqDqmhySzwmrfcDUQA2tTbm3P9G1IcWFhUpBQ8Vvza
34RZkjEy8HKzn31bp9ByMNt5ApwbmA==
=kPgT
-----END PGP SIGNATURE-----

--RcGRkRsZXz5WkioE--
