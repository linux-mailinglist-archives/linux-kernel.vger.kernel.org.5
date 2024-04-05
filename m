Return-Path: <linux-kernel+bounces-132722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05D7899948
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC871C20F76
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148C415F31D;
	Fri,  5 Apr 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzJtCOip"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18015FD1B;
	Fri,  5 Apr 2024 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308653; cv=none; b=hm7ZAkaF2oUPiNBnQHblQfA6tUH07ksvE0+z3V2VaB0zhRhSAqdlmcSV//M4MhfkzJxC3Em9lzstB8pQulTdTg4uaz33pnLAxqxHCd9orGzNxGJ0PyBpE+1iIX8g4WFtjETp/x3dFnlkf102MIEScgsRBsmwdhSDP+KiKFyLmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308653; c=relaxed/simple;
	bh=arne33H5//u9DO+V442IJ7DrQF6kabb/of8ByX5eni0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qPOghpStzjlat6loyHGvcvM3f0uO8PoX7Z90/0M3FmehnJu+NMEMoo1ULP6kb8yRqYmwR3vyg7sFJf2WCYP5je6w/9YZyt/z0chsM6/fdTPlsYtNpGp74TTb4DsH/HzXyPSSqXZFcyDUuYuxiFo4d52oVZHpLUzrlYv5CZr77dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzJtCOip; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41551639550so13904365e9.2;
        Fri, 05 Apr 2024 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712308649; x=1712913449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LX/ma26TDvYVdpCIWg6iUhgi/+t6jX0tkNjGdFErDfk=;
        b=kzJtCOipc0PGWTAIzhWCt42nTXcjST16Q0DJqovup6Kl2OipUZ4lCEas0BGjcX51J9
         JVRUrbL6Qpyj7tMZWtmXOUgP9oFqQC116k116DECpseJK3hBU8AGmqf83gZePNFZEAyp
         FIajbu9wkXBLPurCvFNgyMfHRs90gQE15FPN6aAnn44AFDF+YQB09GGtrI9ygg7zTxLZ
         FaGJE695m22z0/o+HfHdYGWVepN+selmKRrgA6sCyH8xLSOZ1eYyow4aXUC9PRjth2Rx
         Bu836SqoX5pjs4GLVxDZwW0Pp1lPWrBpxfhFoVrhH36qEgT56lQfTE7svPwkTRmdHV+Z
         UoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712308649; x=1712913449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LX/ma26TDvYVdpCIWg6iUhgi/+t6jX0tkNjGdFErDfk=;
        b=WxG6H3i/Kyxx1dqweEV97VTZXatzVNm7XaOtSgEe9GIhovxVT0WSWcu09P2YVcHaRJ
         C3uRz5UsCtVVjfMWdjzhwHXUFNN9r5LTRBCTHPbMZ2OcWMsb3NaNMMuHARe00KWHaZKQ
         8XxgcOTrHmlt+3TcfF+2GhKYNtscNgC/oh2lslGGBihGdXji3HikPZZDChomCnsx8SrI
         HhJHk1mtF/aPkjtarl6CriqKuD5GfboNC5A0m3C9e1UwzgyTGfSpBr9pJeNcgQrpSZY2
         UUjQAP1enyQAxs9XY3E5uiWU4gGcxcRHBcX5gnuFMwoIBv3szXm6pClSyWQxctGAWpQ3
         E7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUEIlqKh0a50/dMExoO3GYBRsrA4OTJvKBAl8bcBzx70QhmC/0pX39m1n6QmPhh0VtOwQK142riwmm2GSSGKF5sXW613IbiaVAVCFkUKFpMIKtglhvBC0Mu7mdMgEuhoChP
X-Gm-Message-State: AOJu0YxKSUmYKDRl8/LfGcjSV/z7fQGofcgFMKWl2oX4QVj68oIJMvJ2
	2BtQ7QDpXE3jMVgq2WOCqhT/qfatjlz2UnIwTgn1qrugcKFk8LimuHD2fDl9KlyPaeyx
X-Google-Smtp-Source: AGHT+IGgfHTLTIsVgQ3B5HauM2cnUDg4HorY6H22kp7XWlCO7vVHucxahGea+Fkf1Sjbk1Up4r//pg==
X-Received: by 2002:a05:600c:4f41:b0:416:1df0:7c06 with SMTP id m1-20020a05600c4f4100b004161df07c06mr933170wmq.6.1712308648855;
        Fri, 05 Apr 2024 02:17:28 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b00416306c17basm1017286wmn.14.2024.04.05.02.17.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:17:28 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
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
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Florent Revest <revest@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next] arm64, bpf: add internal-only MOV instruction to resolve per-CPU addrs
Date: Fri,  5 Apr 2024 09:17:07 +0000
Message-Id: <20240405091707.66675-1-puranjay12@gmail.com>
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

