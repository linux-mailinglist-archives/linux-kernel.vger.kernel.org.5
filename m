Return-Path: <linux-kernel+bounces-25440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B6C82D049
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 11:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4C81C20C05
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF9920F1;
	Sun, 14 Jan 2024 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="E/PuUshD"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD31FB2;
	Sun, 14 Jan 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705227865; x=1705832665; i=erick.archer@gmx.com;
	bh=v7nvUPA9OesHnOY8TOQ/tEDzJPZ9C3L0VTmMHqqdqCg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=E/PuUshD8TGQY82SBpOAPIL8fFQkIpFxpnOWu6hlgAimBDTC7j6dVeGpz7SwGooA
	 eoCcFM19BVd+hLZ7R7/5tjB1xXYK11S8qd0G2pgP+GYQxs2tZVe/Vw1Wlvj6mcEQh
	 Y/YbDLHAI9iQjvvdv2MPVT/04odvB6IuZAH58zbmvfFnaj9Uoq6LZErebRsNBcpGO
	 c51o5BAYcMItEVZlMaPa4Ck2daSzv+bdtk80tI/hN/hV4NEitkcBcDeEFJFKGrxMp
	 3vZQhDAroEebw8Rj9bt91MM+4AZnH78Px+jTGFP+kZEdTyzZxhT6Uk8f5jlv5wRVk
	 y9a8fKE0fDUBY21N5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N33Ed-1r1UTF4BzR-013RDI; Sun, 14 Jan 2024 11:24:25 +0100
From: Erick Archer <erick.archer@gmx.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	Kees Cook <keescook@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] scsi: csiostor: Use kcalloc() instead of kzalloc()
Date: Sun, 14 Jan 2024 11:24:00 +0100
Message-Id: <20240114102400.3816-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xJ85ZowQaVa1OldU6FzPfNXRLaX+yPPgWuef38/WNGua4RxRri6
 OlQil9I2dzIT/+wjstr6h9LR3cm8DSnkJuNn/9kr5MqgriqGEE52TDlLGrjHpdN2wRClrFk
 gx/J6xAu8I1bm8gH+Be0N+RmCb5Fuh/iu3awBpP03OCLZGy/wsn1xtjPbsgOcP36KrPi3/h
 fuhJOfkttmNy14ZTcJJUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vNv9MwBiC54=;OJwtbY227lidkukH55eW6u+Blo4
 3qCTOKjT9ZwDmW76FXlvj7NkWiyCt0q3tp+1rCjBaRsykO/HHmC1GcAgVwXcXY9zbJB9syQli
 lGqX5kDS1wsWobJBai0E96tBrWCS/fiYrgsjg6RuPXX+siG2cgYC+CQa8wDmjePYSO7D7Ufkp
 RengseWl51czMZs+z5KtAZtEUs5TertUVLLAPFE/y/rzHou1+7jhbvlTJ8h7QggdSQvte6O6E
 jsmmZJ6Y+t6AIN/HlV+Nt/h5020vlP36+vOwv9N0r/06ad83ITUGpe96BfTa8qTPm4MlDm6m5
 0TVfZIgjMLols9tz3KrA9Ag3RgM5Cg39nYdCMcqU7N11XR6IoWNZlN6mqKE5F1/pP+parnNjV
 /sYfFzxxYYwGSLOb4FWwM83lhK7q3Kb4cyjE7xLYUnHL/oVn+kgoqRbttK6uay9tO64OJFvv3
 a0fQcEBD4o7cNes3KdjXubWJSquwAJoY4v7Qq2IzDqnWUbK/PWIHE6EJZ3rtP7Bs69ykxXHr8
 tO6yIiL0gAlN4NpZfDvcZpi1hJeYgNGgyFk2syQIt/aaea+PiIgSPdB21WiFjEw34dMnmHnsA
 vJPBHsarcaPw3t982FyGKy2qAcFPqcB04GN1fRdW7wzmlYXjO/fymRYyI0Clt6obA3dTZFApY
 DMGpsvm1RynymxFKLl23Gc3jCW6/9/pYVWB8WS5rp30D/hEpxs4a0VIgulHOcpyZ19mN37HrF
 Y930d4QNMcBsfxc2tvvYOweHRJSwAHeZXtM3Cnd5IPmpZpejbgiFJjkgDkuKAX3ygW+X8RI7n
 0hytW7qJ8X4/HXJzULYFhuZAu95J5ZRTIZsglDFuN21gcbV6z1r13avJPNXTGynS8Tc0SVE74
 uoXUmdki8cPq9+8w3AJmwP9fexqHEyUrpughz+RJu9Chka80+ArCVuOfa+MW7zMUD2hi5cPbm
 AJ2/5Rkc5aqWF3FB0nPRhRUd/gA=

