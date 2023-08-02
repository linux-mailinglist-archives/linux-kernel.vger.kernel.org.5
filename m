Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EEB76D4FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjHBRVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjHBRVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A0011D;
        Wed,  2 Aug 2023 10:21:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C16A961377;
        Wed,  2 Aug 2023 17:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E76C433C7;
        Wed,  2 Aug 2023 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690996865;
        bh=V+7J5iMl8WESEj4Cb67K/RCJO33+poqVvT0BwhRiAxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IgN5nEWimzIHei44JnWou6LQO2Xz9xfPWdUscdopUP3nSooYinHWCg51jQogAfXCh
         IkP6GhQ+mWg9fu5H5Ylu5pp8M8S9DubR+sNfef+b7QkdlI3aLBv+VY9kbCSFXNko1M
         a4LpE7eIjsqQMxv6qZvfVOJI5KaJjkEcsyDVfbPAsTHiTjH7gzARVyv3ls+Rk7dAcw
         oFluHqcZAfL5yarEIALIealee/EZtOXpNYeHws0R8PE5Cit3KKuP7M7F5RUJEfKHvf
         3h90SnbMmrxXFmpJTfEh1knoGeZOmGYAPY2XvZEweDFLZBWuON3IFtLaTBq4zHtY3D
         S2iJcB24T0hyg==
Date:   Wed, 2 Aug 2023 18:20:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 01/15] RISC-V: Add riscv_get_intc_hartid() function
Message-ID: <20230802-deviancy-vengeful-cbecf4350526@spud>
References: <20230802150018.327079-1-apatel@ventanamicro.com>
 <20230802150018.327079-2-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2kdZzoSQMTLDssYb"
Content-Disposition: inline
In-Reply-To: <20230802150018.327079-2-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2kdZzoSQMTLDssYb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 02, 2023 at 08:30:04PM +0530, Anup Patel wrote:

> +/* Find hart ID of the INTC fwnode. */
> +int riscv_get_intc_hartid(struct fwnode_handle *node, unsigned long *hartid)
> +{
> +	int rc;
> +	u64 temp;
> +
> +	if (!is_of_node(node)) {
> +		rc = fwnode_property_read_u64_array(node, "hartid", &temp, 1);
> +		if (!rc)
> +			*hartid = temp;
> +	} else
> +		rc = riscv_of_parent_hartid(to_of_node(node), hartid);

This branch needs to be enclosed in braces too.

> +
> +	return rc;
> +}
> +
>  DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);


--2kdZzoSQMTLDssYb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMqQewAKCRB4tDGHoIJi
0oI/AP4mfxD8KI2kW8xjXStGxSzehmET1254kpoBNm9rD/RP+gEAuB0Z2Cgramuw
EoCQ4U+WeJmvdDUdCguKiECHDM8AZgo=
=w4op
-----END PGP SIGNATURE-----

--2kdZzoSQMTLDssYb--
