Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F82766C27
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbjG1LzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjG1Ly6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:54:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF64B5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20A0562118
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D878AC433C8;
        Fri, 28 Jul 2023 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690545296;
        bh=jBL+22K8k3oi8qSB5q1EObGCgE5WtiNomO2kIvDm49Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6x1IjIDpOfgOgMJEPZQtN7MmxQMqh+KZpdmnPdt6Bq1GKkXKEOSX8QvUcloigyfh
         OHai6OzJatsoTt5xn7AHq8cvrSiKs1TMALD1+Q+gGWYgFXP6QoeZsz/BCnF7LzhKVz
         eJi9ee1WFPjoMmTKW8nkYjqsP8gkGZ5KGL7OdaN0alhZmKeFehltuDPdjKRbC2t7n8
         Vq509Ofz63bjs3OO9CM2xKXQGgBcHqm2cEAEIBgU508Ve7JmWumwRv8smjokNO93vH
         3LseZwd5930UUg2JhNXRzppb6sddDX5UIGJrTQb8LJTua9ssQiaxn5b9v7607eOPYS
         aMwikQeug4bDg==
Date:   Fri, 28 Jul 2023 12:54:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/fpsimd: Only provide the length to cpufeature for
 xCR registers
Message-ID: <89a8e191-63e0-4237-879e-03130fb07f88@sirena.org.uk>
References: <20230727-arm64-sme-fa64-hotplug-v1-1-34ae93afc05b@kernel.org>
 <20230728112720.00005ee6@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FQX97XPkgudQ/lMU"
Content-Disposition: inline
In-Reply-To: <20230728112720.00005ee6@Huawei.com>
X-Cookie: Ontogeny recapitulates phylogeny.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FQX97XPkgudQ/lMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 28, 2023 at 11:27:20AM +0100, Jonathan Cameron wrote:
> Mark Brown <broonie@kernel.org> wrote:

> >  	zcr = read_sysreg_s(SYS_ZCR_EL1);
> > -	zcr &= ~(u64)ZCR_ELx_LEN_MASK; /* find sticky 1s outside LEN field */
> > +	zcr &= ~(u64)ZCR_ELx_LEN_MASK;
> >  	vq_max = sve_vq_from_vl(sve_get_vl());
> >  	zcr |= vq_max - 1; /* set LEN field to maximum effective value */

> > -	return zcr;
> > +	return SYS_FIELD_GET(ZCR_ELx, LEN, zcr);

> Isn't that overly complex if we only end up with the length? (if I'm reading this right)
> Perhaps it is more logical to build the register then pull the
> field out of it, but it would be simpler as something like...

> 	return sve_vq_from_vl(sve_get_vl()) - 1;

We could, yes - I did prefer to keep it clear that this is an actual
if modified register value we're returning, though that could've been a
comment.

--FQX97XPkgudQ/lMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTDrIgACgkQJNaLcl1U
h9BWXQf/dqqsPLMv2CB4YNk84bBsQLmXfts/KM6OGsYoZPcX6miJjVL/5LbbUWgb
FT2OwHWdJ3dOiQyAx1bI/9XH3W+/KYHxdY3sFUcl+AUDUN8c7EG+NqNnAUoNaNeY
nLUaWTU465jrgA6n9Sjr2mBGDyE6SCWa8wrn7D+xRKFj6JT79n8pcQykYx790l+g
9x78SYAy63VFXsU+v0lam0q/HvVKGwaX5CFNm/+RYvKz6ztFnTHpve8oDwTpibZZ
0B+TUcSlVHzlt0Xana0HYjRTuRw8sIeJHVK4tMl+27OzmB9xhZea7Zn+3QcEGPTW
WHZz4UvExk/+CEEu4e86zTJH6W0WeQ==
=Z5gV
-----END PGP SIGNATURE-----

--FQX97XPkgudQ/lMU--
