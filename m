Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD4780C0FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjLKFub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjLKFuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:50:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26804213E;
        Sun, 10 Dec 2023 21:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702273758;
        bh=5ownzIkARz43eQTloQkKelbMKKK9J+c14Q+Xkg/VpWU=;
        h=Date:From:To:Cc:Subject:From;
        b=g1QYRRL0JgzIR/pbzVUeOs0X3Oy8te73acyAmxtMQiUrZtQLpDlFBSkvl0pC0K/uz
         h/a0AVTGZwQ+RTMd4lFEHpyxrOU3dPIlCgTfIQYP5tZNLNc+bwjmAvYP3QDJG6UorT
         h5XnUabVn0trae5u3qQpq+3E6IcBF0799Z+ZZAOnUory6qqS79ZMOtjGMTRRuN6gUl
         JPF8tCcCh+2DycfYsxYbqFoV4zZMMo9MtPmacJ/rUXK7eeLwDg4ZpiMnUl7f/xOF3k
         9vAyQGYJx0WGLKgWfJNHEIp0AZ+pS/4K+I4NA/bGu5X5GjB6ir/cbuywybHKnhBxbE
         fQu2W1xABUpFg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpW5p1Rx6z4xGR;
        Mon, 11 Dec 2023 16:49:18 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 16:49:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the nvmem tree
Message-ID: <20231211164916.6f0d2357@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nYikG/bmL+ZRJ2lLCNwpPJo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nYikG/bmL+ZRJ2lLCNwpPJo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nvmem tree, today's linux-next build (i386 defconfig)
failed like this:

/home/sfr/next/next/drivers/nvmem/core.c: In function 'nvmem_cell_put':
/home/sfr/next/next/drivers/nvmem/core.c:1603:9: error: implicit declaratio=
n of function 'nvmem_layout_module_put' [-Werror=3Dimplicit-function-declar=
ation]
 1603 |         nvmem_layout_module_put(nvmem);
      |         ^~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  ed7778e43271 ("nvmem: core: Rework layouts to become regular devices")

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 11 Dec 2023 16:34:34 +1100
Subject: [PATCH] fix up for "nvmem: core: Rework layouts to become regular =
devices"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/nvmem/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9fc452e8ada8..784b61eb4d8e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1491,6 +1491,11 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_n=
ode *np, const char *id)
 	return cell;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
+
+#else /* IS_ENABLED(CONFIG_OF) */
+
+static inline void nvmem_layout_module_put(struct nvmem_device *nvmem) { }
+
 #endif
=20
 /**
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/nYikG/bmL+ZRJ2lLCNwpPJo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2otwACgkQAVBC80lX
0GxrhQgAmGlntDh8OyosiXZ5XBpZQRAHQPVjinRKuBEa0QMBqP/ozsVEmRp3VM11
THPuzzrsaFfFaSyXrHwwI44XDPTbdTZ1X833tsWM5GOtV33pgLq7LLJ5m60Xb8DI
qNbKR30addnNolHnI9eipaeZSjlKxXwWC7Wg4g2xyMBljtfKERK349Qj85mCnicf
iLyaM4woBrLBYHBo4ZsWb/h5ykE1DRI40KPuJM9JVNnOiC0vFYRyl7xBsUtfX88I
WkZ77SQ6iOM8zcV/gWwGZj2FaCBqZD0BMmhunu1E0W1bUsn/2Z2YXJH8bZ1NfLqy
H/Cd06ddyZK4KcaPcgCl0gZs2xeIoA==
=4mza
-----END PGP SIGNATURE-----

--Sig_/nYikG/bmL+ZRJ2lLCNwpPJo--
