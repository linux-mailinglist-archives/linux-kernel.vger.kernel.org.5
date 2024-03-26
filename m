Return-Path: <linux-kernel+bounces-118803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157DA88BF8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C553D2E3FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8C8823DB;
	Tue, 26 Mar 2024 10:30:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8FD8286F;
	Tue, 26 Mar 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449004; cv=none; b=n4iSljv8Gccm2zxUK5JpXHc61jJ3XcZRPL9hIed6P7Cj+Z7ZF56qclEE6eFscF2b9SMCm7t42dDkE0UTImOnmQ0Xoufa5T5GwY/FAIK+yckhCpMdKE9jDzZCFUkYYGxq4DYQzI7L58O8E2Pi99VQZVQg96bQDvmWixHADdu/Xx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449004; c=relaxed/simple;
	bh=v2jL1hy4xGTvomfW5Zhh9PpQnxZHZB2SqnKYDTHsHco=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XSTxa5WKvwIMB/6U9Z6TVBL2ROqEaZJ/oLbPV9B9NbvyqQDTZKZkio16vEEEqgq2eE/HGEQ3IJi0Ct2p/ZZGN2XIf9IPUYT1ZucsYGRGW4QBMKQwRgBaNffIBhNLHOA9Q+BgEH9Kh5WVdFArvMyesXGvH5hdzWDlNphpbYgz2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 42QATt6i2378481; Tue, 26 Mar 2024 19:29:55 +0900
X-Iguazu-Qid: 2rWh11C4gmtKu6UUN6
X-Iguazu-QSIG: v=2; s=0; t=1711448995; q=2rWh11C4gmtKu6UUN6; m=NZKyFdp6DPl6ZkM+TxeUnhEP8FgEa1YAjoiLGCcwQkY=
Received: from CNN1EMTA02.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1120) id 42QATsUr2928218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Mar 2024 19:29:54 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA02.test.kioxia.com (Postfix) with ESMTP id 736292F028;
	Tue, 26 Mar 2024 19:29:54 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id E4EF81938D7224;
	Tue, 26 Mar 2024 19:08:27 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002VAAAAAA012LG;
	 Tue, 26 Mar 2024 19:08:27 +0900
Received: from CNN1EXMB04.r1.kioxia.com (CNN1EXMB04.r1.kioxia.com [10.232.20.153])
	by Switcher-Pre_Send (Postfix) with ESMTP id D9CBDA035DC28;
	Tue, 26 Mar 2024 19:08:27 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB04.r1.kioxia.com (10.232.20.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 19:29:53 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Tue,
 26 Mar 2024 19:29:53 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/11] md: avoid conflicts in nr_pending operations
Thread-Topic: [PATCH 11/11] md: avoid conflicts in nr_pending operations
Thread-Index: Adp/ZKBKW6uU4n/lRH2pDrm0xZHe5Q==
Date: Tue, 26 Mar 2024 10:29:53 +0000
Message-ID: <22c6696bf0594cd69cad3a2002695402@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-as-result: No-10--9.404500-8.000000
x-tmase-matchedrid: k7uoLACGqMqmagT1k9kBpgrcxrzwsv5uXPK9y3z82GsPdZmyx8xAa4Ul
	JlxlTIT+tPwtczFrCbS12HagvbwDji/7QU2czuUNA9lly13c/gFezmeoa8MJ86G5P8xDq4BXoK5
	B6+qXU7BvF9oQ/B54yN5WE7eMYlPKhrD3pNcSx1aqFx2c/3V5cbs5i+al07BJUrMN6XtW1EtvXF
	TtvgJmGhSu3n/oQBOZmsmH6sEd2eHyAV/ow31xqxMxKDqgAFSzuoYFb0nRiqNULhp+W/a9mTiRi
	c6D7updJciLWd+sUhmbKItl61J/ySKveQ4wmYdMijciq9xw8kXCttcwYNipX6pqCpA94QmM0iSE
	K8EapKcB2Iz/+kAhduXu7VHCH84vZipFGUz6bng9AUz4NAIVDw==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--9.404500-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-snts-smtp: 3DD78E085F0BFC6C32DCF8BE2822A0836075F333BA941AC969AEB0C3F5A3F29B2000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB04.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB04.r1.kioxia.com

This patch depends on patch 10.

Change nr_pending from atomic mode to percpu mode.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/md.c     | 5 +++--
 drivers/md/raid1.c  | 6 ++++++
 drivers/md/raid10.c | 6 ++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1c7b774dbb48..7cbf199bd168 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3742,7 +3742,6 @@ int md_rdev_init(struct md_rdev *rdev)
 	ret =3D percpu_ref_init(&rdev->nr_pending, percpu_wakeup_handle_req_pendi=
ng,
 		PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
 	WARN_ON(ret);
-	percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
 	nr_pending_dec(rdev);
 	atomic_set(&rdev->read_errors, 0);
 	atomic_set(&rdev->corrected_errors, 0);
@@ -9266,7 +9265,7 @@ static bool rdev_removeable(struct md_rdev *rdev)
 		return false;
=20
 	/* There are still inflight io, don't remove this rdev. */
-	if (nr_pending_is_not_zero(rdev))
+	if (nr_pending_is_atomic_mode(rdev) && nr_pending_is_not_zero(rdev))
 		return false;
=20
 	/*
@@ -9364,6 +9363,8 @@ static int remove_and_add_spares(struct mddev *mddev,
 			rdev->raid_disk =3D -1;
 			removed++;
 		}
+		if (mddev->pers->level !=3D 1 && mddev->pers->level !=3D 10)
+			percpu_ref_switch_to_percpu(&rdev->nr_pending);
 	}
=20
 	if (removed && mddev->kobj.sd)
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 146eda6c4961..dd721b9c19b9 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2006,6 +2006,7 @@ static int raid1_remove_disk(struct mddev *mddev, str=
uct md_rdev *rdev)
 			conf->mirrors[conf->raid_disks + number].rdev =3D NULL;
 			unfreeze_array(conf);
 		}
+		percpu_ref_switch_to_percpu(&rdev->nr_pending);
=20
 		clear_bit(WantReplacement, &rdev->flags);
 		err =3D md_integrity_register(mddev);
@@ -3298,6 +3299,11 @@ static int raid1_run(struct mddev *mddev)
 static void raid1_free(struct mddev *mddev, void *priv)
 {
 	struct r1conf *conf =3D priv;
+	struct md_rdev *rdev;
+
+	rdev_for_each(rdev, mddev) {
+		percpu_ref_switch_to_percpu(&rdev->nr_pending);
+	}
=20
 	mempool_exit(&conf->r1bio_pool);
 	kfree(conf->mirrors);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index eebbf9185deb..e285481464b9 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2180,6 +2180,7 @@ static int raid10_remove_disk(struct mddev *mddev, st=
ruct md_rdev *rdev)
 		clear_bit(Replacement, &p->replacement->flags);
 		WRITE_ONCE(p->replacement, NULL);
 	}
+	percpu_ref_switch_to_percpu(&rdev->nr_pending);
=20
 	clear_bit(WantReplacement, &rdev->flags);
 	err =3D md_integrity_register(mddev);
@@ -4172,6 +4173,11 @@ static int raid10_run(struct mddev *mddev)
=20
 static void raid10_free(struct mddev *mddev, void *priv)
 {
+	struct md_rdev *rdev;
+
+	rdev_for_each(rdev, mddev) {
+		percpu_ref_switch_to_percpu(&rdev->nr_pending);
+	}
 	raid10_free_conf(priv);
 }
=20
--=20
2.34.1


