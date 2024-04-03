Return-Path: <linux-kernel+bounces-130543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA938979C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A588C282657
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90C6155A46;
	Wed,  3 Apr 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsI7nGgQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C343AB6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175830; cv=none; b=QO4B34eQ4QPdKUj7jOOMcqKlrNVRh8tY5HNcRUCY7qFIIwFOr0WJJF+1n6iAu2eUbFS22Sxwhs8BTEsNzS+3jU+TyO9PqW3bI/ldiwk/uaU1FuMPoazr5O3WWCryEZ98iuX97YZXnrcf5FNsY/eldVQWu25B2ZLYU+D3vbU9+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175830; c=relaxed/simple;
	bh=2qKPGDldjh2RrBduUVGCqzQbm0jorRgtnsM9rufsE2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKSmcQBUnECdrkROWMBzBgz3COTH9xLn7gtbN+gt6lvUGb0KJBGX6bODmpAz7CcnD3EsRpRQ+nRfstmvkELZl4vkASyMgGKcCrUbfwNii41njONryyyySuoKlEaZaLqpyfPjvCRA4r7gUKVukUqNflxq5af0vj5GokvrsgWqQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsI7nGgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F544C433F1;
	Wed,  3 Apr 2024 20:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712175829;
	bh=2qKPGDldjh2RrBduUVGCqzQbm0jorRgtnsM9rufsE2I=;
	h=From:To:Cc:Subject:Date:From;
	b=lsI7nGgQDZxTlhcEEcqtKp7uCwEXjOdlAwIbCFjjP39Nspb4zCJjGkCHhLHNkFJOm
	 WbC70Qf7krj7CZmbIoiB2hTuKMzKQ8Z8LChW8S+cqTzXw3kwPxA01PoY8Iz+yYU/5k
	 sdpDVdzuW+VfQAIaFDIAV/RU3c13v+Zo/QAkk+zM9iHOWsUQ5UBIXaJbe9F2modXAL
	 ZHqn7IlxbqRU8rzFrHGxcRsjTzSf2lY3NMr16IzN2/jOeefhmeVxesunjN90fJpoSw
	 QqG+nc7yEugbKnMUNBTdH4OuY56EvZzbd0DVJb+pN2EHdnSdAlbhbs7jRJsEN+JWSa
	 Ws5rNmcI/ZjoQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86: numa: include asm/pgtable_areas.h
Date: Wed,  3 Apr 2024 22:23:37 +0200
Message-Id: <20240403202344.3463169-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The __vmalloc_start_set declaration is in a header that is not included
in numa_32.c in current linux-next:

arch/x86/mm/numa_32.c: In function 'initmem_init':
arch/x86/mm/numa_32.c:57:9: error: '__vmalloc_start_set' undeclared (first use in this function)
   57 |         __vmalloc_start_set = true;
      |         ^~~~~~~~~~~~~~~~~~~
arch/x86/mm/numa_32.c:57:9: note: each undeclared identifier is reported only once for each function it appears in

Add an explicit #include

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This showed up in linux-next after 6.8-rc1, but could not immediately see what changed.
---
 arch/x86/mm/numa_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/numa_32.c b/arch/x86/mm/numa_32.c
index 104544359d69..025fd7ea5d69 100644
--- a/arch/x86/mm/numa_32.c
+++ b/arch/x86/mm/numa_32.c
@@ -24,6 +24,7 @@
 
 #include <linux/memblock.h>
 #include <linux/init.h>
+#include <asm/pgtable_areas.h>
 
 #include "numa_internal.h"
 
-- 
2.39.2


