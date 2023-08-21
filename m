Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695F37822EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjHUEkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjHUEkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:40:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA4499;
        Sun, 20 Aug 2023 21:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692592832;
        bh=H2bmdkltZ26Ec+PUJuphMKVkQe4a/Axwlp4oH2FDr08=;
        h=Date:From:To:Cc:Subject:From;
        b=NuAQn9D8a2Elx8iuy9qFXbXhrFFkJt80DF6nFmcpnS0ubmpsJP7rHj0ZaSIa7cGdo
         WmLbyHk7K0K9Z37GpnKgF38qAWGwLdheUrOcWmYiBTb5rioqsNx7/J8X8Kkrh60m+o
         LDzQuXxMXW8UeZF7N1yf9NitHHhQ9WWmAOEIOUyAJcsf4wuJS/W4hv+LJgcOf+n6+G
         67qPa/JEI0NiHbxUgTWJOr0tphg1T5cxQ8ys8jhVZfO677BBS1fM8gPJywLgMXgBTB
         JnwuynH2uh2NVLKx708R1aAcKBiZoo4OFjXLa7R6gzQyiZR5+KmQ7iPt3rIkt/PaYW
         oF4Z3whP6H9Xg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTft73h01z4wxy;
        Mon, 21 Aug 2023 14:40:31 +1000 (AEST)
Date:   Mon, 21 Aug 2023 14:40:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: linux-next: manual merge of the coresight tree with the arm-perf,
 arm64 trees
Message-ID: <20230821144030.52ab1357@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lp8528AKDoGlE4+qFjTkdaX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lp8528AKDoGlE4+qFjTkdaX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the coresight tree got a conflict in:

  drivers/hwtracing/coresight/coresight-trbe.c

between commit:

  e926b8e9eb40 ("coresight: trbe: Add a representative coresight_platform_d=
ata for TRBE")

from the arm-perf, arm64 trees and commit:

  39744738a67d ("coresight: trbe: Allocate platform data per device")

from the coresight tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/hwtracing/coresight/coresight-trbe.c
index 9c59e2652b20,e20c1c6acc73..000000000000
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@@ -1244,6 -1254,10 +1254,21 @@@ static void arm_trbe_register_coresight
  	if (!desc.name)
  		goto cpu_clear;
 =20
 -	desc.pdata =3D coresight_get_platform_data(dev);
++	/*
++	 * TRBE coresight devices do not need regular connections
++	 * information, as the paths get built between all percpu
++	 * source and their respective percpu sink devices. Though
++	 * coresight_register() expect device connections via the
++	 * platform_data, which TRBE devices do not have. As they
++	 * are not real ACPI devices, coresight_get_platform_data()
++	 * ends up failing. Instead let's allocate a dummy zeroed
++	 * coresight_platform_data structure and assign that back
++	 * into the device for that purpose.
++	 */
++	desc.pdata =3D devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
+ 	if (IS_ERR(desc.pdata))
+ 		goto cpu_clear;
+=20
  	desc.type =3D CORESIGHT_DEV_TYPE_SINK;
  	desc.subtype.sink_subtype =3D CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
  	desc.ops =3D &arm_trbe_cs_ops;

--Sig_/lp8528AKDoGlE4+qFjTkdaX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTi6r4ACgkQAVBC80lX
0Gyu6wf9Fip2E4hzb6oqboBigMsj5ulb6dcl2r4Yjlk2lJ+wYpZbh2uT5l3FCZB4
PAx4uY4NUP1ccHn0DDP+H/Zxpk+QpTFsFYDj4DaX55Xp0rACGvhp1pmYv5ofqnD6
L9dS9b+tGvsTfbcdkDMe+Pnoc8XlArIgvMBtkKnUGn6neK8KERBe+FXykphctQ41
TdHkZ4WjIhs8Y+cmMQL3DlR49312Jq4N6OKeeNLGBFqheHya9x1zsov2Q5hX2UnH
zMveywsYXgAb7RJ9uxqrKvhcS5au8IAXKhSJk2eRwpc7Ms/q+BCLc/eKT34LpHqb
uiXU7Tn7YrOJyVOJ7zPa0QiI+19jfQ==
=olF6
-----END PGP SIGNATURE-----

--Sig_/lp8528AKDoGlE4+qFjTkdaX--
