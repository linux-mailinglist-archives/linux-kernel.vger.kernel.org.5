Return-Path: <linux-kernel+bounces-139606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD18A054A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D381528820D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20A162178;
	Thu, 11 Apr 2024 01:05:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB9605CD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797521; cv=none; b=axNKaOzeBcsniWotj0QsftiLiZuYqnTdNa931xUaVVV8cIwzbCJcrWfbkoggSRanwF275RAorfwIJi1XN0+mJbp9OKTwts4Ueyy1Y/DxGNqioHIgHfEp6vX1njzUi/rL9uQ3u+V8u0PkIcrKggHmAYjZGbt7qCckSEbrKuigL/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797521; c=relaxed/simple;
	bh=Hwwauo5s9IR4XHfl2giofayHzvsDSnRmqNLccIaI9SA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcFNvSyv1MRHiJejMfO79kGiyI/15bhx1n5H0x71kW5EN+8U9iccl+0PPFkr1UnkOPqgcQ/1DKVt8oEyPSe+BltqGxBcqjUkcijygL0eLZ2YWrgYeahHoAvhLlgy1azyu6a7bjK3WmYt5Ic3xPK7cMzcT3VJ2zc4V7Jd34p764M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxDLtLNxdm6ZAlAA--.4929S3;
	Thu, 11 Apr 2024 09:05:15 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxhhFHNxdmnrx3AA--.22869S2;
	Thu, 11 Apr 2024 09:05:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <maz@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 0/4] Give chance to build under !CONFIG_SMP for LoongArch
Date: Thu, 11 Apr 2024 09:05:06 +0800
Message-ID: <20240411010510.22135-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxhhFHNxdmnrx3AA--.22869S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy3AF4DZrWkury8uF45Jwc_yoW8GFy3pr
	1SkrsxJF48Grn3Aayak34UuF98trn3Gry2qa17A348AF1UZa4jqr10vr97XFyUt3y3Gr40
	qFn3J34a9FyUA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EoGPUUUUU==

The changes of irqchip have been merged into the irq/core branch of tip.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=42a7d887664b
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=a64003da0ef8

This version is only related with arch/loongarch and based on 6.9-rc3,
the first 3 patches with detailed commit message are preparations for
patch #4.

Tested with the following configs:
(1) CONFIG_NUMA=n, CONFIG_SMP=n
(2) CONFIG_NUMA=n, CONFIG_SMP=y
(3) CONFIG_NUMA=y, CONFIG_SMP=n (not allowed due to NUMA select SMP)
(4) CONFIG_NUMA=y, CONFIG_SMP=y

Tiezhu Yang (4):
  LoongArch: Move CONFIG_HAVE_SETUP_PER_CPU_AREA related code to smp.c
  LoongArch: Refactor get_acpi_id_for_cpu() related code
  LoongArch: Save and restore PERCPU_BASE_KS for ACPI S3 state
  LoongArch: Give chance to build under !CONFIG_SMP

 arch/loongarch/Kconfig                |  4 +-
 arch/loongarch/include/asm/acpi.h     |  8 +++-
 arch/loongarch/include/asm/smp.h      |  5 +++
 arch/loongarch/kernel/acpi.c          |  9 +++-
 arch/loongarch/kernel/irq.c           |  2 +
 arch/loongarch/kernel/machine_kexec.c |  2 +-
 arch/loongarch/kernel/numa.c          | 58 --------------------------
 arch/loongarch/kernel/smp.c           | 59 +++++++++++++++++++++++++++
 arch/loongarch/power/suspend.c        |  4 +-
 9 files changed, 87 insertions(+), 64 deletions(-)

-- 
2.42.0


