Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121DB7E176D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjKEWtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjKEWtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:49:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F33CCF;
        Sun,  5 Nov 2023 14:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699224537;
        bh=L6zHQsQltusScahnA+vWcv3kyj7CxopeqfK6s7GAgfo=;
        h=Date:From:To:Cc:Subject:From;
        b=f95g484er1ViIFXecBQFbkbf7X+4I1RtUQ2OPHd6enfjQshGML8kLGI/WIbBYgE5V
         Ah1Kmbtoa7zTUpyfAk2aw571liN3PnFsjIUx3hFF/1aEcIqxujGmz/sPhNY8zv3ZCG
         r5i+hS8omEdDZOkIwdW3T5yBLuW7pZz/lwfw2i/zFUWCvDK8Q3f2B3rPaWTuy1OXI0
         U6G4cwEIC0FaAGr4RSXDV0Qa1aaoOfbwil87t3mYKPDLr1zqnmw6lb5TsCQCo4f/oZ
         /D49j6K1dkik8oYEvi3Rr1iG00UC/uNUMH3EncQGCA8yhHV533f9MAQK5Zb+TYysbH
         4a466f6KNJzNg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SNqQw0Yxdz4xF5;
        Mon,  6 Nov 2023 09:48:56 +1100 (AEDT)
Date:   Mon, 6 Nov 2023 09:48:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: linux-next: manual merge of the amdgpu tree with Linus' tree
Message-ID: <20231106094855.38376d52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/URENiMlDcB9LImW7A4CTEOx";
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

--Sig_/URENiMlDcB9LImW7A4CTEOx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c

between commit:

  18bf400530ca ("drm/amdgpu: Use pci_get_base_class() to reduce duplicated =
code")

from Linus' tree and commit:

  432e664e7c98 ("drm/amdgpu: don't use ATRM for external devices")

from the amdgpu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 5bbb23e102ba,f3a09ecb7699..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@@ -286,12 -287,12 +287,16 @@@ static bool amdgpu_atrm_get_bios(struc
  	/* ATRM is for the discrete card only */
  	if (adev->flags & AMD_IS_APU)
  		return false;
+=20
+ 	/* ATRM is for on-platform devices only */
+ 	if (dev_is_removable(&adev->pdev->dev))
+ 		return false;
 =20
 -	while ((pdev =3D pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) !=3D N=
ULL) {
 +	while ((pdev =3D pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev))) {
 +		if ((pdev->class !=3D PCI_CLASS_DISPLAY_VGA << 8) &&
 +		    (pdev->class !=3D PCI_CLASS_DISPLAY_OTHER << 8))
 +			continue;
 +
  		dhandle =3D ACPI_HANDLE(&pdev->dev);
  		if (!dhandle)
  			continue;

--Sig_/URENiMlDcB9LImW7A4CTEOx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVIG9cACgkQAVBC80lX
0GwUfgf/WBtdZkkvfywcpEhQJHAb0ZO4m//Rz8kptrLOAflNsTtKfTlkNDkOgY+w
C5AB7Gz16fde2fnvOOUU4LWZD7lUdub3wPTJnuHF3i+P2zY5TKU52Td4HOxLtOcA
vFC4FQxForoCZWMcJvGPPBOzwE4vRgl7rSIBika6NuyJg8Fm9OTS7mDMD8AUF6+a
nXl1yjHZ2WfYp59ayeigLOpEZYwCqNnuphyepIA7tmTXFCHiPT8cofFQzYmrjA92
/5U+z6llH6i6ULjLzTKHnc97WEroMeNpN4hHrPusbBTb1yXlwlvtlhcV4ZsbB+jp
BEZdrYvPVe11oedEkDf3Eeak3jt/QQ==
=PVz8
-----END PGP SIGNATURE-----

--Sig_/URENiMlDcB9LImW7A4CTEOx--
