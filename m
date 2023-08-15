Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAB677C5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 04:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjHOC2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 22:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjHOC2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 22:28:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D94810C1;
        Mon, 14 Aug 2023 19:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692066488;
        bh=yn404caKCvYzrFWgHbLiy3+pIAut/KwIxxQePdoi2Nw=;
        h=Date:From:To:Cc:Subject:From;
        b=rj9NU/KPfFwRk1RbnkAeRjSUfYDPMVCHjlZz+NI6rVBEl7il1mUNf9nRfvKXSe3D8
         ynq5ODoCnL4v0ERdZz1vs7FZhxs7RhbeT5gr3iKAyz8r7bb5WGxe/NG0mKccwtWiRL
         ABEgf4plKhrOiqN3kFIyuvpyb4jWr2HaGpUR9W5pMKhr82L/3Vj9XkIXKlgHKteQpG
         eCeroH1XlBYbe/pugYBnNxRHQzUC7dggew74U9jimqBhKhKIFHYlT+FLm1SlfMgFzq
         SJBxlNc1xyvDcUc0DCHGY6Z4zUbHoz+BSJV5mYhzd3t4p2jyFatJ14K1bybIZNNhuy
         vSOsB8hqMe2qQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPwD802qxz4wZx;
        Tue, 15 Aug 2023 12:28:07 +1000 (AEST)
Date:   Tue, 15 Aug 2023 12:28:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Adham Faris <afaris@nvidia.com>,
        Jianbo Liu <jianbol@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: linux-next: manual merge of the mlx5-next tree with the net-next
 tree
Message-ID: <20230815122807.7dddd4a3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_+jTWPsYMUYkxIPJb6=edsH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_+jTWPsYMUYkxIPJb6=edsH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mlx5-next tree got a conflict in:

  include/linux/mlx5/driver.h

between commits:

  c8e350e62fc5 ("net/mlx5e: Make TC and IPsec offloads mutually exclusive o=
n a netdev")
  1f507e80c700 ("net/mlx5: Expose NIC temperature via hardware monitoring k=
ernel API")

from the net-next tree and commits:

  e26051386a94 ("net/mlx5e: Move MACsec flow steering and statistics databa=
se from ethernet to core")
  17c5c415b9cb ("net/mlx5: Add RoCE MACsec steering infrastructure in core")

from the mlx5-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/mlx5/driver.h
index e1c7e502a4fc,728bcd6d184c..000000000000
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@@ -806,9 -804,12 +806,14 @@@ struct mlx5_core_dev=20
  	struct mlx5_rsc_dump    *rsc_dump;
  	u32                      vsc_addr;
  	struct mlx5_hv_vhca	*hv_vhca;
 -	struct mlx5_thermal	*thermal;
 +	struct mlx5_hwmon	*hwmon;
 +	u64			num_block_tc;
 +	u64			num_block_ipsec;
+ #ifdef CONFIG_MLX5_MACSEC
+ 	struct mlx5_macsec_fs *macsec_fs;
+ 	/* MACsec notifier chain to sync MACsec core and IB database */
+ 	struct blocking_notifier_head macsec_nh;
+ #endif
  };
 =20
  struct mlx5_db {

--Sig_/_+jTWPsYMUYkxIPJb6=edsH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa4rcACgkQAVBC80lX
0GwJYAf9HMqfXCGysiiD9uPkWD3jZqMCASMxQDItmcjxYy0A4jCKDKzX8LQarfKT
7uuOZRmqAlB9MYo2QjZV1MNrxHRUT8Df/hf1tdd/RdSSWo0NWuQuw6i/DVZxdyM3
uViQFp9h/Eg4LCTkDhdlr+i9Tccdi52O6PhcRnA7F9YmKjqlBXGKJoCd5rPtKm3h
gJdef1Hp2m+efR+Kwu2Qj337HCY2nvEldD9FA9KB5SKcJ4TFo5HcttASU4FC4M8n
GLJn0xUiaxU6NIx7kQUvg3PTnJF/59VGGjQogE5Yfjh8xhqAqAAY/1msRAkV88Qs
q08Pv/Mw05PyWOwpRCp8DuqNRAJZVQ==
=eB3f
-----END PGP SIGNATURE-----

--Sig_/_+jTWPsYMUYkxIPJb6=edsH--
