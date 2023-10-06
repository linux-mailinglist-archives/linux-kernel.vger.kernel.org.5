Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C957BAFD8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 02:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjJFA7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 20:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjJFA6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 20:58:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E637113;
        Thu,  5 Oct 2023 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696553765;
        bh=kEKAMLbFQaWXPR2KKnqKBoL2rpL/FrPpvO6NnmEwC10=;
        h=Date:From:To:Cc:Subject:From;
        b=Zbt7gXzYbeM8tZkTn1NCABjLiwlvnxLeBTOI00TRUOxjjteKJep76jXiN1uDbMYyt
         jcUHnH/zGiAlS7nYqTSwVH4Cv4yKSLKAGPFtcdp6Ivi5RBHiLFFE0AFXACuD4SKLzu
         qUqhB+HEhiHg9sW5ZV0c9pH4jSpR5Ss/R63RytAlRnlm1JHfaC73HpGwF1lZA3Rsy+
         GfloQ+iq6+PjbzBap6ZeReeVmYVM/6YKw15rvkVC05lcS9t7h4XDzqSJY7CvCjKlQd
         IUuDsrEfjSdNs4ZCmmdr91nHcRlC/NVDUpv16QN1eB/928OuRF8OoaSuvnLDmbiSp/
         +dBsIy9+bkYdQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1qjx2mBlz4xKl;
        Fri,  6 Oct 2023 11:56:05 +1100 (AEDT)
Date:   Fri, 6 Oct 2023 11:56:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pci tree
Message-ID: <20231006115604.42971aa0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g5vVmV692N+PiDcKjTq+iER";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g5vVmV692N+PiDcKjTq+iER
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

arch/x86/pci/fixup.c: In function 'amd_rp_pme_suspend':
arch/x86/pci/fixup.c:929:13: error: 'pm_suspend_target_state' undeclared (f=
irst use in this function)
  929 |         if (pm_suspend_target_state =3D=3D PM_SUSPEND_ON)
      |             ^~~~~~~~~~~~~~~~~~~~~~~
arch/x86/pci/fixup.c:929:13: note: each undeclared identifier is reported o=
nly once for each function it appears in
arch/x86/pci/fixup.c:929:40: error: 'PM_SUSPEND_ON' undeclared (first use i=
n this function); did you mean 'RPM_SUSPENDING'?
  929 |         if (pm_suspend_target_state =3D=3D PM_SUSPEND_ON)
      |                                        ^~~~~~~~~~~~~
      |                                        RPM_SUSPENDING
arch/x86/pci/fixup.c: In function 'amd_rp_pme_resume':
arch/x86/pci/fixup.c:951:27: error: implicit declaration of function 'FIELD=
_GET' [-Werror=3Dimplicit-function-declaration]
  951 |         rp->pme_support =3D FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
      |                           ^~~~~~~~~

Caused by commit

  624306d2c241 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and=
 Phoenix USB4")

I have used the pci tree from next-20231005 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/g5vVmV692N+PiDcKjTq+iER
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUfWyQACgkQAVBC80lX
0GwvJggAjwj6OUeoSXrxg7D7YsZcYAiLnwWKAg4QhNicISB9eoU8iKyaAeFsbkwz
G9RDJyqFfBU63VxEw2YE/X15JmzCjCJj0fgqnO+Y6bCeJeLW6iUOcGy25v+LB5Yn
wWb/wp+IDcYzwEu5NKerg8Zd+jZhgxtIfqZY9azmAKUnXH2JxyDZ6NaTTNV669fD
OnHrsxp9LR1Xqkx20YXrV1ce4QSn2Q/E4Jt8XyMBe43Pt4Fepd1ZX5kT32MncNA0
VO6iVXldO1ZD05HhGstJflDJ2hDClzkCPAd5VSDEV3XToobRPUzKV451JGnIJn0A
tuJ5Z1V6h/7Vy4VBnAzQdjUsQPG9Ag==
=eW+B
-----END PGP SIGNATURE-----

--Sig_/g5vVmV692N+PiDcKjTq+iER--