Use 2-factor multiplication argument form kcalloc() instead
of kzalloc().

Also, it is preferred to use sizeof(*pointer) instead of
sizeof(type) due to the type of the variable can change and
one needs not change the former (unlike the latter).

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
Changes in v2:
- Update the changelog text describing the sizeof()
  changes (Gustavo A. R. Silva)

Version 1:
Link: https://lore.kernel.org/linux-hardening/20240112182603.11048-1-erick=
archer@gmx.com/
=2D--
 drivers/scsi/csiostor/csio_init.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_init.c b/drivers/scsi/csiostor/csi=
o_init.c
index d649b7a2a879..d72892e44fd1 100644
=2D-- a/drivers/scsi/csiostor/csio_init.c
+++ b/drivers/scsi/csiostor/csio_init.c
@@ -698,8 +698,7 @@ csio_lnodes_block_request(struct csio_hw *hw)
 	struct csio_lnode **lnode_list;
 	int cur_cnt =3D 0, ii;

-	lnode_list =3D kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
-			GFP_KERNEL);
+	lnode_list =3D kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
 	if (!lnode_list) {
 		csio_err(hw, "Failed to allocate lnodes_list");
 		return;
@@ -737,8 +736,7 @@ csio_lnodes_unblock_request(struct csio_hw *hw)
 	struct csio_lnode **lnode_list;
 	int cur_cnt =3D 0, ii;

-	lnode_list =3D kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
-			GFP_KERNEL);
+	lnode_list =3D kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
 	if (!lnode_list) {
 		csio_err(hw, "Failed to allocate lnodes_list");
 		return;
@@ -775,8 +773,7 @@ csio_lnodes_block_by_port(struct csio_hw *hw, uint8_t =
portid)
 	struct csio_lnode **lnode_list;
 	int cur_cnt =3D 0, ii;

-	lnode_list =3D kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
-			GFP_KERNEL);
+	lnode_list =3D kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
 	if (!lnode_list) {
 		csio_err(hw, "Failed to allocate lnodes_list");
 		return;
@@ -816,8 +813,7 @@ csio_lnodes_unblock_by_port(struct csio_hw *hw, uint8_=
t portid)
 	struct csio_lnode **lnode_list;
 	int cur_cnt =3D 0, ii;

-	lnode_list =3D kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
-			GFP_KERNEL);
+	lnode_list =3D kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
 	if (!lnode_list) {
 		csio_err(hw, "Failed to allocate lnodes_list");
 		return;
@@ -855,8 +851,7 @@ csio_lnodes_exit(struct csio_hw *hw, bool npiv)
 	struct csio_lnode **lnode_list;
 	int cur_cnt =3D 0, ii;

-	lnode_list =3D kzalloc((sizeof(struct csio_lnode *) * hw->num_lns),
-			GFP_KERNEL);
+	lnode_list =3D kcalloc(hw->num_lns, sizeof(*lnode_list), GFP_KERNEL);
 	if (!lnode_list) {
 		csio_err(hw, "lnodes_exit: Failed to allocate lnodes_list.\n");
 		return;
=2D-
2.25.1


