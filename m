Return-Path: <linux-kernel+bounces-12810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C3981FA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA90A1F21EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD2FBFB;
	Thu, 28 Dec 2023 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qNO5iXGk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D78F9C7;
	Thu, 28 Dec 2023 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703784122; x=1704388922; i=markus.elfring@web.de;
	bh=X/gKRB8Ifpq3Kc0ZFe/BKNuVoOjfjzMQxZThCkDRvjc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=qNO5iXGkYXAaJJk/swBDMVii4SHZm7mEsIRQSq+9a9WzXT7r2XBGPbQSYzvZ2POu
	 AowrRyal6e8iaBKxqohIc3OjBRcgHaSbOU/7eSCYf28X4EhgC7KeBJatiq3uZ7Zqs
	 lX0t4YV5ZpM41hB7A6UTPC2gOEyWFPC65fi/CE8jPBk077iHrdiZEm/7/8CDSGDYx
	 ZBcZ+V0v9RB20lwwFwREjviWJEqhk85DadTAxS4wbAcdFjAzi7rTgd/VCcB9QMLMK
	 wGLQxZpK53IImxal0yCpY/HrkTxzN0mU5wUFsaK33KFDH/2EZPbVcEm5yOFJ+pRDF
	 txmNlJJwhrzXERyhWA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjIb-1rmvHR1T8R-00Wt5l; Thu, 28
 Dec 2023 18:22:02 +0100
Message-ID: <562d25d9-9550-4dc2-a7d9-40af3109e3db@web.de>
Date: Thu, 28 Dec 2023 18:22:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] scsi: lpfc: Improve exception handling in
 lpfc_rcv_plogi()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dick Kennedy <dick.kennedy@broadcom.com>,
 James Smart <james.smart@broadcom.com>,
 "James E. J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <48a127e8-ca4f-4fc4-81b7-226080fba720@web.de>
In-Reply-To: <48a127e8-ca4f-4fc4-81b7-226080fba720@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PfPgGX9wqxCqCOCcwdoypN85NPCwwIWH1fFjD6sPXjtEvgFZjiy
 CFtls3X4+2+fyyKPS6F/wvPlaZU6YGMXuT2vNcHqfH8EHI1+MxzublFag9fOQdACFyYKoHR
 Vf/ooIuhH+dB0v0IZ3njZ5FLtH34rwkHAfQWeINzH8mFHO1zHvdjYVUZCuliAcUMgpwMxv+
 TxY8NtMqAsFmvXn7mpPww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PGu0RpL5zzo=;7LyogwglXRvDOIz4ELTClkKFIC/
 2xHXh1dzuYt8S0eY8JKF6InUpgW8dDJuCGyO3TrM6kwfbW3PC8l3ufmpHbkiUMCGd27CxtWQM
 TWJTaWeGYNOi5gmkdva+/+NNl22kzNS6AjWFJSILzmcvR3Vz2Tez86ytfBHOkkwA6L9CaVNq1
 6WfvGOHyz0I6XlnfSq6lazjgRdBHtekK0a7vR9Z4jBwW44adLLABHJhWDe5IhnVcFtoxA7yc4
 US+krwNqKcW5hflyNTauCbDJEbR0BIC2HDRQfB3Su/ulqgNDwediuytz4Oou6Edf/rUxrnoW+
 5MhF2M6AKJ3nuYeDOJpDr99aMl3aapmGNp8NOgq5fDVNcbH4Lj2dluVNNDDDOSX46+/LvJMrE
 42nY/ykz2nMGigXTZbR9Ak2k4/FsEa7drHsqwXZmDaEoCjg1b+iuS0GywvcW7DB9OTC6ac4ab
 Lf7jx8Lmc4iWIl4g3NTIQsPiSkJClZ3mW8Mq0oK1IRRnz9GZy5KCI28lvmp5ln2vyZCPvOPYn
 gAiR3JcHkgJgI3h6pDtQDJe+tDHeJoBucFvK/LPslV7Yk/VQP8BlDyalsRpFuKj8r8ZYTvES2
 xdTugIPhQcuxrqPHoHR08dSSZZI5Se89lQ20ePKACV8xbp3hjGSGMoP8N3bRDxeJ85KN5LNZ5
 Mnpf0Qc+b+H/wLTOmClA1a+mXmwGNJfMOJHVJ7z2V73ssWAnRmbOf1jCbCp7DML9NRITWQjQT
 cuIa6ySqhq7IdMBNwEZJ4SKxVuE7DOUfve9h2v4tSE/Jm+npsNIV5gb1cVvKxtCDBbTUoPRD0
 tw2+A1OPKD/s8ynzLQBqmIEFtLGvdi62CLP6Jo6O9DBNXPhc0F9OyiBOHB0ka0x0KtXw48p17
 wvZMUh0beuhx9kojioKc+6hQFBFuzmsnCjZdPvXpGOBvDoFE19UJfj5UbIFgwQsB8GR8Svnxr
 NSOyHGPhMphz0p2NUqAufDfw50A=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2023 17:00:07 +0100

