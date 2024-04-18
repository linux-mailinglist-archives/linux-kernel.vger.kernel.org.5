Return-Path: <linux-kernel+bounces-149597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFA58A9347
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1ABF1C20B57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15032C6BB;
	Thu, 18 Apr 2024 06:41:50 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219372CCC2;
	Thu, 18 Apr 2024 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422510; cv=none; b=Jv4hXZu1XEIPE/NbkkafOEPS6xioRJPcBr+700ZnkHI65oXECXNcQTFvkl3gU2oo5cU2vjC/lL5ADmNGxPRUvT/W8cUlCoZwD3L9imQBv/OcJKEydqI5Flt6ruIUO7xiO31Rt7+MrH05y3vIu9SM/pO6LzGJmxsoF18mrCSopbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422510; c=relaxed/simple;
	bh=SzE8IQJ48xc7908eyTNtDsHkCKQFHLy2DgGThS09xpo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fq9007cjwY1lIJtBLd2goHMwCKvINKac89hI1vZQ1j5aua7IOBnanpq8+NYE76TKx0xUzj9NC6T9XDTEDfA6EL51hDtyTyGDUsKophOlo86ljPtFK0dU0Qb9R+yXCkLH1WrYY/7kwRyGeL0k5iGK9dP6byzrGOuLI4Do/8Bevcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 43I5iYZe2019031; Thu, 18 Apr 2024 14:44:34 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 43I5iE7j2465865; Thu, 18 Apr 2024 14:44:14 +0900
X-Iguazu-Qid: 2rWhYYPQE6cu19H1s9
X-Iguazu-QSIG: v=2; s=0; t=1713419053; q=2rWhYYPQE6cu19H1s9; m=afDSdK3UvNipDoLKBSLLnma5OONPJ5FrYHGDMbHQdyY=
Received: from CNN1EMTA01.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1121) id 43I5iCX22637104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Apr 2024 14:44:13 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA01.test.kioxia.com (Postfix) with ESMTP id D4E4B48A81;
	Thu, 18 Apr 2024 14:44:12 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 2778B1900001EB;
	Thu, 18 Apr 2024 14:31:30 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR04.kioxia.com with ESMTP id 0003QAAAAAA02211;
	 Thu, 18 Apr 2024 14:31:30 +0900
Received: from CNN1EXMB02.r1.kioxia.com (CNN1EXMB02.r1.kioxia.com [10.232.20.151])
	by Switcher-Pre_Send (Postfix) with ESMTP id 1BFCBA0640E18;
	Thu, 18 Apr 2024 14:31:30 +0900 (JST)
Received: from CNN1EXMB04.r1.kioxia.com (10.232.20.153) by
 CNN1EXMB02.r1.kioxia.com (10.232.20.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:44:12 +0900
Received: from CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) by
 CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) with mapi id 15.01.2507.035; Thu,
 18 Apr 2024 14:44:12 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/11] md: match the type of variables to percpu_ref
Thread-Topic: [PATCH v2 05/11] md: match the type of variables to percpu_ref
Thread-Index: AdqLx+FXdNJkPwyDSq2lcgBOkP0WcQ==
Date: Thu, 18 Apr 2024 05:44:11 +0000
Message-ID: <1c04e1a6d79c494faad6bdc21d86d76e@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-as-result: No-10--5.106300-8.000000
x-tmase-matchedrid: g7XVaO+YFMumagT1k9kBpgrcxrzwsv5uXPK9y3z82GsPdZmyx8xAa+K5
	fhRxt1aADpxsntCj+iajrLRBxwnZS7VQ6XPWwtdyEXjPIvKd74BMkOX0UoduuRFBDiQWqOMkJwY
	Oi+iMxY3U5iXDpe6YeP6mFiC4o7QUdJMdJS+tDywZgmFGHqyx630tCKdnhB581kTfEkyaZdz6C0
	ePs7A07QsfaqMZktsd9K4u2mW1AZ3iZawwAP+WlZ2c5QMBYjIDRSkcJMJhH2I=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--5.106300-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-snts-smtp: 206CAC30B0DCD9F165B7D62BF7D51A0DF8E8655C7C4CA21B759AF0D5981D8EF02000:8
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
index 2eaf8606af9e..783fec1f1445 100644
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
index 962cebbba6cd..12318fb15a88 100644
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
index 2b1238befd8a..b91dd6c0be5a 100644
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



