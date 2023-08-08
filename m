Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB0774311
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjHHR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjHHRzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6345D298B0;
        Tue,  8 Aug 2023 09:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B63DB6252F;
        Tue,  8 Aug 2023 12:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18551C433C7;
        Tue,  8 Aug 2023 12:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691498773;
        bh=t7PyoU8AYWJIwvZWdit4Ps/WdiBR7sDlId44lw9ADY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFworbM+/yJt/EfmhyEMhA9+l2c/miHLb6HaHL9AfsivHW54QG4o5rJ+xtfmhbmfl
         KSTCPC7+X6XZkhnqMsjuxz/FcklTSQBgOvrrz6nH9Emi+soxo9GbAX8IireViO+rbu
         epS9AgI4OIh71xEaz1oeMC4LR333iDxuULQEL1x6TUNO/ey/eqnu7vjRxvsgHbMEAX
         zssnpf5nOVNsK9IhpJdaD/IXyqPGgtn0wLLCFOL4NBm+waWjfAuIx9GnDYIHvrELPV
         8lbgSu5vKdvg0NY25hEONWmZh6/ZFACWHZtic8o2IsF2uOCFoOrpxGkybit3viqKpy
         YQYl0oS1JoHBg==
Date:   Tue, 8 Aug 2023 13:46:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Set default value if reg-io-width isn't
 specified
Message-ID: <1505ec01-186d-451a-9164-d42796954c01@sirena.org.uk>
References: <20230807001621.196776-1-hayashi.kunihiko@socionext.com>
 <az7wvv5f42mnuuwkqzpfmwg4ngvl4jvpcfmns7d6lhzogc4qdi@ox64l6i7b44r>
 <213763b3-5a8b-3a88-54f1-024325f7fe80@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TJalYs/MizfFRmvC"
Content-Disposition: inline
In-Reply-To: <213763b3-5a8b-3a88-54f1-024325f7fe80@socionext.com>
X-Cookie: You need not be present to win.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TJalYs/MizfFRmvC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 08, 2023 at 09:00:18AM +0900, Kunihiko Hayashi wrote:
> On 2023/08/08 7:57, Serge Semin wrote:
> > On Mon, Aug 07, 2023 at 09:16:21AM +0900, Kunihiko Hayashi wrote:

> > > According to the dt-bindings, the default value of reg-io-width is 4.
> > > However, the value becomes zero when reg-io-width isn't specified.

> > This semantic is implied by the dw_read_io_reg() and dw_write_io_reg()
> > methods. It doesn't seem like that much necessary duplicating it in the
> > property parse procedure, if not to say - redundant.

> I see. Currently since the variable reg_io_width has no other references
> other than dw_{read, write}_io_reg(), it means the default value is taken
> if this is zero.

> So, I think we should be careful when actually using the value of
> this variable.

It does feel like a sensible robustness improvement, even if it's not
fixing a specific issue now it might save us from future issues.

--TJalYs/MizfFRmvC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTSORAACgkQJNaLcl1U
h9AB8wf/ddcf2la7li0vRgQn1O0T32/K+4cecju7caiwiFf/8icP1QlQpElqHyQw
nEIpn+pzs8QWVREykUqKt6WWLI+KhtIDrUuSSs3NoIFkQ7yk9Gacfr4Y/SLP0JCf
uwMaSRVdapPl2ou5KcfyI0MK/Cc1BlMjwNPFb4POpub+0qdJRp8ImCeKfy7wzKSr
Tx0d7tv/IxzjD3ScGT6ydIm6BTFLJg2g6WXgeJMZQLmX3Kqv1J0Th376pxMNpqST
EoXlOy5DlAHs3X21KnUeThzEYd8NhCdhi1WYK/02LPG21geKPnYYgsOf3KBbh5nG
Zx0Ufq9+SoGZEJRJ99eR97Uy09USVQ==
=2aGO
-----END PGP SIGNATURE-----

--TJalYs/MizfFRmvC--
