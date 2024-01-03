Return-Path: <linux-kernel+bounces-15381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752E4822B36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BB4285003
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC4118B0D;
	Wed,  3 Jan 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmIdK5rP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D5818AF0;
	Wed,  3 Jan 2024 10:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FB1C433C8;
	Wed,  3 Jan 2024 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704277425;
	bh=z0qY/gX0M8RB0LK5KbRuBi5q9cGMDpSG9tSCAaQIxfw=;
	h=From:To:Cc:Subject:Date:From;
	b=XmIdK5rPNDInU6AUMdojnCYK4XltdzDK2PAy+WwMqmO2Ow9WN1A4nLGeX53uW9Vmp
	 +VSdfmqMquJZSS5SS1F3DqS6PbzIwI2F9inEiSZDUqLfgQBP3DIlTuE8sdxSjMKuAP
	 gx+iMiwjsgmrVX46ouGskrTDRkxN1vFUuq+7v2JmlgJ0+NEzeVa0iv2F1rGkyydYgE
	 VnBxPgVoizXiy3Uk1WLXJrod5GESjpxfyrOdVTwRUrV6jrbCGMPH5EQcdz7qXIQxrq
	 U7HOAzMOYJJJtsSNZfW8o1JpqRwLNjvKCBh5NKmAYToxxwHl9MvWk5GsM0R1psTsMZ
	 /rUzbv7/5VrCQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Randy Schacher <stuart.schacher@broadcom.com>,
	Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bnxt: fix building without CONFIG_RFS_ACCEL
Date: Wed,  3 Jan 2024 11:23:11 +0100
Message-Id: <20240103102332.3642417-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A recent patch series generalized the filter logic in bnxt to no
longer just be used for RFS, but it now fails to build when RFS_ACCEL
is disabled:

drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_cfg_ntp_filters':
drivers/net/ethernet/broadcom/bnxt/bnxt.c:14077:37: error: implicit declaration of function 'rps_may_expire_flow' [-Werror=implicit-function-declaration]
14077 |                                 if (rps_may_expire_flow(bp->dev, fltr->base.rxq,
      |                                     ^~~~~~~~~~~~~~~~~~~

Add back one #ifdef check around a call to the missing rps_may_expire_flow()
function.

Fixes: 59cde76f33fa ("bnxt_en: Refactor filter insertion logic in bnxt_rx_flow_steer().")
Cc: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I don't know if this is a correct fix, only checked that it is plausible
and that it does address the build failure. If a different fix is needed,
please just treat this as a bug report.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 827821e89c40..83a97c65b728 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14074,6 +14074,7 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 			if (test_bit(BNXT_FLTR_VALID, &fltr->base.state)) {
 				if (fltr->base.flags & BNXT_ACT_NO_AGING)
 					continue;
+#if IS_ENABLED(CONFIG_RFS_ACCEL)
 				if (rps_may_expire_flow(bp->dev, fltr->base.rxq,
 							fltr->flow_id,
 							fltr->base.sw_id)) {
@@ -14081,6 +14082,7 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 									 fltr);
 					del = true;
 				}
+#endif
 			} else {
 				rc = bnxt_hwrm_cfa_ntuple_filter_alloc(bp,
 								       fltr);
-- 
2.39.2


