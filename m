Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847FA756EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjGQVGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGQVGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2EE118
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2852A61277
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 21:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E50C433C8;
        Mon, 17 Jul 2023 21:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689627961;
        bh=GEH6PeqFEn2W/DaCSHTeq2QGKD26VZbQZSk+OehlT2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faaCZCmWlCpPK0T0p4ck4cIgTo3fy4IuuZJI6YrjdctgIBVm9i8JHRhF4kzoz+hLi
         dTi/kuGv3twJDWHClknJOp1o7LNuP7P3HcFQjCC3OFQocZOdEiGI8F/aZh1+fpjPIM
         9I5QzXI0OapMVrO68KL19+gMHcC8N9+j+oCgt+IFL1KQD+EceBWDz+xxJj71pdYAeD
         2RM6+onNFrm17MiqB+mWXvNcKc4FNZ43QgAFL4YRzFz8RtTxr7Ae93oxpYmBIOphHw
         HmHn2SDRd8ZwuVP5vfIwS1uPwTZbIGgXpRsM3DA8KP0eAcOm2I3V17skkLeWF+CUhR
         ZpMPxfMlR5oqg==
Date:   Mon, 17 Jul 2023 22:05:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap-irq: Set IRQCHIP_MASK_ON_SUSPEND if no wake_base
Message-ID: <adf8e9bf-2783-402e-a8dd-7adeb7e09d5b@sirena.org.uk>
References: <20230717191654.1303285-1-samuel.holland@sifive.com>
 <56388e8a-dfc6-4fe7-8aa8-a4b69f201bd0@sirena.org.uk>
 <1C2DB0DE-016C-4F19-9D6F-5C8A0C003273@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yXvDM+k88PaiFYSo"
Content-Disposition: inline
In-Reply-To: <1C2DB0DE-016C-4F19-9D6F-5C8A0C003273@sifive.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yXvDM+k88PaiFYSo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 17, 2023 at 02:54:18PM -0500, Samuel Holland wrote:

> The current problem is that if wakeup is enabled for any IRQ in the chip
> (say, the PMIC's power button), then we enable wakeup for the parent IRQ,
> and now suddenly all (enabled) IRQs on the PMIC are also inadvertently
> wakeup-enabled.

Yeah, I can see the issue.

> But I realize this patch does not actually solve the issue, for a couple
> of reasons:
> 1) regmap-irq does not implement .irq_mask, just .irq_disable.

It's possible we're doing the wrong thing here?  It's been a decade or
something since I wrote this code.

> 2) The __disable_irq() call in suspend_device_irq() should be sufficient,
>    except that we fail the irq_settings_is_nested_thread() check in
>    suspend_device_irqs().

> So maybe the real issue is that commit 3c646f2c6aa9 ("genirq: Don't
> suspend nested_thread irqs over system suspend") missed the case where
> the child IRQ should be suspended, but the parent IRQ should not.

> If that is fixed, then suspend_device_irq() should do the right thing
> without any changes to the regmap-irq code.

> Sorry for the noise.

No worries, I can see the logic and it feels like there might be
something to look at here, I'm just not sure that's it.

--yXvDM+k88PaiFYSo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS1rTQACgkQJNaLcl1U
h9AzgAf9Ho1g3/WBNj9ViaLy/ONnkgV6I6bcGu0Beww4E8wMDN3yG8C+87Fs1m4h
oM54umREdffG5E7RbXGhHZYq7hx8LYRarwDwuDJNHEn89R1TuJsD86cm/RXacwwD
A7VztmSlqehgWyCO6oVj4ikShF6VIqz8tbeCS9dQinpuxuPA9LoO3iTBam0EE7Yj
eMYZ8oJePCpy30UxAoNqaB4VHiKU4JGNb0ShRW8hyyEEM8QdRIkEYTcRe2lcs0iH
Fy0X4k84xq8QNLunDupvQicHS1MuR0MVa8iGrcXaYQ7jmAIE86n/D4HoHf3Ib+Ex
2KdKefZg4agci8EHLTx1f36ARc9HJw==
=l+qm
-----END PGP SIGNATURE-----

--yXvDM+k88PaiFYSo--
