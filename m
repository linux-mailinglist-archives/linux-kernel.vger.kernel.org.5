Return-Path: <linux-kernel+bounces-36787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 641FA83A6A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D571F2321C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4BD19475;
	Wed, 24 Jan 2024 10:22:10 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522F618E2C;
	Wed, 24 Jan 2024 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091729; cv=none; b=j9+R6CGWmBd9mfl2bXZIMFsOjx0LXiwwpolK9MzytWIJ3C2IpP5z3FUNDDuoM2UbwYUJ3Up6M25sZtjX7N/xixvwjaSnZkq2VKDH+3EKBQDdEjEYToWQ04fhWCmMHpivB1Sli0MaQYsGeINujIBXFE4etutlhDxFEq49lpaNDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091729; c=relaxed/simple;
	bh=ZlArPEEwD7BQTNN98/r9t9pw2bQYWEwA4G5549Z+BZ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eE699mAL3lLXR0e5ZzahL60dotdrcX56KMMLi9rnx+JXqMGBe2s6m4Jc2OvbtIhqQ4Xlx2kqVqB/WineysyYB5x2IZ3mL2oxR3mSZQm/Glai2QA2TZrkFgxmjiLs+SXSs/AjyYJDkX2e9QyQ30/OyW4pkP5UKwcO0iaypadhH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 24 Jan
 2024 13:21:56 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 24 Jan
 2024 13:21:56 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Simon Horman
	<horms@kernel.org>, Wojciech Drewek <wojciech.drewek@intel.com>, "Murali
 Karicheri" <m-karicheri2@ti.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<syzbot+3ae0a3f42c84074b7c8e@syzkaller.appspotmail.com>
Subject: [PATCH net] net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()
Date: Wed, 24 Jan 2024 02:21:47 -0800
Message-ID: <20240124102147.14081-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Syzkaller reported [1] hitting a warning after failing to allocate
resources for skb in hsr_init_skb(). Since a WARN_ONCE() call will
not help much in this case, it might be prudent to switch to
netdev_warn_once(). At the very least it will suppress syzkaller
reports such as [1].

Just in case, use netdev_warn_once() in send_prp_supervision_frame()
for similar reasons.

[1]
HSR: Could not send supervision frame
WARNING: CPU: 1 PID: 85 at net/hsr/hsr_device.c:294 send_hsr_supervision_frame+0x60a/0x810 net/hsr/hsr_device.c:294
RIP: 0010:send_hsr_supervision_frame+0x60a/0x810 net/hsr/hsr_device.c:294
..
Call Trace:
 <IRQ>
 hsr_announce+0x114/0x370 net/hsr/hsr_device.c:382
 call_timer_fn+0x193/0x590 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x764/0xb20 kernel/time/timer.c:2022
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2035
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
..

This issue is also found in older kernels (at least up to 5.10).

Cc: stable@vger.kernel.org
Reported-by: syzbot+3ae0a3f42c84074b7c8e@syzkaller.appspotmail.com
Fixes: 121c33b07b31 ("net: hsr: introduce common code for skb initialization")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 net/hsr/hsr_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 7ceb9ac6e730..9d71b66183da 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -308,7 +308,7 @@ static void send_hsr_supervision_frame(struct hsr_port *master,
 
 	skb = hsr_init_skb(master);
 	if (!skb) {
-		WARN_ONCE(1, "HSR: Could not send supervision frame\n");
+		netdev_warn_once(master->dev, "HSR: Could not send supervision frame\n");
 		return;
 	}
 
@@ -355,7 +355,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 
 	skb = hsr_init_skb(master);
 	if (!skb) {
-		WARN_ONCE(1, "PRP: Could not send supervision frame\n");
+		netdev_warn_once(master->dev, "PRP: Could not send supervision frame\n");
 		return;
 	}
 
-- 
2.25.1


