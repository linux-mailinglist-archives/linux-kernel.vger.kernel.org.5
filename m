Return-Path: <linux-kernel+bounces-146519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70298A6683
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224F8B219A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDFC83CDE;
	Tue, 16 Apr 2024 08:56:01 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196BDEEB7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257761; cv=none; b=hiiXhbsl89CXDByz0GQhe3uAPh8Nii3HEOCK45doMzfkuf5z0CM1fxu7XCRIDKP77PRg2QdZsuBlgHECgYUyj5uVOx2H5gh+R6P5SkFF3rHwwtxu1kM/4QCpjBmLAlP039INeQkaiikxUrnARD73G2cDL9tzn9dsMdt7BCgPIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257761; c=relaxed/simple;
	bh=ut5LT5kihp43ZMuWD+9aryn+cKQoe9RLrygYduJB090=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=imtHfrT3481MsaPXWroSauXihFwlNBqs279fH1czx3MOIRDn1bA1arT7giaMhrddA9Xi3QA6lMpGmQkuCKK0UCC9pu70fONPnkL8e+z3LHdA6wvVLkyM0Cwl4wDo7WREoWCcm4ukze+5GMkXg3dMj2CGv07twKnXq0sZXH+vbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz9t1713257715tmw5ooq
X-QQ-Originating-IP: pnWe3/FxPwTygbx4ZDZAArIy6TOjZgD1QJHdoepRWhM=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 16:55:13 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: oxgq2YVMtX+Kfqg6MR5ieUTWXbIEe1CyM8GEnslx8SCHfotdSCTOJfBJfofOx
	pokZbom+kHLZB7y6XNxsUwEpvKauZ1DiHV1SrRItr5aPXGFCs4joB+qXpVv3yPIVjxAFJeN
	7EYB9Vnu07Fw6sPUqQ4yzbXiyBFLw0xb5w8xqk69106jmkiTGLnVSliqJgk9FSF8ZiyYB2S
	W4X73SduDDA9PkyZlKeHp35bxzJYc3TArmT2goIW4GDrwfE9dbb6u3Q22XqdTDD0CJH3g9K
	gV7ESU3aiAYoy9b3A5GWF1E7/dSwqp7eHLde9I3qNmv4kD8Oo+9uGJOXl637IM3qUPIXiuW
	h7KyoHhmadEdPE7+1sxfzs/Pt1JeGBCH6MLQQksTesmVFkR8BwKG3SL5IutKVYJP0dnwu2t
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 311192914979424231
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	yury.norov@gmail.com,
	rafael@kernel.org
Cc: akpm@linux-foundation.org,
	maz@kernel.org,
	florian.fainelli@broadcom.com,
	chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	anup@brainfault.org,
	palmer@dabbelt.com,
	samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk,
	daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 0/7] Remove on-stack cpumask var for irq subsystem 
Date: Tue, 16 Apr 2024 16:54:47 +0800
Message-Id: <20240416085454.3547175-1-dawei.li@shingroup.cn>
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

This is v2 of previous series[1] on removal of onstack cpumask var.

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

The case with gic-v3-its(Patch 3) is special from others since it's not
related to intersections between 3 cpumask.

Patch#7 is not for irq subsystem, it's in this series only because it
uses new helper. Please ignore it if you found it's inappropriate for
this series.

Any comments are welcomed.

------------

Change since v1:

- Rebased against tip/irq/core;

- Patch[1]: [Yury]
  - Remove ifdefery nesting on find_first_and_and_bit; 
  - Update commit message;

- Patch[3]: [Marc]
  - Merge two bitmap ops into one;
  - Update commit message;

- Patch[2,4-6]: [Yury]
  - Unwrap lines;

- Patch[7]:
  Newly added. Feel free to drop/ignore it if you found it's inappropriate
  for this series.

[1] v1:
https://lore.kernel.org/lkml/20240412105839.2896281-1-dawei.li@shingroup.cn/

Dawei Li (7):
  cpumask: introduce cpumask_first_and_and()
  irqchip/irq-bcm6345-l1: Avoid explicit cpumask allocation on stack
  irqchip/gic-v3-its: Avoid explicit cpumask allocation on stack
  irqchip/loongson-eiointc: Avoid explicit cpumask allocation on stack
  irqchip/riscv-aplic-direct: Avoid explicit cpumask allocation on stack
  irqchip/sifive-plic: Avoid explicit cpumask allocation on stack
  cpuidle: Avoid explicit cpumask allocation on stack

 drivers/cpuidle/coupled.c                | 13 +++---------
 drivers/irqchip/irq-bcm6345-l1.c         |  6 +-----
 drivers/irqchip/irq-gic-v3-its.c         | 15 ++++++++-----
 drivers/irqchip/irq-loongson-eiointc.c   |  8 ++-----
 drivers/irqchip/irq-riscv-aplic-direct.c |  7 ++----
 drivers/irqchip/irq-sifive-plic.c        |  7 ++----
 include/linux/cpumask.h                  | 17 +++++++++++++++
 include/linux/find.h                     | 27 ++++++++++++++++++++++++
 lib/find_bit.c                           | 12 +++++++++++
 9 files changed, 76 insertions(+), 36 deletions(-)

base-commit: 35d77eb7b974f62aaef5a0dc72d93ddb1ada4074

Thanks,

    Dawei

-- 
2.27.0


