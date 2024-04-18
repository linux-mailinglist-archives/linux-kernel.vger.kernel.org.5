Return-Path: <linux-kernel+bounces-149570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DE18A92F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58424B22E13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807216EB7B;
	Thu, 18 Apr 2024 06:19:09 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1121.securemx.jp [210.130.202.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B255B208;
	Thu, 18 Apr 2024 06:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421149; cv=none; b=DswCBlb3LzUtu1f6H7FwfuVJpob1oDHyQ+nXS5Xrb9PsTySJD5MrsxnMv12vwwsswHJHb45Ut2wVWoV2FzeYiHCuuikqvyUH9DNr7ogdbGBTabVnJ1D39n8DbkwceT73TZ7j2JIv2xR2BAooYBwQRqWp97KORAB7NzG4qdlpMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421149; c=relaxed/simple;
	bh=iqhSMZOztFGqdMfh57SBwjiZxFAblcAJChR5FSzrOvA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gZJPd4sR8Y1fP+iuyhAvY5V6RY5pZwRzA6bLpIInfcfuwdqFztSRf3yi8veqZE/kKd2D7azByYGEAQQKkTkWqzhn9wEcJI+sKU3FLs4rplDHGUNOaxR19SznQjWi/7Jx5d2gemX5Vz+ufKCNZ4TusJAtPcY7GnMw8cXNEh6Qec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1121) id 43I5iTq72031331; Thu, 18 Apr 2024 14:44:29 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 43I5hxVQ2464871; Thu, 18 Apr 2024 14:44:00 +0900
X-Iguazu-Qid: 2rWhYYPQE6csxVxb9A
X-Iguazu-QSIG: v=2; s=0; t=1713419039; q=2rWhYYPQE6csxVxb9A; m=ugGMhLoVwFKiNOp51ehxd5ki18LT8ISPHPFwj4Fq0Gg=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1122) id 43I5hwFk2851571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Apr 2024 14:43:59 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 850ED2FE0F;
	Thu, 18 Apr 2024 14:43:58 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id CD9E81900001EB;
	Thu, 18 Apr 2024 14:31:15 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR04.kioxia.com with ESMTP id 0003QAAAAAA021GJ;
	 Thu, 18 Apr 2024 14:31:15 +0900
Received: from CNN1EXMB04.r1.kioxia.com (CNN1EXMB04.r1.kioxia.com [10.232.20.153])
	by Switcher-Pre_Send (Postfix) with ESMTP id C25BCA0640E18;
	Thu, 18 Apr 2024 14:31:15 +0900 (JST)
Received: from CNN1EXMB04.r1.kioxia.com (10.232.20.153) by
 CNN1EXMB04.r1.kioxia.com (10.232.20.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:43:57 +0900
Received: from CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) by
 CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) with mapi id 15.01.2507.035; Thu,
 18 Apr 2024 14:43:57 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/11] md: add infra for active_aligned_reads changes
Thread-Topic: [PATCH v2 01/11] md: add infra for active_aligned_reads changes
Thread-Index: AdqLx9n45Jz8xtHMQ62+pkfRbuv/qg==
Date: Thu, 18 Apr 2024 05:43:57 +0000
Message-ID: <abc0af65cc3146aba127ce4c355a12d9@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-as-result: No-10--1.684500-8.000000
x-tmase-matchedrid: qiJ73D9abaWmagT1k9kBppTQgFTHgkhZKQNhMboqZlrHhoBEyuHcbYUl
	JlxlTIT+ewNtMWg+aOa12HagvbwDji/7QU2czuUNA9lly13c/gE2SSdNEgI3sEz5vzLEGq8DTTC
	YELjM+CVvF9oQ/B54yFo4rfBbwEOR23JrSYCBAceJI2OHymiAOytc78OfBHnLGTX5zLczNzU5d9
	n04fLNZlepMMW3nEo1fpJkaQdvaIEGzl9AHE05zZ4CIKY/Hg3AcmfM3DjaQLHEQdG7H66TyKsQd
	9qPXhnJ/4rWvpj9UcjHPy5LhFKP1Mrhybo4rxmZmm5wpQj0cWzQvUxRY7ho0BZyUZ/veE38bbqZ
	gQU59nN2zGeYx7YxxEtpJMKtiIn0UFhuhyAg+DoVrg5c4Vk8DXApsmbw8EMtreWoUbwyBi2trdV
	Vx3oRXuqhTICYOFJ/
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--1.684500-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-snts-smtp: AB58909CB39702EAD9C4D99C2765CE33FA42D16BAC07815109FBD20A7CE368952000:8
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

