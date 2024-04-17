Return-Path: <linux-kernel+bounces-148282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FE28A803C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BAFDB2122F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0396613AA2D;
	Wed, 17 Apr 2024 10:00:00 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7D413280F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347999; cv=none; b=hIeWLUlkGijafApOdR2B8/tQm049X3/xrKevqkJLkmeajReqSgae0RnQvMHzpvvFb3edlfxKnb1QpyeC1ai4UgqlmefUsSHiSp4dC5pzcZ5zkSStolW5PpAggg7cIven1JWoMJXjg+jQgcLWF9sjJMBRiZtdyLoiocXimDHjo+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347999; c=relaxed/simple;
	bh=mHgaZJegfQ+stN8+YXhVA3PdfM0vALppszIpJsvRwX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CovPjiEzP+5IgzwdI2IN8+hOdY1HhD/JVyejKgSP6nVg+6m7njMXZiJ1TbHwTeCvqtGoZzeiPz8bVuL1X1duCP3PHe0gDtoJ8TKZR/8TlOquOobpsJnYtMgBuNIGffys22v0UftxxrvE2HdQswpx7/AvBmMQ4xr6lZXWmxl8MBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxGLqanR9mGbgoAA--.11036S3;
	Wed, 17 Apr 2024 17:59:54 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxKBKYnR9muOR9AA--.32535S2;
	Wed, 17 Apr 2024 17:59:52 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <maz@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH v4 0/3] Give chance to build under !CONFIG_SMP for LoongArch
Date: Wed, 17 Apr 2024 17:59:48 +0800
Message-ID: <20240417095951.2635-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxKBKYnR9muOR9AA--.32535S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFy3AF4DZrWkury8tw45twc_yoW8Gry8pF
	W09r4DJF48Gr93Aayak348uF98trnxGry2gay7C34UAF1DXayjgr1vvF9rXF1jq3yfWr40
	qFs3G34avFyUA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jr6p9UUUUU=

The changes of irqchip have been merged into the irq/core branch of tip.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=42a7d887664b
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=a64003da0ef8

This version is only related with arch/loongarch and based on 6.9-rc4,
drop the patch "LoongArch: Move CONFIG_HAVE_SETUP_PER_CPU_AREA related
code to smp.c" to use the generic setup_per_cpu_areas() if CONFIG_NUMA
is not set.

The first 2 patches with detailed commit message are preparations for
patch #3.

Tested with the following configs:
(1) CONFIG_NUMA=n, CONFIG_SMP=n
(2) CONFIG_NUMA=n, CONFIG_SMP=y
(3) CONFIG_NUMA=y, CONFIG_SMP=n (not allowed due to NUMA select SMP)
(4) CONFIG_NUMA=y, CONFIG_SMP=y

Tiezhu Yang (3):
  LoongArch: Modify acpi_parse_processor() for non-SMP
  LoongArch: Modify ACPI S3 state function for non-SMP
  LoongArch: Give chance to build under !CONFIG_SMP

 arch/loongarch/Kconfig                | 2 +-
 arch/loongarch/include/asm/acpi.h     | 1 +
 arch/loongarch/include/asm/smp.h      | 5 +++++
 arch/loongarch/kernel/acpi.c          | 9 ++++++++-
 arch/loongarch/kernel/irq.c           | 2 ++
 arch/loongarch/kernel/machine_kexec.c | 2 +-
 arch/loongarch/power/suspend.c        | 4 +++-
 7 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.42.0


