Return-Path: <linux-kernel+bounces-1364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 543B5814E09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ADCA1F23847
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5041868;
	Fri, 15 Dec 2023 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0PCupFfe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OxnZOC1B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27503FE2C;
	Fri, 15 Dec 2023 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdH3/zFhbfYvyMpVZfiOEfwuE0dIUmNZkBQapN7l63I=;
	b=0PCupFfe+/uFey6s8CR4f9MUqgcVNN73B+mT4AjbMmEuUYcfy0bqw87xJkVjLHDvpgVcJ4
	d0UMEOxIhSmbQ17Hs0rwZgbWhFGU6wk8ubGb1b1Y4yd3WgdpCpe5ZimbEewJ39BgXCtG99
	7Q6ZTf1166uzWAaJ5O/hBXDn2gj1CT0VUBFFeLTNUl+xVZ39K7Dkb+KT6YaxHkpEyFPK9j
	ioVD6mk99L00DHhoJbOBDHg23kTJFT2vlbVJ7JJBKnU6NSx4X45BRjh8mhO/obj9qYfdpL
	biNNMp4wsnCRpvPPuKQk4npx92qh4VOztO4PZ5cC2KMjwFZdQWUrhcPJRYyuUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdH3/zFhbfYvyMpVZfiOEfwuE0dIUmNZkBQapN7l63I=;
	b=OxnZOC1BtcPQMgoNzblfsAnPzGRwme2vpzY8QeTyU8THH57SzRl5iNlkGb9sQtRgOLfwyR
	pvjgxZFCIEjwmSAQ==
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
Subject: [PATCH net-next 03/24] net: Use __napi_alloc_frag_align() instead of open coding it.
Date: Fri, 15 Dec 2023 18:07:22 +0100
Message-ID: <20231215171020.687342-4-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The else condition within __netdev_alloc_frag_align() is an open coded
__napi_alloc_frag_align().

Use __napi_alloc_frag_align() instead of open coding it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/skbuff.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b157efea5dea8..de9397e45718a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -311,11 +311,8 @@ void *__netdev_alloc_frag_align(unsigned int fragsz, u=
nsigned int align_mask)
=20
 		data =3D page_frag_alloc_align(nc, fragsz, GFP_ATOMIC, align_mask);
 	} else {
-		struct napi_alloc_cache *nc;
-
 		local_bh_disable();
-		nc =3D this_cpu_ptr(&napi_alloc_cache);
-		data =3D page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC, align_mask=
);
+		data =3D __napi_alloc_frag_align(fragsz, align_mask);
 		local_bh_enable();
 	}
 	return data;
--=20
2.43.0


