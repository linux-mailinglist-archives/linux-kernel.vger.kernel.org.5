Return-Path: <linux-kernel+bounces-133008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC807899D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4473A1F23522
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E5716C876;
	Fri,  5 Apr 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct5AtXc5"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECAF1DDD1;
	Fri,  5 Apr 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321041; cv=none; b=Lasd7qenMqEBs6hMmxN6CzNjs6ckWrkGlkHkeyCPOm9fPxZhXMVAO8MGxJpqmg37Ehr0EZ0Bcy3U4xwsfsmBrwBfNWg/VL6NYnzCqTzlUve0SYGdevY+f7SQxvJHlzZ9W+Nd/YNCKsZVBi2ViowpgnpeoLH+lZ21Wlwyxj1p38s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321041; c=relaxed/simple;
	bh=5GYBpqDHl1ruxELv5Dvt6rvSuLuznw5wiX1smMGHpyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eE4jmYjljYk6ZrzXFDJ6ejfoQQF0xeIoVuGiEothsPL1uOz02U44Fh10m+5Ene2HJmETpV2Ny+3B+xOPnjh4Vxk5PygZpCYVYWZ1+Ph5F7K3gIRiMgYVAn4R/QYHNbIxRXfn+TrxFfidFR5kveFhjOyK6JwxA/AqIqSYT/ATphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct5AtXc5; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4162b74f2a1so11329295e9.3;
        Fri, 05 Apr 2024 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712321038; x=1712925838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pULb2/SEKmMEonTMi0DJm45CRye8jTdoFzr8IafrgxM=;
        b=ct5AtXc5XiXqbIdF1L2Jx3gVb82WqV0qovX5HCvTQd5VM3PYY00TGX1beSXFeoHTkd
         QAqAMLKQlI9DinK7LfFkgyPqH3NK/Dh/zOhGLUPHVnm1bwXGTvPT1yux0c/BWvenOobs
         9UQJUi9162l3VVkWRxYUA/ajBIlov0zK2aT1fX7bptmC/xBwBiaOIwA6I/kNKjwAaglD
         /KAIhbOHByWJ2IT1BJa187J0LMRi7wLPnJVs9ZJGZGbKwT75T+wA5mf++imkMHv0f6sJ
         VdJmYAQkMza15MfZQWRU3pfJK7m4uWqNsj7K+EnUUBWVtqS+zumEKzdnaSLuvCeDhHJT
         HBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321038; x=1712925838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pULb2/SEKmMEonTMi0DJm45CRye8jTdoFzr8IafrgxM=;
        b=p37zgOPmebPOofkeQitJUKnQiT6DLTtBzh5gXg8SzDqfyfhF+YNPgyxcn1HzHTPZ6v
         cTeOF/5w8vNFmUkdOmUpbOdYduKTRYLEJBSfeoUWMC6gjEam68dR5M39EwZVLnmjG6EZ
         oFHO/aWOh2fyeNuWKclu9C9msUaYF5r9MUKZr9pJETb88Er45ZmwXZ9PiLH373ADnSZg
         9GVdOHWrykMABeK+ZYqzyWQAfRgfZxTO8n9uO0q5G6ktNW+7p3BJjbkM+XQ23dEdPcno
         G0Y8irXkzf6iyDS0B/+sVgl/Dn5pA3+nPLFE6J0+m7Qfh8LtVG+4601AfQeY8UjJM0Zz
         j53A==
X-Forwarded-Encrypted: i=1; AJvYcCVGcI7wQ9CR9kOWhw0AMyJKTsE8Quyo1EJFM6m2oT6w/egFW96M0Hx6slhHBr9QHigkE5f6fN7GIdxfUGGCyGKtGdlC9chc5GkMOWXO04bFnOnXinL6qFb2v79NfDnkQopx
X-Gm-Message-State: AOJu0Yyo1O5m0CoBtoYo89tmBZm5Dvn2MNnitGHA1VSYgv6k+6KdyHwN
	tkhBtaJTosrsZwAt5FJO6SkYuP8yPL2AEu3HBFTw3yI4sWDXWff9
