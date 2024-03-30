Return-Path: <linux-kernel+bounces-125651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69D4892A35
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665D41F222B6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8128DDF;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhF/qfMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E381EB5A;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792677; cv=none; b=UBroF+nQKze7k5kkZdy+nsVtLKS7OwGg42paDCoR4ReIxsGcQAYz6/7FkDw/O0ayTSfreTBbXv3REuPJeZabDcTIk3guOML7miPFKJ7Avx0G5RNPTgQUz5WJNU5v5vmmgSr2x3AC4X6uf9hxBC7he20ETy+aIrbOdhEQunRs7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792677; c=relaxed/simple;
	bh=eDnRUPngHqoQZ7G0b6cjOURT4uhlTvBwqKCHkp86dUI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QfauZKJJH+s1+v0RjTZV41bZp5+jTw2RjxC3cvG4cVS7IQD4ORfx8ITsf2U3AIN+A0PyQTdQXSap+O9opTBP2UEPuVyBqm6hubyWjJ/V32hcYyrD3Eo1oCSN+aUAYIsDcgJ+mY8KvTJb9SPi4R9vUcXgivBUlTYi2bXqJOcyX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhF/qfMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBA97C433C7;
	Sat, 30 Mar 2024 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792676;
	bh=eDnRUPngHqoQZ7G0b6cjOURT4uhlTvBwqKCHkp86dUI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JhF/qfMGRF2vRF9lE7VZ9fXM8H87R6irghexmiTHRAAyGdBzRAuQ8CNW4iyOk2XnV
	 JXXDTzTq82CQ4xQR/1ykWZFZ6dzSPyxI9Zbt3Z2QR5OM273vEmxIcvdxd84mnkxZml
	 HZR+FhYjZXYqQNZz1pt5oB0sxaKFLTJOteIPMRFxCRnwjth13nwPioeLluXmFA2/W2
	 JXNRe76Guf5Y1v1pBfxlUsCeBGeau2f+bwyhvdxnSNTqjVNLA2J+gAAtTjLCSxBQVO
	 3bkGe8UtsPK0VoWih9WUqyrD7jTFd3v1LeSyrZ00mguL96ztYSYQqiS6/cUry3MMS+
	 0ZQo7ntmGqIMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFE5CD11DD;
	Sat, 30 Mar 2024 09:57:56 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Subject: [PATCH 00/10] sparc64: Fix CPU online bug and warning fixes
Date: Sat, 30 Mar 2024 10:57:36 +0100
Message-Id: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABHiB2YC/x3MQQqAIBBA0avErBNMTaqrRAuzsWZjMQMVRHdPW
 r7F/w8IMqHAUD3AeJLQnguauoK4hbyioqUYjDZOW9MrOQJH79QVOFNeRXnfxdhrTK2doWQHY6L
 7X47T+35CLiOJYgAAAA==
To: Andreas Larsson <andreas@gaisler.com>, 
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>, 
 Atish Patra <atish.patra@oracle.com>, stable@vger.kernel.org, 
 Bob Picco <bob.picco@oracle.com>, Vijay Kumar <vijay.ac.kumar@oracle.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711792675; l=2071;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=eDnRUPngHqoQZ7G0b6cjOURT4uhlTvBwqKCHkp86dUI=;
 b=XbiHaZ/tYJDLA+a14/hq+RNLsBlpQeOA1+rEeZk7TbiaKPXwytF49GTZiGF68WZIeOwb02V/RLnH
 CJVACzeFBQ/ioYueEX2mS2PTVVtDyJVb3DKSvYn8mxZNLwri6H+R
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with
 auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: sam@ravnborg.org

Nick Bowler reported that sparc64 failed to bring all his CPU's online,
and that turned out to be an easy fix.

The sparc64 build was rather noisy with a lot of warnings which had
irritated me enough to go ahead and fix them.
With this set of patches my arch/sparc/ is almost warning free for
all{no,yes,mod}config + defconfig builds.

There is one warning about "clone3 not implemented", which I have ignored.

The warning fixes hides the fact that sparc64 is not yet y2038 prepared,
and it would be preferable if someone knowledgeable would fix this
poperly.

All fixes looks like 6.9 material to me.

	Sam 

---
Sam Ravnborg (10):
      sparc64: Fix prototype warning for init_vdso_image
      sparc64: Fix prototype warnings in traps_64.c
      sparc64: Fix prototype warning for vmemmap_free
      sparc64: Fix prototype warning for alloc_irqstack_bootmem
      sparc64: Fix prototype warning for uprobe_trap
      sparc64: Fix prototype warning for dma_4v_iotsb_bind
      sparc64: Fix prototype warnings in adi_64.c
      sparc64: Fix prototype warning for sched_clock
      sparc64: Fix number of online CPUs
      sparc64: Fix prototype warnings for vdso

 arch/sparc/include/asm/smp_64.h  |  2 --
 arch/sparc/include/asm/vdso.h    | 10 ++++++++++
 arch/sparc/kernel/adi_64.c       | 14 +++++++-------
 arch/sparc/kernel/kernel.h       |  4 ++++
 arch/sparc/kernel/pci_sun4v.c    |  6 +++---
 arch/sparc/kernel/prom_64.c      |  4 +++-
 arch/sparc/kernel/setup_64.c     |  3 +--
 arch/sparc/kernel/smp_64.c       | 14 --------------
 arch/sparc/kernel/time_64.c      |  1 +
 arch/sparc/kernel/traps_64.c     | 10 +++++-----
 arch/sparc/kernel/uprobes.c      |  2 ++
 arch/sparc/mm/init_64.c          |  5 -----
 arch/sparc/vdso/vclock_gettime.c |  1 +
 arch/sparc/vdso/vma.c            |  5 +++--
 14 files changed, 40 insertions(+), 41 deletions(-)
---
base-commit: 84b76d05828a1909e20d0f66553b876b801f98c8
change-id: 20240329-sparc64-warnings-668cc90ef53b

Best regards,
-- 
Sam Ravnborg <sam@ravnborg.org>



