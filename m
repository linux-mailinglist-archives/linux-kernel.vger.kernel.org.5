Return-Path: <linux-kernel+bounces-149611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E2E8A9375
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C17281FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C25745D6;
	Thu, 18 Apr 2024 06:45:55 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF146A8AD;
	Thu, 18 Apr 2024 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422755; cv=none; b=sSHQeOgg6VVDmvZgFrlY46ceifncyR7y1qyKX/gYtZdjqHXSnkan7zoa454kDXCuz6jA8tWH4Ncoq6L2i3/OxFozK6xq7E25sgA+WhSiXIAARF+BihnPYaYVt93nteZoYgSHI/MNb9XAhpmj5emc3Cr9HYrRv+0eAaftjx0nNZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422755; c=relaxed/simple;
	bh=Ypi0ot5qJ8tn0ASlGHSUepHvLkwFH4KHfNbquxNLrHg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I1pTbvj0DoUnpz3f7k2aSP41p0nRrgJWHBMzvXOysFT3IslOYlRrfvOKtagXyXrBLU9mxmGkOg06FXvHAcFYj9JfQAg1wlEv7XRRy0vGjFN9CONlYAaywEdJdAmHySut5rW3zPtHsyJATdlXvGiSFzwCSAAMM/wn8g9d6xk/jXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 43I5ifvv2019038; Thu, 18 Apr 2024 14:44:41 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 43I5iMCF2153416; Thu, 18 Apr 2024 14:44:23 +0900
X-Iguazu-Qid: 2rWhTy7tBPr10isDrf
X-Iguazu-QSIG: v=2; s=0; t=1713419062; q=2rWhTy7tBPr10isDrf; m=IDB3TLEYIEqh17n/W51ywxnqltOA5XjHLUvRZYIxeNM=
Received: from CNN1EMTA01.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1120) id 43I5iLs33349860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Apr 2024 14:44:22 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA01.test.kioxia.com (Postfix) with ESMTP id BB40F48A81;
	Thu, 18 Apr 2024 14:44:21 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 0FED21900001EB;
	Thu, 18 Apr 2024 14:31:39 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR04.kioxia.com with ESMTP id 0003QAAAAAA02252;
	 Thu, 18 Apr 2024 14:31:39 +0900
Received: from CNN1EXMB04.r1.kioxia.com (CNN1EXMB04.r1.kioxia.com [10.232.20.153])
	by Switcher-Pre_Send (Postfix) with ESMTP id 0479EA0640E18;
	Thu, 18 Apr 2024 14:31:39 +0900 (JST)
Received: from CNN1EXMB04.r1.kioxia.com (10.232.20.153) by
 CNN1EXMB04.r1.kioxia.com (10.232.20.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:44:21 +0900
Received: from CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) by
 CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) with mapi id 15.01.2507.035; Thu,
 18 Apr 2024 14:44:21 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/11] md: add atomic mode switching in RAID 1/10
Thread-Topic: [PATCH v2 08/11] md: add atomic mode switching in RAID 1/10
Thread-Index: AdqLx+XD0n9rpAUxRba5DThcEUS6pA==
Date: Thu, 18 Apr 2024 05:44:20 +0000
Message-ID: <47c035c3e741418b80eb6b73d96e7e92@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-as-result: No-10--6.422500-8.000000
x-tmase-matchedrid: qiJ73D9abaWmagT1k9kBppTQgFTHgkhZKQNhMboqZlrGZbX3v50WrzPn
	4yDW5yf3V6Ny+iZr9he3d+TOD1+jLJGZilTi8ctSTuctSpiuWyUUi4Ehat05499RlPzeVuQQse2
	N9uwuoMxvu+EAUOCx0zIsEmLPbWXN3KL5FsheQW+BQTHl0mqX8bqGBW9J0YqjzAdJD7JeNMNr9d
	0gL19NYGia98iXBgonCp+UfJBxGTuLb+PIurKEXancG1vVsfbQDC6fYjMn4vybKItl61J/yZkw8
	KdMzN86KrauXd3MZDU1/yv/AIRJw8cld6KwOZfpg8+h0lWiZNrgXt3XbMNFbKlj5YlS/zPM
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--6.422500-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-snts-smtp: 2D1032A6F2573EDEA24CC3A4998FBCB0AE888AE2ED3D8D9F946C69D67D587FD42000:8
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

This patch depends on patch 07.

