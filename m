Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C671380BE6A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 01:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjLKADZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 19:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKADY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 19:03:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482ADEB;
        Sun, 10 Dec 2023 16:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702253009;
        bh=Xu2o7UhOz+q82dze+E6Eq5AxrzPlgZYyi0f1QrDEumU=;
        h=Date:From:To:Cc:Subject:From;
        b=DeHMjPoBU+KiXQyXjXi6MwL1kybHIfqmMe1QV3kWygyEdfReZQjJwgFbzu5uT6EoO
         GISfQEKG8iyVMitdfu/i62Q5v23q92KwuepzdhMzHcgVdiqRyMKhq8DMqILho/J/zn
         0v0ZVFvv97V2KRPX3L1N1Arm9WF9cn8pFuaAwW/jftemQWibOf8x54O4FEStOuK1sW
         61A/Siq2r04ukHDDAqNq8kri/3F0MR6WAU39w+/jW5s2mD+IvcSiLqF11yTJGqz6xo
         sQsbo7Gqxz1n2UV71RJKTA4dGHOFNpHI9LasNvQ5pxbZa/5+cVOaa8YVyWo0san/SD
         3wSQjBKL+P8hw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpMQm5dQrz4wdC;
        Mon, 11 Dec 2023 11:03:28 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 11:03:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20231211110328.76c925af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hjS7o5CUo4wh7zjheP.rlT6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hjS7o5CUo4wh7zjheP.rlT6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c

between commit:

  3d7a3f2612d7 ("net/mlx5: Nack sync reset request when HotPlug is enabled")

from the net tree and commit:

  cecf44ea1a1f ("net/mlx5: Allow sync reset flow when BF MGT interface devi=
ce is present")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index c4e19d627da2,4b8cb120362b..000000000000
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@@ -325,29 -325,25 +325,48 @@@ static void mlx5_fw_live_patch_event(st
  		mlx5_core_err(dev, "Failed to reload FW tracer\n");
  }
 =20
 +#if IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)
 +static int mlx5_check_hotplug_interrupt(struct mlx5_core_dev *dev)
 +{
 +	struct pci_dev *bridge =3D dev->pdev->bus->self;
 +	u16 reg16;
 +	int err;
 +
 +	if (!bridge)
 +		return -EOPNOTSUPP;
 +
 +	err =3D pcie_capability_read_word(bridge, PCI_EXP_SLTCTL, &reg16);
 +	if (err)
 +		return err;
 +
 +	if ((reg16 & PCI_EXP_SLTCTL_HPIE) && (reg16 & PCI_EXP_SLTCTL_DLLSCE)) {
 +		mlx5_core_warn(dev, "FW reset is not supported as HotPlug is enabled\n"=
);
 +		return -EOPNOTSUPP;
 +	}
 +
 +	return 0;
 +}
 +#endif
 +
+ static const struct pci_device_id mgt_ifc_device_ids[] =3D {
+ 	{ PCI_VDEVICE(MELLANOX, 0xc2d2) }, /* BlueField1 MGT interface device ID=
 */
+ 	{ PCI_VDEVICE(MELLANOX, 0xc2d3) }, /* BlueField2 MGT interface device ID=
 */
+ 	{ PCI_VDEVICE(MELLANOX, 0xc2d4) }, /* BlueField3-Lx MGT interface device=
 ID */
+ 	{ PCI_VDEVICE(MELLANOX, 0xc2d5) }, /* BlueField3 MGT interface device ID=
 */
+ 	{ PCI_VDEVICE(MELLANOX, 0xc2d6) }, /* BlueField4 MGT interface device ID=
 */
+ };
+=20
+ static bool mlx5_is_mgt_ifc_pci_device(struct mlx5_core_dev *dev, u16 dev=
_id)
+ {
+ 	int i;
+=20
+ 	for (i =3D 0; i < ARRAY_SIZE(mgt_ifc_device_ids); ++i)
+ 		if (mgt_ifc_device_ids[i].device =3D=3D dev_id)
+ 			return true;
+=20
+ 	return false;
+ }
+=20
  static int mlx5_check_dev_ids(struct mlx5_core_dev *dev, u16 dev_id)
  {
  	struct pci_bus *bridge_bus =3D dev->pdev->bus;

--Sig_/hjS7o5CUo4wh7zjheP.rlT6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2UdAACgkQAVBC80lX
0GyKWQf+Ia4wx1trE5N3tEhDkjKdcg3E9xvWxQZDZQ1JkPMwP3D2DHbF4t8nRZdL
QgzSS9qyFaUBsYiKrQtwlxhtBV7l5cM9bWTs/jgXHxg1+Zo+fzpdhRaAULgcC/gZ
Vdv7bYipCpTTnSNA5dvao/M8TJqz8xA+bFrimRYfEi5SbgrtX4JnYlXECoSKyZF2
L+7M4hgDjdb2VJAreBf0XnBU+uwYhTxWn3M6hi9WoNk6RoEHqgsf/8y5ZBQNwoPz
+dyzv7D/mUlpjVwAZ8bldV5gdqRB02Aom68dDnfv5NQ9n4YIX/p7yBKCBvqJEjTj
rEvnNah5ut5mQMLPRYqPNTUmBSvlSw==
=vcRh
-----END PGP SIGNATURE-----

--Sig_/hjS7o5CUo4wh7zjheP.rlT6--