The kfree() function was called in one case by the
lpfc_rcv_plogi() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus adjust jump targets.

* Delete three variable assignments and a repeated pointer check
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/scsi/lpfc/lpfc_nportdisc.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_n=
portdisc.c
index d9074929fbab..2559f2ac7277 100644
=2D-- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -459,10 +459,6 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_=
nodelist *ndlp,
 	ndlp->nlp_nvme_info &=3D ~NLP_NVME_NSLER;
 	ndlp->nlp_flag &=3D ~NLP_FIRSTBURST;

-	login_mbox =3D NULL;
-	link_mbox =3D NULL;
-	save_iocb =3D NULL;
-
 	/* Check for Nport to NPort pt2pt protocol */
 	if ((vport->fc_flag & FC_PT2PT) &&
 	    !(vport->fc_flag & FC_PT2PT_PLOGI)) {
@@ -509,7 +505,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_n=
odelist *ndlp,
 			link_mbox =3D mempool_alloc(phba->mbox_mem_pool,
 						  GFP_KERNEL);
 			if (!link_mbox)
-				goto out;
+				goto reject_response;
 			lpfc_config_link(phba, link_mbox);
 			link_mbox->mbox_cmpl =3D lpfc_sli_def_mbox_cmpl;
 			link_mbox->vport =3D vport;
@@ -522,7 +518,7 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_n=
odelist *ndlp,
 			rc =3D lpfc_sli_issue_mbox(phba, link_mbox, MBX_NOWAIT);
 			if (rc =3D=3D MBX_NOT_FINISHED) {
 				mempool_free(link_mbox, phba->mbox_mem_pool);
-				goto out;
+				goto reject_response;
 			}
 		}

@@ -540,11 +536,11 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc=
_nodelist *ndlp,

 	login_mbox =3D mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
 	if (!login_mbox)
-		goto out;
+		goto reject_response;

 	save_iocb =3D kzalloc(sizeof(*save_iocb), GFP_KERNEL);
 	if (!save_iocb)
-		goto out;
+		goto free_mempool;

 	/* Save info from cmd IOCB to be used in rsp after all mbox completes */
 	memcpy((uint8_t *)save_iocb, (uint8_t *)cmdiocb,
@@ -657,9 +653,9 @@ lpfc_rcv_plogi(struct lpfc_vport *vport, struct lpfc_n=
odelist *ndlp,
 	return 1;
 out:
 	kfree(save_iocb);
-	if (login_mbox)
-		mempool_free(login_mbox, phba->mbox_mem_pool);
-
+free_mempool:
+	mempool_free(login_mbox, phba->mbox_mem_pool);
+reject_response:
 	stat.un.b.lsRjtRsnCode =3D LSRJT_UNABLE_TPC;
 	stat.un.b.lsRjtRsnCodeExp =3D LSEXP_OUT_OF_RESOURCE;
 	lpfc_els_rsp_reject(vport, stat.un.lsRjtError, cmdiocb, ndlp, NULL);
=2D-
2.43.0


