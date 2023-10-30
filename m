Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84697DB26D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 05:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjJ3EGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 00:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjJ3EGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 00:06:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5467AB;
        Sun, 29 Oct 2023 21:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698638754;
        bh=xDY1FF72MCKSgLkCNHi8hlY0YdxTF/uJi8s+M0DfQUg=;
        h=Date:From:To:Cc:Subject:From;
        b=hQ3VYhr63lyMzM3K+Ty3E/yv16wKiGEaQ0mlPQmhAsAtH7TlkvIg+k0TFxouSm6ff
         MCsBPf6ke8onupY+cZQwJSnjIYHQA1LSbejzE2oaDzJgJCFZwpYz+5izRSa6YHGBkL
         Xvw9U/VPewnkziuEsQVN5irGmmvQDjewi9SX3QWKcSsSVyg3MOzK661+8p7UelK8C3
         ztPOB3mZxIK0uMxxCnBBNXun1B4fqcX7bEVnecO5JzQxHN27U6J3jvOEMR3ULew4Pd
         WVO4CCDoNSX2sqiQM//QgcCM05R4UXjUjV4/8/zlH+kRuTo3S6Dk1g4nqDUVJse5J9
         uI0wRP+Ka5tzQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJfnr6V6Rz4xRs;
        Mon, 30 Oct 2023 15:05:52 +1100 (AEDT)
Date:   Mon, 30 Oct 2023 15:05:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Richter <rrichter@amd.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: linux-next: manual merge of the cxl tree with the pm tree
Message-ID: <20231030150551.505a5d7b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a2_o8911KH+Sdh/3qv=iuDC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a2_o8911KH+Sdh/3qv=iuDC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cxl tree got a conflict in:

  drivers/pci/pcie/aer.c

between commit:

  e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data=
 has multiple sections")

from the pm tree and commit:

  6777877eb7a3 ("PCI/AER: Refactor cper_print_aer() for use by CXL driver m=
odule")

from the cxl tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/pci/pcie/aer.c
index dcd35993004e,36541bfab688..000000000000
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@@ -997,16 -1137,7 +1138,16 @@@ static void aer_recover_work_func(struc
  			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
  			continue;
  		}
- 		cper_print_aer(pdev, entry.severity, entry.regs);
+ 		pci_print_aer(pdev, entry.severity, entry.regs);
 +		/*
 +		 * Memory for aer_capability_regs(entry.regs) is being allocated from t=
he
 +		 * ghes_estatus_pool to protect it from overwriting when multiple secti=
ons
 +		 * are present in the error status. Thus free the same after processing
 +		 * the data.
 +		 */
 +		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 +					      sizeof(struct aer_capability_regs));
 +
  		if (entry.severity =3D=3D AER_NONFATAL)
  			pcie_do_recovery(pdev, pci_channel_io_normal,
  					 aer_root_reset);

--Sig_/a2_o8911KH+Sdh/3qv=iuDC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU/K58ACgkQAVBC80lX
0GzZDQf/c60ja4vn7yQH/EyWpza6kzJalfqRvu8TlAgX87wqBZVYYa9oq7rcCBpT
zOV+WYj+1HKOte0mYizLnC9gQ4MXJcLJ9wXeR71RqV8tOdQeW1OP/cX+0Cu9A+Lh
UO60neTSzG4cACzdHEgQsi2puxl1PEr0thKxfgiEL4Q0D3NyXwHqdq83mZ6eHt6b
qD/XnjCiucvpaHQJACgOr36isZtPBmrioPxsogR5/43gU1Km1onc+sXG48Y0B5QJ
Df6PXmRMAcsleQZxnx675QrmBbARCFewXI9yi4nfNwJS3CKdlThFx69Dlj3kFwUi
BHCXmVFszfQHYZAIxfSD5EcRgRlQPQ==
=1A3M
-----END PGP SIGNATURE-----

--Sig_/a2_o8911KH+Sdh/3qv=iuDC--
