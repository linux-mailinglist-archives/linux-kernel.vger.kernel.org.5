Return-Path: <linux-kernel+bounces-118953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6705B88C1D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999A31C38DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7886F75806;
	Tue, 26 Mar 2024 12:15:20 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350511804F;
	Tue, 26 Mar 2024 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455319; cv=none; b=oxF6tWHuoR16cSGlg2JMt6KNxF3C3mnyMBf8lKGZ+4VlFugx8K65NG6PLV44lBjaJD8AfuV6yzpXvBEY7Dmmi18b6M+NLKHlsry2YmQcdFabVt4+Xob1/yN07mW3NdKDn4YN0WYxcYFCOijhv9Z+ghhMHckYrAYGCRAe2zBQjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455319; c=relaxed/simple;
	bh=7GKEcD8lRU98zTCcjYmD6skL4kJppLGyorf7w2xZPcQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AeL5/MOBnoAsp1YCNnRHIOCrevWpvSxfsOJBdBNvVN0XYVWIx8kQ/urrMd7K24XuaQj/kE5ho+WHSYO5E1QijZ5+bule3mhA/Bvm7xVQ3PzLVB4G9XQSOEndeQeltBim1+RAfpJyF52SWKlT2XJ0Fw5NeKuE1CtjKm4nSqfhiRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 42QATmXK671698; Tue, 26 Mar 2024 19:29:48 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 42QATXKa2209272; Tue, 26 Mar 2024 19:29:33 +0900
X-Iguazu-Qid: 2rWgQ8FBVvU2Je3XjI
X-Iguazu-QSIG: v=2; s=0; t=1711448972; q=2rWgQ8FBVvU2Je3XjI; m=CbOMDN9j+hbog7p/aMHarUVt7cTJKkxEtg07Zdph4ek=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1123) id 42QATWjE2317794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Mar 2024 19:29:32 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 0C4A232440;
	Tue, 26 Mar 2024 19:29:32 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 86A391938D7203;
	Tue, 26 Mar 2024 19:08:05 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002VAAAAAA012AM;
	 Tue, 26 Mar 2024 19:08:05 +0900
Received: from CNN1EXMB02.r1.kioxia.com (CNN1EXMB02.r1.kioxia.com [10.232.20.151])
	by Switcher-Pre_Send (Postfix) with ESMTP id 7B8ABA035DC28;
	Tue, 26 Mar 2024 19:08:05 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB02.r1.kioxia.com (10.232.20.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 19:29:31 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Tue,
 26 Mar 2024 19:29:31 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/11] md: minimize execution of zero check for nr_pending
Thread-Topic: [PATCH 04/11] md: minimize execution of zero check for
 nr_pending
Thread-Index: Adp/ZCwIEaSNdvzYSU+n+frmE556SA==
Date: Tue, 26 Mar 2024 10:29:31 +0000
Message-ID: <5319159bd74f4c4c9979c748b216b2f8@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-as-result: No-10--5.659600-8.000000
x-tmase-matchedrid: 5V0fm+sVFB2magT1k9kBpgrcxrzwsv5uXPK9y3z82GtXGTbsQqHbkmzE
	TQ7/otyjd+FThkXYawcVNmOCBj98YKZY4PxfRMWETuctSpiuWyUUi4Ehat05499RlPzeVuQQB4x
	q6g7kDalvF9oQ/B54yGPKQgbIX4yuFdV6KRtQicSkkQPcJHKMT+ovpkXHOUFXv1l2Uvx6idpqHX
	ONfTwSQsRB0bsfrpPIFT1PBs+MVY3ocuK7+JBlJC5g7R642iP7Sqy+Sk/9UVNHtFfvh1y31yo9L
	wbibKKfG/fqr4pTSlM=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--5.659600-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-snts-smtp: 9B2049F3415A909983D745DE68787A79943D7C77A482092E0C8205982E682B572000:8
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

This patch depends on patch 02.

The Faulty flag is required for the if statement to be true.
A rdev in Faulty state does not issue I/O commands.
So, nr_pending is also not increased.
Therefore, decrement and zero check of nr_pending can be separated and stil=
l be consistent.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/md.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index b990be0981bc..ed7e36212d58 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -236,11 +236,6 @@ static inline unsigned int nr_pending_read(struct md_r=
dev *rdev)
 	return atomic_read(&rdev->nr_pending);
 }
=20
-static inline bool nr_pending_dec_and_test(struct md_rdev *rdev)
-{
-	return atomic_dec_and_test(&rdev->nr_pending);
-}
-
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sector=
s,
 			      sector_t *first_bad, int *bad_sectors)
 {
@@ -875,9 +870,12 @@ static inline bool is_rdev_broken(struct md_rdev *rdev=
)
 static inline void rdev_dec_pending(struct md_rdev *rdev, struct mddev *md=
dev)
 {
 	int faulty =3D test_bit(Faulty, &rdev->flags);
-	if (nr_pending_dec_and_test(rdev) && faulty) {
-		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+	nr_pending_dec(rdev);
+	if (faulty) {
+		if (nr_pending_is_zero(rdev)) {
+			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+			md_wakeup_thread(mddev->thread);
+		}
 	}
 }
=20
--=20
2.34.1


