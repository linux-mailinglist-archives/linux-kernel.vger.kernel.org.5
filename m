Return-Path: <linux-kernel+bounces-25341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBCA82CDF7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74ABE1C213A0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CAB5697;
	Sat, 13 Jan 2024 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pappasbrent.com header.i=@pappasbrent.com header.b="RYEqEo+S"
Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5B523D;
	Sat, 13 Jan 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pappasbrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pappasbrent.com
Received: from MTA-12-4.privateemail.com (mta-12-1.privateemail.com [198.54.122.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id EC46160636;
	Sat, 13 Jan 2024 17:29:33 +0000 (UTC)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
	by mta-12.privateemail.com (Postfix) with ESMTP id BD54518001B5;
	Sat, 13 Jan 2024 12:29:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
	s=default; t=1705166964;
	bh=xJhkIgx9nO8naQQ8a/I0VKfrFGYxd2LGCl8rS/IP/vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYEqEo+S0zGRoAnXvv9Vyg9mZu4AJI/Huv68zC6g05qFVvvhtbHXJk3HiBqWf/j92
	 0E/aFdTN0bAqaI0+Pno0tKI2um2t+EB2QYQEJpLJI1bHLxK02v6JHdg9pEo7XkUnRX
	 f5svPYcj7TFaGU2YbwPeQegRqAwYooroj0WZJfr9SIjWP73+QcRs+cn4FrRHx/IxXD
	 HCuclvLT3VI6WiOH4GOkifb9zg5eyUAZj+yNAuBiovZgOytCiUptq7Msg4afWtLuP6
	 cpMRP+PGqKiWFt8Z+2n2hsUcDEOjD8v9dDZl53Q4dA0of+diHUTCmdz332L8R26YS+
	 kRQxSx9u/X3Fw==
Received: from bpappas-XPS-13-9310.cfl.rr.com (050-088-208-203.res.spectrum.com [50.88.208.203])
	by mta-12.privateemail.com (Postfix) with ESMTPA;
	Sat, 13 Jan 2024 12:29:13 -0500 (EST)
From: Brent Pappas <bpappas@pappasbrent.com>
To: bpappas@pappasbrent.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH v2] wifi: mac80211: tx: Add __must_hold() annotation
Date: Sat, 13 Jan 2024 12:27:21 -0500
Message-ID: <20240113172719.40364-3-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113011145.10888-2-bpappas@pappasbrent.com>
References: <20240113011145.10888-2-bpappas@pappasbrent.com>
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
Changelog:
v1 -> v2: Include linux/compiler_types.h with angle brackets instead of
          quotes.

 net/mac80211/tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 314998fdb1a5..ca7adace6a9c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -10,6 +10,7 @@
  * Transmit and frame generation functions.
  */
 
+#include <linux/compiler_types.h>
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


