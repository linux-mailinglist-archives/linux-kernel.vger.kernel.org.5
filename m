Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EBD7846FE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbjHVQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbjHVQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:20:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004FE61
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:20:16 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0181187F4;
        Tue, 22 Aug 2023 18:18:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692721135;
        bh=LO6DVrF7Wy//586q71JqmvhJ6yqjCtp6tNE4HEdX3hc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=CQNJQdUewY94WUFp9YPll+PZlDY1phdM4tVllfLf9tWDLtfljBMn7CgXk95lIJeMJ
         VqFB/z4vpcxTbOBRpsaIfxiBFu2iqUrU2RohOpTOegdhKeCDlTBxtnWf7drjLPMgKh
         jMK9q0I4Spa4gups2zh4fGRoadXnLpbgVtQg6SEI=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Tue, 22 Aug 2023 19:19:44 +0300
Subject: [PATCH v3 11/12] drm/bridge: tc358768: Fix tc358768_ns_to_cnt()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-tc358768-v3-11-c82405dac0c1@ideasonboard.com>
References: <20230822-tc358768-v3-0-c82405dac0c1@ideasonboard.com>
In-Reply-To: <20230822-tc358768-v3-0-c82405dac0c1@ideasonboard.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=956;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=LO6DVrF7Wy//586q71JqmvhJ6yqjCtp6tNE4HEdX3hc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBk5OAuWjKWskwExcfKQDmgn/U8rq857fNH5jATm
 ZR/kqZaJDiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZOTgLgAKCRD6PaqMvJYe
 9ZwAEACr5jOQagaCCvcZpT8sfneYHY7YPSelKldZoR04bQCAK7S5k5aa3SpTIQ/EeTBc53dOjkq
 ewlV4E2veNj+RKf5HA8f243swDg9tdU4WBj60XglDh1JCKwEgkaWDSYzgZnKtXuH2pz9MGv5oKd
 VbBaBkEiU3f+AxL+tLLHS5fifFJIJ08ZMSjhLuo82pQYJ9BSOGQPzmDFLkW3kQUgE38rgrHh3mw
 jEAKEqSbd6c5EejvSEq7ynzJDVB0I4i6iJtiIJuXdVh7uIBwqRdtvRXrpRRHIza2Kg/LRRCwGV4
 /OB8+3sRs1HaQzT1o75L+Zro0IJlJBlkDNgJ2DZAkISO1Yfk+83vFod1nhDow5Nmvg7L+rW9fqN
 RVImT2DTJb9H297Xf9TFVrg96UWwUd9pI2OTsc0xnDo5lNYV45Nq5w6KOacgvfT9v42Zf9c9oC1
 mglS612hxEXQg1q3ES2jiwHWpPVp8EaP0qLSryjMKhaVD18dsClBh779ZCG2jNbrx6wakpfHLf4
 4DEl1eRGAFULetw0heN5UGHyiw+6J+CGbCQVtX+T6xQHNO0DFSaovXA4twlKXtHdHVHzQ8YVTEG
 u6xJOQtqgQO/cjNe8MDQQaRt0A2hMoooMU9wqyd4I3OOf2U94/WccXaKBsFzr3SriP+GMOdsiNj
 LimPFRnaGpghTFQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tc358768_ns_to_cnt() is, most likely, supposed to do a div-round-up
operation, but it misses subtracting one from the dividend.

Fix this by just using DIV_ROUND_UP().

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 9ce8d120b50c..f41bf56b7d6b 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -630,7 +630,7 @@ static int tc358768_setup_pll(struct tc358768_priv *priv,
 
 static u32 tc358768_ns_to_cnt(u32 ns, u32 period_ps)
 {
-	return (ns * 1000 + period_ps) / period_ps;
+	return DIV_ROUND_UP(ns * 1000, period_ps);
 }
 
 static u32 tc358768_ps_to_ns(u32 ps)

-- 
2.34.1

