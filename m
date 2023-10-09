Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691FE7BD15D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 02:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345022AbjJIAI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 20:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344929AbjJIAI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 20:08:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51894A6;
        Sun,  8 Oct 2023 17:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696810134;
        bh=H3b5Q4CPhf81BAdNsBH6LuxbsnJyU4sVyUV1x2qhmA8=;
        h=Date:From:To:Cc:Subject:From;
        b=AGb1iLFDKb9CIgjxZnImgYVCOwokV6IZSIqFHl1vR4uD3FF7hOqYNNsEgClYAnV1+
         o2udg/jytrXq50a49CBtHXPslZb0QMgIf3kJQUwg2+dSBK3RH91qL8tPwZcyviH0gg
         dNvCugSvjM5jkA1f3plzX3CCnydnbRp/CProX6coyj9+q+9jAFI4I5wRyvPIGK8k0V
         31J6Lyjf7MOSIOuwBA9L2aTRuSsqlpGD2eXz/t0J5Dp4IVs2uYRlLjalJurYa2uo6R
         FE1Pjy7fsA3idSqfyQA1/O3hTB6ppOZulHDRbAznkS16jBtsI9HIN21rM0QPHcEstj
         wt4zzjagMh0fA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3fX56NxKz4xPf;
        Mon,  9 Oct 2023 11:08:53 +1100 (AEDT)
Date:   Mon, 9 Oct 2023 11:08:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the v4l-dvb-next tree
Message-ID: <20231009110852.36b0bd42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A1sezmQ/KuRtzY79VQD+=6s";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A1sezmQ/KuRtzY79VQD+=6s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/media/platform/qcom/camss/camss.c: In function 'camss_probe':
drivers/media/platform/qcom/camss/camss.c:1634:17: error: label 'err_cleanu=
p' used but not defined
 1634 |                 goto err_cleanup;
      |                 ^~~~

Caused by commits

  7405116519ad ("media: qcom: camss: Fix pm_domain_on sequence in probe")
  b278080a89f4 ("media: qcom: camss: Fix V4L2 async notifier error path")

interacting with commit

  2c1bae27df78 ("media: qcom: camss: Fix pm_domain_on sequence in probe")

from the v4l-dvb tree.

I have applied the following merge resolution patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 9 Oct 2023 11:05:26 +1100
Subject: [PATCH] v4l-dvb-next: fix up for bad automatic merge.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/media/platform/qcom/camss/camss.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/plat=
form/qcom/camss/camss.c
index 38d20b12cdd8..8e78dd8d5961 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1628,12 +1628,6 @@ static int camss_probe(struct platform_device *pdev)
 		return ret;
 	}
=20
-	ret =3D camss_configure_pd(camss);
-	if (ret < 0) {
-		dev_err(dev, "Failed to configure power domains: %d\n", ret);
-		goto err_cleanup;
-	}
-
 	ret =3D camss_init_subdevices(camss);
 	if (ret < 0)
 		goto err_genpd_cleanup;
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/A1sezmQ/KuRtzY79VQD+=6s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUjRJQACgkQAVBC80lX
0GwuiQf/QfAzuWmGC6qJnIVAonO6LYfjmaUK06Ga8oQlvRphiOSu3980xTLIBg6F
CoANi+4K1bSiQJYDfuQQigeffbfT/4c3FgTM5wP/9VUYIuruoA8NNJJoVcdPYlKI
FGkiRzkAyiZSfWY7gIph9kb5lcYjdRgaJNHnFY/xUX9oWlsptH94AQ5HCe/SzaQT
PBpWMRWoUgYyB/5w79BLJ4d7XZybzi9e8mGo1lnDCL5hCQJVo61260h6cgmH//To
QAunR1ug2qqkuBMSRO7S5gjtIUq03s4s3vBdL08rdjWm6rUEsuRYPvtPw4PeytpB
+UyvJRIw9b0+X74JL5/BfgUBQhd3ig==
=ybwZ
-----END PGP SIGNATURE-----

--Sig_/A1sezmQ/KuRtzY79VQD+=6s--
