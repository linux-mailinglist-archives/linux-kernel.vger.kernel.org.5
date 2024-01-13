Return-Path: <linux-kernel+bounces-25153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EBD82C8A5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B5928735E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546C01549F;
	Sat, 13 Jan 2024 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pappasbrent.com header.i=@pappasbrent.com header.b="QcbN3/tm"
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D41134C2;
	Sat, 13 Jan 2024 01:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pappasbrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pappasbrent.com
Received: from MTA-10-4.privateemail.com (mta-10.privateemail.com [198.54.118.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id B138B60562;
	Sat, 13 Jan 2024 01:14:49 +0000 (UTC)
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
	by mta-10.privateemail.com (Postfix) with ESMTP id E443E180020E;
	Fri, 12 Jan 2024 20:14:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
	s=default; t=1705108481;
	bh=5tLeUjD4Wuj2pnMpbrqMQhIri6Cryus27QrLloXWnoE=;
	h=From:To:Cc:Subject:Date:From;
	b=QcbN3/tm2Mzp1wE86PFCzJsLp8ocsCOFrvclQrhYXpGSYMFuMcvh5Hcl7VqAZ7Cc+
	 aAel++fm523ubqNQ3B13GH33fzD4tydNS3woLkLuvXHjYQZOMyzdhxXuIUKUPncqhV
	 jEz4pHOSNjWR5LYlJOIXMmDTz6bCNOkDdmNXm6L6UoD41wC0BB7xbs4KHFgJDtUXBX
	 BrizwHfnjtfM3m7rD3k+WrsSWsf7q4R62lOGrWaKZfCt/FLidHWkdme37WDtGhhQea
	 QtH7sXMOlNVFfbOCFD/KmB/t9CPXKKF5HkVv3RBlafVAfH9/2Ev3m+LGItkigT2Rv6
	 tSCasZnAe62EQ==
Received: from bpappas-XPS-13-9310.cfl.rr.com (050-088-208-203.res.spectrum.com [50.88.208.203])
	by mta-10.privateemail.com (Postfix) with ESMTPA;
	Fri, 12 Jan 2024 20:14:30 -0500 (EST)
From: Brent Pappas <bpappas@pappasbrent.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Brent Pappas <bpappas@pappasbrent.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mac80211: tx: Add __must_hold() annotation
Date: Fri, 12 Jan 2024 20:11:45 -0500
Message-ID: <20240113011145.10888-2-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Annotates ieee80211_set_beacon_cntdwn() with a __must_hold() annotation to
make it clear that ieee80211_set_beacon_cntdwn() is only intended to be
called when the caller has a lock on the argument "link."

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---

Currently, ieee80211_set_beacon_cntdwn() calls rcu_dereference(), but
without calling rcu_read_lock() beforehand and rcu_read_unlock()
afterward.  At first I thought this was a bug, since (if I understand the
RCU API correctly) rcu_dereference() should only be called in RCU
read-side critical sections. However, upon closer inspection of the code,
I realized that ieee80211_set_beacon_cntdwn() is only ever called inside
critical sections. Therefore it seems appropriate to me to annotate
ieee80211_set_beacon_cntdwn() with a __must_hold() annotation to make this
apparent precondition explicit.

This is my first time submitting an RCU-related patch so please tell me if
I am misunderstanding the RCU API.

 net/mac80211/tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 314998fdb1a5..7245f2e641ba 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -10,6 +10,7 @@
  * Transmit and frame generation functions.
  */
 
+#include "linux/compiler_types.h"
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/skbuff.h>
@@ -4974,6 +4975,7 @@ static int ieee80211_beacon_add_tim(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
 					struct beacon_data *beacon,
 					struct ieee80211_link_data *link)
+	__must_hold(link)
 {
 	u8 *beacon_data, count, max_count = 1;
 	struct probe_resp *resp;
-- 
2.43.0


