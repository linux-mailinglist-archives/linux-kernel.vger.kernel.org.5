Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002D57AEB1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjIZLM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZLM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:12:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0664FE5;
        Tue, 26 Sep 2023 04:12:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A136C433C8;
        Tue, 26 Sep 2023 11:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695726769;
        bh=RCT3ksFfxXJUFEFoooNTpXtMGpORVm3wt6SDo0yzwmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PnSQ4fEY9EzdNCHhk5QjY7a7Lr6P7QiEj7kurskRLU+lPsoG8n2MMxSPQuWYUfus/
         6JfLmXgWJinhzUbLWYvfRgn9PGR3JOc76sxGakLjyXP9cPSSK71LGuZ/Atco6Nq5DE
         SJJBmHOiqR4C1E6XlOebea00znq68BFinA5mj+gC11ziLIwtl02ECX1Ye76uabp/SH
         hbppwmjIlZ/tMX6DPMbqPfO6rf7AntkbdRujTam9AO/Mcn1SzGi2ItClO+iSI0sDmU
         fy+pF5ntNp/g5rRWMSgXeVzQsNUxTgfV3JKY/tYhqAJf/K5kxJl7i0rV4j5n/xX1mJ
         3TojyEDcyRcDg==
Date:   Tue, 26 Sep 2023 12:12:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] riscv: fix out of bounds in walk_stackframe
Message-ID: <20230926-shorter-acetone-25a93d7ab27c@spud>
References: <0000000000000170df0605ccf91a@google.com>
 <20230926105949.1025995-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MisKy8cQA+A+qNEs"
Content-Disposition: inline
In-Reply-To: <20230926105949.1025995-2-twuufnxlz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MisKy8cQA+A+qNEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Edward,

Where did you come up with the CC list for this patch from? Please run
get_maintainer.pl on your patches and CC the output. You've not CCed any
relevant developers on this mail :(

On Tue, Sep 26, 2023 at 06:59:50PM +0800, Edward AD wrote:
> Increase the check on the frame after assigning its value. This is to pre=
vent=20
> frame access from crossing boundaries.
>=20
> Reported-and-tested-by: syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail=
=2Ecom

Please also add a Fixes: tag & a Closes: tag with a link to the report
when you do so.

Thanks,
Conor.

> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>  arch/riscv/kernel/stacktrace.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index 64a9c093aef9..53bd18672329 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -54,6 +54,8 @@ void notrace walk_stackframe(struct task_struct *task, =
struct pt_regs *regs,
>  			break;
>  		/* Unwind stack frame */
>  		frame =3D (struct stackframe *)fp - 1;
> +		if (!virt_addr_valid(frame))
> +			break;
>  		sp =3D fp;
>  		if (regs && (regs->epc =3D=3D pc) && (frame->fp & 0x7)) {
>  			fp =3D frame->ra;
> --=20
> 2.25.1
>=20

--MisKy8cQA+A+qNEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRK8rQAKCRB4tDGHoIJi
0kqjAP90g4/G1TGVcQIXrpJ/IpCj6h9HaqBw4HfNIj6uQ/YO8gD/WqV+EnH6Ri0n
4R16KfJi3y1+MrAgywo2gRnpSYCSfQA=
=OI2P
-----END PGP SIGNATURE-----

--MisKy8cQA+A+qNEs--
