Return-Path: <linux-kernel+bounces-139604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C584A8A0549
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D2E1F23943
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735AA612D0;
	Thu, 11 Apr 2024 01:05:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202B23201
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797521; cv=none; b=Grw/6IY1XgMtuoYy6OQNC6Djtiv8rv/xH9r74NWyiWmkuGk/BT7PdOK/E9Gg6LE44XkCDcpv178D0GrkkwZYvT06p1mLmzdvo3syPs2U+qwd/5AWiLa4qBf7GG/oYuiMkVFU/0i/x24cHGOJcUvvlMMSpB2HefR03RVKtoqvS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797521; c=relaxed/simple;
	bh=xo0Llg4p1LxmuJODEJTVpjH3Ymlve9IafDDhoC7HqB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUZO8eowuLQvxI/I5SIpkAZd3lVEexDSA8B8g+v00O5vpcULv28oLEqerndPEj+5/YWLnyqs8YGKCKYFNzW+6F7tw9ChRdyfreWD+x+i0ODvZK/MvmXjBHB3xlSgqkLrB7JEFkLjlvObrlYMKecrJQ0AgUnN3802SclFtTdO4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxhrlMNxdm9JAlAA--.4978S3;
	Thu, 11 Apr 2024 09:05:16 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxhhFHNxdmnrx3AA--.22869S4;
	Thu, 11 Apr 2024 09:05:15 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <maz@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 2/4] LoongArch: Refactor get_acpi_id_for_cpu() related code
Date: Thu, 11 Apr 2024 09:05:08 +0800
Message-ID: <20240411010510.22135-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240411010510.22135-1-yangtiezhu@loongson.cn>
References: <20240411010510.22135-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxhhFHNxdmnrx3AA--.22869S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWkuFyxWrW3Kw1kZF4rCrX_yoW8tF15pF
	nFyryDJrW8WFySkrWDJw4fWry5Jw1DCa4Sq3W2ka45AF47ur15Xr93tryqgFWqgw4rKw4S
	vrn3JF1YkFWUXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14v3UUUUUU==

Currently, cpu_logical_map(cpu) is defined as __cpu_logical_map[cpu]
in arch/loongarch/include/asm/smp.h and __cpu_logical_map[] is defined
in arch/loongarch/kernel/smp.c, that is to say, cpu_logical_map(cpu) is
vaild only under CONFIG_SMP, the implementation of get_acpi_id_for_cpu()
which calls cpu_logical_map(cpu) is not suitable for the case of non-SMP,
so refactor get_acpi_id_for_cpu() related code to make it work well for
both SMP and non-SMP.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/acpi.h | 7 ++++++-
 arch/loongarch/kernel/acpi.c      | 9 ++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index 49e29b29996f..a4ad3f75bd60 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -39,9 +39,14 @@ extern struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
 
 extern int __init parse_acpi_topology(void);
 
+static inline struct acpi_madt_core_pic *acpi_cpu_get_core_pic(int cpu)
+{
+	return &acpi_core_pic[cpu];
+}
+
 static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
 {
-	return acpi_core_pic[cpu_logical_map(cpu)].processor_id;
+	return acpi_cpu_get_core_pic(cpu)->processor_id;
 }
 
 #endif /* !CONFIG_ACPI */
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 5cf59c617126..ccfa90faf0ea 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -98,8 +98,15 @@ acpi_parse_processor(union acpi_subtable_headers *header, const unsigned long en
 		return -EINVAL;
 
 	acpi_table_print_madt_entry(&header->common);
+
+	/*
+	 * When CONFIG_SMP is disabled, mapping won't be created for all cpus.
+	 * CPUs more than num_possible_cpus will be ignored.
+	 */
+	if (processor->core_id >= 0 && processor->core_id < num_possible_cpus())
+		acpi_core_pic[processor->core_id] = *processor;
+
 #ifdef CONFIG_SMP
-	acpi_core_pic[processor->core_id] = *processor;
 	set_processor_mask(processor->core_id, processor->flags);
 #endif
 
-- 
2.42.0


