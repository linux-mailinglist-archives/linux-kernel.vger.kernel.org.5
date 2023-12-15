Return-Path: <linux-kernel+bounces-1362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4DB814E03
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30881F2550E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1493FB36;
	Fri, 15 Dec 2023 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDJgxTzv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fdc2dNEE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395D3FE31;
	Fri, 15 Dec 2023 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ousXBW8YKwa+nWI6kv1lhXaySXJ0I7exp/MtxAHjcWw=;
	b=EDJgxTzv/PR7nL34hOo/iutHnq9tW0tjeIj2ikrEGyOzaEHjxiQRge594/R+cPF/ZVn63R
	oqUkJkJIG04oClSRTdQ3kPuusKwzDZZSIEN5C/lZRqSXVwWmwVTGHU5bF00PuJ58inqXPM
	v0F+i94zKcXl+E3UrPNDDwKtxWA5nJ9uMJjcwILuniEnB+cMU7OHTOlmi1MDFlHP4jmKp4
	YTIEejYnnMwDmKYB9rIfw5bQGnlrvTmbpG8OIWeJuqu4eHKZi1ur1Pgi/T+DgukUHx2fix
	tmt+uvYD0N81CPmW2CrIStLf8b1kk2mng3y1AwF/VPNS97pal+Ia6fLlRpceIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ousXBW8YKwa+nWI6kv1lhXaySXJ0I7exp/MtxAHjcWw=;
	b=Fdc2dNEEqv0Wbzbs4tUFApE/hBTBsMkY2FZ0QLsAPtak9Rt5rAa13DQHGKBmCu3V5o2dFh
	CAdgwtV7uDMpMXBQ==
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
	Will Deacon <will@kernel.org>
Subject: [PATCH net-next 00/24] locking: Introduce nested-BH locking.
Date: Fri, 15 Dec 2023 18:07:19 +0100
Message-ID: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Disabling bottoms halves acts as per-CPU BKL. On PREEMPT_RT code within
local_bh_disable() section remains preemtible. As a result high prior
tasks (or threaded interrupts) will be blocked by lower-prio task (or
threaded interrupts) which are long running which includes softirq
sections.

The proposed way out is to introduce explicit per-CPU locks for
resources which are protected by local_bh_disable() and use those only
on PREEMPT_RT so there is no additional overhead for !PREEMPT_RT builds.

The series introduces the infrastructure and converts large parts of
networking which is largerst stake holder here. Once this done the
per-CPU lock from local_bh_disable() on PREEMPT_RT can be lifted.

Sebastian


