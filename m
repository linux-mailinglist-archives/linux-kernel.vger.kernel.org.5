Return-Path: <linux-kernel+bounces-24966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F4882C560
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AF61C2257E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E9817C8D;
	Fri, 12 Jan 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="jEbrZzQ3"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E87175B0;
	Fri, 12 Jan 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705083982; x=1705688782; i=erick.archer@gmx.com;
	bh=+Gybv52t9GG+h/zrvAoxV5B+3VXNY3CX5/ikX0He3fo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=jEbrZzQ3DAJzHbArawwFAvrR3181x7bOeVmyz70JTzN8gjaDzZUtwD2U8RbwN+0a
	 Xz6YYW0D2OXBs7c4Y7ynAFvshBDL/ej7VETNM0GTfrlVzGSvwRGtnCzLS6dJaualA
	 TSLoTKSXfcgHM2qSnhdlCoxsZ6MiMFRNeWs5QLlXEyfXIPHtXPKI7wLi6R26VZdrZ
	 12hvSDtCme+m6/xAiZHjnX5/1BaRgHQWo7LB4H7jsQ4DcPcsNglU+oOG45JapofVU
	 Q0KlcZAb4GIy+oiZuNnYL6nxm+uWAjv1iIJnd/Eya8s4r0gNHH9m59nj9cTqVMBX+
	 AeUQBGIqOknavJlISQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MQ5rU-1rkRSf3fuq-00M3wH; Fri, 12 Jan 2024 19:26:22 +0100
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
Subject: [PATCH] scsi: csiostor: Use kcalloc() instead of kzalloc()
Date: Fri, 12 Jan 2024 19:26:03 +0100
Message-Id: <20240112182603.11048-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VqSrX2QEK19EdjFd/yQN1WWLQ7POmZiuBsYckjEvZYo0v8/G3HX
 qVv85dL9MOxFSzsVUJBbubAuAQ4L0jePv3wpZwc3baUgn2dDWqC8tXUU2t08/r74MetNjUZ
 3ZmF3fe/n0Is9WPmpv6bhGd/FoHp3ZpqVxMjni0QhkOl2Y6mBzRBzz3VJCWoLLzfz9y7m+x
 0F7OSGrOna4uMSQBisglQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gYeDrLFe1ck=;KD7kEcholIXzrSPNj27MNUcZjiV
 hy89Hnf1tkqrMmy37I0Y3eiF/8Az5bONZGq6EfvT7jTMFYnCMc08D+1ejNys8TUCJrKCqZE3I
 ypJDVqkS0c4sS2qhoLmCr94aJXmCA/3cOLEcFEMBK80eClLILo4ghKy3yvrtIOYJL0aUvzD+6
 aSZwI3rtxlG0E6iCBqAlBhD8elVhh2X5mSwa9IbdHwNIEERMX/LXVvtj7DmAKb8MQf4Ti8WS+
 hfwJQbhVV36bTvFVUD3jCLVOny/EXoz2G/Fh1ZSO/W0Y7UDK7b5Aji0rtFPXYrggMo50pbUOp
 ubJDN5guxEchE+OVtthlVuKZ1qqCTinn/J4xKe9ewBjLEFo53Adt7FhC4S8mSuNZHy1k3IUdC
 CIJy/8foyCctV1eo+1lfT7rigwliSeCfCGXFrKeFmmtb2bIiu+4q88BbCqMk+ITgTFoVOovnW
 HmX4x2Ho7PD06ekbNCJ0uBXipdsnKdbZnUUp9O3A1Oj6f3Lme8kpVTWnReYvjK/FLllBKFyM/
 LQ+eQDaieYhxyk4zK4SvuAxDDMNqTOiWHNHkirb5KiX21rHpflJXNZ5HjQ/1FGk3di1gdgaoE
 gZ/GZJAOsUueQYjtSR2a3Qe7xIYzt59EsuGA6FFwyhjtbtoYHcp0IBPxBEQUBM5B3Dog9oSZo
 fSelG2p4GknyONSeduDNoihF4oSmV0Lw86pJN+8BQgZSYL5w9WRrdqhdzhw44N1foNWGaKsQD
 HYApzDY5GXCGdUAcSaeNk43n3UuYGnsxaAPCpGPQNee+ZeM5KplKNvb7R1d2ogF7lVFMt8uc5
 zBY+ZA0n/Bgd22wugyhv/7/uaw3fs2rafepy8G1Ch0ymQ5DuO1ppsZvkhc9TKaHbAPnKuROSI
 rhMUJnXgbxQl/F+wRVntax6xyr+793O1BnY/bt6IaXuYQ0AGPxkJsBhKw1OScKig7jFiBRcJ6
 uldUNMT8v2sysQQyOISacVd6D/o=

Use 2-factor multiplication argument form kcalloc() instead
of kzalloc().

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
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


