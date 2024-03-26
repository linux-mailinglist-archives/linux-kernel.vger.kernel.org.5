Return-Path: <linux-kernel+bounces-118942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D4488C1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739522E0F89
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA2D71758;
	Tue, 26 Mar 2024 12:11:37 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF35B5644F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455097; cv=none; b=pzpt9JGBmiDv2fVaVrEJYr/RMzbrytpQF2tL31P7JnGbz5SnEjibeuHSd7awMZiyw0sbXLtd0c/v/sxV7+1dLujn3K+F7tf/m8q9lShwK0JdUT0ziVgm/Ptbcqu0QO/8ECeGkVWcVhUarz21j92WZr/D5WXuI3dNgu9pKF/llDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455097; c=relaxed/simple;
	bh=yvds8o8itMQD3KUQgIwv4hSWKn0bA3aL6wtLvYmDyvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BNGfbjCFmGj/HMCzNbmKEYp/dHAE2k6DWegw6c/F17/M7b7c4hJzSAOe+ElMq7TVv+k6fOeUdXjXFe3rug19+FflhszEqgTwlz++NL69zFyIBfNnpMb0TEk/oPnCkVqH3Ux+PM2DEI84Ua/egM+R2HJPFt9qxH23p0uGmbPX/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxuvB1uwJm9lweAA--.6038S3;
	Tue, 26 Mar 2024 20:11:33 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTs1zuwJm8eVoAA--.8693S2;
	Tue, 26 Mar 2024 20:11:31 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <maz@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 0/3] Give chance to build under !CONFIG_SMP for LoongArch
Date: Tue, 26 Mar 2024 20:11:27 +0800
Message-ID: <20240326121130.16622-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTs1zuwJm8eVoAA--.8693S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKFy8Kw4UKFWkurW8uFWfJFc_yoW3XFc_C3
	47Ca1kGrW8X3y7A3ZFqr1fX34Uta48WFnYvr1qgrWrZr1Yvr1fJw48Aw15Zr4qkFW8uFs5
	C3y093s8Zr47tosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=

This patch series is based on 6.9-rc1, split the single patch of v1
to 3 patches after some thought, solve only one problem per patch.

Tiezhu Yang (3):
  LoongArch: Give chance to build under !CONFIG_SMP
  irqchip: Select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP for
    IRQ_LOONGARCH_CPU
  irqchip: Set CPU affinity only on SMP machines for LoongArch

 arch/loongarch/Kconfig                 | 2 +-
 arch/loongarch/include/asm/acpi.h      | 1 +
 arch/loongarch/include/asm/smp.h       | 5 +++++
 arch/loongarch/kernel/irq.c            | 2 ++
 arch/loongarch/kernel/machine_kexec.c  | 2 +-
 arch/loongarch/power/suspend.c         | 2 ++
 drivers/irqchip/Kconfig                | 2 +-
 drivers/irqchip/irq-loongson-eiointc.c | 4 ++++
 8 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.42.0


