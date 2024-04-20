Return-Path: <linux-kernel+bounces-152145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326FC8AB9D1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91EEAB2120F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891F414F68;
	Sat, 20 Apr 2024 05:16:48 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D62DF59;
	Sat, 20 Apr 2024 05:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713590208; cv=none; b=NTlgqEgHz4BsYLD45FK/ixARaqsFNooyLztvH1dQ4AfgubPXtQV1Fvdhbhhz20QVQJOmg24YulPJQ5d6YoP7+CQclkrpUqBetJGMIRLBzoiLfVB3hvcdIANC/KXWCLfHABuRvXh39DYiNp0+mOE5ySe0/O5RJM3t9OGgzIR0dCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713590208; c=relaxed/simple;
	bh=XU2yWoK1WrQqtBnfl3ZITnUQStHR0Uv3u1ddNO9vpgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ck9entTn0GQu5sibrJRCJGppIJH3dRqditYSdlglHA0eKxPZoIKfwCRt80BHZlRlplNrtVZFQaivhldYqsmJMFR9djy7mCQ9xPUuoWO7rD662x5jZDyBwX5+MHstUTQoL/Wt4xokdng4K8nMw2ar4Z6FJ8SHOyZLau0dwBYtnIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz10t1713590158trc69o
X-QQ-Originating-IP: ygxXT8qgCis1aPxzC1hVeFySac1DMyjQDT7ybjxZsG4=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 20 Apr 2024 13:15:56 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: rl11S5XfjRPSfQM4W5Pyaf/gzHrbMVKf2sydQfEV+SLQNUmsRgrcTwfZNLTHW
	7ns4FjTNat80pnKXYTtQgqaGsvDQIrnAJ3WAnD6dbyICwR4N6P57gxV22k94bKlnPeX8Ujw
	hzKhB23S1zcKvpJSpI41KS6GMqPwh8WowsOLtQ7MoR0+flCijONJiKgync2iMuYP6moybGi
	SPhotQYBHp0FtH0UAbASisYipsfiwFSiwwdHsfWaL8CKCRFGaf8pejOPG/Krn8FqIk2oBeB
	jlKBpcBGP/UkRosdDlE6mo5XIsqnysVoIrxAhz80vV9E+XRxBblJlBBwFsIaJnluSJBzl8w
	8ft46A4qcPbgfNe+T53GYjl4FOtyASuSTql2dunStUy6pYkGx5oZwg9YoS1Ml5ylGGe31m6
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11763089425837061908
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 0/7] Remove onstack cpumask var for sparc 
Date: Sat, 20 Apr 2024 13:15:40 +0800
Message-Id: <20240420051547.3681642-1-dawei.li@shingroup.cn>
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

This is v2 of previous series[1] on removal of onstack cpumask for sparc
arch.

Change since v1:

- Fix build warning reported by test bot.
- Extend scope of removal, as suggested by Sam[2].

  Note: Couldn't figure out proper approach dealing with case of
  arch/sparc/kernel/ds.c. Just leave it as is.

[1] v1: https://lore.kernel.org/all/20240418104949.3606645-1-dawei.li@shingroup.cn/
[2] https://lore.kernel.org/all/20240419051350.GA558245@ravnborg.org/

Dawei Li (7):
  sparc/srmmu: Remove on-stack cpumask var
  sparc/irq: Remove on-stack cpumask var
  sparc/of: Remove on-stack cpumask var
  sparc/pci_msi: Remove on-stack cpumask var
  sparc: Remove on-stack cpumask var
  sparc/leon: Remove on-stack cpumask var
  sparc/smp: Remove on-stack cpumask var

 arch/sparc/include/asm/smp_32.h  | 12 +++++-----
 arch/sparc/kernel/irq_64.c       | 10 +++-----
 arch/sparc/kernel/kernel.h       | 11 +++++++++
 arch/sparc/kernel/leon_kernel.c  |  9 +++----
 arch/sparc/kernel/leon_smp.c     | 11 ++++-----
 arch/sparc/kernel/of_device_64.c |  5 +---
 arch/sparc/kernel/pci_msi.c      |  5 +---
 arch/sparc/kernel/sun4d_smp.c    | 10 ++++----
 arch/sparc/kernel/sun4m_smp.c    | 10 ++++----
 arch/sparc/mm/init_64.c          |  2 +-
 arch/sparc/mm/srmmu.c            | 40 ++++++++++----------------------
 11 files changed, 50 insertions(+), 75 deletions(-)

Thanks,

    Dawei

-- 
2.27.0


