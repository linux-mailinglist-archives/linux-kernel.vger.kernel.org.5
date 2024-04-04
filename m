Return-Path: <linux-kernel+bounces-131442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F28987F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C2B2C411
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D512C7F9;
	Thu,  4 Apr 2024 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUNQ1o7S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8F98626C;
	Thu,  4 Apr 2024 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234035; cv=none; b=LGV9plMhXh+UjX4aNlZ6SQlWB+qrLrFexYJaqp5FZc/fpuusrs1pIjaznjSp5UrctwqTOfWxJwxfX3cGitvblPoDYCtFIN3bko81HZyheq+fVWi0YN+hPNUHRIroemmur/8I1lDN9bx1ejiphNAS0O8sMhmDF9nEpyUaAPSj7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234035; c=relaxed/simple;
	bh=raX09q2D8RhaIMquAEK8OmefmHQ7J0YcK6aZgyGJtSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qU/TTALQ43IZLM67xzY8Hq11QWIkz68pKbshTb/0l0luYDjwmYTKZ+waCsQMQcceQ6qeE0/xgA1nNS2SS89jcMrL1g+Yt+07Yo5GmyTLhllAkT6y/e4WNfBxagf425IyLbIaajpeI+r0n4W7tImz0Ijcq9pK5yb5ko/Psd2HT58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUNQ1o7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F01EC433C7;
	Thu,  4 Apr 2024 12:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712234034;
	bh=raX09q2D8RhaIMquAEK8OmefmHQ7J0YcK6aZgyGJtSE=;
	h=From:To:Cc:Subject:Date:From;
	b=bUNQ1o7SywzP9x0FsTVSvhZpwLO1DzU6rkrw649CRzArlC/qiMJt0q6yBCVpxKWBP
	 Npf9tiIaLRzI+krIpBLyCAA0ZWHOHYjuIxVi6T6o+LicwGR2F84++jPfloDwyZd7Ma
	 E1z0/WPUreu2hufwumtogOLBHMRKRaB2g7jtQglfVFyNPIw6Nz2aayBPEbNnWTzHn3
	 qjp0841EsRfMVkK/w+qVxtnSzv4s8e/nw2r2svdrCvmD3Pca/O3wTIh5WryYIN0vOg
	 kns0S475uhhKurjrXMH8HINlPdRVbK8vSr5lC6ZhZghWstU9+VD+uixzj4gcXd0ObK
	 CsvUKxvBd4YhA==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Menglong Dong <imagedong@tencent.com>,
	Leon Hwang <hffilwlqm@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: x86: avoid link error with CONFIG_SMP=n
Date: Thu,  4 Apr 2024 14:33:25 +0200
Message-Id: <20240404123346.2661488-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

On UP systems, this_cpu_off is not defined, so the new percpu code in bpf
fails to link:

x86_64-linux-ld: vmlinux.o: in function `do_jit':
bpf_jit_comp.c:(.text+0xbab14): undefined reference to `this_cpu_off'

Use offset zero on UP builds instead.

Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I assume this is not the correct fix, or at least not the best one, so
please treat this as a bug report. It does address the link failure for
me, so I applied this to my randconfig build tree.
---
 arch/x86/net/bpf_jit_comp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d6ebb9136f3c..8b8eebb89a9b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1383,7 +1383,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 				EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
 				break;
 			} else if (insn_is_mov_percpu_addr(insn)) {
-				u32 off = (u32)(unsigned long)&this_cpu_off;
+				u32 off = 0;
+
+				if (IS_ENABLED(CONFIG_SMP))
+					off = (u32)(unsigned long)&this_cpu_off;
 
 				/* mov <dst>, <src> (if necessary) */
 				EMIT_mov(dst_reg, src_reg);
-- 
2.39.2


