Return-Path: <linux-kernel+bounces-118846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266DA88C022
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A940F1F362CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA1F535AB;
	Tue, 26 Mar 2024 11:05:32 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1121.securemx.jp [210.130.202.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE01B59A;
	Tue, 26 Mar 2024 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451131; cv=none; b=EicYdT6okheoVHvOMqRXHUbD+F3L50gzHGVibH3lZKIIn6gsGZbtezYrb68xhLMBBN7zZmlOMZ3OfIFzYdcieQNmHjIaQXIkE8JKNRVfP7CaN2y/krJ48CCg2++WIx+gEwc41ynFFgJ9o2hDRLrK7eDbbXAOIxRccnhrS4A3ChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451131; c=relaxed/simple;
	bh=pWwwp25BjYeP7PCVUAYK9bGOXwcU5GgFSs/6zOVf1kI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HKUxp4qmyOKyUcnUHn8J2qiqw65BQifhinxNZ22z6WIs2PG4adfOSFuYumhwnqPtmHnd2jdKeanbZCBeauzkNbIJ0t7Ik1sYJatE3oDREyK+UwVP9lyg7E93jXBxZiTyMqeDbKVv1RKWV07LfsddsaiQG2jM2wse+kqxoRG5BdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1121) id 42QATtd4846052; Tue, 26 Mar 2024 19:29:55 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 42QAThJH2611311; Tue, 26 Mar 2024 19:29:43 +0900
X-Iguazu-Qid: 2rWgWcEMw7gzoPQ1DM
X-Iguazu-QSIG: v=2; s=0; t=1711448982; q=2rWgWcEMw7gzoPQ1DM; m=PaWt10EU8bzrpSXl5RYsZTwdoaLSopBY8IGYGc3YOyI=
Received: from CNN1EMTA01.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1121) id 42QATf9m2222317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Mar 2024 19:29:42 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA01.test.kioxia.com (Postfix) with ESMTP id D19152F015;
	Tue, 26 Mar 2024 19:29:41 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 996031900001E2;
	Tue, 26 Mar 2024 19:17:15 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR04.kioxia.com with ESMTP id 0003VAAAAAA01M89;
	 Tue, 26 Mar 2024 19:17:15 +0900
Received: from CNN1EXMB01.r1.kioxia.com (CNN1EXMB01.r1.kioxia.com [10.232.20.150])
	by Switcher-Pre_Send (Postfix) with ESMTP id 8DFC6A29B6838;
	Tue, 26 Mar 2024 19:17:15 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB01.r1.kioxia.com (10.232.20.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 19:29:41 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Tue,
 26 Mar 2024 19:29:41 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/11] md: change the type of nr_pending from atomic_t to
 percpu_ref
Thread-Topic: [PATCH 07/11] md: change the type of nr_pending from atomic_t to
 percpu_ref
Thread-Index: Adp/ZHDlM7a9GiVuROS72GmNvZS6yA==
Date: Tue, 26 Mar 2024 10:29:41 +0000
Message-ID: <c6f68d4b97a84562b9564cf3d5b59ff6@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-as-result: No-10--11.170200-8.000000
x-tmase-matchedrid: Sx6Z8sZ1/uymagT1k9kBpgrcxrzwsv5uXPK9y3z82GsPdZmyx8xAa4Ul
	JlxlTIT+uzW0mXOtDblgTs7PNu5YyogrKnsJ1GRgTuctSpiuWyUUi4Ehat05499RlPzeVuQQbo+
	zo8QXL7dce6BqICgMNO++yHYM+maWCEeKzjvXhRNT3j6uyvUYPHO1oaQ51CuNyPRAwD/3abY9/h
	S2mXmf7hyQILeil6Pygimqy60vioomCg+Lak4DCfQxpA7auLwMsnK72MaPSqc4UXcfFIawgC4TI
	zFTm9BjfS0Ip2eEHnzWRN8STJpl3PoLR4+zsDTta4jJ6gfgIy2la73bcvT9XuBggTcklL0jRIHt
	QC2du/mubi7Hj6ORU1qe1Xx4uHiGxYVzI3UCCaY=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--11.170200-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-snts-smtp: ED4621EFA559CECE17F037732FB8301002A8F9A433FA24094DEBA62C9E64F8112000:8
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