Prepare to smoothly change the type of active_aligned_reads from atomic_t t=
o percpu_ref.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/raid5.c | 12 ++++++------
 drivers/md/raid5.h | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 2bd1ce9b3922..3b04d8b526b1 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5435,7 +5435,7 @@ static void raid5_align_endio(struct bio *bi)
=20
 	if (!error) {
 		bio_endio(raid_bi);
-		if (atomic_dec_and_test(&conf->active_aligned_reads))
+		if (active_aligned_reads_dec_and_test(conf))
 			wake_up(&conf->wait_for_quiescent);
 		return;
 	}
@@ -5499,7 +5499,7 @@ static int raid5_read_one_chunk(struct mddev *mddev, =
struct bio *raid_bio)
=20
 	did_inc =3D false;
 	if (conf->quiesce =3D=3D 0) {
-		atomic_inc(&conf->active_aligned_reads);
+		active_aligned_reads_inc(conf);
 		did_inc =3D true;
 	}
 	/* need a memory barrier to detect the race with raid5_quiesce() */
@@ -5507,12 +5507,12 @@ static int raid5_read_one_chunk(struct mddev *mddev=
, struct bio *raid_bio)
 		/* quiesce is in progress, so we need to undo io activation and wait
 		 * for it to finish
 		 */
-		if (did_inc && atomic_dec_and_test(&conf->active_aligned_reads))
+		if (did_inc && active_aligned_reads_dec_and_test(conf))
 			wake_up(&conf->wait_for_quiescent);
 		spin_lock_irq(&conf->device_lock);
 		wait_event_lock_irq(conf->wait_for_quiescent, conf->quiesce =3D=3D 0,
 				    conf->device_lock);
-		atomic_inc(&conf->active_aligned_reads);
+		active_aligned_reads_inc(conf);
 		spin_unlock_irq(&conf->device_lock);
 	}
=20
@@ -6608,7 +6608,7 @@ static int  retry_aligned_read(struct r5conf *conf, s=
truct bio *raid_bio,
=20
 	bio_endio(raid_bio);
=20
-	if (atomic_dec_and_test(&conf->active_aligned_reads))
+	if (active_aligned_reads_dec_and_test(conf))
 		wake_up(&conf->wait_for_quiescent);
 	return handled;
 }
@@ -8586,7 +8586,7 @@ static void raid5_quiesce(struct mddev *mddev, int qu=
iesce)
 		smp_store_release(&conf->quiesce, 2);
 		wait_event_cmd(conf->wait_for_quiescent,
 				    atomic_read(&conf->active_stripes) =3D=3D 0 &&
-				    atomic_read(&conf->active_aligned_reads) =3D=3D 0,
+				    active_aligned_reads_is_zero(conf),
 				    unlock_all_device_hash_locks_irq(conf),
 				    lock_all_device_hash_locks_irq(conf));
 		conf->quiesce =3D 1;
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 9b5a7dc3f2a0..5bd6bb3540c5 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -696,6 +696,26 @@ struct r5conf {
 	struct r5pending_data	*next_pending_data;
 };
=20
+static inline void active_aligned_reads_inc(struct r5conf *conf)
+{
+	atomic_inc(&conf->active_aligned_reads);
+}
+
+static inline void active_aligned_reads_dec(struct r5conf *conf)
+{
+	atomic_dec(&conf->active_aligned_reads);
+}
+
+static inline bool active_aligned_reads_is_zero(struct r5conf *conf)
+{
+	return atomic_read(&conf->active_aligned_reads) =3D=3D 0;
+}
+
+static inline bool active_aligned_reads_dec_and_test(struct r5conf *conf)
+{
+	return atomic_dec_and_test(&conf->active_aligned_reads);
+}
+
 #if PAGE_SIZE =3D=3D DEFAULT_STRIPE_SIZE
 #define RAID5_STRIPE_SIZE(conf)	STRIPE_SIZE
 #define RAID5_STRIPE_SHIFT(conf)	STRIPE_SHIFT
--=20
2.34.1



