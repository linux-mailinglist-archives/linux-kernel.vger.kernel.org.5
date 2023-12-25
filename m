Return-Path: <linux-kernel+bounces-11090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629B081E12E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B271C21414
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712045027A;
	Mon, 25 Dec 2023 14:50:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DA52F62;
	Mon, 25 Dec 2023 14:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070CBC433C7;
	Mon, 25 Dec 2023 14:50:43 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2] LoongArch: Let cores_io_master cover the largest NR_CPUS
Date: Mon, 25 Dec 2023 22:50:23 +0800
Message-Id: <20231225145023.1505439-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now loongson_system_configuration::cores_io_master only covers 64 cpus,
if NR_CPUS > 64 there will be memory corruption. So let cores_io_master
cover the largest NR_CPUS (256).

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/bootinfo.h | 6 ++++--
 arch/loongarch/kernel/acpi.c          | 2 +-
 arch/loongarch/kernel/smp.c           | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
index c60796869b2b..6d5846dd075c 100644
--- a/arch/loongarch/include/asm/bootinfo.h
+++ b/arch/loongarch/include/asm/bootinfo.h
@@ -24,13 +24,15 @@ struct loongson_board_info {
 	const char *board_vendor;
 };
 
+#define NR_WORDS DIV_ROUND_UP(NR_CPUS, BITS_PER_LONG)
+
 struct loongson_system_configuration {
 	int nr_cpus;
 	int nr_nodes;
 	int boot_cpu_id;
 	int cores_per_node;
 	int cores_per_package;
-	unsigned long cores_io_master;
+	unsigned long cores_io_master[NR_WORDS];
 	unsigned long suspend_addr;
 	const char *cpuname;
 };
@@ -42,7 +44,7 @@ extern struct loongson_system_configuration loongson_sysconf;
 
 static inline bool io_master(int cpu)
 {
-	return test_bit(cpu, &loongson_sysconf.cores_io_master);
+	return test_bit(cpu, loongson_sysconf.cores_io_master);
 }
 
 #endif /* _ASM_BOOTINFO_H */
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 8e00a754e548..b6b097bbf866 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -119,7 +119,7 @@ acpi_parse_eio_master(union acpi_subtable_headers *header, const unsigned long e
 		return -EINVAL;
 
 	core = eiointc->node * CORES_PER_EIO_NODE;
-	set_bit(core, &(loongson_sysconf.cores_io_master));
+	set_bit(core, loongson_sysconf.cores_io_master);
 
 	return 0;
 }
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 5bca12d16e06..33e583303652 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -208,7 +208,7 @@ static void __init fdt_smp_setup(void)
 	}
 
 	loongson_sysconf.nr_cpus = num_processors;
-	set_bit(0, &(loongson_sysconf.cores_io_master));
+	set_bit(0, loongson_sysconf.cores_io_master);
 #endif
 }
 
-- 
2.39.3


