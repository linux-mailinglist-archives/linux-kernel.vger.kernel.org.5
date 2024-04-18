Return-Path: <linux-kernel+bounces-149623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B68A9396
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F1CB21C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBC238DD9;
	Thu, 18 Apr 2024 06:56:40 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8F2576E;
	Thu, 18 Apr 2024 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423400; cv=none; b=a9Y1e6u/jBA2tjdrMFw+U9gmU4or6UqF+iL43xQaIa4FpAfawdoi6+dNoiSA9F9j0Zryv73sYOsb55UAVxxDEvcf0Im9UuNm/TXFr2o8v2c1PB7r6YaL77gbqnMfMQN7tCnkOT7Z7TdZ1q7EG/6l+ALKXdP6z11UKIvdQbOqsy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423400; c=relaxed/simple;
	bh=a4hrlylITEtimTumffZSXVCQvjxwph/PpFXcseW5wLI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FGRlNnSAJERCB6YTyy7qqWLyBl6jrknRVfjcQXH38A1i1Hwo6ndu5yHMFiWKUEbAhbmTl0EVf1T1kqvSJ/z9XJ1qShUdb66vmB1W5wlJMNlDliPjOighgw6aIsILDeEI6AU3kJgFHAECI/kSLTjoV/bFauLkdcAz3IkQwofvu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 43I5icES2019037; Thu, 18 Apr 2024 14:44:38 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 43I5iAP12152677; Thu, 18 Apr 2024 14:44:10 +0900
X-Iguazu-Qid: 2rWhYYPQE6ctn5HIHq
X-Iguazu-QSIG: v=2; s=0; t=1713419050; q=2rWhYYPQE6ctn5HIHq; m=uRZhONpQHkzEcOPMdo5WXIisYFeMFbsAQygYXrNlQrc=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1121) id 43I5i9Vd2636963
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Apr 2024 14:44:09 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 3968F2FE0F;
	Thu, 18 Apr 2024 14:44:09 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 8C2101900001EB;
	Thu, 18 Apr 2024 14:31:26 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR04.kioxia.com with ESMTP id 0003QAAAAAA021N3;
	 Thu, 18 Apr 2024 14:31:26 +0900
Received: from CNN1EXMB01.r1.kioxia.com (CNN1EXMB01.r1.kioxia.com [10.232.20.150])
	by Switcher-Pre_Send (Postfix) with ESMTP id 80EC0A0640E18;
	Thu, 18 Apr 2024 14:31:26 +0900 (JST)
Received: from CNN1EXMB04.r1.kioxia.com (10.232.20.153) by
 CNN1EXMB01.r1.kioxia.com (10.232.20.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:44:08 +0900
Received: from CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) by
 CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) with mapi id 15.01.2507.035; Thu,
 18 Apr 2024 14:44:08 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/11] md: minimize execution of zero check for nr_pending
Thread-Topic: [PATCH v2 04/11] md: minimize execution of zero check for
 nr_pending
Thread-Index: AdqLx9/4oTxaoxgcTPKqUtGd+w6HlQ==
Date: Thu, 18 Apr 2024 05:44:08 +0000
Message-ID: <68a3ec69e8424ba485a369870c2e9177@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-as-result: No-10--5.659600-8.000000
x-tmase-matchedrid: g7XVaO+YFMumagT1k9kBpgrcxrzwsv5uXPK9y3z82GtXGTbsQqHbkmzE
	TQ7/otyjd+FThkXYawcVNmOCBj98YKZY4PxfRMWETuctSpiuWyUUi4Ehat05499RlPzeVuQQB4x
	q6g7kDalvF9oQ/B54yGPKQgbIX4yuFdV6KRtQicSeAiCmPx4NwJwhktVkBBrQ38LauI2fxt4qtq
	5d3cxkNQ97ozsDEZvUB9eDeIdUSivNgawOLAkwRBzunJpIx5qBmXpTt4Va+To=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--5.659600-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-snts-smtp: 33DCE608A229C05FEE447A2E6D22FFCB7D0B52B69A0FD7D4C11675C897FF9A802000:8
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
index f57a894b924b..2eaf8606af9e 100644
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
@@ -876,9 +871,12 @@ static inline bool is_rdev_broken(struct md_rdev *rdev=
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



