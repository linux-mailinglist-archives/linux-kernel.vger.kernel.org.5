Return-Path: <linux-kernel+bounces-15383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D1822B3C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8770EB22E94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6918B14;
	Wed,  3 Jan 2024 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4vF7p7q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD318AF6;
	Wed,  3 Jan 2024 10:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD08C433C7;
	Wed,  3 Jan 2024 10:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704277505;
	bh=5Rcik7t02gBhfvqwKpMZbmbnkEm1DrJkNCgPCnScgEk=;
	h=From:To:Cc:Subject:Date:From;
	b=U4vF7p7qcZWkkoYObZ9qmo2ktv6FBoq5E+Xg7MNFl/frEzm3aIqjASJ43SafT9eKK
	 5IpbXaxOjjl2lG+Id2vXcO69Qnn/0YAhjb84cjlPKoLCILW2XNFu2U1rcuOlq4dcoq
	 w43AbxgDl5V+UczWqL6v4oxgftsQLFHgtEkPerbGCx8S1X/6YinQsr/yZNRC4IEyKP
	 G0yuGTqTW1EMaW9hLA6taWKxbt8/XFwaRURbi2jLF1wbbmILn45J7uMQZtIl22ZHY6
	 JY0gphYd0AggEXOrhAG6CljcM7VTkiKGh7focQO0U3x1GUyvy21GwKiAa+j8JWLNYm
	 rMlwxDkzRsmkg==
From: Arnd Bergmann <arnd@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ice: fix building withouto XDP
Date: Wed,  3 Jan 2024 11:24:45 +0100
Message-Id: <20240103102458.3687963-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added function fails to build when struct xsk_cb_desc is
not defined:

drivers/net/ethernet/intel/ice/ice_base.c: In function 'ice_xsk_pool_fill_cb':
drivers/net/ethernet/intel/ice/ice_base.c:525:16: error: variable 'desc' has initializer but incomplete type

Hide this part in the same #ifdef that controls the structure definition.

Fixes: d68d707dcbbf ("ice: Support XDP hints in AF_XDP ZC mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 6e3694145f59..0d1aeb7ca108 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -521,6 +521,7 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 
 static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
 {
+#ifdef CONFIG_XDP_SOCKETS
 	void *ctx_ptr = &ring->pkt_ctx;
 	struct xsk_cb_desc desc = {};
 
@@ -530,6 +531,7 @@ static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
 		   sizeof(struct xdp_buff);
 	desc.bytes = sizeof(ctx_ptr);
 	xsk_pool_fill_cb(ring->xsk_pool, &desc);
+#endif
 }
 
 /**
-- 
2.39.2


