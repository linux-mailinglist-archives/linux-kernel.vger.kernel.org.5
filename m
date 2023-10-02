Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551C37B50A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbjJBKuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbjJBKuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:50:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9509D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:50:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BE7C433C7;
        Mon,  2 Oct 2023 10:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696243804;
        bh=A5TVSy/RyxdaPRDJCSqKK9bT9IOZ2zpzALgJ1vmntiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQ1kpsL7LhwZeZGrGZikZUATmhLoeDHabXkebO4uKQL/jOwgFNFOcvpq64wv9R9L/
         yt4xygnmMB7dQbSZ5SD5EJCepD6bsd5b5TMYfPMbMM19vaJFgcp2eGgNfvr6PugxCW
         6PnHOsFlclCSNQCCyyQ/+RviG6TddSNi9rTucQXkuHlW674XFlGXzI+J0FgY20KVP2
         r8JvFgaD3ZCmg10kj9pTLAkmnB6yy+ulGdRMhx1/mXHBdVtfFadBTokawY91Tli1sm
         9GPklsSA3eVcgCkL/ZjzUQ0yMjmyaTUiM5TNiQCxW1ETz2fhXgWVkOHsbZVZFs+2Ho
         cZLuVlxQazJGg==
Date:   Mon, 2 Oct 2023 11:49:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Topel <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Subject: Re: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
Message-ID: <20231002-spearman-doze-70cc026ac13e@spud>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
 <20230930-patchy-curdle-ef5ee6e1a17c@spud>
 <8ce6cd97-6d63-4174-a290-40690c81e205@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xQd2gXEgEYu731tW"
Content-Disposition: inline
In-Reply-To: <8ce6cd97-6d63-4174-a290-40690c81e205@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xQd2gXEgEYu731tW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 09:40:04AM +0200, Cl=E9ment L=E9ger wrote:
>=20
>=20
> On 30/09/2023 11:23, Conor Dooley wrote:
> > On Tue, Sep 26, 2023 at 05:03:09PM +0200, Cl=E9ment L=E9ger wrote:
> >> Since commit 61cadb9 ("Provide new description of misaligned load/store
> >> behavior compatible with privileged architecture.") in the RISC-V ISA
> >> manual, it is stated that misaligned load/store might not be supported.
> >> However, the RISC-V kernel uABI describes that misaligned accesses are
> >> supported. In order to support that, this series adds support for S-mo=
de
> >> handling of misaligned accesses as well support for prctl(PR_UNALIGN).
> >>
> >> Handling misaligned access in kernel allows for a finer grain control
> >> of the misaligned accesses behavior, and thanks to the prctl call, can
> >> allow disabling misaligned access emulation to generate SIGBUS. User
> >> space can then optimize its software by removing such access based on
> >> SIGBUS generation.
> >>
> >> Currently, this series is useful for people that uses a SBI that does
> >> not handled misaligned traps. In a near future, this series will make
> >> use a SBI extension [1] allowing to request delegation of the
> >> misaligned load/store traps to the S-mode software. This extension has
> >> been submitted for review to the riscv tech-prs group. An OpenSBI
> >> implementation for this spec is available at [2].
> >>
> >> This series can be tested using the spike simulator [3] and an openSBI
> >> version [4] which allows to always delegate misaligned load/store to
> >> S-mode.
> >=20
> > Some patches in this series do not build for any configs, some are
> > broken for clang builds and others are broken for nommu. Please try to>=
 build test this more thoroughly before you submit the next version.
>=20
> Hi Conor,
>=20
> Thanks for the feedback, I'll check that.
>=20
> >=20
> > Also, AIUI, this series should be marked RFC since the SBI extension
> > this relies on has not been frozen.
>=20
> This series does not actually uses the SBI extension but provides a way
> to detect if misaligned accesses are not handled by hardware nor by the
> SBI. It has been reported by Ron & Daniel they they have a minimal SBI
> implementation that does not handle misaligned accesses and that they
> would like to make use of the PR_SET_UNALIGN feature. This is what this
> series addresses (and thus does not depend on the mentioned SBI extension=
).

Ah, I must have misread then. Apologies.

--xQd2gXEgEYu731tW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRqgVAAKCRB4tDGHoIJi
0kh4AQCds9HaaSWc6+G2/rCLAFVWSc9lPYaRIMy/rUFqv/LHyAD/aEHhM10kGhAp
gckNo3pQaPbdit3vo1809F4vJIN+5Ak=
=BRxM
-----END PGP SIGNATURE-----

--xQd2gXEgEYu731tW--
