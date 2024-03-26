Return-Path: <linux-kernel+bounces-118860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE86F88C063
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2352C3203
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC74C618;
	Tue, 26 Mar 2024 11:16:51 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1120.securemx.jp [210.130.202.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A467134A8;
	Tue, 26 Mar 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451811; cv=none; b=TCDgxGj3KD0UA6mjYn/eAcMVaoq7vjdRZyNlad+PoUjxdKtK05bl8eunLlLq8WB2J7yRtqUgNuIOrxeero6flgyyPT7X0ms+lrHonmM2AisOSKuM9O17SMFVoJZh+twdnZKZOpwyzc9mn5OLjifR+e/yNhHyQGCrl5U8pmexh4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451811; c=relaxed/simple;
	bh=xSEzLoXG7ilM1etL8aaSD1TDnPKgw15ps6p0vsfPTXo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bQc5j7FOAycvyI/ea16OtSaWE84mU2mFfMcLXwYZKhNMD5HntyRw5IAMOOJfj5dWZO2P8x+JH6rOLS1nhYXIwhG5zr+LC2FCQ6ymadJs+OZqi0O5EAg9yApRLEmIdYpDFcy1MPFu54iwZHTBkb95wHHtgeiKfr0ikh2k9Glmcqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1120) id 42QATssb671701; Tue, 26 Mar 2024 19:29:54 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 42QATdJk2611184; Tue, 26 Mar 2024 19:29:39 +0900
X-Iguazu-Qid: 2rWg9o4uinxHarSWO2
X-Iguazu-QSIG: v=2; s=0; t=1711448978; q=2rWg9o4uinxHarSWO2; m=VTooRhJM/Sss0dbxVP1M9CwhVAaK2S3XeIYq6RBLwrU=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1122) id 42QATcWM2454001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Mar 2024 19:29:38 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 3A26C32440;
	Tue, 26 Mar 2024 19:29:38 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id AB3561938D7224;
	Tue, 26 Mar 2024 19:08:11 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002VAAAAAA012FG;
	 Tue, 26 Mar 2024 19:08:11 +0900
Received: from CNN1EXMB01.r1.kioxia.com (CNN1EXMB01.r1.kioxia.com [10.232.20.150])
	by Switcher-Pre_Send (Postfix) with ESMTP id A0015A035DC28;
	Tue, 26 Mar 2024 19:08:11 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB01.r1.kioxia.com (10.232.20.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 19:29:37 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Tue,
 26 Mar 2024 19:29:37 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/11] md: avoid conflicts in active_aligned_reads operations
Thread-Topic: [PATCH 06/11] md: avoid conflicts in active_aligned_reads
 operations
Thread-Index: Adp/ZElvNupNLKs/Rxilvj3/IfhIIg==
Date: Tue, 26 Mar 2024 10:29:37 +0000
Message-ID: <ffb112e756514a0eaab891379df0d834@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-as-result: No-10--10.964700-8.000000
x-tmase-matchedrid: +gTBWF+Z0ROmagT1k9kBpgrcxrzwsv5uXPK9y3z82GsPdZmyx8xAa4Ul
	JlxlTIT+SMhOCdNodgNTbKunqk1vfbVQ6XPWwtdyEXjPIvKd74BMkOX0UoduufLIj08N6FsEuJE
	UmdYPGSVzy5czsqHK1z4BLF18v1Ji23JrSYCBAcfN+qWlu2ZxaFr2hZxjCLzqMoh6scCF9jF96t
	9wDfdERVvLgfDdKWEFEn91NheE+HWip6xhGipIWazGfgakLdja0NaTZUEzRZzC9DxHKrnk8luWw
	Soz2HVyH7iboQD+7I4VaGy/EyU2eafccBtB84hSnXdphQTSK/K/yN2q8U674odzPqBXhP/S4Mmu
	En4nwqo1W+3DxdRobxDflJk00ivp0FQxfjRHOzi4u3nS+3EEDuDDEwfnBUy6lwV2iaAfSWeDGx/
	OQ1GV8t0H8LFZNFG7gaH1JgrOSO4aMUyeC0staN0RHUNUuP2opWu923L0/V6a+gqq4Q/lRG0nH4
	VYvyBw3HbxZLSwb85agnrZz8DBG+ulxyHOcPoH
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--10.964700-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-snts-smtp: BD34B6522F5962555E5B84274C8D74DA3A9F433931466499FF82D0D1F3A5AB512000:8
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

This patch depends on patch 03.

Change the type of active_aligned_reads from atomic_t to percpu_ref in perc=
pu mode.

Signed-off-by: Keisuke TADA <keisuke1.tada@kioxia.com>
Signed-off-by: Toshifumi OHTAKE <toshifumi.ootake@kioxia.com>
---
 drivers/md/raid5.c | 26 ++++++++++++++++++--------
 drivers/md/raid5.h | 13 ++++---------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index c7186ebcd299..99f42bc02231 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5436,8 +5436,7 @@ static void raid5_align_endio(struct bio *bi)
=20
 	if (!error) {
 		bio_endio(raid_bi);
-		if (active_aligned_reads_dec_and_test(conf))
-			wake_up(&conf->wait_for_quiescent);
+		active_aligned_reads_dec(conf);
 		return;
 	}
=20
@@ -5508,8 +5507,8 @@ static int raid5_read_one_chunk(struct mddev *mddev, =
struct bio *raid_bio)
 		/* quiesce is in progress, so we need to undo io activation and wait
 		 * for it to finish
 		 */
