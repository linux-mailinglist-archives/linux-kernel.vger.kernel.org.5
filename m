Return-Path: <linux-kernel+bounces-162068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0E88B557C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E04B231FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571B47A5C;
	Mon, 29 Apr 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="ArUfwr12"
Received: from out0-202.mail.aliyun.com (out0-202.mail.aliyun.com [140.205.0.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F639AC3;
	Mon, 29 Apr 2024 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386964; cv=none; b=SqzLdrzNx+zF6qyHQWYY6ajx55p14yy8KIbkP94+l/7uY+w/ejfJLrP8oMAkSf0+muxt/H16dqfw8Dqq4PIIlHjNuIbau+RQ1gx+jybJuYVknRuiSRQVt5DdnLkUCPizwo+OeTs8FxL0Z9Vq7XBWVS4sPtKQy2Bl5gljO0YD7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386964; c=relaxed/simple;
	bh=h2xeHWWYBwglEX+x9qdisO8pVjvAPSpXhXhaDjkMQHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HrabMBivSh0C1K7P7nbcM1th8wYP+Xe40IdzFteo2BARSxZLeULskqqU8tBL4QPmxFI82neNEKWha/HBZeimQk+6GYNB7gF2hIbn7uBbkt2mJoto32hOU1kEU20jJCi4tG+bmskDIrzQQ7T/8UC+nXBuPR2x1qymXRdmSOkzuio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=ArUfwr12; arc=none smtp.client-ip=140.205.0.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1714386952; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dLJfLm6QSven/Kk0xr1PvysR3nscl1fg/cBxpNWoFzo=;
	b=ArUfwr12m/13gjqdD/r0ZIsihv3TfM1SvtZhKzqB8oLUrgM+MhPWy/epJvVljTPbBazl7oTiWTXQVTASw8ZDs4B82BAUPaAsWC3jAAeNySLZoftkYm60t2tl5sDU/DG+1dp9xRsRyP2joXspahbGuXrjsXOgzYSdV0nJP74C7bw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047192;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---.XOFewr4_1714386949;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XOFewr4_1714386949)
          by smtp.aliyun-inc.com;
          Mon, 29 Apr 2024 18:35:50 +0800
From: "Bang Li" <libang.li@antgroup.com>
To: akpm@linux-foundation.org,
	chenhuacai@kernel.org,
	tsbogend@alpha.franken.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com
Cc:  <david@redhat.com>,
   <ryan.roberts@arm.com>,
   <libang.linux@gmail.com>,
   <ioworker0@gmail.com>,
   <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
   <loongarch@lists.linux.dev>,
   <linux-mips@vger.kernel.org>,
   <linux-riscv@lists.infradead.org>,
  "Bang Li" <libang.li@antgroup.com>
Subject: [PATCH v1 0/5] Add update_mmu_tlb_range() to simplify code
Date: Mon, 29 Apr 2024 18:33:41 +0800
Message-Id: <20240429103346.59115-1-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of commits mainly adds the update_mmu_tlb_range() to
batch update tlb in an address range.

After the commit 19eaf44954df ("mm: thp: support allocation of anonymous
multi-size THP"), We may need to batch update tlb of a certain address
range by calling update_mmu_tlb() in a loop. Using the 
update_mmu_tlb_range(), we can simplify the code and possibly reduce the
execution of some unnecessary code in some architectures.

Bang Li (5):
  LoongArch: Add update_mmu_tlb_range()
  mips: Add update_mmu_tlb_range()
  riscv: Add update_mmu_tlb_range()
  xtensa: Add update_mmu_tlb_range()
  mm: Add update_mmu_tlb_range()

 arch/loongarch/include/asm/pgtable.h | 2 ++
 arch/mips/include/asm/pgtable.h      | 2 ++
 arch/riscv/include/asm/pgtable.h     | 2 ++
 arch/xtensa/include/asm/pgtable.h    | 2 ++
 arch/xtensa/mm/tlb.c                 | 6 ++++++
 include/linux/pgtable.h              | 5 +++++
 mm/memory.c                          | 4 +---
 7 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.19.1.6.gb485710b


