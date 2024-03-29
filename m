Return-Path: <linux-kernel+bounces-125199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B593892209
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD481C261CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D8B13342F;
	Fri, 29 Mar 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHtrv7L/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057051C2B;
	Fri, 29 Mar 2024 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731643; cv=none; b=WtDxgVLfOlcltNACgaAjFO20f7Uk+MQU7DMnOcB9JowgeTabG2szhb9LSp5E8plHqCzPMNZ2u3tIRqBAg2YPFJQFnQNJ6MdM9nuuqrYEGloZmWl3GW7IMfDj3F42/SOzdq/Hx9szx9JyrpL2gzBt/o3fsK/mI48BW9u8nOKK+Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731643; c=relaxed/simple;
	bh=09E6RhJfzgrPJs9dxwPQdzyvQDacD3o1uN6PDWnf09s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cekVqdwMELNWTqIqlOATfwCv8vQv7Z8vJpXgLvWaivtsfBJ4AUf6M3GIMK5IN2pygDHf5z1MBI3qNU1Grat2gq4hpYRYRJet3QSINvxWmIdBIyzijmFylo9QQqOiVF+QtbzgUfB3iUWlWj7ehZbftomLIhVNVScibsXFSiow5dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHtrv7L/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711731642; x=1743267642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=09E6RhJfzgrPJs9dxwPQdzyvQDacD3o1uN6PDWnf09s=;
  b=VHtrv7L/vonTX5122jTmmK0nJPbiMbTEInLRLSjZAjx34gkR031uCIQa
   Pm7eUpdiDzWkC7iMJHqXd0Xz+vQywVoNYes8QFLaXSO5KwEFkqZwkQWdu
   6svQ2cQwy5K08d9v0TzSFsz+hthhaxdSnueju1XmjkVbqeessiY/F+3Wc
   yOPvQIPUhm2Ybvk8x5YXXoYNcB3kIxvnyXnLbljCFDVbesOR9AbomS4OQ
   j+7CyeuePkUhi1xdSyp7FHCb9XV7o7O5DwdxNrI4sfyPDhiPZvUG7nxmD
   5RiMvT/tC/6w1jj5rWD1fkd9riDEbt+JG78vAW2EetphX68VQDVBtWml/
   g==;
X-CSE-ConnectionGUID: yv8opZAmT9eFVgj3LSf7Tg==
X-CSE-MsgGUID: pX02Ws5gQKavC02eARb03Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="18367606"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="18367606"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 10:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="48231976"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa001.fm.intel.com with ESMTP; 29 Mar 2024 10:00:39 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net/tcp: fix -Wshadow / Sparse shadow warnings in tcp_hash_fail()
Date: Fri, 29 Mar 2024 17:59:59 +0100
Message-ID: <20240329170000.3241460-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following spam coming from <net/tcp_ao.h> when building with
W=12 and/or C=1:

Clang:

In file included from drivers/net/ethernet/intel/idpf/idpf_txrx.c:4:
In file included from drivers/net/ethernet/intel/idpf/idpf.h:24:
In file included from drivers/net/ethernet/intel/idpf/idpf_txrx.h:8:
/include/net/tcp.h:2812:3: warning: declaration shadows a local variable [-Wshadow]
 2812 |                 tcp_hash_fail("TCP segment has incorrect auth options set",
      |                 ^
/include/net/tcp_ao.h:153:23: note: expanded from macro 'tcp_hash_fail'
  153 |         const struct tcphdr *th = tcp_hdr(skb);                         \
      |                              ^
/include/net/tcp.h:2805:23: note: previous declaration is here
 2805 |         const struct tcphdr *th = tcp_hdr(skb);
      |                              ^
/include/net/tcp.h:2820:4: warning: declaration shadows a local variable [-Wshadow]
 2820 |                         tcp_hash_fail("TCP connection can't start/end using TCP-AO",
      |                         ^
/include/net/tcp_ao.h:153:23: note: expanded from macro 'tcp_hash_fail'
  153 |         const struct tcphdr *th = tcp_hdr(skb);                         \
      |                              ^
/include/net/tcp.h:2805:23: note: previous declaration is here
 2805 |         const struct tcphdr *th = tcp_hdr(skb);
      |                              ^
/include/net/tcp.h:2840:4: warning: declaration shadows a local variable [-Wshadow]
 2840 |                         tcp_hash_fail("AO hash is required, but not found",
      |                         ^
/include/net/tcp_ao.h:153:23: note: expanded from macro 'tcp_hash_fail'
  153 |         const struct tcphdr *th = tcp_hdr(skb);                         \
      |                              ^
/include/net/tcp.h:2805:23: note: previous declaration is here
 2805 |         const struct tcphdr *th = tcp_hdr(skb);
      |                              ^
/include/net/tcp.h:2846:4: warning: declaration shadows a local variable [-Wshadow]

Sparse:

drivers/net/ethernet/intel/idpf/idpf_main.c: note: in included file (through drivers/net/ethernet/intel/idpf/idpf_txrx.h, drivers/net/ethernet/intel/idpf/idpf.h):
/include/net/tcp.h:2812:17: warning: symbol 'th' shadows an earlier one
/include/net/tcp.h:2805:29: originally declared here
/include/net/tcp.h:2820:25: warning: symbol 'th' shadows an earlier one
/include/net/tcp.h:2805:29: originally declared here
/include/net/tcp.h:2840:25: warning: symbol 'th' shadows an earlier one
/include/net/tcp.h:2805:29: originally declared here
/include/net/tcp.h:2846:25: warning: symbol 'th' shadows an earlier one
/include/net/tcp.h:2805:29: originally declared here

Just use __UNIQUE_ID() for the variables declared inside
tcp_hash_fail().

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/tcp_ao.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 471e177362b4..c5303c9c6f80 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -148,7 +148,7 @@ static inline bool tcp_hash_should_produce_warnings(void)
 	return static_branch_tcp_md5() || static_branch_tcp_ao();
 }
 
-#define tcp_hash_fail(msg, family, skb, fmt, ...)			\
+#define _tcp_hash_fail(msg, family, skb, th, hdr_flags, f, fmt, ...)	\
 do {									\
 	const struct tcphdr *th = tcp_hdr(skb);				\
 	char hdr_flags[6];						\
@@ -179,6 +179,10 @@ do {									\
 				hdr_flags, ##__VA_ARGS__);		\
 	}								\
 } while (0)
+#define tcp_hash_fail(msg, family, skb, fmt, ...)			\
+	_tcp_hash_fail(msg, family, skb, __UNIQUE_ID(th_),		\
+		       __UNIQUE_ID(hdr_flags_), __UNIQUE_ID(f_), fmt,	\
+		       ##__VA_ARGS__)
 
 #ifdef CONFIG_TCP_AO
 /* TCP-AO structures and functions */
-- 
2.44.0


