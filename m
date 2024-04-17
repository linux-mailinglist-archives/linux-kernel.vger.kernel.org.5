Return-Path: <linux-kernel+bounces-148283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238C98A803B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBAD41F231FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B4613AA3B;
	Wed, 17 Apr 2024 10:00:00 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4298C137766
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347999; cv=none; b=j3NDj9XSmRYj4xE6ZsqwP1Gyll/5dkcxNhKomlxL/iWdLJrHoQS9kusQBe0v3DE/VTcC4JXsdD4TgvJi6d0qB40hM328EjXReElZjR7XcpDzU0UcBaHNXVohh+sBggn5Fk+kaANUd3tKrxHzqNEmI0ruyKLzPFaHd2VezBO9ejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347999; c=relaxed/simple;
	bh=QdgGWV9RX7cxuOd0TYtBwlJs6ULCACWNNmp/JLLF8lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/mQ2hyAgrBXLuSVUjc2tHRtTFMosYFUdz0oZWEFwB3YMfYdpECepOEE794CX40StzQmrAO3H/py43zosyDDnEHuiG5gFp4CdLNxHMX8VAUJddHfPDzCVfXepLuY/yGZA2QFYYE/xOM9Jn501UHyaK1y8ejA7EpZ8Gd76DzPvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxbOmbnR9mHLgoAA--.16564S3;
	Wed, 17 Apr 2024 17:59:55 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxKBKYnR9muOR9AA--.32535S3;
	Wed, 17 Apr 2024 17:59:53 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <maz@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH v4 1/3] LoongArch: Modify acpi_parse_processor() for non-SMP
Date: Wed, 17 Apr 2024 17:59:49 +0800
Message-ID: <20240417095951.2635-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240417095951.2635-1-yangtiezhu@loongson.cn>
References: <20240417095951.2635-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxKBKYnR9muOR9AA--.32535S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GrykAw4xKF1kZFWkGw17Arc_yoWkAFg_CF
	nxJw18GrWrAFykur1UKayrur1jg34IgFyFkF1qv347C34rXryDXFZrJwn3uwsxJrWkKFZx
	J3yUWas7ur4YyosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr6p9UUUUU=

When CONFIG_SMP is disabled, mapping won't be created for all cpus.
CPUs more than num_possible_cpus will be ignored. This is preparation
for later patch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/acpi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

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


