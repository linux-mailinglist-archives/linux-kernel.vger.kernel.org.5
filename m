Return-Path: <linux-kernel+bounces-142538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F768A2CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557D31C216C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D1C4437D;
	Fri, 12 Apr 2024 10:59:23 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C95E1B5A0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919562; cv=none; b=Q0XABgeo7TmDuC+aQBcWeCXAj40+QoVoLD59wvhGVngDQMkE3DaqbdMeXHv55aS1pHk2HZ3srd9t3tZRPkRHqKNBYt/6gxFXiFl7/QhXnXeHXEp2mysa47jc60rgH5ZXDQQmsZmiStIjDeCVWHobCC0rnos3bnQeMUl5nJHIDJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919562; c=relaxed/simple;
	bh=0RtFFg5+N9Y2kQzt26BiZ+RHuA9c5KrrvmaPyEYQ8xA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gmvPi9Kn6EiiYnlfw4XcshbC5qot70NNVNIpeGZW4TBhitd5OfhhNCGmjBxI58ZAImlwSPLeYku5Vsi2K96cwGjfxdwtbCXdfDjEYZO0xM1+9NMHCpHpciRGUvpeY/Q9t0utHefGJ4mGjASitqo5RU/yLixRR9gLnAhkjNhNReQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz12t1712919532tgnpo2
X-QQ-Originating-IP: 60s/XeLSjmpUxocLnKj2JdHh7MZlH2TCyjf2ATbWmkQ=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Apr 2024 18:58:51 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: SX+E1PC0a4Bj3EOShPW6Qa/r+mYU5aXhQ9BafXC5UteUhZfU8MLQFKH23IYlR
	vqGLwzgTtGRKu1O5Glrynb+Y8ed1CMq274/NlMl1yaG05Dc06b5Yx6KWtEldF23D763k4rk
	uDmwvYRinRJF2R3FQOmnJlgurC1Yli4p7BTi7DC2ipaoP5MJDMVsPo7KtKqzQDC54XVPGZA
	lDrqUm2a55JyJxLlV2jAqogkYvnYxdnuWR57y2QtQEyyUhUjFSLGTp3noGKFFNyNYDRowDI
	O1kJiq7IEz4Gqjs5V/tFtcETk6n79377Qh3q7UaYja7BTCC5CCgpD6if0FrJVEskpntJ2PD
	EUjCtLWrhMLIhEemF/C9aXo4Tp60Z2ilifEk0oOm9BuD/sBtk9fGbWaF+KtKVEO2gL00vBB
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9611785477904977050
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	yury.norov@gmail.com
Cc: akpm@linux-foundation.org,
	maz@kernel.org,
	florian.fainelli@broadcom.com,
	chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	anup@brainfault.org,
	palmer@dabbelt.com,
	samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 0/6] Remove on-stack cpumask var for irq subsystem 
Date: Fri, 12 Apr 2024 18:58:33 +0800
Message-Id: <20240412105839.2896281-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi,

Generally it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

One may argue that alloc_cpumask_var() and its friends are the formal
way for these cases. But for struct irqchip::irq_set_affinity(), it's
called under atomic context(raw spinlock held), and dynamic memory
allocation in atomic context is less-favorable.

So a new helper is introduced to address all these issues above. It's
free of any context issue and intermediate cpumask variable allocation
issue(no matter it's on stack or heap).

The case with gic-v3-its is special from others since it's not related
to intersections between 3 cpumask.

And yes, the helper naming(maybe the whole idea) is terrible, and I am
all ears for any comments from you :).

Dawei Li (6):
  cpumask: introduce cpumask_first_and_and()
  irqchip/irq-bcm6345-l1: Avoid explicit cpumask allocation on stack
  irqchip/gic-v3-its: Avoid explicit cpumask allocation on stack
  irqchip/loongson-eiointc: Avoid explicit cpumask allocation on stack
  irqchip/riscv-aplic-direct: Avoid explicit cpumask allocation on stack
  irqchip/sifive-plic: Avoid explicit cpumask allocation on stack

 drivers/irqchip/irq-bcm6345-l1.c         |  7 ++----
 drivers/irqchip/irq-gic-v3-its.c         |  9 +++++---
 drivers/irqchip/irq-loongson-eiointc.c   |  9 +++-----
 drivers/irqchip/irq-riscv-aplic-direct.c |  8 +++----
 drivers/irqchip/irq-sifive-plic.c        |  8 +++----
 include/linux/cpumask.h                  | 17 ++++++++++++++
 include/linux/find.h                     | 29 ++++++++++++++++++++++++
 lib/find_bit.c                           | 14 ++++++++++++
 8 files changed, 77 insertions(+), 24 deletions(-)

Thanks,

    Dawei

-- 
2.27.0


