Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6024C80AA22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574420AbjLHRJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjLHRJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:09:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03140AD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:09:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3329C433C8;
        Fri,  8 Dec 2023 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702055350;
        bh=/IphcbvtWoyG/fdkcm9lA/I86nGtTbDJid5q4OPmEp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ptJPFirgLLzF4T9HWYpbubQGoTykPHi7WT2waoDAsLMD6zIR3crBpBCYOU97GrC5M
         0FTe8NhXD23I5iDp/Pbschttbk74s0fCaip0kwsrcfJJXJtJMdkVcITZJddmTj8K2E
         2zdXeK8JrovcaeUTLQrqGbypNw8vpDB+XOxpsggn6sorHggDihewFzdAJJKkFnMydF
         mBmtq9N89lMSWgH76ElNC+T35o3B+lDqEU+X7E+hscnZo9DL03TuOTduToMCkiLRBL
         rz7Anh7o7D0lZSUYHDOPKpcZ6JkreGHTFnTSvefUOXnxSalgPiyO3wZVDJCH+Ljbom
         ZAvDReaocRJjA==
Date:   Fri, 8 Dec 2023 17:09:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v1 0/7] MPFS clock fixes required for correct CAN clock
 modeling
Message-ID: <20231208-majestic-train-ee55b30de95a@spud>
References: <20231208-sizably-repressed-16651a4b70e7@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FA6cKNTv83r5pITX"
Content-Disposition: inline
In-Reply-To: <20231208-sizably-repressed-16651a4b70e7@spud>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FA6cKNTv83r5pITX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 05:07:39PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> While reviewing a CAN clock driver internally for MPFS [1], I realised
> that the modeling of the MSSPLL such that one one of its outputs could
> be used was not correct. The CAN controllers on MPFS take 2 input
> clocks - one that is the bus clock, acquired from the main MSSPLL and
> a second clock for the AHB interface to the result of the SoC.
> Currently the binding for the CAN controllers and the represetnation
> of the MSSPLL only allows for one of these clocks.
> Modify the binding and devicetree to expect two clocks and rework the
> main clock controller driver for MPFS such that it is capable of
> providing multiple outputs from the MSSPLL.
>=20
> Cheers,
> Conor.

Whoops, that was meant to get a dry run arg... Please ignore!

--FA6cKNTv83r5pITX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXNNsAAKCRB4tDGHoIJi
0js1AP9ZqKk/YBSEPrALxRtNPh7qmxhWn6pQU0kY4tNa5xZ++wD/b+Aro0mcj91z
Tut9u4n6gLOaDGjwvPG1K/0/eD5mzAg=
=yfBZ
-----END PGP SIGNATURE-----

--FA6cKNTv83r5pITX--
