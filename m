Return-Path: <linux-kernel+bounces-120710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C79C88DBCD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3E8B22D25
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B7352F7F;
	Wed, 27 Mar 2024 11:02:18 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C431A82
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537338; cv=none; b=rVkoGbqQsSzvqnIuAyD1Lu+6+J3hqMSC/Mn3YMss4SZ7aM2DuBUJdKyqOBCJdwHi5kbpwD8bEsbIFFck4yc2eiLg/CYpBS/ErlD+8jwbghgg37LOoVjnR9pyYK5l1W4nZanSw/UFWYiMjCC/lXN5T/z11NdffcP9BD85qWQEGy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537338; c=relaxed/simple;
	bh=h0Rpo+o2sqTiQsLfncHy+BMwtvr0BdHceAlBi/RMVMY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t8/kj6M1+bZm2ACFLvp4il+hKC8UvMyn+8yBLbgphbcxFq6zDmpIVfwCU9c/8Jw6+3FNcj7lKgly1n5eoN2+XVYRj7cmDvM6vY4SWTZaSCzpQ+Avqo9eigzOZKc9m09UeKeTg0LMXpn5V8Hq8XkneD6GY8sCq15LvzyH91N1KUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42RB1uoB056670;
	Wed, 27 Mar 2024 19:01:56 +0800 (+08)
	(envelope-from cathy.cai@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4V4Nx94wClz2MN62X;
	Wed, 27 Mar 2024 19:00:13 +0800 (CST)
Received: from zeshkernups02.spreadtrum.com (10.29.35.184) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 27 Mar 2024 19:01:55 +0800
From: Cathy Cai <cathy.cai@unisoc.com>
To: <cathycai0714@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <cathy.cai@unisoc.com>, <xuewen.yan94@gmail.com>, <cixi.geng1@unisoc.com>,
        <wade.shu@unisoc.com>, <zhiguo.niu@unisoc.com>,
        <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH] net: stmmac: Fix the problem about interrupt storm
Date: Wed, 27 Mar 2024 19:01:42 +0800
Message-ID: <20240327110142.159851-1-cathy.cai@unisoc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 42RB1uoB056670

After I do seven days of MSR test (monkey sleep reboot test) in Android,
I can encounter below netdev watchdog timeout issue. Tx queue timed out
then reset adapter. There is a probability that an interruption storm will
occur and the system will crash.

When we do MSR test, there is a NETDEV WATCHDOG WARNING:
[  117.885804] ------------[ cut here ]------------
[  117.885818] NETDEV WATCHDOG: eth0 (stmmaceth): transmit queue 0 timed
               out
[  117.885873] WARNING: CPU: 1 PID: 4169 at net/sched/sch_generic.c:473
               dev_watchdog+0x2fc/0x41c
[  117.886070]  sprd_systimer sprd_sip_svc sprd_wdt_fiq sprd_wdt_pon
[  117.886082] CPU: 1 PID: 4169 Comm: RenderThread Tainted: G S       C O
               5.4.147-ab41313 #1
[  117.886085] Hardware name: Spreadtrum UIS6780 SoC (DT)
[  117.886090] pstate: 60400005 (nZCv daif +PAN -UAO)
[  117.886094] pc : dev_watchdog+0x2fc/0x41c
[  117.886098] lr : dev_watchdog+0x2fc/0x41c
[  117.886100] sp : ffffffc01000bcf0
[  117.886103] x29: ffffffc01000bcf0 x28: ffffffc011eafe28
[  117.886107] x27: ffffff80f97a5c40 x26: 00000000ffffffff
[  117.886111] x25: 0000000000000001 x24: 0000000000000008
[  117.886114] x23: ffffffc011ea6000 x22: ffffffc011e73020
[  117.886118] x21: 0000000000000000 x20: ffffff80f434841c
[  117.886122] x19: ffffff80f4348000 x18: ffffffc01000d048
[  117.886127] x17: ffffffc012050044 x16: 00000000000508d0
[  117.886130] x15: 0000000000000006 x14: 0000000000000058
[  117.886134] x13: 0000000000000008 x12: 0000000042d7d11b
[  117.886138] x11: 0000000000000015 x10: 0000000000000001
[  117.886141] x9 : a6fe08b7d867fd00 x8 : a6fe08b7d867fd00
[  117.886145] x7 : 0000000000000000 x6 : ffffffc0120a0899
[  117.886149] x5 : 0000000000000058 x4 : 0000000000000002
[  117.886152] x3 : ffffffc01000b980 x2 : 0000000000000007
[  117.886156] x1 : 0000000000000006 x0 : 000000000000003d
[  117.886164]

[  117.887028]
[  117.887030] Call trace:
[  117.887035]  dev_watchdog+0x2fc/0x41c
[  117.887043]  call_timer_fn+0x5c/0x274
[  117.887046]  expire_timers+0x74/0x1b4
[  117.887050]  __run_timers+0x250/0x2b0
[  117.887054]  run_timer_softirq+0x28/0x4c
[  117.887061]  __do_softirq+0x128/0x4dc
[  117.887067]  irq_exit+0xf8/0xfc
[  117.887072]  __handle_domain_irq+0xb0/0x108
[  117.887076]  gic_handle_irq+0x6c/0x124
[  117.887081]  el0_irq_naked+0x64/0x74
[  117.887084] ---[ end trace 1308772835db89f6 ]---
[  117.887188] stmmaceth 32600000.ethernet eth0: Reset adapter.

Tx queue time out then reset adapter. When reset the adapter, stmmac driver
sets the state to STMMAC_DOWN and calls dev_close() function. If an interrupt
is triggered at this instant after setting state to STMMAC_DOWN, before the
dev_close() call.

The scene is as follows:
stmmac_reset_subtask()
	set_bit(STMMAC_DOWN, &priv->state);
					--->interrupt
					  stmmac_interrupt()
					    return IRQ_HANDLED
	dev_close(priv->dev);

The interrupt handler stmmac_interrupt is executed, judging that the state is
STMMAC_DOWN and returning IRQ_HANDLED. Then the processing will not continue,
and it will not be able to clear the interrupt status.

Therefore, to avoid this, set STMMAC_DOWN after dev_close().

Signed-off-by: Cathy Cai <cathy.cai@unisoc.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 24cd80490d19..61690b68b6ad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7167,8 +7167,8 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
 	while (test_and_set_bit(STMMAC_RESETING, &priv->state))
 		usleep_range(1000, 2000);
 
-	set_bit(STMMAC_DOWN, &priv->state);
 	dev_close(priv->dev);
+	set_bit(STMMAC_DOWN, &priv->state);
 	dev_open(priv->dev, NULL);
 	clear_bit(STMMAC_DOWN, &priv->state);
 	clear_bit(STMMAC_RESETING, &priv->state);
-- 
2.34.1


