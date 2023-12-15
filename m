Return-Path: <linux-kernel+bounces-1363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B039B814E04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65261C23978
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4413FE43;
	Fri, 15 Dec 2023 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jKG9NExl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DL38CTnF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C203FE34;
	Fri, 15 Dec 2023 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/q97aPaf2TtEboxaC2GbAVq2Ev6772dX7ZG1qr6PDU=;
	b=jKG9NExlJAUwVurTamQ/Y5uB8afBObOeg/joHUDYSRGRnRYwa7lgFUdmQ0+uYAtN+0VCE8
	2p2/M4s4aSIexbGXhUuegc5t1bnNwmC7uFAHUCPJJJM82c0dzhgGda4mXexUlIgWK1K1d+
	5H60g3hC76se2wSZmrNTgrIIQ6rfmzFPtpQ7lX9hz2GJ6BOCK/UmCsWKLeYr/j0ch9RT6u
	HONWxxGP+4RNGATTUVKpatsI9ZfbOt8rbSe+yRCWzxHNqVLjmGbN67y1qH7EDJkklWykzq
	Z/1ASP8LDS6FPeMUMHleTPT8kNw4HaYS4AuYqZhSjd88vkVVJ/aG3w+/WEwHig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/q97aPaf2TtEboxaC2GbAVq2Ev6772dX7ZG1qr6PDU=;
	b=DL38CTnF+tPPzN6vDefTDYcyZ2x9OD840MfG+7VuH9RdiQQVB1J2Vora7r5UtZGkprfmog
	U2jIr+ukC3v/kcDg==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 01/24] locking/local_lock: Introduce guard definition for local_lock.
Date: Fri, 15 Dec 2023 18:07:20 +0100
Message-ID: <20231215171020.687342-2-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce lock guard definition for local_lock_t. There are no users
yet.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/local_lock.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index e55010fa73296..706c4b65d9449 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -51,4 +51,15 @@
 #define local_unlock_irqrestore(lock, flags)			\
 	__local_unlock_irqrestore(lock, flags)
=20
+DEFINE_LOCK_GUARD_1(local_lock, local_lock_t,
+		    local_lock(_T->lock),
+		    local_unlock(_T->lock))
+DEFINE_LOCK_GUARD_1(local_lock_irq, local_lock_t,
+		    local_lock_irq(_T->lock),
+		    local_unlock_irq(_T->lock))
+DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t,
+		    local_lock_irqsave(_T->lock, _T->flags),
+		    local_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
 #endif
--=20
2.43.0


