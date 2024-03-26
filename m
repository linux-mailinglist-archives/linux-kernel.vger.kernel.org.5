Return-Path: <linux-kernel+bounces-118862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6895C88C069
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99608B228C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F294E1C6;
	Tue, 26 Mar 2024 11:18:03 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1122.securemx.jp [210.130.202.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C8D803;
	Tue, 26 Mar 2024 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451883; cv=none; b=p7bLdt+kjYKHNxypxTynVvz0zGPlgvj1s9C2ZbamjvIXH09e158BX4QqERIWI3K6Ur/BjJHcwIyG0qUd9yC9YMjmZTXy7EzpUcbqQ4PgA0OtX77x0V2Y5ppwb3Sohxk3WH2sE5tYtc1iP3JebcHDI+GHBUTcImbZzY2BOCvXa6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451883; c=relaxed/simple;
	bh=EJ2ztyq7sMa6fZAUWBIpzG0seKO1DHeU1ApmIbIb8jU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bmvj/bqiaUQQYq9w2OpXBONuUZMIpED5YoOrK+rsHDWJoBX8bCK7WStr3cmNni4P86hfPQcf/5p0jd199vha5tOcYNf8WSczTlSC2LTZUSBS3ZBAgaMyZm8j3IOR/qDVwjT/nUSy4ooXW4DOGIFld0tPucOW41QZSl6waG+IYuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1122) id 42QATikT899004; Tue, 26 Mar 2024 19:29:44 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 42QATJjK2377118; Tue, 26 Mar 2024 19:29:19 +0900
X-Iguazu-Qid: 2rWgdkpBNplgg44mI6
X-Iguazu-QSIG: v=2; s=0; t=1711448958; q=2rWgdkpBNplgg44mI6; m=EDiCsAsvOikaimQ8/2iYLoxgNF2e7jwkNUA59DB6gvs=
Received: from CNN1EMTA02.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1120) id 42QATHHT2927459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Mar 2024 19:29:18 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA02.test.kioxia.com (Postfix) with ESMTP id 942E12F028;
	Tue, 26 Mar 2024 19:29:17 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id 5C5451900001E2;
	Tue, 26 Mar 2024 19:16:51 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR04.kioxia.com with ESMTP id 0003VAAAAAA01LH2;
	 Tue, 26 Mar 2024 19:16:51 +0900
Received: from CNN1EXMB04.r1.kioxia.com (CNN1EXMB04.r1.kioxia.com [10.232.20.153])
	by Switcher-Pre_Send (Postfix) with ESMTP id 50F99A29B6838;
	Tue, 26 Mar 2024 19:16:51 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB04.r1.kioxia.com (10.232.20.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 19:29:16 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Tue,
 26 Mar 2024 19:29:16 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: "song@kernel.org" <song@kernel.org>,
        "yukuai3@huawei.com"
	<yukuai3@huawei.com>
CC: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/11] md: avoid counter operation conflicts
Thread-Topic: [PATCH 00/11] md: avoid counter operation conflicts
Thread-Index: Adp/Y1jSZkz1OENpR0iwTWSI17JctA==
Date: Tue, 26 Mar 2024 10:29:16 +0000
Message-ID: <a022f547c43e40e2b9f0aebb2bd0bfa8@kioxia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-as-result: No-10--7.718100-8.000000
x-tmase-matchedrid: qiJ73D9abaWmagT1k9kBpgrcxrzwsv5uXPK9y3z82GskZ/X003mSjrWO
	DdZ1PDmEWdeP1D3rX+FqrRvLBntyL1zsSetYc4qWzYK5U+QI3O430KSHUeaVmFGJGXffuLdvhSU
	mXGVMhP4smgs5IfYoxnf/bfV/o9zNyPJ7XPXPXTEHz0YoejTedncF/0kiqyh4OhR0VsdhRrDJw6
	G9NdOWi5KQhRnJRBQncqHNBgW+pKyQB2N+lzcDUufOVcxjDhcwPcCXjNqUmkXCttcwYNipX6pqC
	pA94QmM1BDRiB4eeCPyEnOe3ra2BHC+EljyibT0ZaHJFVY9zjGXEWdkgv56pw==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--7.718100-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28274.000
x-tm-snts-smtp: 09B56E109C13C6AB31B9438989AF5091A938865B184494FE7CD9F52324406A2C2000:8
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

Currently, active_aligned_reads and nr_pending used as counters are atomic =
types.
Therefore, when inc/dec in a multi-core results in conflicts.

To solve this problem, use "percpu_ref" counters that can avoid conflicts a=
nd maintain consistency.

Switch modes of percpu_ref to achieve both consistency and conflict avoidan=
ce.
During normal operations such as inc/dec, it operates as percpu mode.
When consistency is required, it operates as atomic mode.
The operations that require consistency are as follows:
=1B$B!&=1B(BZero check for the counter
=1B$B!&=1B(BAll operations in RAID 1/10

Patches 1, 3, 6 change active_aligned_reads, and patches 2, 4, 5, 7 to 11 c=
hange nr_pending.
nr_pending temporarily switch from percpu mode to atomic mode in patch 7.
This is to reduce the amount of changes from patches 8 to 10.
Finally, nr_pending switch from atomic mode to percpu mode in patch 11.

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
 drivers/md/md.c          | 40 +++++++++++++++---
 drivers/md/md.h          | 62 ++++++++++++++++++++++++----
 drivers/md/raid1.c       | 37 +++++++++++------
 drivers/md/raid10.c      | 60 ++++++++++++++++-----------
 drivers/md/raid5-cache.c |  4 +-
 drivers/md/raid5.c       | 89 +++++++++++++++++++++++++++-------------
 drivers/md/raid5.h       | 17 +++++++-
 8 files changed, 230 insertions(+), 81 deletions(-)


base-commit: fcf3f7e2fc8a53a6140beee46ec782a4c88e4744
--=20
2.34.1


