Return-Path: <linux-kernel+bounces-120077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E0988D144
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D942322444
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDA113E6CA;
	Tue, 26 Mar 2024 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUkPCOXw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91F13DDD1;
	Tue, 26 Mar 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492762; cv=none; b=FHYj4h6/i7WOKhArQy1D46faoc1vXg3BxSAx5GvAM31JKBbJ1SACpnt0aS8Wwt1y+HzHPkW56tP+jd46u4jAuK92twUGC05p8UwCdZW2mRIn8CtLeJf8x0U+SV+d0tB7Gw/TSvgq9iFWza2KJ6vdsX+9k87o2SpP3X24Wi1GTZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492762; c=relaxed/simple;
	bh=KeyNCZskP6/b1M7OoexAF78T4p7x0+NMkepYQTejfAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+DwFPLz8/N/YbHpK7GsSotFK8aBeH+dVlGB+obaKAnxo0BsCwM/gtcRrHgtaT55Sx9YI6BCjoQ9m8HAvbBg/aFDCwAg6nz/Nq4aqhkOrEgqdnDGSDLrzwt0Q1gDQEoucaT6rET96eVnCmOMsgLvVjiYxVyP+Mn2aLogv8FfmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUkPCOXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FCCC433F1;
	Tue, 26 Mar 2024 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711492762;
	bh=KeyNCZskP6/b1M7OoexAF78T4p7x0+NMkepYQTejfAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUkPCOXw+m5dqLk95Et2hTWpRql228gXeu8f+g16q/hj+saAwDtlMyNW4nQsKg0uX
	 uETZmJRUz04kFjXnWd6W6R71BSc8mkPb2IheQs1CmSdeBBbbe/n4vD2rj0QdFMLbat
	 8nrxaQORCAEzyEdi/qJkvRTjb+nalTS/yJYn0BT+m23og1RLtxP67iJ/eq8Jmk3drz
	 hpl+H88S0+HhCx/NRHckYmvJ5ja+NMBvGik3LgZ30BQlsrYIjOym+Ve1NWmGxISm6H
	 kyZfezpARfHQ7tCCQuFrkZIT0abEeJqADaFJswMq3U8ES5bVtnnp4K4tH2fYoGBMI2
	 oUYIkuTMnNyMw==
From: Arnd Bergmann <arnd@kernel.org>
To: llvm@lists.linux.dev,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Simon Horman <horms@kernel.org>,
	Ferenc Fejes <fejes@inf.elte.hu>,
	Wei Fang <wei.fang@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/9] enetc: avoid truncating error message
Date: Tue, 26 Mar 2024 23:38:01 +0100
Message-Id: <20240326223825.4084412-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223825.4084412-1-arnd@kernel.org>
References: <20240326223825.4084412-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

As clang points out, the error message in enetc_setup_xdp_prog()
still does not fit in the buffer and will be truncated:

drivers/net/ethernet/freescale/enetc/enetc.c:2771:3: error: 'snprintf' will always be truncated; specified size is 80, but format string expands to at least 87 [-Werror,-Wformat-truncation]

Replace it with an even shorter message that should fit.

Fixes: f968c56417f0 ("net: enetc: shorten enetc_setup_xdp_prog() error message to fit NETLINK_MAX_FMTMSG_LEN")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 9f07f4947b63..5c45f42232d3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2769,7 +2769,7 @@ static int enetc_setup_xdp_prog(struct net_device *ndev, struct bpf_prog *prog,
 	if (priv->min_num_stack_tx_queues + num_xdp_tx_queues >
 	    priv->num_tx_rings) {
 		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "Reserving %d XDP TXQs does not leave a minimum of %d for stack (total %d)",
+				       "Reserving %d XDP TXQs leaves under %d for stack (total %d)",
 				       num_xdp_tx_queues,
 				       priv->min_num_stack_tx_queues,
 				       priv->num_tx_rings);
-- 
2.39.2