All rdevs running in RAID 1/10 switch nr_pending to atomic mode.
The value of nr_pending is read in a normal operation (choose_best_rdev()).
Therefore, nr_pending must always be consistent.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/md.h     | 14 ++++++++++++++
 drivers/md/raid1.c  |  7 +++++++
 drivers/md/raid10.c |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index ab09e312c9bb..57b09b567ffa 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -236,6 +236,20 @@ static inline unsigned long nr_pending_read(struct md_=
rdev *rdev)
 	return atomic_long_read(&rdev->nr_pending.data->count);
 }
=20
+static inline bool nr_pending_is_percpu_mode(struct md_rdev *rdev)
+{
+	unsigned long __percpu *percpu_count;
+
+	return __ref_is_percpu(&rdev->nr_pending, &percpu_count);
+}
+
+static inline bool nr_pending_is_atomic_mode(struct md_rdev *rdev)
+{
+	unsigned long __percpu *percpu_count;
+
+	return !__ref_is_percpu(&rdev->nr_pending, &percpu_count);
+}
+
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sector=
s,
 			      sector_t *first_bad, int *bad_sectors)
 {
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 12318fb15a88..c38ae13aadab 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -784,6 +784,7 @@ static int choose_best_rdev(struct r1conf *conf, struct=
 r1bio *r1_bio)
 		if (ctl.readable_disks++ =3D=3D 1)
 			set_bit(R1BIO_FailFast, &r1_bio->state);
=20
+		WARN_ON_ONCE(nr_pending_is_percpu_mode(rdev));
 		pending =3D nr_pending_read(rdev);
 		dist =3D abs(r1_bio->sector - conf->mirrors[disk].head_position);
=20
@@ -1930,6 +1931,7 @@ static int raid1_add_disk(struct mddev *mddev, struct=
 md_rdev *rdev)
 			if (err)
 				return err;
=20
+			percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
 			raid1_add_conf(conf, rdev, mirror, false);
 			/* As all devices are equivalent, we don't need a full recovery
 			 * if this was recently any drive of the array
@@ -1949,6 +1951,7 @@ static int raid1_add_disk(struct mddev *mddev, struct=
 md_rdev *rdev)
 		set_bit(Replacement, &rdev->flags);
 		raid1_add_conf(conf, rdev, repl_slot, true);
 		err =3D 0;
+		percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
 		conf->fullsync =3D 1;
 	}
=20
@@ -3208,6 +3211,7 @@ static void raid1_free(struct mddev *mddev, void *pri=
v);
 static int raid1_run(struct mddev *mddev)
 {
 	struct r1conf *conf;
+	struct md_rdev *rdev;
 	int i;
 	int ret;
=20
@@ -3269,6 +3273,9 @@ static int raid1_run(struct mddev *mddev)
 	/*
 	 * Ok, everything is just fine now
 	 */
+	rdev_for_each(rdev, mddev) {
+		percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
+	}
 	rcu_assign_pointer(mddev->thread, conf->thread);
 	rcu_assign_pointer(conf->thread, NULL);
 	mddev->private =3D conf;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index b91dd6c0be5a..66896a1076e1 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -808,6 +808,7 @@ static struct md_rdev *read_balance(struct r10conf *con=
f,
=20
 		nonrot =3D bdev_nonrot(rdev->bdev);
 		has_nonrot_disk |=3D nonrot;
+		WARN_ON_ONCE(nr_pending_is_percpu_mode(rdev));
 		pending =3D nr_pending_read(rdev);
 		if (min_pending > pending && nonrot) {
 			min_pending =3D pending;
@@ -2113,6 +2114,7 @@ static int raid10_add_disk(struct mddev *mddev, struc=
t md_rdev *rdev)
 		p->recovery_disabled =3D mddev->recovery_disabled - 1;
 		rdev->raid_disk =3D mirror;
 		err =3D 0;
+		percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
 		if (rdev->saved_raid_disk !=3D mirror)
 			conf->fullsync =3D 1;
 		WRITE_ONCE(p->rdev, rdev);
@@ -2127,6 +2129,7 @@ static int raid10_add_disk(struct mddev *mddev, struc=
t md_rdev *rdev)
 		err =3D mddev_stack_new_rdev(mddev, rdev);
 		if (err)
 			return err;
+		percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
 		conf->fullsync =3D 1;
 		WRITE_ONCE(p->replacement, rdev);
 	}
@@ -4028,6 +4031,7 @@ static int raid10_run(struct mddev *mddev)
 	rdev_for_each(rdev, mddev) {
 		long long diff;
=20
+		percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
 		disk_idx =3D rdev->raid_disk;
 		if (disk_idx < 0)
 			continue;
--=20
2.34.1



