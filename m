Return-Path: <linux-kernel+bounces-72309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1E685B1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783ED2844C2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8210F53E3B;
	Tue, 20 Feb 2024 04:08:23 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C6168B8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708402103; cv=none; b=p0vgnEAkaoeOpXhizXgVvB1OFPuvfggNRt8I66b5HhF/GqT13MHevPovnroFsdvbk5GsLIRGoeoNsk44Gr8/hg27QycsqENM88sUJmzF5Yzs+yShRE1+ZgSBLIl1Bpht0IwATT28eWrrdbZGzs/uziWD6uawFFpSXUiw8WBctDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708402103; c=relaxed/simple;
	bh=2j4D5kYG7JtSUKyxtW/u2iHPXr2uOOtuX8szenPUMeY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ivzi2/NcK1WTmoRIDZJRQIaSFoguH886GQAq8T8SW4kz4DR7htz31oi02K8hLoH7sH2iIz2zFSLchbosiaxqOzw5H/kCJtdkFLROM/jSu3v3TOofhbXiDXJhazs1aCRSYK6SQRcItlh1+OgjkURAMbDjRazMMStErZmIxcgC6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Tf52G06ZtzNlm1;
	Tue, 20 Feb 2024 11:47:18 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id A70F0140257;
	Tue, 20 Feb 2024 11:48:39 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 20 Feb 2024 11:48:38 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <mawupeng1@huawei.com>,
	<bp@suse.de>, <mingo@redhat.com>, <rdunlap@infradead.org>,
	<bhelgaas@google.com>, <linux-mm@kvack.org>
Subject: [PATCH v4 0/3] Cleanup for PAT
Date: Tue, 20 Feb 2024 11:48:32 +0800
Message-ID: <20240220034835.507022-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200001.china.huawei.com (7.185.36.224)

From: Ma Wupeng <mawupeng1@huawei.com>

Patch #1 move follow_phys to memtype.c since only pat use this.
Patch #2 cleanup parameter in follow_phys.
Patch #3 drop the unnecessary WARN_ON_ONCE if follow_phys fails.

Changelog since v3:
- rebase to latest linux
- fix compile warnings

Changelog since v2:
- rebase to latest linux

Changelog since v1:
- split patch #1 into two patches based on Boris's advise

Ma Wupeng (3):
  x86/mm/pat: Move follow_phys to pat-related file
  x86/mm/pat: Cleanup unused parameter in follow_phys
  x86/mm/pat: Remove WARN_ON_ONCE if follow_phys fails

 arch/x86/mm/pat/memtype.c | 32 ++++++++++++++++++++++++++------
 include/linux/mm.h        |  2 --
 mm/memory.c               | 28 ----------------------------
 3 files changed, 26 insertions(+), 36 deletions(-)

-- 
2.25.1


