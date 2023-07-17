Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE279756D15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGQTWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQTWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:22:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5A71B1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52DBE6121D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 19:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D24C433C7;
        Mon, 17 Jul 2023 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689621766;
        bh=UvYiF3qrBlyC1syicYjZHD7SVtP/K0Jnm6oMXXXBr4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRQex1DL0V2FS7Plf7+D/0PFU/Wkj9r0dBo+IjQmXizsdOEQyIQ45vqvw4fmZMyQu
         hDCmMDeyqvVmH7kvSuJFE5f9qdwxufPz1hD7laRhC5kQxF6h/7udNbTph7LacJC/DB
         nwqkcznDzl+mdwCgNjmZB72dmunP/BPIg0vkNSxUWfHqCN1QQ1TR2sr9ScXe5C7vkK
         fJF1ik6cOyxOBc7o5DoOkg+XT+FL9rDY/YLfRlD/vB8dPFgcSHahedaO2Z7t8Y92S0
         /sSS5o9tJl3bTk8l8Tb2UKsWPoulq+h6VF+wozORaTtLmDI3uvvRU1I7HlB4Bmchym
         YiiAAkKEHowwA==
Date:   Mon, 17 Jul 2023 20:22:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap-irq: Set IRQCHIP_MASK_ON_SUSPEND if no wake_base
Message-ID: <56388e8a-dfc6-4fe7-8aa8-a4b69f201bd0@sirena.org.uk>
References: <20230717191654.1303285-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KvOYIZIgUSYgO70W"
Content-Disposition: inline
In-Reply-To: <20230717191654.1303285-1-samuel.holland@sifive.com>
X-Cookie: Not a flying toy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KvOYIZIgUSYgO70W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 17, 2023 at 12:16:54PM -0700, Samuel Holland wrote:

> If hardware provides no way to control which IRQs are wakeup enabled,
> then software needs to mask non-wakeup-enabled IRQs when going to sleep.

This isn't an unambigiously clear statement, especially for MFDs where
there might be a desire to have some function on the device be able to
wake the system (eg, headset button press on an audio CODEC or a RTC on
a PMIC) even if there's no control within the device...

> Fixes: 55ac85e942c6 ("regmap: irq: enable wake support by default")

...as the commit log does hint at.  If there's a problem I think we need
some finer grained control here.

--KvOYIZIgUSYgO70W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS1lQEACgkQJNaLcl1U
h9BePAgAhg3spMuZ9T6ziHpC2Lfnwj/P0Hp/B1TldGx7GBO1ixwX1ezLzs+BC41P
njnsTllhjb22tDuuNIulLrVqPf4illP/el7ccCgqMPGNEsTwcjXUOwFpPa4pBhmE
x0/MH/3/K99gzAM4U/gq9NZ1VBKLnoXwX/pM0jsTHn/TOr0hsORiz2P+jWyENhLP
2JDfRTJYhSDwsVkAQHnoEltgxC3XRTBBEWtzK+ZIyOJZF9OobJk1kNcirSu04XJS
spXHHEZ8MRX+U9jhfaFPVkvsQBROzx6z3Db/2Oed/GoCnaMF3GcVmp9E96meuDDc
S6urA2IxScA9CmATOPc9CZOWvYtXgA==
=YYmc
-----END PGP SIGNATURE-----

--KvOYIZIgUSYgO70W--
