Return-Path: <linux-kernel+bounces-133149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630F2899F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2971F21F56
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F370116EC1C;
	Fri,  5 Apr 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GArRvp9X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA716EC01;
	Fri,  5 Apr 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327204; cv=none; b=Hzm4Rtpo+Pqn+vthtxYZMFSos2uxwplh6Jb2YXT/VCA3b6P2FOell1N0g2rl2adPbVTtXDPCCUAGUTp5a1leP/JwGza50PriTWWkAJV0F4rHDn25xFiEW48evuoyWTLnpMabhBLG5UEmzKtKb+LpUVA8JbjhZb7ZG7L7ec+NM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327204; c=relaxed/simple;
	bh=4gI3JY/aS1qAjeKrQZ38gb5dce7Uv7MoJZjqtRTJfZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MaJDYxf9wmREPP6KfG511OH9LHaAu+SdGSLoDvpvyPDh7Io3+CD7ySq/7O/AKjeRUNed/K5tnrETvFy1JhfyOWu+13Ji++FUchqdLIcaDxyNk6lgh1Fjs2zUXsdDYxxhylpUt7t0p+um91LUTxbaCySOgTgon2vfl0EGFD5MhVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GArRvp9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AB3C433C7;
	Fri,  5 Apr 2024 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712327203;
	bh=4gI3JY/aS1qAjeKrQZ38gb5dce7Uv7MoJZjqtRTJfZU=;
	h=From:To:Cc:Subject:Date:From;
	b=GArRvp9X47B5AB5J6I9p6riAu39YnE9MM5h4dyylwkf7e15QcZLFCyHlQRNBISuBt
	 XamNQYOH6S1iUSGbllnKoEkdcqynh1bUoUYd0hXRnUiY3ybgW5OIF5Aj01XHaCKC6a
	 qT++ZieI8cf4sLg5VaygYGfM58s2KEUf269XTxLCaKmQtxQ8CJj6uTmDQND954vM9J
	 bdZcQSy82NRuI8qM/csPXFrVyLfzGOsM75nd36huucxsMZm9wHl1LBj4YbEbr9wpzp
	 NtWUPBHogG/PTtoopIPUXXHeJXHSh/CSL1BBgAldrwOcZZOoU716KwlvMy9toXWPau
	 wxr9fVMI8A7Yw==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: fix perf_snapshot_branch_stack link failure
Date: Fri,  5 Apr 2024 16:26:25 +0200
Message-Id: <20240405142637.577046-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added code to handle bpf_get_branch_snapshot fails to link when
CONFIG_PERF_EVENTS is disabled:

aarch64-linux-ld: kernel/bpf/verifier.o: in function `do_misc_fixups':
verifier.c:(.text+0x1090c): undefined reference to `__SCK__perf_snapshot_branch_stack'

Add a build-time check for that Kconfig symbol around the code to
remove the link time dependency.

Fixes: 314a53623cd4 ("bpf: inline bpf_get_branch_snapshot() helper")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aca00ba61232..b34cdeff415e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20192,7 +20192,8 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		/* Implement bpf_get_branch_snapshot inline. */
-		if (prog->jit_requested && BITS_PER_LONG == 64 &&
+		if (IS_ENABLED(CONFIG_PERF_EVENTS) &&
+		    prog->jit_requested && BITS_PER_LONG == 64 &&
 		    insn->imm == BPF_FUNC_get_branch_snapshot) {
 			/* We are dealing with the following func protos:
 			 * u64 bpf_get_branch_snapshot(void *buf, u32 size, u64 flags);
-- 
2.39.2


