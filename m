Return-Path: <linux-kernel+bounces-146906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E668A6CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2E81F22AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ABA12C534;
	Tue, 16 Apr 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="VxsK6mtR"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC82B12882C;
	Tue, 16 Apr 2024 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713275121; cv=none; b=IrWTrbzlv8N3jzYhYFQBCPuqtw4lyvHLL6WlPqiB/bkWFM/cxKe6S8+vP7pasI5F5ZCytRsMRRAi0gCUw0SdHKe97xTeGMsZAZ0MDybv63OuVBMINy2DkjWMnlEseArBEwxw2/w9kNLBwRmM4xQEfGc2c8LQ/kl0jRKp4++JE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713275121; c=relaxed/simple;
	bh=1njBmj21axg5qMv0sjG4Y7pWXG32zd3JS58XEjmtqTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ugtVi1Zun8owylrxZ/aSxsPAnsVC+DC06lX1x890dQtJhq+HmZ6lwHbDtSJA+/Oi1qxPfULRXAODQJG4x503l7brVTInoHn/6bpsx6zwwQXU+4HXuE+fKA1uUKUIjFq/IMEN2gJKELEQUo+It1o0m2cTzaranrdXmCx3TX6qBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=VxsK6mtR; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 93B29600A2;
	Tue, 16 Apr 2024 13:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713275109;
	bh=1njBmj21axg5qMv0sjG4Y7pWXG32zd3JS58XEjmtqTA=;
	h=From:To:Cc:Subject:Date:From;
	b=VxsK6mtR5nYx82A1Aaebbuub5HopqNfqb24FUXato8zwwsjwqwq4xDYchY78Gtk/F
	 4VU4Lvte7w35Fr09iXusp8O4wHuMAJmkCoOyB83ahV+E5FYxlUTLQSmsxnxdXFOysH
	 E0zqwILhKJMM5QX8cm3u9FjXmwCFUsopLtRHiMmoo5mcCSoe7ns4m8u4QtnZgOfxR/
	 tKdYafOmTTxNy7gEDO/hvssyBd2scEGfBjqjf3l/qNkBb2URa/5P71SlkG9uaWPA5j
	 13ihdYrKGuP1OcEUfcfgzCxCaMMnT1AOIZsNnZxVuy+5soxE4WeYK7JwskKc6Q+NSp
	 7sI3lGT3dBWWQ==
Received: by x201s (Postfix, from userid 1000)
	id 398E4202498; Tue, 16 Apr 2024 13:44:53 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	linux-net-drivers@amd.com
Subject: [PATCH net-next] sfc: use flow_rule_no_unsupp_control_flags()
Date: Tue, 16 Apr 2024 13:44:30 +0000
Message-ID: <20240416134432.9527-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adopt nfp-style *_FLOWER_SUPPORTED_CTLFLAGS define.

Change the check for unsupported control flags, to use the new helper
flow_rule_is_supp_control_flags().

Since the helper was based on sfc, then nothing really changes.

Compile-tested, and compiled objects are identical.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/sfc/tc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 82e8891a619a..5f73f1dea524 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -21,6 +21,10 @@
 #include "ef100_rep.h"
 #include "efx.h"
 
+#define SFC_FLOWER_SUPPORTED_CTLFLAGS \
+	(FLOW_DIS_IS_FRAGMENT | \
+	 FLOW_DIS_FIRST_FRAG)
+
 enum efx_encap_type efx_tc_indr_netdev_type(struct net_device *net_dev)
 {
 	if (netif_is_vxlan(net_dev))
@@ -273,11 +277,9 @@ static int efx_tc_flower_parse_match(struct efx_nic *efx,
 			match->value.ip_firstfrag = fm.key->flags & FLOW_DIS_FIRST_FRAG;
 			match->mask.ip_firstfrag = true;
 		}
-		if (fm.mask->flags & ~(FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG)) {
-			NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported match on control.flags %#x",
-					       fm.mask->flags);
+		if (!flow_rule_is_supp_control_flags(SFC_FLOWER_SUPPORTED_CTLFLAGS,
+						     fm.mask->flags, extack))
 			return -EOPNOTSUPP;
-		}
 	}
 	if (dissector->used_keys &
 	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
-- 
2.43.0


