Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4757EA8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 03:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjKNCNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 21:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjKNCNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 21:13:48 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB062D46;
        Mon, 13 Nov 2023 18:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699928021;
        bh=bfwQgbnr3uPqinHx2I45+hDAQq90P+NrKF252UH8xN8=;
        h=Date:From:To:Cc:Subject:From;
        b=VL1Yod4b90x/DNrpkY465Zbjc8UP7P53iaR8wwO+gsUQuInGXS30qawvqU0Kt/j8y
         OxBHlDA15+WQCEU3XlvxRljW4McRRgam66+umekRCW9Vckolwd3YiuUTjxhY8NJ+hg
         DQ0svm2g35coK/3yMCCNlMQj8/p/JeUqo/LE6flshySrzCSbrGQe5eiSwU6CDrW2Cz
         R2JtSNv+793qeUCtdG5A4eXwtgE9M3sZQWbha+loDes64Pg9RQuzTG56lb7lgYqEmr
         4uwtOiAqoldP3FDlRDJ1eH79IFFJkj0ExinARqys7cJv9Bcr5LwTiEw6MkNhkzVX8b
         1SOIrRRhKMMtw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4STqbT2yFFz4wcH;
        Tue, 14 Nov 2023 13:13:41 +1100 (AEDT)
Date:   Tue, 14 Nov 2023 13:13:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pinctrl tree
Message-ID: <20231114131335.3aba4f4d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZWwQvSDGULCaDm68s/m8.in";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZWwQvSDGULCaDm68s/m8.in
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pinctrl tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:232:10: error: 'const struc=
t lpi_pinctrl_variant_data' has no member named 'flags'
  232 |         .flags =3D LPI_FLAG_SLEW_RATE_SAME_REG,
      |          ^~~~~
drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:232:18: error: 'LPI_FLAG_SL=
EW_RATE_SAME_REG' undeclared here (not in a function); did you mean 'LPI_SL=
EW_RATE_CTL_REG'?
  232 |         .flags =3D LPI_FLAG_SLEW_RATE_SAME_REG,
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                  LPI_SLEW_RATE_CTL_REG
drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:232:18: error: excess eleme=
nts in struct initializer [-Werror]
drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c:232:18: note: (near initial=
ization for 'sm8650_lpi_data')
cc1: all warnings being treated as errors

Caused by commit

  c4e47673853f ("pinctrl: qcom: sm8650-lpass-lpi: add SM8650 LPASS")

I have used the pinctrl tree from next-20231113 for today.



--=20
Cheers,
Stephen Rothwell

--Sig_/ZWwQvSDGULCaDm68s/m8.in
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVS188ACgkQAVBC80lX
0GwXUQf/UDR4Qc88Viu0PZAaBiK6xBxJ9MPgOn0mH7/y3fSQZAI+Qwm1mkJ8je4n
YWaofMX7mFE1N0GZJlUSRGXrbngrRBzzPiGw4jzCaP+KbeGgAjr+vtTZuTVs/VMW
/dpTAh2UL2G+05RfMJ+EaOKmANS/nkVtJfS2Q4sjGANPChPOJrUdXaD1ZieUHoMN
x2tQJda++09f2npw6tni1Q+41CiKcmTQ4/mthSClGaia8QYhfukjesEyj2rep3o0
2A9TfAUpgKPUTq68X7WVIvqsvx5lDB+i0uNE4HwzM1Tvglpo+KCECa+Zxu5nuRJF
ewMoIXINPyGbWHqWcJ8qtAy4CRvN0g==
=esfr
-----END PGP SIGNATURE-----

--Sig_/ZWwQvSDGULCaDm68s/m8.in--
