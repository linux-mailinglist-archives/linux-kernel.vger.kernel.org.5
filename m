Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4D977E39F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343624AbjHPOcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343657AbjHPOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:32:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555C82716
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E01186630E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB66C433C8;
        Wed, 16 Aug 2023 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692196322;
        bh=GcEwYp6TztIvoHV57BX8j32YSSYSJBrx3eIgVWF2nqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PqWr121xIoP7vi6BlvLBd/qEb9E8WAk2HdhVddrPIhNNgJt7IyXj4ZJj5sFB2B8U+
         CqnYgNKOmmtvz6o7yAbT28ObYlrqTJeDeNN/qZC5lw8+c4TvS0XBlz2NinymaF8QBN
         ghw1Aqfc7RRlhv8g1RN40KzzyqBmAxkB49uCHStKVoyPQhzC+n5k38upYkzpsONnyY
         K0hF6ytFaZ0tWgljEd06phVIXifpuEcBe4qlQL2V+eTzXGE30/bPjUu4vYN9dV14qP
         NuA++LIC75rUhmGEQqTzKT6ocRqec76TiAyowXSKU2SSptNWqKv5xioVcT8yJnFrPv
         jDEyf5ZF4DKqg==
Date:   Wed, 16 Aug 2023 15:31:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Spickett <David.Spickett@arm.com>
Subject: Re: [PATCH] arm64/ptrace: Ensure that the task sees ZT writes on
 first use
Message-ID: <b903e4ce-83c9-4fa0-ac95-8378c436d846@sirena.org.uk>
References: <20230814-arm64-zt-ptrace-first-use-v1-1-fc8e8022140f@kernel.org>
 <20230816142219.GA13526@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s4rNUHRjF2KWGoco"
Content-Disposition: inline
In-Reply-To: <20230816142219.GA13526@willie-the-truck>
X-Cookie: Old soldiers never die.  Young ones do.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s4rNUHRjF2KWGoco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 03:22:19PM +0100, Will Deacon wrote:
> On Mon, Aug 14, 2023 at 10:27:51PM +0100, Mark Brown wrote:

> > @@ -1182,6 +1187,8 @@ static int zt_set(struct task_struct *target,
> >  	if (ret =3D=3D 0)
> >  		target->thread.svcr |=3D SVCR_ZA_MASK;
> > =20
> > +	set_tsk_thread_flag(target, TIF_SME);

> Hmm, this is now weirdly inconsistent with za_set(), which doesn't touch
> the thread flag unless the regset copy succeeds. Is that intentional?

Not particularly, it's just a product of the more complex parsing that
ZA needs due to the variable size and optional payload.  Either way is
fine so long as we allocated the storage but it would be better if they
were consistent, I'll update this to match what ZA does.

--s4rNUHRjF2KWGoco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTc3dwACgkQJNaLcl1U
h9AtVgf9HS5c0fIU8LG6aCTVzGi9dcQfpW6cnpakre3AJZCpNHjXZpBOM0Zg6F2A
4ZkPLxjQHzc3NtHxV1cmUq2L1+wGGRdQGQAXRFioQ6wrDPCepA9QYTG+gsn6k2Ba
9Ov7Vtrj0aCCTaWYDlSxECVSFehAnIYmiWKrDiba4FC4m1/uk//9yh5gEmO3Z1P/
YcMC46CH7WQKlDSTJmzgJeeDc7osxd/o0VA34Prt7/POCpmP8F2VrCnQXbL9tQpG
9zXadPU+Hvb8ice3WEU/Uc0z50XIIg/lyfob4Q+XfJL46LM+L+voA2Ae4RhPT0AV
+tRQlAiDPBoOZd3/xbKRTuEuUp40+A==
=Hdmf
-----END PGP SIGNATURE-----

--s4rNUHRjF2KWGoco--
