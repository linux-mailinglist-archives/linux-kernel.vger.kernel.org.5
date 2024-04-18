Return-Path: <linux-kernel+bounces-149572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955418A92FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52038281799
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DCF6A8A6;
	Thu, 18 Apr 2024 06:20:59 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1121.securemx.jp [210.130.202.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0658119;
	Thu, 18 Apr 2024 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421259; cv=none; b=HO1WESGTsGpFK40nX09gc20PsRik+YBibH+EKs0nI8rs4HFoeRtLnfQyrXXgIVRdz05ycIlSoV0O53x+zVy27dK6a4cMgC9GGYY+PiT2Xz0vSU8/Jlxog3eQewWGLQZdNAf9gw4Jw179MFdqBmRhVBPBFZ/10XJJe2Vn4uzhLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421259; c=relaxed/simple;
	bh=XopwifXpuSYMxTu0djZ7l5KAMkauC5yrSO6iBds929Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L148c0Y4maptD1ulmZZKy87FP5qDNu60WWOGsoSZVRIpy4UGMXd8slK6GaL6L8Z/Ld++KAJj8opFBpqVFH3iJZBnySU8wtGYkeXdZq/+09PjEytSCPyh4DTAPBB3yRX05175q+7e6xyGZyeX/Imwmsa3YOvndH77GMBmdIg3hqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1121) id 43I5iSGZ2031330; Thu, 18 Apr 2024 14:44:29 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 43I5huV71973228; Thu, 18 Apr 2024 14:43:56 +0900
X-Iguazu-Qid: 2rWhlfeQc0hSsjZa8G
X-Iguazu-QSIG: v=2; s=0; t=1713419035; q=2rWhlfeQc0hSsjZa8G; m=j+Pm1D1XhGYku2T5ouRzXGoXJW46/+QRkInjIAawLJs=
Received: from CNN1EMTA01.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1121) id 43I5hteu2636276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Apr 2024 14:43:55 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA01.test.kioxia.com (Postfix) with ESMTP id 1561B48A81;
	Thu, 18 Apr 2024 14:43:55 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id DFE9C1947AEC50;
	Thu, 18 Apr 2024 14:21:56 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR03.kioxia.com with ESMTP id 0002QAAAAAA01FEA;
	 Thu, 18 Apr 2024 14:21:56 +0900
Received: from CNN1EXMB04.r1.kioxia.com (CNN1EXMB04.r1.kioxia.com [10.232.20.153])
	by Switcher-Pre_Send (Postfix) with ESMTP id D448AAA28483C;
	Thu, 18 Apr 2024 14:21:56 +0900 (JST)
Received: from CNN1EXMB04.r1.kioxia.com (10.232.20.153) by
 CNN1EXMB04.r1.kioxia.com (10.232.20.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:43:54 +0900
Received: from CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) by
 CNN1EXMB04.r1.kioxia.com ([10.13.100.23]) with mapi id 15.01.2507.035; Thu,
 18 Apr 2024 14:43:54 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/11] md: avoid counter operation conflicts
Thread-Topic: [PATCH v2 00/11] md: avoid counter operation conflicts
Thread-Index: AdqLxvhW3yuFLJT7RSafviwhPizLJw==
Date: Thu, 18 Apr 2024 05:43:54 +0000
Message-ID: <3c0ab8eb94ad4b6fb4cb2159f0638650@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-as-result: No-10--8.702300-8.000000
x-tmase-matchedrid: gIzQ6PxOy4OmagT1k9kBpppg8IOIewHQKQNhMboqZlrk6Qbi+9i6D9BB
	eW0QNlfKOuzeNmOGKnMoztzelpYOLoV30ZD7XA/lOIQ9GP2P2u8CtGYG0znilOZYcdJgScjxW8R
	Edt1lp4+09yOz81cF1VqwbjhrO/15FZiP0To6+OjNgrlT5Ajc7jfQpIdR5pWY33Nl3elSfspWIq
	OpyCFExzbFumM3RppUG7nZVjdmJcUQQGM6WcQD/LnHu4BcYSmtVeAZ5VSHdZ2bKItl61J/yZ+in
	TK0bC9e/N9/P5Y462I=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--8.702300-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28328.001
x-tm-snts-smtp: 1DD97C27C0337261ED25501F0EA644C35AC96E2C0497ED9F1CC646863CB8607B2000:8
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

Changes in v2:
 - Add message of performance in cover.
 - Fix a problem of error code initialization in patch 6.
 - Fix a problem of sleeping during rcu_read_lock() in patch 9.
 - Change base-commit from md-6.9 to md-6.10

Currently, active_aligned_reads and nr_pending used as counters are atomic =
types.
Therefore, when inc/dec in a multi-core results in conflicts and READ I/O b=
ecomes slow.
To improve performance, use "percpu_ref" counters that can avoid conflicts =
and maintain consistency.

Switch modes of percpu_ref to achieve both consistency and conflict avoidan=
ce.
During normal operations such as inc/dec, it operates as percpu mode.
When consistency is required, it operates as atomic mode.
The operations that require consistency are as follows:
 - Zero check for the counter
 - All operations in RAID 1/10

Patches 1, 3, 6 change active_aligned_reads, and patches 2, 4, 5, 7 to 11 c=
hange nr_pending.
nr_pending temporarily switch from percpu mode to atomic mode in patch 7.
This is to reduce the amount of changes from patches 8 to 10.
Finally, nr_pending switch from atomic mode to percpu mode in patch 11.

We applied the patch to base-commit and used fio to compare IOPS.
CPU: AMD EPYC 7313P (3.0GHz, 16cores)
DISK: ramdisk x 3 (modprobe brd rd_nr=3D3)
RAID: level 5
fio config: bs=3D4k, rw=3Drandread, iodepth=3D128, numjobs=3D16

without patch: 3.64 MIOPS
with patch   : 3.84 MIOPS

Keisuke TADA (11):
  add infra for active_aligned_reads changes
  add infra for nr_pending changes
  workaround for inconsistency of config state in takeover
  minimize execution of zero check for nr_pending
  match the type of variables to percpu_ref
  avoid conflicts in active_aligned_reads operations
  change the type of nr_pending from atomic_t to percpu_ref
  add atomic mode switching in RAID 1/10
  add atomic mode switching when removing disk
  add atomic mode switching when I/O completion
  avoid conflicts in nr_pending operations

 drivers/md/md-bitmap.c   |  2 +-
 drivers/md/md.c          | 48 ++++++++++++++++++---
 drivers/md/md.h          | 62 +++++++++++++++++++++++----
 drivers/md/raid1.c       | 37 +++++++++++------
 drivers/md/raid10.c      | 60 ++++++++++++++++-----------
 drivers/md/raid5-cache.c |  4 +-
 drivers/md/raid5.c       | 90 +++++++++++++++++++++++++++-------------
 drivers/md/raid5.h       | 17 +++++++-
 8 files changed, 238 insertions(+), 82 deletions(-)


base-commit: 9d1110f99c253ccef82e480bfe9f38a12eb797a7
--
2.34.1



