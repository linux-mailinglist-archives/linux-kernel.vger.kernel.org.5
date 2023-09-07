Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEE4797A76
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245279AbjIGRkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245262AbjIGRk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:40:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F852128
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:39:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E202FC433BC;
        Thu,  7 Sep 2023 09:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694080365;
        bh=4NjL8K4R6fpztrR/Dgccj7AXRwKd3L0DWcJs2pDqGtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huYT4+giRmWYVqxUCb9V8Z4oo1OqM0S8aq9h96mmxlmVHzH+Y5cEl36UeRPZCWZKZ
         DdkNYGG4JQkfTV6FDL1tayxgnHfpFXQb3YJCif1hAPMBF3VNUasz0Ir3+G0DL97rc6
         dvyqbrePU+Tst4xzKAgYdaTopqurD9bdMR/OkDKZ8z74dzj3+DXUHFs+KfwbFlCoNq
         44LUdtdmK8mmpA6rc5zhH8nDCHzpZ9cU3HMktWXLkYkIb4ejYIIFahQpZtqEtNc7+K
         AaFZRjPUUV42/1RwGy/q4fe2woxpNyFPIey0qKbN8lGtfC+l6UVY0Y+G4UTpgwlkEW
         a4uz4TvLf38dQ==
Date:   Thu, 7 Sep 2023 10:52:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 2/5] riscv: Add checksum library
Message-ID: <20230907-9d5d2e7ef2a20edd75514470@fedora>
References: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
 <20230905-optimize_checksum-v2-2-ccd658db743b@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3Gz+z7jGL7ncD+4"
Content-Disposition: inline
In-Reply-To: <20230905-optimize_checksum-v2-2-ccd658db743b@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3Gz+z7jGL7ncD+4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 05, 2023 at 09:46:51PM -0700, Charlie Jenkins wrote:

> +#ifdef CONFIG_RISCV_ISA_ZBB
> +	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
> +		/*
> +		 * Zbb is likely available when the kernel is compiled with Zbb
> +		 * support, so nop when Zbb is available and jump when Zbb is
> +		 * not available.
> +		 */
> +		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop",  0,
> +					      RISCV_ISA_EXT_ZBB, 1)
> +		    :
> +		    :
> +		    :
> +		    : no_zbb);
> +	} else {
> +		if (!__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_ZBB))
> +			goto no_zbb;
> +	}

Again, do these constructs have an appreciable benefit over doing
if (!riscv_has_extension_likely(<ZBB>)
	goto no_zbb;

?

That encaspulates the fallback to a non-alternative mechanism for you,
in case you had not noticed.

--u3Gz+z7jGL7ncD+4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPmdYwAKCRB4tDGHoIJi
0gPaAQCWfaA4BsurBPCfNHsJ5cIRXgEUpRYKmdhLrs1tMc9gmgEAvioIEb04cNY2
OYY8B8G9Z3xdn8bl0pskyuYYaS9NWQg=
=KM80
-----END PGP SIGNATURE-----

--u3Gz+z7jGL7ncD+4--
