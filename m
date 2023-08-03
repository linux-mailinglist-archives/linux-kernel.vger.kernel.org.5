Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C20B76EDFD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbjHCPYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbjHCPYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:24:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2847335B5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FDAF61DF8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A052C433C9;
        Thu,  3 Aug 2023 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691076254;
        bh=ps0OX5jIdA6Pp9zgaz7sRP4v9HKZ6NOefzonsbVDzJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaMCInwsRoeDqbEHLfrPgnp+aUOy6ySKfMqG3jLvM1B1w/bssCUg8ro38lLKr2+dw
         LLgGMhGu6CNIcO7wwpT6MhayyoL9wn4ZNZDMkdoGAdsgXB+4O78vls7UaN57cFnqkA
         hMSehkIIbCOKlSpw4QPg+42u2mknU3l7e04nYPDOyJFexOQQqhJtwLbzibPEDyU69u
         FWSv4khN1rCYkcnmKkX2oYqqW0oLb/pKSidqxZEqJ8H5gLCYsgU4c4cAkk32j6SEz8
         8U+ogayiYSNH0++PSZq4aKbqy4RcAos+/hmtJdHfGg6dqZ64EHnQJj++Se8MsEdz2c
         VCDHYE598Lp0w==
Date:   Thu, 3 Aug 2023 16:24:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?utf-8?B?5pet6Lev?= <luxu.kernel@bytedance.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] riscv: Fix local irq restore when flags indicates
 irq disabled
Message-ID: <20230803-sage-mongoose-2452dbe3109d@spud>
References: <20230803132818.2092166-1-luxu.kernel@bytedance.com>
 <20230803-curtly-sandbox-9ff8c7aafb85@spud>
 <CAPYmKFsbGMRY7S6WguDHkkY1futTS7+piKf83Pb+aktO2yLXpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qX9DtSamNXDyfInn"
Content-Disposition: inline
In-Reply-To: <CAPYmKFsbGMRY7S6WguDHkkY1futTS7+piKf83Pb+aktO2yLXpw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qX9DtSamNXDyfInn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 11:20:53PM +0800, =E6=97=AD=E8=B7=AF wrote:
> On Thu, Aug 3, 2023 at 10:36=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > Hey,
> >
> > On Thu, Aug 03, 2023 at 09:28:18PM +0800, Xu Lu wrote:
> > > When arch_local_irq_restore() is called with flags indicating irqs
> > > disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
> > > implementation based on csr_set() function only sets SR_IE bit of
> > > CSR_STATUS when SR_IE bit of flags is high and does nothing when
> > > SR_IE bit of flags is low.
> > >
> > > This commit supplies csr clear operation when calling irq restore
> > > function with flags indicating irq disabled.
> > >
> > > Fixes: 6d60b6ee0c97 ("RISC-V: Device, timer, IRQs, and the SBI")
> > > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > > ---
> >
> > There's no changelog or explanation, so what is the reason for the
> > resend?
> >
> > Cheers,
> > Conor.
>=20
> Sorry for disturbing you.

Nah, tis fine.

> I haven't received any response since the patch was sent last week. I
> think maintainers are busy and thus I want to have a ping. This patch
> was resent because I found it is said that resending patch is one of
> the methods to ping maintainers in this kernel doc:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html.

Right, resending is a valid way to do that - but leaving a comment about
why you are resending under the --- line is advised so that people know
why it is that you are resending.

Thanks,
Conor.

--qX9DtSamNXDyfInn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvGmwAKCRB4tDGHoIJi
0rrnAQCkHXYxHxGxG4oSXUAxx2XZI+yqXgkHJpn/JOh0/zH7vgEAr7wOdeqv+u1Y
kNMZG9HQcX1C6QNjrRueg8jYB7R5IgA=
=u7Lk
-----END PGP SIGNATURE-----

--qX9DtSamNXDyfInn--
