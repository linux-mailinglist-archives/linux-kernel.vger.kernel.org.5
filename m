Return-Path: <linux-kernel+bounces-4127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6202681782B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3877B22177
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3D5D721;
	Mon, 18 Dec 2023 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TMpb5mc+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16654FF77;
	Mon, 18 Dec 2023 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1702919221;
	bh=aHRCn+impFKpkz3R6slruxku9ubynUSdSVmN2XdopGU=;
	h=From:Date:Subject:To:Cc:From;
	b=TMpb5mc++cVz83CXQUzt/w20r0GR356w6FBMxJCqi1R2OqBe50lMa/MTnCuwLlf6l
	 dOCR9R+2pswnDKobINUcHLN0N5dUS2YfIqy7pCudNGPS+M9AC3ivsnl5FjAg6yOnYv
	 7i3/voOUAgpNyZpov1W0fSqC1VFGwY3zAuI/c0sY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 18 Dec 2023 18:06:54 +0100
Subject: [PATCH] net: avoid build bug in skb extension length calculation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231218-net-skbuff-build-bug-v1-1-eefc2fb0a7d3@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAC18gGUC/x2MQQ5AMBAAvyJ7tkm3BPEVcSjdsiElLSIRf9e4T
 DKHmQciB+EIbfZA4EuibD4J5RmMs/ETo9jkoJUuSFODng+My3A6h8Mpq02csDT1SKQKq0wFKd0
 DO7n/bde/7wdmq+p9ZgAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702919221; l=1738;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=aHRCn+impFKpkz3R6slruxku9ubynUSdSVmN2XdopGU=;
 b=8ZU5O5/paR5Az8f4liBJ3H5k/b9Dd8zA3pXbvncKPTvN2Snat6rn1hiDCfIxloWRkq6El6NOh
 bTG8D9oQFi2Dzs5M/9HOpMIxXZU14cnrghEF33prcqTruGrwICZVITO
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

GCC seems to incorrectly fail to evaluate skb_ext_total_length() at
compile time under certain conditions.

The issue even occurs if all values in skb_ext_type_len[] are "0",
ruling out the possibility of an actual overflow.

As the patch has been in mainline since v6.6 without triggering the
problem it seems to be a very uncommon occurrence.

As the issue only occurs when -fno-tree-loop-im is specified as part of
CFLAGS_GCOV, disable the BUILD_BUG_ON() only when building with coverage
reporting enabled.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312171924.4FozI5FG-lkp@intel.com/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/lkml/487cfd35-fe68-416f-9bfd-6bb417f98304@app.fastmail.com/
Fixes: 5d21d0a65b57 ("net: generalize calculation of skb extensions length")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/core/skbuff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83af8aaeb893..94cc40a6f797 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4825,7 +4825,9 @@ static __always_inline unsigned int skb_ext_total_length(void)
 static void skb_extensions_init(void)
 {
 	BUILD_BUG_ON(SKB_EXT_NUM >= 8);
+#if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
 	BUILD_BUG_ON(skb_ext_total_length() > 255);
+#endif
 
 	skbuff_ext_cache = kmem_cache_create("skbuff_ext_cache",
 					     SKB_EXT_ALIGN_VALUE * skb_ext_total_length(),

---
base-commit: ceb6a6f023fd3e8b07761ed900352ef574010bcb
change-id: 20231218-net-skbuff-build-bug-4a7c1103d0a6

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


