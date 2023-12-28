Return-Path: <linux-kernel+bounces-12348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB35F81F3A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE181C21188
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B362136F;
	Thu, 28 Dec 2023 01:38:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26010E6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4T0rjg1yJMzMprn;
	Thu, 28 Dec 2023 09:37:43 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 813261402E0;
	Thu, 28 Dec 2023 09:38:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:05 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 00/17] ubifs: Add filesystem repair support
Date: Thu, 28 Dec 2023 09:40:55 +0800
Message-ID: <20231228014112.2836317-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)

UBIFS repair provides a way to fix inconsistent UBIFS image(which is
corrupted by hardware exceptions or UBIFS realization bugs) and makes
filesystem become consistent, just like fsck tools(eg. fsck.ext4,
fsck.f2fs, fsck.fat, etc.) do.

About why do we need it, how it works, what it can fix or it can not
fix, when and how to use it, see more details in
Documentation/filesystems/ubifs/repair.rst (Patch 17).

Testing on UBIFS repair refers to
https://bugzilla.kernel.org/show_bug.cgi?id=218327

Whatever, we finally have a way to fix inconsistent UBFIS image instead
of formatting UBI when UBIFS becomes inconsistent.

Zhihao Cheng (17):
  ubifs: repair: Load filesystem info from volume
  ubifs: repair: Scan nodes from volume
  ubifs: repair: Remove deleted nodes from valid node tree
  ubifs: repair: Add valid nodes into file
  ubifs: repair: Filter invalid files
  ubifs: repair: Extract reachable directory entries tree
  ubifs: repair: Check and correct files' information
  ubifs: repair: Record used LEBs
  ubifs: repair: Re-write data
  ubifs: repair: Create new root dir if there are no scanned files
  ubifs: repair: Build TNC
  ubifs: Extract a helper function to create lpt
  ubifs: repair: Build LPT
  ubifs: repair: Clean up log and orphan area
  ubifs: repair: Write master node
  ubifs: Enable ubifs_repair in '/sys/kernel/debug/ubifs/repair_fs'
  Documentation: ubifs: Add ubifs repair whitepaper

 Documentation/filesystems/index.rst           |    3 +-
 .../authentication.rst}                       |    0
 Documentation/filesystems/ubifs/index.rst     |   11 +
 .../filesystems/{ubifs.rst => ubifs/main.rst} |    0
 Documentation/filesystems/ubifs/repair.rst    |  235 ++
 MAINTAINERS                                   |    5 +-
 fs/ubifs/Makefile                             |    2 +-
 fs/ubifs/debug.c                              |   57 +-
 fs/ubifs/debug.h                              |    2 +
 fs/ubifs/journal.c                            |   39 +-
 fs/ubifs/lpt.c                                |  140 +-
 fs/ubifs/repair.c                             | 2651 +++++++++++++++++
 fs/ubifs/repair.h                             |  176 ++
 fs/ubifs/sb.c                                 |   24 +-
 fs/ubifs/super.c                              |   10 +-
 fs/ubifs/ubifs.h                              |  113 +-
 16 files changed, 3315 insertions(+), 153 deletions(-)
 rename Documentation/filesystems/{ubifs-authentication.rst => ubifs/authentication.rst} (100%)
 create mode 100644 Documentation/filesystems/ubifs/index.rst
 rename Documentation/filesystems/{ubifs.rst => ubifs/main.rst} (100%)
 create mode 100644 Documentation/filesystems/ubifs/repair.rst
 create mode 100644 fs/ubifs/repair.c
 create mode 100644 fs/ubifs/repair.h

-- 
2.31.1


