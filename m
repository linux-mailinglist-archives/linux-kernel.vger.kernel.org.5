Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA54802A3A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjLDCW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDCW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:22:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1508FC3;
        Sun,  3 Dec 2023 18:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701656577;
        bh=xFb81dgPot++0Rm5Gwsc/XhjSKpeH1BXs5fHWqrZU+k=;
        h=Date:From:To:Cc:Subject:From;
        b=fXSqR8wxcIynlamuqDBW96ZsUp9jjM0cbkypwIllWsyK9d9C048ZrO3NIO/I9sGvz
         9YzNP6poY9zfoNBt9ooYR1u737+K1GI6HPMPbGBAZnjUbBmccjgWYCuIbrKgT2eHWa
         SXl+u6QuAH5ZUQBuNeI4yICcw/V5WrUt1/BXYvvRAB49KdOZ37ix/jZVG0KNaAZoZo
         2LEouzw9Kiv1pg93QESpPVf0KOIMqOWgb0GKxDnCzVE0M5gzJ2g4/ujnY2mh6ACEGm
         89QJO+a+q5qqkZsR6hd721n5QGR4ketUqousRWe44UFQBx8Y/BEfVs31WqoLtdf49F
         Vqn4y2S+IJBgw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sk6rw0WCsz4x1p;
        Mon,  4 Dec 2023 13:22:56 +1100 (AEDT)
Date:   Mon, 4 Dec 2023 13:22:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Armin Wolf <W_Armin@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drivers-x86 tree with the
 hwmon-staging tree
Message-ID: <20231204132252.065ad867@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XF++MVm_gx2QHZFmpd18R1q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XF++MVm_gx2QHZFmpd18R1q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  drivers/platform/x86/wmi.c

between commit:

  9ad55f14cc30 ("hwmon: (dell-smm) Add support for WMI SMM interface")

from the hwmon-staging tree and commits:

  75c487fcb69c ("platform/x86: intel-wmi-sbl-fw-update: Use bus-based WMI i=
nterface")
  2340f12023ef ("platform/x86/intel/wmi: thunderbolt: Use bus-based WMI int=
erface")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/platform/x86/wmi.c
index d68a96a2c570,cb7e74f2b009..000000000000
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@@ -106,7 -106,8 +106,9 @@@ MODULE_DEVICE_TABLE(acpi, wmi_device_id
  static const char * const allow_duplicates[] =3D {
  	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
  	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
 +	"F1DDEE52-063C-4784-A11E-8A06684B9B01",	/* dell-smm-hwmon */
+ 	"44FADEB1-B204-40F2-8581-394BBDC1B651",	/* intel-wmi-sbl-fw-update */
+ 	"86CCFD48-205E-4A77-9C48-2021CBEDE341",	/* intel-wmi-thunderbolt */
  	NULL
  };
 =20

--Sig_/XF++MVm_gx2QHZFmpd18R1q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVtN/wACgkQAVBC80lX
0GzSPgf+NKKG7X74SSAVuR/t7gmmZOmxugC8XKjaOCqOgRHqw2IiDJ54XeaSQCLA
V97HgOHfc76Co5gEsxH8f+uyo3/kmHi6y2PwrjPqDDdcnyXTZsDiPS/w5K6DMGd+
OH5pvPUbaXQdU94Usl89YJQZ2h/1s3+gou/+Ii4cSKT9TQCOgnzZT8d/Ei8ySvz3
R2E783AArqgrcXVAW0kZpwgK+BwitnLLXZNQBe26NMGK9H9+U3naDq8lNgP7JKDb
ZEmXQ/FxKeFj7vofWpQCnXJJpE4955B6sECTGnlxFGJZT/xxBFRkhRfI1KuCE1D3
rfAHE5cFO2bYQsyVLLxO88thiqJufg==
=bF2W
-----END PGP SIGNATURE-----

--Sig_/XF++MVm_gx2QHZFmpd18R1q--
