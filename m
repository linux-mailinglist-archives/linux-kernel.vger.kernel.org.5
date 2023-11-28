Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A257FC123
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbjK1RzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346688AbjK1Ryu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:54:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5EC19A7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:54:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D643EC433C9;
        Tue, 28 Nov 2023 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701194094;
        bh=N3vZMmlwPmMLxmgsU8NU5aW8UlcCxY+iRKRi4fSgJas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hsiw/925cVatmSVS2Mjf+lwGsahVcUe9gEJwVlcmNPn+zWbmwNZ2MPg9C24I1RYFq
         skwNvzE0segMkYvoLC58hDXsNzhnsX3tfykvPEfkeBlgAQXPLVjPalu2EOmmIgvATQ
         aoxfGaC2vUW1mpXBAFr/E2qRXkpGsa6WRLj3i45jI8GsHf/aJokHiMdpDsswRmp4Ah
         DfMLen3NJkBkTvG87EMmW3JR0n8L0v4+iXgXwtJcN0VoeGH7M1OgsO9pWPe5lQyExH
         iZTLYaSNqnPLlBpXSFPrzBksF+fRvVV8C9J7TpdYC6shFoTQk/+7WWgpHw8LPVNmEh
         zdq2ORS22eNSg==
Date:   Tue, 28 Nov 2023 17:54:49 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        ebiggers@kernel.org, ardb@kernel.org, heiko@sntech.de,
        phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 04/13] RISC-V: crypto: add Zvkned accelerated AES
 implementation
Message-ID: <20231128-await-tipper-2094715466f2@spud>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-5-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c+Bx+5YDpVONEprp"
Content-Disposition: inline
In-Reply-To: <20231127070703.1697-5-jerry.shih@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c+Bx+5YDpVONEprp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +static inline bool check_aes_ext(void)
> +{
> +	return riscv_isa_extension_available(NULL, ZVKNED) &&
> +	       riscv_vector_vlen() >= 128;
> +}

I'm not keen on this construct, where you are checking vlen greater than
128 and the presence of Zvkned without checking for the presence of V
itself. Can you use "has_vector()" in any places where you depend on the
presence of vector please?

Also, there are potentially a lot of places in this drivers where you
can replace "riscv_isa_extension_available()" with
"riscv_has_extension_likely()". The latter is optimised with
alternatives, so in places that are going to be evaluated frequently it
may be beneficial for you.

Cheers,
Conor.

--c+Bx+5YDpVONEprp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWYpaQAKCRB4tDGHoIJi
0gizAQClyXLat6AoDqeEMU7fszIl0aqY562jWFVvkg9MjgR24gEAzNdLynP6jTGp
PoJqYxyEhhUhpsxklOCYQbwZPyDf8ws=
=ixTm
-----END PGP SIGNATURE-----

--c+Bx+5YDpVONEprp--
