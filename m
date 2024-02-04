Return-Path: <linux-kernel+bounces-51523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374EC848C28
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E5C1C223BD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F912B7A;
	Sun,  4 Feb 2024 08:26:43 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72CF125DB;
	Sun,  4 Feb 2024 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035203; cv=none; b=szAG3lqAAQb2Np58KCp5Bv9GNc6dj4MiusWgAAaHXnQN3qam3T3QzQNByMVPLgZWNSJPike7loedckoPW8HLJYvp1hm8LmE3IL+MzTPr/WhSk45aGcjG72YqI21IIsOMB3fCRVTke0M+7nuNoWh0lvFMajrJyXmXsOoxs/oaUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035203; c=relaxed/simple;
	bh=2DNwTv1VrV9mcsexzKV9H62e06r46BDwnFnMJYRG1NE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aMazE/nI+WPyqKXoqB27eCs9NerZ5Yz2vZa5i2To7/nD2l5LzyHOGW6wdvVSHzhLfyh48S0I7ldm2KykKfmfLCZSCMgT8in4xw4ZxqaVUKN3Fafx0zoPxbD81BueFmKwF7KjGH/P0X+sWJLoLtCNcbdGmFYT+y/bo7IGZSP/uuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TSMxg1Rpxz1gyTP;
	Sun,  4 Feb 2024 16:24:39 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id D6F74140120;
	Sun,  4 Feb 2024 16:26:32 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 16:26:31 +0800
From: Tong Tiangen <tongtiangen@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <wangkefeng.wang@huawei.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-mm@kvack.org>, Tong Tiangen <tongtiangen@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
Subject: [PATCH -next v5 0/3] minor improvements for x86 mce processing
Date: Sun, 4 Feb 2024 16:26:24 +0800
Message-ID: <20240204082627.3892816-1-tongtiangen@huawei.com>
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
 kwepemm600017.china.huawei.com (7.193.23.234)

In this patchset, we remove the unused macro EX_TYPE_COPY and centralize
the processing of memory-failure to do_machine_check() to avoid calling
memory_failure_queue() separately for different MC-Safe scenarios. In
addition, MCE_IN_KERNEL_COPYIN is renamed MCE_IN_KERNEL_COPY_MC to expand
its usage scope.

[1]https://lore.kernel.org/linux-mm/20230526063242.133656-1-wangkefeng.wang@huawei.com/

since v4:
  1. Patch1, suggested by Petkov, changes as follows:
    a.Improve the commit msg.
    b.Directly delete the unused fixup_type EX_TYPE_COPY instead of
      disrupting the overall layout.
  2. Patch2/3, improve the commit msg suggested by Petkov.
  3. To better describe the problem, reorder the patch 2/3.

since v3:
  1. Rebased on linux-next tag next-20240111.
  2. Delete duplicate commit references on patch 3.

since v2:
  1. remove redundant fixup type EX_TYPE_COPY.
  2. rename MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC.
  3. update patch3's commit message and the processing logic of
     EX_TYPE_DEFAULT_MCE_SAFE based on the discussion of [1].

Kefeng Wang (1):
  x86/mce: set MCE_IN_KERNEL_COPYIN for DEFAULT_MCE_SAFE exception

Tong Tiangen (2):
  x86/mce: remove redundant fixup type EX_TYPE_COPY
  x86/mce: rename MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC

 arch/x86/include/asm/asm.h                 |  3 ---
 arch/x86/include/asm/extable_fixup_types.h |  2 +-
 arch/x86/include/asm/mce.h                 |  8 ++++----
 arch/x86/kernel/cpu/mce/core.c             |  2 +-
 arch/x86/kernel/cpu/mce/severity.c         |  7 +++----
 arch/x86/mm/extable.c                      |  9 ---------
 mm/ksm.c                                   |  1 -
 mm/memory.c                                | 13 ++++---------
 8 files changed, 13 insertions(+), 32 deletions(-)

-- 
2.25.1


