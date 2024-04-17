Return-Path: <linux-kernel+bounces-148652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0944D8A858F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B449B1F22DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6E01411DA;
	Wed, 17 Apr 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="orbQPSri"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE813D24A;
	Wed, 17 Apr 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362844; cv=none; b=ZvZoSzdo2BRRbwfzQkFt06TicnQPm4mr8GoElJGixcMGYuOGB5TLXaLP9RowQhmV+3ITRunzaVuo01bnd6tISfNnPdtCrSCul31HxIA0avVZwQA2WchAeMiK/alQVXjeZJJqhclCG/EUd8SpGWQcemzriG8eWGUToqmxiLxFNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362844; c=relaxed/simple;
	bh=Wvftcg4E/BXWRBvcVc6jRpJ+isZyObnfz/ePdTUQ0rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CDcvZ/Fg2vOlSbkulOlycsSy+6E3xQAflQ7bmO2K66/XZYtc+olgpiEC+p7dvZxEmrGy/Xh3vctDdRC2u4PL5V9vUJGgW32+rlK7gGAe9m7K4O+GrPSsGchq3H9ht3VTLZsI9afd0ZQLXi9P+FCI+rp6vxOMK4R/A4LRAzfPNrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=orbQPSri; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 72950600A2;
	Wed, 17 Apr 2024 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713362838;
	bh=Wvftcg4E/BXWRBvcVc6jRpJ+isZyObnfz/ePdTUQ0rA=;
	h=From:To:Cc:Subject:Date:From;
	b=orbQPSriuL4I8xbfWu3Ag0bwjOUYdnoRiS0jcIYjAUgU6vhRI/DtwTOv6bznA3JoE
	 WX/uywIukJHfNlF+ysqwFP6QYDEQXvKOYrddA2h5vhsKTzG94HGGD+rmL6bEpijSLx
	 rDOh5vozxT4SvdIAs3/i4tbdawvWjRcFKRtTK1jTCnmFSaj6f9TSxmXxRyV/ApErao
	 a49cex7jtjkYfmdoCszL0TzIcNBud+uP92mhgrUjiPKbIIj/PEOpW5inY7wqcHzgeK
	 usjLMsSaZQLuqLJ9GVclaDt5Lrxdvm5PmHeMio/2ZbT49//fzhzMLeE7+g9u9kJIwy
	 4KUEzmemDCK6A==
Received: by x201s (Postfix, from userid 1000)
	id 5C3FD203AC4; Wed, 17 Apr 2024 14:07:14 +0000 (UTC)
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
Subject: [PATCH net-next v2] sfc: use flow_rule_is_supp_control_flags()
Date: Wed, 17 Apr 2024 14:07:10 +0000
Message-ID: <20240417140712.100905-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Change the check for unsupported control flags, to use the new helper
flow_rule_is_supp_control_flags().

Since the helper was based on sfc, then nothing really changes.

Compile-tested, and compiled objects are identical.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---

Changelog:

v2:
- fix subject (noticed by Ed)
- remove #define (requested by Ed)

v1: https://lore.kernel.org/netdev/20240416134432.9527-1-ast@fiberby.net/

 drivers/net/ethernet/sfc/tc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 82e8891a619a..9d140203e273 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -273,11 +273,10 @@ static int efx_tc_flower_parse_match(struct efx_nic *efx,
 			match->value.ip_firstfrag = fm.key->flags & FLOW_DIS_FIRST_FRAG;
 			match->mask.ip_firstfrag = true;
 		}
-		if (fm.mask->flags & ~(FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG)) {
-			NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported match on control.flags %#x",
-					       fm.mask->flags);
+		if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT |
+						     FLOW_DIS_FIRST_FRAG,
+						     fm.mask->flags, extack))
 			return -EOPNOTSUPP;
-		}
 	}
 	if (dissector->used_keys &
 	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |
-- 
2.43.0