Since commit 7158627686f0 ("arm64: percpu: implement optimised pcpu
access using tpidr_el1"), the per-cpu offset for the CPU is stored in
the tpidr_el1/2 register of that CPU.

To support this BPF instruction in the ARM64 JIT, the following ARM64
instructions are emitted:

mov dst, src		// Move src to dst, if src != dst
mrs tmp, tpidr_el1/2	// Move per-cpu offset of the current cpu in tmp.
add dst, dst, tmp	// Add the per cpu offset to the dst.

If CONFIG_SMP is not defined, then nothing is emitted if src == dst, and
mov dst, src is emitted if dst != src.

To measure the performance improvement provided by this change, the
benchmark in [1] was used:

Before:
glob-arr-inc   :   23.597 ± 0.012M/s
arr-inc        :   23.173 ± 0.019M/s
hash-inc       :   12.186 ± 0.028M/s

After:
glob-arr-inc   :   23.819 ± 0.034M/s
arr-inc        :   23.285 ± 0.017M/s
hash-inc       :   12.419 ± 0.011M/s

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/include/asm/insn.h |  7 +++++++
 arch/arm64/lib/insn.c         | 11 +++++++++++
 arch/arm64/net/bpf_jit.h      |  6 ++++++
 arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index db1aeacd4cd9..d16d68550c22 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -135,6 +135,11 @@ enum aarch64_insn_special_register {
 	AARCH64_INSN_SPCLREG_SP_EL2	= 0xF210
 };
 
+enum aarch64_insn_system_register {
+	AARCH64_INSN_SYSREG_TPIDR_EL1	= 0xC684,
+	AARCH64_INSN_SYSREG_TPIDR_EL2	= 0xE682,
+};
+
 enum aarch64_insn_variant {
 	AARCH64_INSN_VARIANT_32BIT,
 	AARCH64_INSN_VARIANT_64BIT
@@ -686,6 +691,8 @@ u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
 }
 #endif
 u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type);
+u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
+			 enum aarch64_insn_system_register sysreg);
 
 s32 aarch64_get_branch_offset(u32 insn);
 u32 aarch64_set_branch_offset(u32 insn, s32 offset);
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index a635ab83fee3..b008a9b46a7f 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -1515,3 +1515,14 @@ u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
 
 	return insn;
 }
+
+u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
+			 enum aarch64_insn_system_register sysreg)
+{
+	u32 insn = aarch64_insn_get_mrs_value();
+
+	insn &= ~GENMASK(19, 0);
+	insn |= sysreg << 5;
+	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT,
+					    insn, result);
+}
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 23b1b34db088..b627ef7188c7 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -297,4 +297,10 @@
 #define A64_ADR(Rd, offset) \
 	aarch64_insn_gen_adr(0, offset, Rd, AARCH64_INSN_ADR_TYPE_ADR)
 
+/* MRS */
+#define A64_MRS_TPIDR_EL1(Rt) \
+	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL1)
+#define A64_MRS_TPIDR_EL2(Rt) \
+	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL2)
+
 #endif /* _BPF_JIT_H */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 76b91f36c729..e9ad9f257a18 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -877,6 +877,17 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			emit(A64_ORR(1, tmp, dst, tmp), ctx);
 			emit(A64_MOV(1, dst, tmp), ctx);
 			break;
+		} else if (insn_is_mov_percpu_addr(insn)) {
+			if (dst != src)
+				emit(A64_MOV(1, dst, src), ctx);
+#ifdef CONFIG_SMP
+			if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+				emit(A64_MRS_TPIDR_EL2(tmp), ctx);
+			else
+				emit(A64_MRS_TPIDR_EL1(tmp), ctx);
+			emit(A64_ADD(1, dst, dst, tmp), ctx);
+#endif
+			break;
 		}
 		switch (insn->off) {
 		case 0:
@@ -2527,6 +2538,11 @@ bool bpf_jit_supports_arena(void)
 	return true;
 }
 
+bool bpf_jit_supports_percpu_insn(void)
+{
+	return true;
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
-- 
2.40.1