-		if (did_inc && active_aligned_reads_dec_and_test(conf))
-			wake_up(&conf->wait_for_quiescent);
+		if (did_inc)
+			active_aligned_reads_dec(conf);
 		spin_lock_irq(&conf->device_lock);
 		wait_event_lock_irq(conf->wait_for_quiescent, conf->quiesce =3D=3D 0,
 				    conf->device_lock);
@@ -6609,8 +6608,7 @@ static int  retry_aligned_read(struct r5conf *conf, s=
truct bio *raid_bio,
=20
 	bio_endio(raid_bio);
=20
-	if (active_aligned_reads_dec_and_test(conf))
-		wake_up(&conf->wait_for_quiescent);
+	active_aligned_reads_dec(conf);
 	return handled;
 }
=20
@@ -7324,6 +7322,7 @@ static void free_conf(struct r5conf *conf)
 {
 	int i;
=20
+	percpu_ref_exit(&conf->active_aligned_reads);
 	log_exit(conf);
=20
 	shrinker_free(conf->shrinker);
@@ -7405,6 +7404,12 @@ static unsigned long raid5_cache_count(struct shrink=
er *shrink,
 	return max_stripes - min_stripes;
 }
=20
+static void percpu_wakeup_handle_req_active(struct percpu_ref *r)
+{
+	struct r5conf *conf =3D container_of(r, struct r5conf, active_aligned_rea=
ds);
+
+	wake_up(&conf->wait_for_quiescent);
+}
=20
 static struct r5conf *setup_conf(struct mddev *mddev, bool quiesce)
 {
@@ -7492,7 +7497,10 @@ static struct r5conf *setup_conf(struct mddev *mddev=
, bool quiesce)
 		percpu_ref_init_flags =3D PERCPU_REF_ALLOW_REINIT | PERCPU_REF_INIT_DEAD=
;
 	else
 		percpu_ref_init_flags =3D PERCPU_REF_ALLOW_REINIT;
-	atomic_set(&conf->active_aligned_reads, 0);
+	ret =3D percpu_ref_init(&conf->active_aligned_reads, percpu_wakeup_handle=
_req_active,
+		percpu_ref_init_flags, GFP_KERNEL);
+	if (ret)
+		goto abort;
 	spin_lock_init(&conf->pending_bios_lock);
 	conf->batch_bio_dispatch =3D true;
 	rdev_for_each(rdev, mddev) {
@@ -7684,7 +7692,7 @@ static struct r5conf *setup_conf_for_takeover(struct =
mddev *mddev)
=20
 	if (mddev->level =3D=3D 4 || mddev->level =3D=3D 5 || mddev->level =3D=3D=
 6) {
 		conf =3D mddev->private;
-		quiesce =3D false;
+		quiesce =3D percpu_ref_is_dying(&conf->active_aligned_reads);
 	}
 	return setup_conf(mddev, quiesce);
 }
@@ -8641,6 +8649,7 @@ static void raid5_quiesce(struct mddev *mddev, int qu=
iesce)
 		 * quiesce started and reverts to slow (locked) path.
 		 */
 		smp_store_release(&conf->quiesce, 2);
+		percpu_ref_kill(&conf->active_aligned_reads);
 		wait_event_cmd(conf->wait_for_quiescent,
 				    atomic_read(&conf->active_stripes) =3D=3D 0 &&
 				    active_aligned_reads_is_zero(conf),
@@ -8653,6 +8662,7 @@ static void raid5_quiesce(struct mddev *mddev, int qu=
iesce)
 	} else {
 		/* re-enable writes */
 		lock_all_device_hash_locks_irq(conf);
+		percpu_ref_reinit(&conf->active_aligned_reads);
 		conf->quiesce =3D 0;
 		wake_up(&conf->wait_for_quiescent);
 		wake_up(&conf->wait_for_overlap);
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 5bd6bb3540c5..c4ab418e2084 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -621,7 +621,7 @@ struct r5conf {
 	unsigned int		retry_read_offset; /* sector offset into retry_read_aligned=
 */
 	struct bio		*retry_read_aligned_list; /* aligned bios retry list  */
 	atomic_t		preread_active_stripes; /* stripes with scheduled io */
-	atomic_t		active_aligned_reads;
+	struct percpu_ref	active_aligned_reads;
 	atomic_t		pending_full_writes; /* full write backlog */
 	int			bypass_count; /* bypassed prereads */
 	int			bypass_threshold; /* preread nice */
@@ -698,22 +698,17 @@ struct r5conf {
=20
 static inline void active_aligned_reads_inc(struct r5conf *conf)
 {
-	atomic_inc(&conf->active_aligned_reads);
+	percpu_ref_get(&conf->active_aligned_reads);
 }
=20
 static inline void active_aligned_reads_dec(struct r5conf *conf)
 {
-	atomic_dec(&conf->active_aligned_reads);
+	percpu_ref_put(&conf->active_aligned_reads);
 }
=20
 static inline bool active_aligned_reads_is_zero(struct r5conf *conf)
 {
-	return atomic_read(&conf->active_aligned_reads) =3D=3D 0;
-}
-
-static inline bool active_aligned_reads_dec_and_test(struct r5conf *conf)
-{
-	return atomic_dec_and_test(&conf->active_aligned_reads);
+	return percpu_ref_is_zero(&conf->active_aligned_reads);
 }
=20
 #if PAGE_SIZE =3D=3D DEFAULT_STRIPE_SIZE
--=20
2.34.1


