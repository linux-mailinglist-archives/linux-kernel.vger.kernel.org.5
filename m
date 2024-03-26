Return-Path: <linux-kernel+bounces-118886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F91D88C0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736FE1C38183
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D99655E4B;
	Tue, 26 Mar 2024 11:29:50 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5455C99;
	Tue, 26 Mar 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452590; cv=none; b=o5yyO2MlNPdKNJ9eKxRg0Z6dyEj3z+Ly4xf1p9MzZRe1KO11Se/At1O5ihOYmNywxn9xGjQvFYPKsbCYM1PE/ivp5cIBUIMXchvAGE90NwX5tO1dMZRP8TGW5ucwihCr45me5Sx7dkfKiCz2I9U6CbmYj9itHjpIYZvHumLXpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452590; c=relaxed/simple;
	bh=TcCxixfsR8/nanhTm/t47/mH9dljdW3na3A6R3j2mz8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L+838s/97JNLp+kvI0iXPaYcH9svNOXpvXbqwiRBTShdyi4zPvMbW70nk7/1p9oaXzCiN/u8TXwxCqZH8k94UsF3MeS5Wf2JcR24Ku4+PFrX6eTgCrRxDWBfAyBXaklYjGvifDQs/liYe0iKAWGoZf4jBRFdMuk8QM7AyJjbKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 42QATlDx671697; Tue, 26 Mar 2024 19:29:47 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 42QATNdA2208940; Tue, 26 Mar 2024 19:29:23 +0900
X-Iguazu-Qid: 2rWgHjhWsbaT7nes8G
X-Iguazu-QSIG: v=2; s=0; t=1711448962; q=2rWgHjhWsbaT7nes8G; m=guZWhoTu9ab33iQ8ONREOi9dm7r4TbvlNifoLkJPiZ8=
Received: from CNN1EMTA01.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1123) id 42QATLmS2317580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Mar 2024 19:29:22 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA01.test.kioxia.com (Postfix) with ESMTP id DCF9F2F015;
	Tue, 26 Mar 2024 19:29:21 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 59DC61938D7203;
	Tue, 26 Mar 2024 19:07:55 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002VAAAAAA0122M;
	 Tue, 26 Mar 2024 19:07:55 +0900
Received: from CNN1EXMB01.r1.kioxia.com (CNN1EXMB01.r1.kioxia.com [10.232.20.150])
	by Switcher-Pre_Send (Postfix) with ESMTP id 4E7D5A035DC28;
	Tue, 26 Mar 2024 19:07:55 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB01.r1.kioxia.com (10.232.20.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 19:29:21 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Tue,
 26 Mar 2024 19:29:21 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/11] md: add infra for active_aligned_reads changes
Thread-Topic: [PATCH 01/11] md: add infra for active_aligned_reads changes
Thread-Index: Adp/Y7Mh/ylXUWuPROyIG62nOILkrg==
Date: Tue, 26 Mar 2024 10:29:20 +0000
Message-ID: <6682020683594800921ca2567e479c3c@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-as-result: No-10--1.684500-8.000000
x-tmase-matchedrid: biL4YBBTMFamagT1k9kBppTQgFTHgkhZKQNhMboqZlrHhoBEyuHcbYUl
	JlxlTIT+ewNtMWg+aOa12HagvbwDji/7QU2czuUNA9lly13c/gE2SSdNEgI3sEz5vzLEGq8DTTC
	YELjM+CVvF9oQ/B54yFo4rfBbwEOR23JrSYCBAceJI2OHymiAOytc78OfBHnLGTX5zLczNzU5d9
	n04fLNZlepMMW3nEo1fpJkaQdvaIEGzl9AHE05zaSRA9wkcoxP6i+mRcc5QVe/WXZS/HqJ2gtuK
	BGekqUpdvpxIsTHHHaRTpSQiv9X7Yp2iWs90+63zEVb/qxkUfgJB7rruKhZCxODU2P2dcmMcJ2G
	9s1in4jGthxghyWxGxuDt74+KZNqnbcWxYm4IwyqYm5C4G8JX8NZ1S8JnLvUgup8jVhIwn/G61L
	W3xarQYiiduc0eATAz+phZh9BMadJA4+6YYiS7R/BXqwE9HSW
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--1.684500-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-snts-smtp: 6CD62EF26E8749BC01D0D36931D1CB24239EABFA7879A738542FB1070EA382F52000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB01.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB01.r1.kioxia.com

Prepare to smoothly change the type of active_aligned_reads from atomic_t t=
o percpu_ref.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/raid5.c | 12 ++++++------
 drivers/md/raid5.h | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f2e3c3e2d879..fd121629603c 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5436,7 +5436,7 @@ static void raid5_align_endio(struct bio *bi)
=20
 	if (!error) {
 		bio_endio(raid_bi);
-		if (atomic_dec_and_test(&conf->active_aligned_reads))
+		if (active_aligned_reads_dec_and_test(conf))
 			wake_up(&conf->wait_for_quiescent);
 		return;
 	}
@@ -5500,7 +5500,7 @@ static int raid5_read_one_chunk(struct mddev *mddev, =
struct bio *raid_bio)
=20
 	did_inc =3D false;
 	if (conf->quiesce =3D=3D 0) {
-		atomic_inc(&conf->active_aligned_reads);
+		active_aligned_reads_inc(conf);
 		did_inc =3D true;
 	}
 	/* need a memory barrier to detect the race with raid5_quiesce() */
@@ -5508,12 +5508,12 @@ static int raid5_read_one_chunk(struct mddev *mddev=
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
@@ -6609,7 +6609,7 @@ static int  retry_aligned_read(struct r5conf *conf, s=
truct bio *raid_bio,
=20
 	bio_endio(raid_bio);
=20
-	if (atomic_dec_and_test(&conf->active_aligned_reads))
+	if (active_aligned_reads_dec_and_test(conf))
 		wake_up(&conf->wait_for_quiescent);
 	return handled;
 }
@@ -8620,7 +8620,7 @@ static void raid5_quiesce(struct mddev *mddev, int qu=
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


