Return-Path: <linux-kernel+bounces-119925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC33288CEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8381C63BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33B0134735;
	Tue, 26 Mar 2024 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JMT8zpp1"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7012B15D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485099; cv=none; b=G7OoMTBrVoWpg/jPYFjm4BZlK/sHiUOsYE9KueH4HfOJCqV8TpdCJ+1qHw10wUSuSoBW6T7472BV3xltIk7nVaJ61iV7JRTtilXd+g4CB43JvZ5a75TtnR8l06MVBSVB5nYoGjM+MTKTg0pCPzTzIH17Va7cqCWTArLpFUVoPmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485099; c=relaxed/simple;
	bh=8/EpHjzfJ1MVMJ4+tmHiCSex+TF4T3+5RAEcQnunBp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eYgOQTzx3dPmkh0xsQ/wQ90cgCZ5u+ggNhMk1eNmicGfjEz8Wh1U/+DsJykAK9jsK8IIu9ugSAUSO/MOk2MzFI1/WM8bc6q+4IrKEO4DIzSP4H7lFD5APvc5aBxgYSevHNw/Ulf2vL47ypjXYjiazgLV6wT6uGCv97rAug6dQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JMT8zpp1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46d0a8399aso31589866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711485095; x=1712089895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lh9U/vyewLtbDFJmjDS8r3hvigj8QyKr7Iw+wfw7H8=;
        b=JMT8zpp1n0ZHDEyEvs2Opkdkf4TP+PKF8Yvicx9qpC4dCandjwKVr5RdmaHMg5HZOm
         +7S44AVM2sL9Itik4EYu9EwxV+Vi5pncBpcl02l4Yls78CqR46LeT2GHIteUMo31bfp/
         Tmh7xER7AjYeZ2xnCOO2mW57/979WKdoXv1i4r6kxjRb7SMPp3osdAC3WBW+0wJWwfee
         XnBSjw4FrRvp0SL3ya/7oeJpQ0s8jJdrNGsnCZsOwQ+5od2uWfEX23Zii30JcI0S1KAg
         X+1ZTkvkYtO+Pf1e6zTDlyJ8z9MJ6vULfK3AO4ybmG8JWyQWXXr5Qxm2rPtb0AZc75Nv
         ypnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485095; x=1712089895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lh9U/vyewLtbDFJmjDS8r3hvigj8QyKr7Iw+wfw7H8=;
        b=FOqd/mmqeJBBEi6c17Ev4VVORDqyXiUOxa3fXQFDYGZo4PJEm42Hwo3VGjm3oW5GAP
         1YH4gGcUJskCHk6+xlybG4yb2oM5Q1yJrj4PEZw3ho6DY7tKYJ04cClFJbzSA10TFbaC
         NkckccdJXKpfwA99h3sxSNh2zOuBRHpgpWv5KjZBVe3m0QRsrdt9TY+8mKlJmy4IzWic
         hrzjXTblpF7BSSStGoiBNt9FrPYIJI+n/SPqy272UWXwUXwU8XjxDL4U+sO9Ditfzaip
         G94wAnraaR5YAqPG8XyrH9mJJRIOz5KoSz7JKPvTgkUGvO7QdweWWa3Dls05G0tLj4mQ
         cQSA==
X-Forwarded-Encrypted: i=1; AJvYcCWfAMU0th5BtZLIKQrfi11ZP/4PffF3LgYS+gaZZvsLLq133H52Rv1reweVIwtNRI/UlpeyhQFSucLtO+5FNlxpJtLGyn654wy2xN4i
X-Gm-Message-State: AOJu0YzmnnGIWHBfoHTsIMETMuQDzmLdPD8ZN6XzI/38BJH0RKX3XbRH
	YgfVdZCo09GIQHIhIlN8yjrMqFIumS3dUW9fDaaFdMlil6FeHs3ru6SLc5HK1Q4=
X-Google-Smtp-Source: AGHT+IHn5ukEbrOXa/xSQN4+acm8vFx4OO0mc31kNe5p13cGaOnb1+adQLu+u+OBPHzLUDOI3daDvw==
X-Received: by 2002:a17:907:7213:b0:a4d:fb90:4a4e with SMTP id dr19-20020a170907721300b00a4dfb904a4emr1302204ejc.2.1711485095264;
        Tue, 26 Mar 2024 13:31:35 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2a02:8440:5240:d2b3:9657:7432:d88d:84a9])
        by smtp.gmail.com with ESMTPSA id ae12-20020a17090725cc00b00a47522c193asm3273954ejc.196.2024.03.26.13.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:31:34 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Zong Li <zong.li@sifive.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Evgenii Shatokhin <e.shatokhin@yadro.com>
