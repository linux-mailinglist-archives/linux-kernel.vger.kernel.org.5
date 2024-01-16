Return-Path: <linux-kernel+bounces-26810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDB282E66C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7861F2308D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3611A10A11;
	Tue, 16 Jan 2024 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6FuVFW0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D36101E8;
	Tue, 16 Jan 2024 01:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F134FC433C7;
	Tue, 16 Jan 2024 01:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367064;
	bh=jyxLSJDJFQYL+4Yk5kFUZxV+9IPiMCyiVPsBQnbjSmY=;
	h=From:To:Cc:Subject:Date:From;
	b=r6FuVFW0iAutx+5dHpjXRw+Im1gTY4K1j1P7UVIsYrOQZUWhbUSlJZoYtcWWBRXRL
	 l+O2Qa/wsCuoOykMoStKNczTJZe1DRKWH0DUz/dc/Hz2wWRSfjf5Jp8Keil6xT08sG
	 3S85f+ijHG+N4gdhyy5c1YNUj4ZOACDBhNSvnLhcS3ZyTlMsQXW6AmTmYbfWldL/mQ
	 DX6InIP4jvGWYL/GYa96Bii5cpFPDjQ0KbQCy6YaDl9w9IJGu8xhCrHd7EfWTClvkS
	 R1ZSoqjnTk1Ovo4Zr/ypqJI9Q/PeKioDLqTcVhtnYOPgSHiRWCdXt2dJUnxoBCmDY8
	 DP7+kZjttdWkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	imbrenda@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 01/21] s390/boot: always align vmalloc area on segment boundary
Date: Mon, 15 Jan 2024 20:03:38 -0500
Message-ID: <20240116010422.217925-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit 65f8780e2d70257200547b5a7654974aa7c37ce1 ]

The size of vmalloc area depends from various factors
on boot and could be set to:

1. Default size as determined by VMALLOC_DEFAULT_SIZE macro;
2. One half of the virtual address space not occupied by
   modules and fixed mappings;
3. The size provided by user with vmalloc= kernel command
   line parameter;

In cases [1] and [2] the vmalloc area base address is aligned
on Region3 table type boundary, while in case [3] in might get
aligned on page boundary.

Limit the waste of page tables and always align vmalloc area
size and base address on segment boundary.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/ipl_parm.c | 2 +-
 arch/s390/boot/startup.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 2ab4872fbee1..b24de9aabf7d 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -274,7 +274,7 @@ void parse_boot_command_line(void)
 			memory_limit = round_down(memparse(val, NULL), PAGE_SIZE);
 
 		if (!strcmp(param, "vmalloc") && val) {
-			vmalloc_size = round_up(memparse(val, NULL), PAGE_SIZE);
+			vmalloc_size = round_up(memparse(val, NULL), _SEGMENT_SIZE);
 			vmalloc_size_set = 1;
 		}
 
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 8104e0e3d188..9cc76e631759 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -255,7 +255,8 @@ static unsigned long setup_kernel_memory_layout(void)
 	VMALLOC_END = MODULES_VADDR;
 
 	/* allow vmalloc area to occupy up to about 1/2 of the rest virtual space left */
-	vmalloc_size = min(vmalloc_size, round_down(VMALLOC_END / 2, _REGION3_SIZE));
+	vsize = round_down(VMALLOC_END / 2, _SEGMENT_SIZE);
+	vmalloc_size = min(vmalloc_size, vsize);
 	VMALLOC_START = VMALLOC_END - vmalloc_size;
 
 	/* split remaining virtual space between 1:1 mapping & vmemmap array */
-- 
2.43.0


