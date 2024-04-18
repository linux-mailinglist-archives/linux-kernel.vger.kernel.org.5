Return-Path: <linux-kernel+bounces-149628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4AC8A93A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E64282B24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F44D481A7;
	Thu, 18 Apr 2024 07:00:27 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1122.securemx.jp [210.130.202.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031B37719;
	Thu, 18 Apr 2024 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423626; cv=none; b=KxLq8gnsy9rrypkv+nnscrrBW5KTognQC05hT6bosxH0vsRai+LSqOIicZaqlqEWKj8oiZkqqNDKeo3V2PpDL2CrwpS6Srpf8dehlNurwmiCbE+P+ir1P+5bNwIus5hsD+gjp/9Rj/3KHE2HliPxGu9qDhJbU1w435J7Pk4CLCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423626; c=relaxed/simple;
	bh=mqwFrIzDju9TMIIICMRMI4d5HpzguSACJdFojcfzKpc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=craHWy6a8yCLXeQJb9Jq/JIBKWiGG4q2USYNMqhT0Hh/CWT7UZdaXgwB3CveO7PfpwdeWmdyxm6OA0b7gF2GK4y43VpAU01n8NzLOcAM9HlJK0CmeyshTYPzSHUDF6SpJ1DkyMgIQc3wU2e+UW9Ft/Zqik//gpu21qbcD3cAW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1122) id 43I5iXsP2111095; Thu, 18 Apr 2024 14:44:33 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 43I5i69a1973992; Thu, 18 Apr 2024 14:44:07 +0900
X-Iguazu-Qid: 2rWhTy7tBPqzniEIkh
X-Iguazu-QSIG: v=2; s=0; t=1713419046; q=2rWhTy7tBPqzniEIkh; m=AevLJNU7sdeyJIm6CUqHIA7BK0AHDkRW4BxeA0WNq2M=
Received: from CNN1EMTA01.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1121) id 43I5i5wJ2636816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Apr 2024 14:44:05 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA01.test.kioxia.com (Postfix) with ESMTP id A77D048A81;
	Thu, 18 Apr 2024 14:44:05 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 7E7A51947AEC50;
	Thu, 18 Apr 2024 14:22:07 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002QAAAAAA01FM9;
	 Thu, 18 Apr 2024 14:22:07 +0900
Received: from CNN1EXMB02.r1.kioxia.com (CNN1EXMB02.r1.kioxia.com [10.232.20.151])
	by Switcher-Pre_Send (Postfix) with ESMTP id 7347DAA28483C;
	Thu, 18 Apr 2024 14:22:07 +0900 (JST)
Received: from CNN1EXMB04.r1.kioxia.com (10.232.20.153) by
 CNN1EXMB02.r1.kioxia.com (10.232.20.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:44:04 +0900
Received: from CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) by
 CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) with mapi id 15.01.2507.035; Thu,
 18 Apr 2024 14:44:04 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/11] md: workaround for inconsistency of config state in
 takeover
Thread-Topic: [PATCH v2 03/11] md: workaround for inconsistency of config
 state in takeover
Thread-Index: AdqLx93+rdcA1FHTRcas4Y+n9m5suw==
Date: Thu, 18 Apr 2024 05:44:04 +0000
Message-ID: <70bf226187b7466eb0a8480922ba9cc7@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-as-result: No-10--9.492700-8.000000
x-tmase-matchedrid: tkB2VEODQ1emagT1k9kBpgrcxrzwsv5uXPK9y3z82GtXGTbsQqHbkkog
	3hT9f/oCJ2spf+DCeJzmn3xyPJAJoh2P280ZiGmRupDIC9422DoWUg/hm489yO+sdQufriAS4aS
	bGEJzu4sESV4es7KJNx8GSwQM8TG4+qIQ7qDJ9P+AwosDBeuPwZki3iIBA3o/rhnpK05RvESFFj
	ccLWe/lssDZ/QWaNswKDX7UR/i5drv4tNJ1H3OMBJo06V2lHTeBGvINcfHqhe52DlOQbIerbFNg
	mH5/5Kd585VzGMOFzA9wJeM2pSaRSAHAopEd76vz6B2CIwVCKQCUFvfbZma39F+WlOsR9awHewC
	W3pU/r2oTymQXYzk1g==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--9.492700-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-snts-smtp: AE5A978A5368A1D0ABA9418A0FFA7FD7368B0AB054A6A95739451643F4FDCDB52000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB02.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB02.r1.kioxia.com

This patch depends on patch 01.

An inconsistency occurs between config state in takeover and percpu_ref sta=
te.
Differentiate percpu_ref state setting for takeover and other to avoid the =
inconsistency.
Therefore, add percpu_ref state setting to match config state in takeover.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/raid5.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 25da83eaa2ef..b7056854375d 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7396,7 +7396,8 @@ static unsigned long raid5_cache_count(struct shrinke=
r *shrink,
 	return max_stripes - min_stripes;
 }