Subject: [PATCH 1/2] riscv: Fix warning by declaring arch_cpu_idle() as noinstr
Date: Tue, 26 Mar 2024 21:30:16 +0100
Message-Id: <20240326203017.310422-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326203017.310422-1-alexghiti@rivosinc.com>
References: <20240326203017.310422-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following warning appears when using ftrace:

[89855.443413] RCU not on for: arch_cpu_idle+0x0/0x1c
[89855.445640] WARNING: CPU: 5 PID: 0 at include/linux/trace_recursion.h:162 arch_ftrace_ops_list_func+0x208/0x228
[89855.445824] Modules linked in: xt_conntrack(E) nft_chain_nat(E) xt_MASQUERADE(E) nf_conntrack_netlink(E) xt_addrtype(E) nft_compat(E) nf_tables(E) nfnetlink(E) br_netfilter(E) cfg80211(E) nls_iso8859_1(E) ofpart(E) redboot(E) cmdlinepart(E) cfi_cmdset_0001(E) virtio_net(E) cfi_probe(E) cfi_util(E) 9pnet_virtio(E) gen_probe(E) net_failover(E) virtio_rng(E) failover(E) 9pnet(E) physmap(E) map_funcs(E) chipreg(E) mtd(E) uio_pdrv_genirq(E) uio(E) dm_multipath(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) drm(E) efi_pstore(E) backlight(E) ip_tables(E) x_tables(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) xor(E) async_tx(E) raid6_pq(E) raid1(E) raid0(E) virtio_blk(E)
[89855.451563] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G            E      6.8.0-rc6ubuntu-defconfig #2
[89855.451726] Hardware name: riscv-virtio,qemu (DT)
[89855.451899] epc : arch_ftrace_ops_list_func+0x208/0x228
[89855.452016]  ra : arch_ftrace_ops_list_func+0x208/0x228
[89855.452119] epc : ffffffff8016b216 ra : ffffffff8016b216 sp : ffffaf808090fdb0
[89855.452171]  gp : ffffffff827c7680 tp : ffffaf808089ad40 t0 : ffffffff800c0dd8
[89855.452216]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffffaf808090fe30
[89855.452306]  s1 : 0000000000000000 a0 : 0000000000000026 a1 : ffffffff82cd6ac8
[89855.452423]  a2 : ffffffff800458c8 a3 : ffffaf80b1870640 a4 : 0000000000000000
[89855.452646]  a5 : 0000000000000000 a6 : 00000000ffffffff a7 : ffffffffffffffff
[89855.452698]  s2 : ffffffff82766872 s3 : ffffffff80004caa s4 : ffffffff80ebea90
[89855.452743]  s5 : ffffaf808089bd40 s6 : 8000000a00006e00 s7 : 0000000000000008
[89855.452787]  s8 : 0000000000002000 s9 : 0000000080043700 s10: 0000000000000000
[89855.452831]  s11: 0000000000000000 t3 : 0000000000100000 t4 : 0000000000000064
[89855.452874]  t5 : 000000000000000c t6 : ffffaf80b182dbfc
[89855.452929] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
[89855.453053] [<ffffffff8016b216>] arch_ftrace_ops_list_func+0x208/0x228
[89855.453191] [<ffffffff8000e082>] ftrace_call+0x8/0x22
[89855.453265] [<ffffffff800a149c>] do_idle+0x24c/0x2ca
[89855.453357] [<ffffffff8000da54>] return_to_handler+0x0/0x26
[89855.453429] [<ffffffff8000b716>] smp_callin+0x92/0xb6
[89855.453785] ---[ end trace 0000000000000000 ]---

To fix this, mark arch_cpu_idle() as noinstr, like it is done in commit
a9cbc1b471d2 ("s390/idle: mark arch_cpu_idle() noinstr").

Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
Closes: https://lore.kernel.org/linux-riscv/51f21b87-ebed-4411-afbc-c00d3dea2bab@yadro.com/
Fixes: cfbc4f81c9d0 ("riscv: Select ARCH_WANTS_NO_INSTR")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 92922dbd5b5c..6abeecbfc51d 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -37,7 +37,7 @@ EXPORT_SYMBOL(__stack_chk_guard);
 
 extern asmlinkage void ret_from_fork(void);
 
-void arch_cpu_idle(void)
+void noinstr arch_cpu_idle(void)
 {
 	cpu_do_idle();
 }
-- 
2.39.2


