Return-Path: <linux-kernel+bounces-100891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAC8879EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7621C22336
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B3A14532C;
	Tue, 12 Mar 2024 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlWgh+XJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF5B14403A;
	Tue, 12 Mar 2024 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282549; cv=none; b=rx1oGqaqvGoBCEzQDNqZuW3p2Z4KH0C4J3p8XnZIa29laP/iEqpqW4iFHTOM683DdsudWO3O4+v9Y3tI/UwcHw9ONmQjAvjU/y/FDtdheq/Cvfxs+trmBPPXKkWphDu+x4rQmGTmursOQjIjdVbIJarChaGx4IbsM2Q6qY3vuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282549; c=relaxed/simple;
	bh=u8AE1TgBiBYssYKjxzzEC6IaZ9p99XcwVxRZfDUcRoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCuZS3ZpBd/HbxOQN8k1VxD154Nv6aCiVfo9VAg1GG2JC/lcvWNfq6je9gy2YGK/01uQpzzgfFw/ypN+6KTa7sbSjpkF4ly2JiDhMEOFmLOzEAEuo7O1K0VM8ZE11nGXZjXg0GajMo/7NLnGbWXgjsEA+OKsYix28C51SPUDjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlWgh+XJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710282548; x=1741818548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u8AE1TgBiBYssYKjxzzEC6IaZ9p99XcwVxRZfDUcRoE=;
  b=YlWgh+XJ6F+Ll9FvYBtWk9zJ0x+S4guMqq3owhv4OpS/d//spXWtFZQ3
   /+To6A7fItKP59uVDafSFHiIcjAaDK2+xaKoAcZ3o2e9rPA2xuELGYZTX
   PwjrbsFRhT4oT7zOnfKctgbvBW8lgUJWAsKMladPV9VdG5q8Wgpu4XiIl
   lKjIKi/nz4pAcXPm3fAHgDaYNqiuWTTJ6f6EzqNBQ5NSYnp0Kzi8mE8VX
   wmXAPZKgIdjHtm9Q9uxmdfdaBcLaYXuPamwmFajOs36uuFmKjrwSV1xsq
   zlWpt1HkjUycNHKcuqN3ZMh18VqBxAmR0RA19fqFDuPa5UdjukzmlChxS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5191974"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5191974"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16356852"
Received: from gargayus-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.255.231.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:02 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	broonie@kernel.org,
	dave.hansen@linux.intel.com,
	debug@rivosinc.com,
	hpa@zytor.com,
	keescook@chromium.org,
	kirill.shutemov@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org,
	christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rick.p.edgecombe@intel.com,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org
Subject: [PATCH v3 05/12] csky: Use initializer for struct vm_unmapped_area_info
Date: Tue, 12 Mar 2024 15:28:36 -0700
Message-Id: <20240312222843.2505560-6-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Future changes will need to add a new member to struct
vm_unmapped_area_info. This would cause trouble for any call site that
doesn't initialize the struct. Currently every caller sets each member
manually, so if new members are added they will be uninitialized and the
core code parsing the struct will see garbage in the new member.

It could be possible to initialize the new member manually to 0 at each
call site. This and a couple other options were discussed, and a working
consensus (see links) was that in general the best way to accomplish this
would be via static initialization with designated member initiators.
Having some struct vm_unmapped_area_info instances not zero initialized
will put those sites at risk of feeding garbage into vm_unmapped_area() if
the convention is to zero initialize the struct and any new member addition
misses a call site that initializes each member manually.

It could be possible to leave the code mostly untouched, and just change
the line:
struct vm_unmapped_area_info info
to:
struct vm_unmapped_area_info info = {};

However, that would leave cleanup for the members that are manually set
to zero, as it would no longer be required.

So to be reduce the chance of bugs via uninitialized members, instead
simply continue the process to initialize the struct this way tree wide.
This will zero any unspecified members. Move the member initializers to the
struct declaration when they are known at that time. Leave the members out
that were manually initialized to zero, as this would be redundant for
designated initializers.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Link: https://lore.kernel.org/lkml/202402280912.33AEE7A9CF@keescook/#t
Link: https://lore.kernel.org/lkml/j7bfvig3gew3qruouxrh7z7ehjjafrgkbcmg6tcghhfh3rhmzi@wzlcoecgy5rs/
---
v3:
 - Fixed spelling errors in log
 - Be consistent about field vs member in log

Hi,

This patch was split and refactored out of a tree-wide change [0] to just
zero-init each struct vm_unmapped_area_info. The overall goal of the
series is to help shadow stack guard gaps. Currently, there is only one
arch with shadow stacks, but two more are in progress. It is compile tested
only.

There was further discussion that this method of initializing the structs
while nice in some ways has a greater risk of introducing bugs in some of
the more complicated callers. Since this version was reviewed my arch
maintainers already, leave it as was already acknowledged.

Thanks,

Rick

[0] https://lore.kernel.org/lkml/20240226190951.3240433-6-rick.p.edgecombe@intel.com/
---
 arch/csky/abiv1/mmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/csky/abiv1/mmap.c b/arch/csky/abiv1/mmap.c
index 6792aca49999..7f826331d409 100644
--- a/arch/csky/abiv1/mmap.c
+++ b/arch/csky/abiv1/mmap.c
@@ -28,7 +28,12 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	int do_align = 0;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {
+		.length = len,
+		.low_limit = mm->mmap_base,
+		.high_limit = TASK_SIZE,
+		.align_offset = pgoff << PAGE_SHIFT
+	};
 
 	/*
 	 * We only need to do colour alignment if either the I or D
@@ -61,11 +66,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			return addr;
 	}
 
-	info.flags = 0;
-	info.length = len;
-	info.low_limit = mm->mmap_base;
-	info.high_limit = TASK_SIZE;
 	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
-	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
-- 
2.34.1


