Return-Path: <linux-kernel+bounces-118800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAE788BF87
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B341C389FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88EC7441F;
	Tue, 26 Mar 2024 10:29:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw1120.securemx.jp [210.130.202.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5FE6BFBC;
	Tue, 26 Mar 2024 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448998; cv=none; b=GJDOE0c+stQ5wQDwsy5kUaN2MU9zicprwNwNtyqJmoC8h/LniEILEOJs5LO4Cj243BXsmXW2h3ZAxGZYXVe9Qu6u0OWjDBCgyDzJr21bIk6FTTBjAYfUv7MRWO8F8/G3Hln9tHV2b4YUUIuBxbqqFt/cabe4OR20+l5+No6k/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448998; c=relaxed/simple;
	bh=EUex2mfZ7Bm7MxE6kDtOUOglovPxx3drI3WWB33h0AQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c2U2LjOSPvuZoOnG3amSGRGPfKR+A8eFeWaHoI3MkoitN5fc/Od+f8KhG9aEIHN+6f2UrvUSlC+gs++U4zv8fgOBOUGV4vZtOqvudgijo0PNHN3hreAiaBms60rYbZo3Ia+d0ozWSoYxnDwzvMZmBqMgC4KMiJ5s6StmBaUQWYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 42QATkOn2209605; Tue, 26 Mar 2024 19:29:46 +0900
X-Iguazu-Qid: 2rWgsWh2CpWREdGp19
X-Iguazu-QSIG: v=2; s=0; t=1711448985; q=2rWgsWh2CpWREdGp19; m=uexFo6Dzx4m6jZkL12YDgItO1rwd2NhgrNEo1Lwarlk=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1120) id 42QATiOa2928036
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Mar 2024 19:29:45 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id D5AD532440;
	Tue, 26 Mar 2024 19:29:44 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 9DB131900001E2;
	Tue, 26 Mar 2024 19:17:18 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR04.kioxia.com with ESMTP id 0003VAAAAAA01M8E;
	 Tue, 26 Mar 2024 19:17:18 +0900
Received: from CNN1EXMB02.r1.kioxia.com (CNN1EXMB02.r1.kioxia.com [10.232.20.151])
	by Switcher-Pre_Send (Postfix) with ESMTP id 9277BA29B6838;
	Tue, 26 Mar 2024 19:17:18 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB02.r1.kioxia.com (10.232.20.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 19:29:44 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Tue,
 26 Mar 2024 19:29:44 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/11] md: add atomic mode switching in RAID 1/10
Thread-Topic: [PATCH 08/11] md: add atomic mode switching in RAID 1/10
Thread-Index: Adp/ZICXwOfGlnukSn+3jpdX/zMiPQ==
Date: Tue, 26 Mar 2024 10:29:44 +0000
Message-ID: <9060d1a27d424db099b60f291555cd2c@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-as-result: No-10--6.422500-8.000000
x-tmase-matchedrid: biL4YBBTMFamagT1k9kBppTQgFTHgkhZKQNhMboqZlrGZbX3v50WrzPn
	4yDW5yf3V6Ny+iZr9hf2Rn4xkq0qEkDek9Bnh47Tuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVULPJ
	tWpbJjY391wFzAlGcPpNywEy6SR9HMX9mM1cyCSMjRwcsjqWGAvA5Umnv0zLsuqWf6Nh7tmEphT
	mCSWz6qUjuhwwkGBHrOR5CVdmNzBKLb+PIurKEXancG1vVsfbQM+pky3DTsZ2qagqQPeEJjJ4CI
	KY/Hg3AcmfM3DjaQLHEQdG7H66TyBU9TwbPjFWN6HLiu/iQZSQZOoCi/3UCsIlztRJHyQ1ROA1J
	CisWh+jAWfSqfUCswndMV9iIuCaQ
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--6.422500-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-snts-smtp: 749F8F7BD728F02F15D30D7A42B633AE9604D3D59524E77EA174EED40124F0DA2000:8
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

This patch depends on patch 07.

All rdevs running in RAID 1/10 switch nr_pending to atomic mode.
The value of nr_pending is read in a normal operation (read_balance()).
Therefore, nr_pending must always be consistent.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/md.h     | 14 ++++++++++++++
 drivers/md/raid1.c  |  7 +++++++
 drivers/md/raid10.c |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index c69e3a0bc4ca..ee84c4b5ee87 100644
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
index 43cc36fec7a2..146eda6c4961 100644
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
index cd5094c4df50..eebbf9185deb 100644
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


