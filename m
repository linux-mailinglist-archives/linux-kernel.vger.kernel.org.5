Return-Path: <linux-kernel+bounces-149537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC29F8A9291
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79042838D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418066CDA9;
	Thu, 18 Apr 2024 05:44:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E92657D5;
	Thu, 18 Apr 2024 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419076; cv=none; b=kll6DUF9Akn4nLrmctvmKSVJ/8byPFkcLyTNLeARAMcq0PCranyL5uR9OcbTVj3MCX/gwMUtlijSRStBXlMoPUObYPZQPypVUGCacRTGw5HQk7zVgQuGbfL9BJqYEry+lPlSdfnlBLw/uk+x5Dc+Dlsdnr00atsCck2kD4nT6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419076; c=relaxed/simple;
	bh=Dr1rG6/0S25koiym8xPwRcbH4k0au0GU3wRtTBO6+cg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UkEVdO7Q/hF+RZKYTk1W4q7KblvyTrHfrfV478B0taGOZTNCeTdk6nJveZOwm0T/o1He2MID2t+XTWhaYx48Q5Iw6Btc7wKkVUxs2X4sCa39mppwwRq+Da4V/Sw6GxmoEwdAsxtp/yq2FsjTOxMOFQKcVDoMKEp2fTcwAESMt7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 43I5iSUj2466659; Thu, 18 Apr 2024 14:44:28 +0900
X-Iguazu-Qid: 2rWhlfeQc0hVIkrQMI
X-Iguazu-QSIG: v=2; s=0; t=1713419067; q=2rWhlfeQc0hVIkrQMI; m=aL4XsiZrZfC6mQirdHAqaPmL6EJv+ITI+WP6JsVjBio=
Received: from CNN1EMTA01.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1121) id 43I5iR852637678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Apr 2024 14:44:27 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA01.test.kioxia.com (Postfix) with ESMTP id 0CD0F48A81;
	Thu, 18 Apr 2024 14:44:27 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 55BF71900001EB;
	Thu, 18 Apr 2024 14:31:44 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR04.kioxia.com with ESMTP id 0003QAAAAAA02272;
	 Thu, 18 Apr 2024 14:31:44 +0900
Received: from CNN1EXMB01.r1.kioxia.com (CNN1EXMB01.r1.kioxia.com [10.232.20.150])
	by Switcher-Pre_Send (Postfix) with ESMTP id 4A793A0640E18;
	Thu, 18 Apr 2024 14:31:44 +0900 (JST)
Received: from CNN1EXMB04.r1.kioxia.com (10.232.20.153) by
 CNN1EXMB01.r1.kioxia.com (10.232.20.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:44:26 +0900
Received: from CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) by
 CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) with mapi id 15.01.2507.035; Thu,
 18 Apr 2024 14:44:26 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/11] md: add atomic mode switching when I/O completion
Thread-Topic: [PATCH v2 10/11] md: add atomic mode switching when I/O
 completion
Thread-Index: AdqLx+iHrS2hQg22QTSH7MYR+7sBqw==
Date: Thu, 18 Apr 2024 05:44:26 +0000
Message-ID: <4ee16fa91cd24fb3b5cbe5134e1831f0@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-as-result: No-10--8.850000-8.000000
x-tmase-matchedrid: Sx6Z8sZ1/uymagT1k9kBppTQgFTHgkhZKQNhMboqZlrGZbX3v50WrzPn
	4yDW5yf3GSNOWaKP4s2t2un08Qrrt3EWVXH5btzQTuctSpiuWyUUi4Ehat054zdlsYL2g/87GyQ
	B1oR95AqsIJcbcumfxGPKQgbIX4yuhcAT8+NWWH8jRwcsjqWGAh90OsLQe4vlyIKHzIGoT62k16
	eVRb8rL5dhlAAXYT7M7YL9OFIRb909S7tGIPO8TQ55FEYgJX09SKtHZwIquEv+Aw16GgqpO+m57
	3tusZjQTqumDQCn8tgrsSQ3gQbaojcpdZ3fQiLdgxsfzkNRlfLdB/CxWTRRu25FeHtsUoHuA4fV
	KyofWMJ8xdQJxSQeWCjw6eAClxWBxKzBq1ALEkpLDBwYotNgRw==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--8.850000-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-snts-smtp: E39F34508721F4E44A2FAE932B2C219A9E3CD167EDB334131169ADAC146489792000:8
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

This patch depends on patch 09.

If percpu mode in softirq context, switch to atomic mode in delayed executi=
on.
Move from softirq context to a context where RCUs are available and switch =
to atomic mode.
This patch completes the addition of atomic mode switching.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/md.c | 16 ++++++++++++++++
 drivers/md/md.h |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5f785353353d..18d0f214098b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9606,6 +9606,7 @@ void md_check_recovery(struct mddev *mddev)
 		return;
 	if ( ! (
 		(mddev->sb_flags & ~ (1<<MD_SB_CHANGE_PENDING)) ||
+		test_bit(MD_RECOVERY_PERCPU, &mddev->recovery) ||
 		test_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
 		test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
 		(mddev->external =3D=3D 0 && mddev->safemode =3D=3D 1) ||
@@ -9616,6 +9617,21 @@ void md_check_recovery(struct mddev *mddev)
=20
 	if (mddev_trylock(mddev)) {
 		bool try_set_sync =3D mddev->safemode !=3D 0;
+		struct md_rdev *fault_rdev;
+		bool faulty_some =3D false;
+
+		rdev_for_each(fault_rdev, mddev) {
+			if (fault_rdev->raid_disk >=3D 0 &&
+			    test_bit(Faulty, &fault_rdev->flags) &&
+			    nr_pending_is_percpu_mode(fault_rdev)) {
+				percpu_ref_switch_to_atomic_sync(&fault_rdev->nr_pending);
+				faulty_some =3D true;
+			}
+		}
+		if (faulty_some) {
+			clear_bit(MD_RECOVERY_PERCPU, &mddev->recovery);
+			goto unlock;
+		}
=20
 		if (!mddev->external && mddev->safemode =3D=3D 1)
 			mddev->safemode =3D 0;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 57b09b567ffa..a3c0b5e8cf05 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -605,6 +605,7 @@ enum recovery_flags {
 	MD_RECOVERY_FROZEN,	/* User request to abort, and not restart, any action=
 */
 	MD_RECOVERY_ERROR,	/* sync-action interrupted because io-error */
 	MD_RECOVERY_WAIT,	/* waiting for pers->start() to finish */
+	MD_RECOVERY_PERCPU,	/* nr_pending when faulty needs to be switched to ato=
mic */
 	MD_RESYNCING_REMOTE,	/* remote node is running resync thread */
 };
=20
@@ -887,6 +888,11 @@ static inline void rdev_dec_pending(struct md_rdev *rd=
ev, struct mddev *mddev)
 	int faulty =3D test_bit(Faulty, &rdev->flags);
 	nr_pending_dec(rdev);
 	if (faulty) {
+		if (nr_pending_is_percpu_mode(rdev)) {
+			set_bit(MD_RECOVERY_PERCPU, &mddev->recovery);
+			md_wakeup_thread(mddev->thread);
+			return;
+		}
 		if (nr_pending_is_zero(rdev)) {
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 			md_wakeup_thread(mddev->thread);
--=20
2.34.1



