Return-Path: <linux-kernel+bounces-13724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A4D820BB1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E851F211ED
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432EA8C1F;
	Sun, 31 Dec 2023 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="lAjUuHKK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BCC8F49;
	Sun, 31 Dec 2023 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704034824; x=1704639624; i=markus.elfring@web.de;
	bh=/EkgIbiDfFiW79s9a4Ba4KIcoGQRr5fomhIzMuL4pkQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:
	 In-Reply-To;
	b=lAjUuHKKLLMTacaMrIMsZ/OOnph36OFk831BnfBHFvGXMU6lzBhtImXYS3zv606E
	 c8NGymPNhvF51C0QZkIpcN0a5BfUPz5m/2kF9n1yIc3pDj2+HgYt/OZUl044Gc22t
	 9V/Q+VVFcz76aP7wn7ZttOaOHEvrgSqQC1e3CiDP3paFIIizR2PecBv5iOks3sAw6
	 awakye2XLnopEWguxPSGEkpDETMIWsOpT+LRRO73RMuPtXgx65mj+hkKKRVywEmAI
	 nyE57tCLrAi204EQagySrf+hJ4fu3xxaXhPbQRFHYj2V9QZro4RuDEiERQGC/680K
	 699MZbZnBVYLTEh+Fg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwA1A-1r3OQ81xBs-00sG9F; Sun, 31
 Dec 2023 16:00:24 +0100
Message-ID: <5253e660-6b66-4775-ae2f-06f5a1d40be5@web.de>
Date: Sun, 31 Dec 2023 16:00:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] net/smc: Improve exception handling in
 smc_llc_cli_add_link_invite()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>,
 Paolo Abeni <pabeni@redhat.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>
References: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oG3OmE7p+Zndch/Dj/BnQFbZ4YKWANLuDuOJVlDnyB2QnqSTIfO
 FN4K3UkD8+tYea+OsaPrlTrg2oWgGiEcCvW11H69MqsCeSl7thehurwIksrf1kwil0QGIDw
 ufE7jsBAHe0kQLj0of+zeF/MIm/8bxPktR6HnHU5qMM6gz2p/WIF3q7arKIq2QB6FVjKZHe
 oNKjkRrfxbvdfzZcUSciA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6M1bFLtV6zc=;k7xX0Go5mPnhUg1AtvOiS4tVGyu
 sES+x3UIFXs/aJtn6JOx64gVuddsXky1mfoDSyu1RGPsHVSaUK5cHvPypQzcxp3Q0TooNHPWt
 7Gfk8dPEHSEk4Nb+055lRygnhv+Wo5qa0TeG8fvp+YuXPnrj8Pyz0aSQGC92NUV0QdDKLF1Dp
 qSiRVjsUL/30IXQQn5TQC+VJq2SgYtZJVQ53DecR0EBGJlT09c4Z1BsNQmH8c0VJVfL8Oq0gA
 /sD9kamMNuOAUhRONYRMxnzz6jOBKF7P8tvR8liB5pUHftM29nCxnpA1tsD5fq58OofoD4DI1
 gYo/PXdvoGvtW3BQVrIfJo7/Tn8JYA4Nu9/Y5c2tCtASy1b296nO17gAQJEgoeinyQuHLBg6a
 bOO31at2WB6IJ7Z4JOqE/MKW6zsNDTGabnpFQwHxKyLf9boybLk7WRBV7jF2UdG9iyNjiby3g
 k2RdesvHAdzxKnLVyKAudjVkDqtc320aXXL6x2YdDQ0RbBBONQY740+Md1Q9evT50IAP/gn8h
 41NKKrF+hDKHqIH8yNZ2U9vWPACVE3M2g2DrkjHCysWxApje9nugAgcqViFF410qNfa2gzEDz
 gKM9vCJ3bGP02sQZy6vuOClXKQL+2VoJCggqyLlUdmhN4oRgjn8i3iP75bTF3uOrgqWS+3Rw1
 qoXn/TC3Erf0hqJl0l0uCHoP8gT6lqTFgIWKzwKfQgZ7mT3sT3LIWjU1keydEt0ukfK/gJznK
 5q4QLYxq9qUN4xgBU+FBLCnCweA3trW13AjRSP+cD/XSlI+OWMPGEmh8TyGZaN1XKANeab43f
 yj3Ieb18vyXBf1QDY47mXGDlt6TNm4DpsE+hnAlsfjyqt2tE+0amYXV8WY36zew6vnsfndb6X
 9FSVQPPSNKPx6PzJu4aTUggy+B8/8WQfPD+b5ZmW6Que1IHm8LVKKFkpNxCau6Vp0imQX+Cup
 rgELGg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 15:42:07 +0100

The kfree() function was called in some cases by
the smc_llc_cli_add_link_invite() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus use another label.

* Merge two if statements.

* Omit an initialisation (for the variable =E2=80=9Cini=E2=80=9D)
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/smc/smc_llc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 018ce8133b02..2ff24a7feb26 100644
=2D-- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -1163,23 +1163,21 @@ static void smc_llc_cli_add_link_invite(struct smc=
_link *link,
 					struct smc_llc_qentry *qentry)
 {
 	struct smc_link_group *lgr =3D smc_get_lgr(link);
-	struct smc_init_info *ini =3D NULL;
+	struct smc_init_info *ini;

 	if (lgr->smc_version =3D=3D SMC_V2) {
 		smc_llc_send_request_add_link(link);
-		goto out;
+		goto free_qentry;
 	}

 	if (lgr->type =3D=3D SMC_LGR_SYMMETRIC ||
-	    lgr->type =3D=3D SMC_LGR_ASYMMETRIC_PEER)
-		goto out;
-
-	if (lgr->type =3D=3D SMC_LGR_SINGLE && lgr->max_links <=3D 1)
-		goto out;
+	    lgr->type =3D=3D SMC_LGR_ASYMMETRIC_PEER ||
+	    lgr->type =3D=3D SMC_LGR_SINGLE && lgr->max_links <=3D 1)
+		goto free_qentry;

 	ini =3D kzalloc(sizeof(*ini), GFP_KERNEL);
 	if (!ini)
-		goto out;
+		goto free_qentry;

 	ini->vlan_id =3D lgr->vlan_id;
 	smc_pnet_find_alt_roce(lgr, ini, link->smcibdev);
@@ -1190,6 +1188,7 @@ static void smc_llc_cli_add_link_invite(struct smc_l=
ink *link,
 			      ini->ib_gid, NULL, SMC_LLC_REQ);
 out:
 	kfree(ini);
+free_qentry:
 	kfree(qentry);
 }

=2D-
2.43.0


