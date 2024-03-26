Return-Path: <linux-kernel+bounces-118865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B1E88C06F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357541F3CFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872AF55C33;
	Tue, 26 Mar 2024 11:18:51 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D8E548F4;
	Tue, 26 Mar 2024 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451931; cv=none; b=uFG2c121192t+WYZYEQC/nGCLxZ5x/2Z118/8IU4IzIKNxEMdsqgS52DjRGdWKpSegE08Kdfb2HG43H+KEHZmT9SonyJ84Inr8lfYpJQiQi9HTyMHVqn5mkb+nNrbTEHjJGAWwgvW21go9YQmUyO+cEiDXI/YWGm9a6OfxVYwnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451931; c=relaxed/simple;
	bh=KufBODuLQhqwQMLcQD/3FVI3mBLOX9NAtVALwxNOPBk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E9whNq5b1kVUTKPBl1gnhA2Ntofq1wmV4flfVKbYyps0ritmYL0Wn2xxS5xlpUfPz+w5iHyWgUSzyYWXc3tnuVKPfR2AXGZjFoygFCWnYgtmT9Q5qwIgK0ZvGkyw/QIioCiwG7aiU5v95WWBuTi1aIXCG7dTMhacJZbCYLwkq7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 42QAToCX671699; Tue, 26 Mar 2024 19:29:50 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 42QATaOw2611071; Tue, 26 Mar 2024 19:29:36 +0900
X-Iguazu-Qid: 2rWgHjhWsbaU6kJ3f0
X-Iguazu-QSIG: v=2; s=0; t=1711448975; q=2rWgHjhWsbaU6kJ3f0; m=5FYyzYhBQls1LZjbj4dr6Qe9A2WGNlbNbcjLFfjbYJ4=
Received: from CNN1EMTA01.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1122) id 42QATZKB2453832
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Mar 2024 19:29:35 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA01.test.kioxia.com (Postfix) with ESMTP id 33B652F015;
	Tue, 26 Mar 2024 19:29:35 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id A4F681938D7227;
	Tue, 26 Mar 2024 19:08:08 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002VAAAAAA012CM;
	 Tue, 26 Mar 2024 19:08:08 +0900
Received: from CNN1EXMB04.r1.kioxia.com (CNN1EXMB04.r1.kioxia.com [10.232.20.153])
	by Switcher-Pre_Send (Postfix) with ESMTP id 99C84A035DC28;
	Tue, 26 Mar 2024 19:08:08 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB04.r1.kioxia.com (10.232.20.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 19:29:34 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Tue,
 26 Mar 2024 19:29:34 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/11] md: match the type of variables to percpu_ref
Thread-Topic: [PATCH 05/11] md: match the type of variables to percpu_ref
Thread-Index: Adp/ZDpSRCvn7gYcTuKr3Qsn+dny/g==
Date: Tue, 26 Mar 2024 10:29:34 +0000
Message-ID: <d61c1d984cf345f084857e5461dc087d@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-as-result: No-10--5.106300-8.000000
x-tmase-matchedrid: 5V0fm+sVFB2magT1k9kBpgrcxrzwsv5uXPK9y3z82GsPdZmyx8xAa+K5
	fhRxt1aADpxsntCj+iajrLRBxwnZS7VQ6XPWwtdyEXjPIvKd74BMkOX0UoduuRFBDiQWqOMkJwY
	Oi+iMxY3U5iXDpe6YeP6mFiC4o7QUdJMdJS+tDywZgmFGHqyx6+DDEwfnBUy6lwV2iaAfSWeDGx
	/OQ1GV8t0H8LFZNFG7gaH1JgrOSO7lXdnkMuZ1VhpbbFGOduqkezVlI2TOQlzhJbWRfawt93FGC
	DH6TcAeMm05OGx1HAU=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--5.106300-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-snts-smtp: 91D0754E4EDB280E8754A76B207E8AEA70593F419E63FA6610B8F89FB2973A632000:8
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

This patch depends on patch 04.

The counter size of percpu_ref is different from that of atomic_t.
This is the only place where the value of nr_pending is read.
The others are used for zero check and type has no effect.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/md.h     | 4 ++--
 drivers/md/raid1.c  | 4 ++--
 drivers/md/raid10.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index ed7e36212d58..724439400ed1 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -231,9 +231,9 @@ static inline bool nr_pending_is_not_zero(struct md_rde=
v *rdev)
 	return atomic_read(&rdev->nr_pending) !=3D 0;
 }
=20
-static inline unsigned int nr_pending_read(struct md_rdev *rdev)
+static inline unsigned long nr_pending_read(struct md_rdev *rdev)
 {
-	return atomic_read(&rdev->nr_pending);
+	return (unsigned long)atomic_read(&rdev->nr_pending);
 }
=20
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sector=
s,
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 9cf56bc1340f..43cc36fec7a2 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -751,7 +751,7 @@ static bool rdev_readable(struct md_rdev *rdev, struct =
r1bio *r1_bio)
 struct read_balance_ctl {
 	sector_t closest_dist;
 	int closest_dist_disk;
-	int min_pending;
+	long min_pending;
 	int min_pending_disk;
 	int sequential_disk;
 	int readable_disks;
@@ -771,7 +771,7 @@ static int choose_best_rdev(struct r1conf *conf, struct=
 r1bio *r1_bio)
 	for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
 		struct md_rdev *rdev;
 		sector_t dist;
-		unsigned int pending;
+		unsigned long pending;
=20
 		if (r1_bio->bios[disk] =3D=3D IO_BLOCKED)
 			continue;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index d8c4bf608767..cd5094c4df50 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -733,7 +733,7 @@ static struct md_rdev *read_balance(struct r10conf *con=
f,
 	int do_balance;
 	int best_dist_slot, best_pending_slot;
 	bool has_nonrot_disk =3D false;
-	unsigned int min_pending;
+	unsigned long min_pending;
 	struct geom *geo =3D &conf->geo;
=20
 	raid10_find_phys(conf, r10_bio);
@@ -753,7 +753,7 @@ static struct md_rdev *read_balance(struct r10conf *con=
f,
 		sector_t first_bad;
 		int bad_sectors;
 		sector_t dev_sector;
-		unsigned int pending;
+		unsigned long pending;
 		bool nonrot;
=20
 		if (r10_bio->devs[slot].bio =3D=3D IO_BLOCKED)
--=20
2.34.1


