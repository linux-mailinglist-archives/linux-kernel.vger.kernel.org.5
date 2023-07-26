Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94584762B94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjGZGhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjGZGhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:37:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032832113;
        Tue, 25 Jul 2023 23:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690353427;
        bh=WC42Jc1mJ8UlGXI9HmCs7ztjCqsAjOjp2m88mWCoWO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P+VatdpECOeurkE3yIPU2cQScPGroWkNnFpN4tTWy6gh9VtFjzr07JtA6fvr0ErWR
         +ruNeE7o02cP3vD8S4QSnv80iizQGOwzLFmsA5KfrunHl2QoEwoAVeccFHXZ15pLuJ
         +fkgpgea4jZt6TcwxnEzJi0ZMbmrzv1cjedGzHLkXEMmnIE/7rFiEa1xW/0jp6n2xC
         rw+TV/lIne8Ox1FaQExRmmSZZp/E15tvs4JshSEouyU6EKV0asWhUNK1sCEc7YltWz
         sWByYq6PRyLQ/HUpZqH66aPW3SdjW7YgeoYMXJ2VytfoJBjzaSBZlra5/oP03KHMjJ
         +WcIygtRoHYGQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R9khg1ZMdz4wy4;
        Wed, 26 Jul 2023 16:37:07 +1000 (AEST)
Date:   Wed, 26 Jul 2023 16:37:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the rcu tree
Message-ID: <20230726163705.3ade6aa6@canb.auug.org.au>
In-Reply-To: <adba817d-a02b-49fb-bf3d-a22779303764@paulmck-laptop>
References: <20230726123230.525202b4@canb.auug.org.au>
        <1c8c257e-55e3-4de9-b2c8-1421c11df664@paulmck-laptop>
        <adba817d-a02b-49fb-bf3d-a22779303764@paulmck-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8uVI3W=y2xElus3Vmk7tzQv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8uVI3W=y2xElus3Vmk7tzQv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, 25 Jul 2023 20:48:13 -0700 "Paul E. McKenney" <paulmck@kernel.org> =
wrote:
>
> Does the following incremental diff (to be squashed into the original) he=
lp?
>=20
> 							Thanx, Paul
>=20
> ------------------------------------------------------------------------
>=20
> diff --git a/init/main.c b/init/main.c
> index c946ab87783a..981170da0b1c 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -135,7 +135,7 @@ EXPORT_SYMBOL(system_state);
>  void (*__initdata late_time_init)(void);
> =20
>  /* Untouched command line saved by arch-specific code. */
> -char __initdata boot_command_line[COMMAND_LINE_SIZE];
> +char boot_command_line[COMMAND_LINE_SIZE] __ro_after_init;
>  /* Untouched saved command line (eg. for /proc) */
>  char *saved_command_line __ro_after_init;
>  unsigned int saved_command_line_len __ro_after_init;

I needed the following (only tested x86_64 allmodconfig build):

diff --git a/include/linux/init.h b/include/linux/init.h
index 9a5973324072..e3ce68988e1b 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -112,6 +112,9 @@
 #define __REFCONST       .section       ".ref.rodata", "a"
=20
 #ifndef __ASSEMBLY__
+
+#include <linux/cache.h>
+
 /*
  * Used for initialization calls..
  */
@@ -143,7 +146,7 @@ struct file_system_type;
=20
 /* Defined in init/main.c */
 extern int do_one_initcall(initcall_t fn);
-extern char __initdata boot_command_line[];
+extern char boot_command_line[] __ro_after_init;
 extern char *saved_command_line;
 extern unsigned int saved_command_line_len;
 extern unsigned int reset_devices;
diff --git a/init/main.c b/init/main.c
index c946ab87783a..981170da0b1c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -135,7 +135,7 @@ EXPORT_SYMBOL(system_state);
 void (*__initdata late_time_init)(void);
=20
 /* Untouched command line saved by arch-specific code. */
-char __initdata boot_command_line[COMMAND_LINE_SIZE];
+char boot_command_line[COMMAND_LINE_SIZE] __ro_after_init;
 /* Untouched saved command line (eg. for /proc) */
 char *saved_command_line __ro_after_init;
 unsigned int saved_command_line_len __ro_after_init;

--=20
Cheers,
Stephen Rothwell

--Sig_/8uVI3W=y2xElus3Vmk7tzQv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTAvxEACgkQAVBC80lX
0GzAhAf+MyI1kFZ7Cl/K/6n76b+E8QLOnpVL+mOvDBbyy1OgKEmQjjzUXovp9MdY
EWp9wRZPGBrWZb52fDqoXEnEEDNFWrr5/TAokDUlMWiCVSdcbks13OxnIEhHGJ9u
DeX8jGV/29fgWCI3Olkjo+5P7fLI2E4cA1hLVbdo5smj7Ev3q3VCDDTMfPwJpwm1
dwXNE5nRwBveXNBsNwmgEBuZ16nemStSk6xpqTFGdQFx2xuq1MoJSgVA2QAJ2lv8
f9xRVr/GyojszHXK2EFi1q6D9wGwGL0chp4TE6OhFfEa7N/eNZwzeBOeFwYvvcLL
4Gfbbg+QowbV0QY2rZDEpO6srt74jA==
=gnio
-----END PGP SIGNATURE-----

--Sig_/8uVI3W=y2xElus3Vmk7tzQv--