X-Google-Smtp-Source: AGHT+IHUW+bDfIBmn2iekT8yv3sAv6IIGKq2Tu5MgysTRgeCJ5Z1WV+/TuTm7uyrmNDypSyF3mGedA==
X-Received: by 2002:a05:600c:a0d:b0:416:331f:d3b3 with SMTP id z13-20020a05600c0a0d00b00416331fd3b3mr53944wmp.38.1712321037814;
        Fri, 05 Apr 2024 05:43:57 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id n32-20020a05600c3ba000b00415612e29a1sm2887862wms.30.2024.04.05.05.43.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 05:43:57 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pu Lehui <pulehui@huawei.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next] riscv, bpf: add internal-only MOV instruction to resolve per-CPU addrs
Date: Fri,  5 Apr 2024 12:43:48 +0000
Message-Id: <20240405124348.27644-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Support an instruction for resolving absolute addresses of per-CPU
data from their per-CPU offsets. This instruction is internal-only and
users are not allowed to use them directly. They will only be used for
internal inlining optimizations for now between BPF verifier and BPF
JITs.

RISC-V uses generic per-cpu implementation where the offsets for CPUs
are kept in an array called __per_cpu_offset[cpu_number]. RISCV stores
the address of the task_struct in TP register. The first element in
tast_struct is struct thread_info, and we can get the cpu number by
reading from the TP register + offsetof(struct thread_info, cpu).

Once we have the cpu number in a register we read the offset for that
cpu from address: &__per_cpu_offset + cpu_number << 3. Then we add this
offset to the destination register.

To measure the improvement from this change, the benchmark in [1] was
used on Qemu:

Before:
glob-arr-inc   :    1.127 ± 0.013M/s
arr-inc        :    1.121 ± 0.004M/s
hash-inc       :    0.681 ± 0.052M/s

After:
glob-arr-inc   :    1.138 ± 0.011M/s
arr-inc        :    1.366 ± 0.006M/s
hash-inc       :    0.676 ± 0.001M/s

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 15e482f2c657..e95bd1d459a4 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -12,6 +12,7 @@
 #include <linux/stop_machine.h>
 #include <asm/patch.h>
 #include <asm/cfi.h>
+#include <asm/percpu.h>
 #include "bpf_jit.h"
 
 #define RV_FENTRY_NINSNS 2
@@ -1089,6 +1090,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_or(RV_REG_T1, rd, RV_REG_T1, ctx);
 			emit_mv(rd, RV_REG_T1, ctx);
 			break;
+		} else if (insn_is_mov_percpu_addr(insn)) {
+			if (rd != rs)
+				emit_mv(rd, rs, ctx);
+#ifdef CONFIG_SMP
+				/* Load current CPU number in T1 */
+				emit_ld(RV_REG_T1, offsetof(struct thread_info, cpu), RV_REG_TP,
+					ctx);
+				/* << 3 because offsets are 8 bytes */
+				emit_slli(RV_REG_T1, RV_REG_T1, 3, ctx);
+				/* Load address of __per_cpu_offset array in T2 */
+				emit_imm(RV_REG_T2, (u64)&__per_cpu_offset, ctx);
+				/* Add offset of current CPU to  __per_cpu_offset */
+				emit_add(RV_REG_T1, RV_REG_T2, RV_REG_T1, ctx);
+				/* Load __per_cpu_offset[cpu] in T1 */
+				emit_ld(RV_REG_T1, 0, RV_REG_T1, ctx);
+				/* Add the offset to Rd */
+				emit_add(rd, rd, RV_REG_T1, ctx);
+#endif
 		}
 		if (imm == 1) {
 			/* Special mov32 for zext */
@@ -2038,3 +2057,8 @@ bool bpf_jit_supports_arena(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_percpu_insn(void)
+{
+	return true;
+}
-- 
2.40.1