This patch depends on patch 05.

Change the type of nr_pending from atomic_t to percpu_ref.
Additionally, temporarily switch from percpu mode to atomic mode.
This is to reduce the amount of changes from patches 8 to 10.
Patches 8 to 10 assume that nr_pending is run in percpu mode.
Finally, switch from atomic mode to percpu mode in patch 11.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/md.c | 13 ++++++++++++-
 drivers/md/md.h | 18 +++++++++---------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index df868b315b45..30fbba38ea58 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -998,6 +998,7 @@ void md_rdev_clear(struct md_rdev *rdev)
 		put_page(rdev->bb_page);
 		rdev->bb_page =3D NULL;
 	}
+	percpu_ref_exit(&rdev->nr_pending);
 	badblocks_exit(&rdev->badblocks);
 }
 EXPORT_SYMBOL_GPL(md_rdev_clear);
@@ -3720,8 +3721,14 @@ static const struct kobj_type rdev_ktype =3D {
 	.default_groups	=3D rdev_default_groups,
 };
=20
+static void percpu_wakeup_handle_req_pending(struct percpu_ref *ref)
+{
+}
+
 int md_rdev_init(struct md_rdev *rdev)
 {
+	int ret;
+
 	rdev->desc_nr =3D -1;
 	rdev->saved_raid_disk =3D -1;
 	rdev->raid_disk =3D -1;
@@ -3732,7 +3739,11 @@ int md_rdev_init(struct md_rdev *rdev)
 	rdev->last_read_error =3D 0;
 	rdev->sb_loaded =3D 0;
 	rdev->bb_page =3D NULL;
-	atomic_set(&rdev->nr_pending, 0);
+	ret =3D percpu_ref_init(&rdev->nr_pending, percpu_wakeup_handle_req_pendi=
ng,
+		PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
+	WARN_ON(ret);
+	percpu_ref_switch_to_atomic_sync(&rdev->nr_pending);
+	nr_pending_dec(rdev);
 	atomic_set(&rdev->read_errors, 0);
 	atomic_set(&rdev->corrected_errors, 0);
=20
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 724439400ed1..c69e3a0bc4ca 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -107,10 +107,10 @@ struct md_rdev {
 					 */
 	};
=20
-	atomic_t	nr_pending;	/* number of pending requests.
-					 * only maintained for arrays that
-					 * support hot removal
-					 */
+	struct percpu_ref	nr_pending;	/* number of pending requests.
+						 * only maintained for arrays that
+						 * support hot removal
+						 */
 	atomic_t	read_errors;	/* number of consecutive read errors that
 					 * we have tried to ignore.
 					 */
@@ -213,27 +213,27 @@ enum flag_bits {
=20
 static inline void nr_pending_inc(struct md_rdev *rdev)
 {
-	atomic_inc(&rdev->nr_pending);
+	percpu_ref_get(&rdev->nr_pending);
 }
=20
 static inline void nr_pending_dec(struct md_rdev *rdev)
 {
-	atomic_dec(&rdev->nr_pending);
+	percpu_ref_put(&rdev->nr_pending);
 }
=20
 static inline bool nr_pending_is_zero(struct md_rdev *rdev)
 {
-	return atomic_read(&rdev->nr_pending) =3D=3D 0;
+	return percpu_ref_is_zero(&rdev->nr_pending);
 }
=20
 static inline bool nr_pending_is_not_zero(struct md_rdev *rdev)
 {
-	return atomic_read(&rdev->nr_pending) !=3D 0;
+	return !percpu_ref_is_zero(&rdev->nr_pending);
 }
=20
 static inline unsigned long nr_pending_read(struct md_rdev *rdev)
 {
-	return (unsigned long)atomic_read(&rdev->nr_pending);
+	return atomic_long_read(&rdev->nr_pending.data->count);
 }
=20
 static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sector=
s,
--=20
2.34.1


