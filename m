Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8179A7D281A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjJWBmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjJWBmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:42:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE019F7;
        Sun, 22 Oct 2023 18:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698025322;
        bh=RaCCh9Z/e12DEo8pm9dRiMR3hb8GPa3Gm/pRDZSRVHw=;
        h=Date:From:To:Cc:Subject:From;
        b=to97amS2dqEJY+ViWtVaCnJwogGRHliuG4GPsnXBw+GT/zPOUuAE8nso6QQoQKwTA
         9BmJz+KkcafJruoMcMMH6R9y3x1ygtAtw9qhiqPHT2FICRmwlaOEWtn1iwqDdM8TWc
         HQk3X1SYgWaAdeDV8tvJqQDst7eJWLNO4VmV1XWyMqEqziWTdale+JLIQMhVYlfNSw
         RZlk/MApmwS3s0kf/Ir4cHbLMz6escHItFqDi6sr28UeNy3YSjJ0QYHRKOnwKSTuRX
         dcVF19X0GUOGJJJY/KNA2DzC1zmLffiCOMi1erPhs0r77pV8sQFl/+dO683r5pDjON
         XEUEwF2FVv6zg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDHx62Vtqz4wd7;
        Mon, 23 Oct 2023 12:42:01 +1100 (AEDT)
Date:   Mon, 23 Oct 2023 12:42:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: linux-next: manual merge of the block tree with Linus' tree
Message-ID: <20231023124200.38dd410b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d3N4OZEb57toJpLPWdvRs6z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d3N4OZEb57toJpLPWdvRs6z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  drivers/nvme/target/tcp.c

between commit:

  d920abd1e7c4 ("nvmet-tcp: Fix a possible UAF in queue intialization setup=
")

from Linus' tree and commit:

  675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")

from the block tree.

I fixed it up (I am not sure this is necessary - see below) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/nvme/target/tcp.c
index 197fc2ecb164,4336fe048e43..000000000000
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@@ -910,8 -932,8 +933,10 @@@ static int nvmet_tcp_handle_icreq(struc
  	iov.iov_base =3D icresp;
  	iov.iov_len =3D sizeof(*icresp);
  	ret =3D kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
--	if (ret < 0)
 -		goto free_crypto;
++	if (ret < 0) {
++		queue->state =3D NVMET_TCP_Q_FAILED;
 +		return ret; /* queue removal will cleanup */
++	}
 =20
  	queue->state =3D NVMET_TCP_Q_LIVE;
  	nvmet_prepare_receive_pdu(queue);

--Sig_/d3N4OZEb57toJpLPWdvRs6z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU1z2gACgkQAVBC80lX
0GxRTgf/WmF5ULtaDAldhJ8rqRyQ0p2AYEPlNW2AEytzKESkmPZXKxQqYlD81xpU
1U+KHAefCzwO585RFsUg72nPgMEjDU4/xA876pMN3ndEIkGlnQTZFjuF6MrtIm38
MAJ1bi2EEYrlaZ0Zmh+0U1dz3QU5OLjL5g6KbmeYvPg8iqNp/CIM7+fmt/tfNcmp
aSjFstLKL6OQNJn09nBfVYxCD8cmCKvjN6EyD7fA2EOF+zYrgDQ0wfJuCP5IvLz+
8x8uKvhp1SkAsEmiXf4U9VLOJkaEuzmfdJjU/QiNUjqNeJJbaRWr1BWQo/Q9Eyo4
1puT1eg+TjeZGRAJDSV5uj+cvx9LuA==
=XXoe
-----END PGP SIGNATURE-----

--Sig_/d3N4OZEb57toJpLPWdvRs6z--
