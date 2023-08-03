Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABAD76ECD1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbjHCOit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbjHCOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79C8359E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:37:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91F4C61B98
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6476C433C8;
        Thu,  3 Aug 2023 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691073398;
        bh=64umwzmMHvF5T4akxhCYwvfOtoV/FtgrTaDvUmJNgls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tR/5zwP7IAunmfklGyp1wkqqNaZpP9pLY0LblcLh7I0b9B6UT80UmK1+AqBGa8Gbo
         yBgixmj27zu4MTbsZ8ttd8oLkjm3yeie8cE9zE2ZC/WM0TQOSr+KKH4F1lUa3r1mxR
         ZfRtvAsR2my4Yx4WFoZLOqix7fZGGaXhNMsuNrZlsK7ZeksrZfqL1iepc8NOaljBWq
         Hp1DtvZoeUgkTV2mPdAUtPTi1iyeN16lfxkvTgDj2ZEtbO9gwtNvhOSKQzU6yVGYUj
         craQfKcmvOszSUjI/QYSofpUKYPpUDtU3MYCFtgSe0cjunm3hMF0hLTX7F3GWNHlgN
         oiWoSfnw320dw==
Date:   Thu, 3 Aug 2023 15:36:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Xu Lu <luxu.kernel@bytedance.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] riscv: Fix local irq restore when flags indicates
 irq disabled
Message-ID: <20230803-curtly-sandbox-9ff8c7aafb85@spud>
References: <20230803132818.2092166-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ah5lt3gn3k7k1TBd"
Content-Disposition: inline
In-Reply-To: <20230803132818.2092166-1-luxu.kernel@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ah5lt3gn3k7k1TBd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Aug 03, 2023 at 09:28:18PM +0800, Xu Lu wrote:
> When arch_local_irq_restore() is called with flags indicating irqs
> disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
> implementation based on csr_set() function only sets SR_IE bit of
> CSR_STATUS when SR_IE bit of flags is high and does nothing when
> SR_IE bit of flags is low.
>=20
> This commit supplies csr clear operation when calling irq restore
> function with flags indicating irq disabled.
>=20
> Fixes: 6d60b6ee0c97 ("RISC-V: Device, timer, IRQs, and the SBI")
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---

There's no changelog or explanation, so what is the reason for the
resend?

Cheers,
Conor.

>  arch/riscv/include/asm/irqflags.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/i=
rqflags.h
> index 08d4d6a5b7e9..7c31fc3c3559 100644
> --- a/arch/riscv/include/asm/irqflags.h
> +++ b/arch/riscv/include/asm/irqflags.h
> @@ -49,7 +49,10 @@ static inline int arch_irqs_disabled(void)
>  /* set interrupt enabled status */
>  static inline void arch_local_irq_restore(unsigned long flags)
>  {
> -	csr_set(CSR_STATUS, flags & SR_IE);
> +	if (flags & SR_IE)
> +		csr_set(CSR_STATUS, SR_IE);
> +	else
> +		csr_clear(CSR_STATUS, SR_IE);
>  }
> =20
>  #endif /* _ASM_RISCV_IRQFLAGS_H */
> --=20
> 2.20.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--Ah5lt3gn3k7k1TBd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMu7cgAKCRB4tDGHoIJi
0j1cAQDxSyszd+g0BfkWsXDmOvMud8yXRe1U4rQjPKB0AMEAuQEA6pCd1rxfAu+0
aXDbSnV/PG41bwAkzhmd1SbHuIktkQo=
=PKfK
-----END PGP SIGNATURE-----

--Ah5lt3gn3k7k1TBd--
