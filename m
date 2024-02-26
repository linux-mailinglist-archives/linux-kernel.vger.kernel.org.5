Return-Path: <linux-kernel+bounces-80443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8AF86687C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB901C212DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F5312E55;
	Mon, 26 Feb 2024 03:06:35 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD396FC01
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916795; cv=none; b=V2YAyWTw8Osr836PdO1BoPxoYfaHZhE5sntiGXUuz2jfPhNdBiNxnNN1sRm75P4AMBbqqmP1KkoEDtJZMJQfgy6r2OVDhG1kGRKRFGCgCsZgK+ntAHaR1FZXCs6CyvkooXociZ+4bZcgX40d1D5HXq2MxA3kpyNg8V+f35/KPaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916795; c=relaxed/simple;
	bh=uWSWIWkD3opthclWyKeivuFFBZgLyDaadr0FCXFpy+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G+60qpCepKxy8Zp/Z3gcQFyJKpXk3tstJOAEAnYIkesEP1V5fUBBSspsMjl5tkFQjAIr51oxaxqbAla+cbYsmy06GNeuNEzRzjAjgbWSkBy9849aGbPaALMVMSU0knYdRw3V06ZLijKsI7errSp7IYMZ9B31ep8KkfxH35iwFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-2d-65dc002fe326
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [RESEND PATCH v8 2/8] arm64: tlbflush: Add APIs manipulating tlb batch's arch data
Date: Mon, 26 Feb 2024 12:06:07 +0900
Message-Id: <20240226030613.22366-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240226030613.22366-1-byungchul@sk.com>
References: <20240226030613.22366-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnoa4+w51Ug5Z+c4s569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF51xw2i3tr/rNanN+1ltVix9J9TBaXDixgsjjee4DJYv69z2wW
	mzdNZbY4PmUqo8XvH0DFJ2dNZnEQ8Pje2sfisXPWXXaPBZtKPTav0PJYvOclk8emVZ1sHps+
	TWL3eHfuHLvHiRm/WTzmnQz0eL/vKpvH1l92Ho1Tr7F5fN4kF8AXxWWTkpqTWZZapG+XwJWx
	p+8he8FsropN79vZGhj3cnQxcnJICJhI3Ph3i6mLkQPM/jTZByTMJqAucePGT2YQW0TATOJg
	6x92EJtZ4C6TxIF+NhBbWCBa4umBvWA2i4CqxI9ZE8FsXgFTict/D7BCjJeXWL3hADPIeE6g
	Oe//G4KEhYBK/vZeZexi5AIq+cwmcX7rOkaIekmJgytusExg5F3AyLCKUSgzryw3MTPHRC+j
	Mi+zQi85P3cTIzDsl9X+id7B+OlC8CFGAQ5GJR7eBR9upwqxJpYVV+YeYpTgYFYS4Q2XuZkq
	xJuSWFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgbH8WUAjB4/K
	pUTN84drxJa9qvKJkwto/LJfe9OESZlTM89eUDnZtPN+8MVLv53und/BNE+FaWPktqmzWvLm
	P5cJrHsYckXSVjpGtkQuM0ZQgSHq+s1tMQptAl9nni1YbyNauPLK04TrlnOLvz4wtLp8yHWh
	kqz6jhusn3ii57kJiHndyyg5+kWJpTgj0VCLuag4EQCxiRetdwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrKvPcCfV4Nh/bYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZezpe8heMJurYtP7drYGxr0cXYwcHBICJhKfJvt0MXJysAmoS9y48ZMZxBYR
	MJM42PqHHcRmFrjLJHGgnw3EFhaIlnh6YC+YzSKgKvFj1kQwm1fAVOLy3wOsILaEgLzE6g0H
	mEHGcwLNef/fECQsBFTyt/cq4wRGrgWMDKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzECg3hZ
	7Z+JOxi/XHY/xCjAwajEw7vgw+1UIdbEsuLK3EOMEhzMSiK84TI3U4V4UxIrq1KL8uOLSnNS
	iw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYbZdFV7/+3CLisHb1f6N//JvnLtg7
	8fL8E5WxHUc2Xb/Vk1retuX/8+tGqjkl/moNHc/2Hn69e8evYI6NrVU8Oj+sXV7y9r0VMQo2
	OqHe2u1qXuQqz/7u5OoL/wXmfNh/+pX1I6Xn7SUB8oX37i9q16jYrT3137HYE1/aNRU8LKOu
	Png5ZWb4ZyWW4oxEQy3mouJEALEqOqReAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that requires to manipulate
tlb batch's arch data. Even though arm64 does nothing with it, arch
with CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH should provide the APIs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/include/asm/tlbflush.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bb2c2833a987..4f2094843e7a 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -328,6 +328,25 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	dsb(ish);
 }
 
+static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	/* nothing to do */
+}
+
+static inline void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* nothing to do */
+}
+
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* nothing to do */
+
+	return false;
+}
+
 /*
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
-- 
2.17.1