=20
-static struct r5conf *setup_conf(struct mddev *mddev)
+
+static struct r5conf *setup_conf(struct mddev *mddev, bool quiesce)
 {
 	struct r5conf *conf;
 	int raid_disk, memory, max_disks;
@@ -7407,6 +7408,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	int group_cnt;
 	struct r5worker_group *new_group;
 	int ret =3D -ENOMEM;
+	unsigned int percpu_ref_init_flags;
=20
 	if (mddev->new_level !=3D 5
 	    && mddev->new_level !=3D 4
@@ -7477,6 +7479,10 @@ static struct r5conf *setup_conf(struct mddev *mddev=
)
 	init_llist_head(&conf->released_stripes);
 	atomic_set(&conf->active_stripes, 0);
 	atomic_set(&conf->preread_active_stripes, 0);
+	if (quiesce)
+		percpu_ref_init_flags =3D PERCPU_REF_ALLOW_REINIT | PERCPU_REF_INIT_DEAD=
;
+	else
+		percpu_ref_init_flags =3D PERCPU_REF_ALLOW_REINIT;
 	atomic_set(&conf->active_aligned_reads, 0);
 	spin_lock_init(&conf->pending_bios_lock);
 	conf->batch_bio_dispatch =3D true;
@@ -7657,6 +7663,23 @@ static struct r5conf *setup_conf(struct mddev *mddev=
)
 	return ERR_PTR(ret);
 }
=20
+static struct r5conf *setup_conf_for_run(struct mddev *mddev)
+{
+	return setup_conf(mddev, false);
+}
+
+static struct r5conf *setup_conf_for_takeover(struct mddev *mddev)
+{
+	struct r5conf *conf;
+	bool quiesce =3D false;
+
+	if (mddev->level =3D=3D 4 || mddev->level =3D=3D 5 || mddev->level =3D=3D=
 6) {
+		conf =3D mddev->private;
+		quiesce =3D false;
+	}
+	return setup_conf(mddev, quiesce);
+}
+
 static int only_parity(int raid_disk, int algo, int raid_disks, int max_de=
graded)
 {
 	switch (algo) {
@@ -7884,7 +7907,7 @@ static int raid5_run(struct mddev *mddev)
 	}
=20
 	if (mddev->private =3D=3D NULL)
-		conf =3D setup_conf(mddev);
+		conf =3D setup_conf_for_run(mddev);
 	else
 		conf =3D mddev->private;
=20
@@ -8627,7 +8650,7 @@ static void *raid45_takeover_raid0(struct mddev *mdde=
v, int level)
 	/* make sure it will be not marked as dirty */
 	mddev->recovery_cp =3D MaxSector;
=20
-	return setup_conf(mddev);
+	return setup_conf_for_takeover(mddev);
 }
=20
 static void *raid5_takeover_raid1(struct mddev *mddev)
@@ -8655,7 +8678,7 @@ static void *raid5_takeover_raid1(struct mddev *mddev=
)
 	mddev->new_layout =3D ALGORITHM_LEFT_SYMMETRIC;
 	mddev->new_chunk_sectors =3D chunksect;
=20
-	ret =3D setup_conf(mddev);
+	ret =3D setup_conf_for_takeover(mddev);
 	if (!IS_ERR(ret))
 		mddev_clear_unsupported_flags(mddev,
 			UNSUPPORTED_MDDEV_FLAGS);
@@ -8692,7 +8715,7 @@ static void *raid5_takeover_raid6(struct mddev *mddev=
)
 	mddev->new_layout =3D new_layout;
 	mddev->delta_disks =3D -1;
 	mddev->raid_disks -=3D 1;
-	return setup_conf(mddev);
+	return setup_conf_for_takeover(mddev);
 }
=20
 static int raid5_check_reshape(struct mddev *mddev)
@@ -8770,7 +8793,7 @@ static void *raid5_takeover(struct mddev *mddev)
 	if (mddev->level =3D=3D 4) {
 		mddev->new_layout =3D ALGORITHM_PARITY_N;
 		mddev->new_level =3D 5;
-		return setup_conf(mddev);
+		return setup_conf_for_takeover(mddev);
 	}
 	if (mddev->level =3D=3D 6)
 		return raid5_takeover_raid6(mddev);
@@ -8790,7 +8813,7 @@ static void *raid4_takeover(struct mddev *mddev)
 	    mddev->layout =3D=3D ALGORITHM_PARITY_N) {
 		mddev->new_layout =3D 0;
 		mddev->new_level =3D 4;
-		return setup_conf(mddev);
+		return setup_conf_for_takeover(mddev);
 	}
 	return ERR_PTR(-EINVAL);
 }
@@ -8840,7 +8863,7 @@ static void *raid6_takeover(struct mddev *mddev)
 	mddev->new_layout =3D new_layout;
 	mddev->delta_disks =3D 1;
 	mddev->raid_disks +=3D 1;
-	return setup_conf(mddev);
+	return setup_conf_for_takeover(mddev);
 }
=20
 static int raid5_change_consistency_policy(struct mddev *mddev, const char=
 *buf)
--=20
2.34.1



