Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E6A7935B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbjIFGwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjIFGwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:52:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007D91984
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:51:46 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E93F82CC7;
        Wed,  6 Sep 2023 08:50:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693983011;
        bh=XUpZ1sa4som54e3a4sbbBeu8u2QabPMAMN6dfT5AT9Q=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=BGQn5qGzaozeMIAWlDJ31LmqJE7w/8vRm57u6nZoDD2t1r23r3S/uOcGeaGozYYTS
         HmmPvoTL1CCmN4oqiONiRqreE7+chBET+5+ii0pL/7ji5c7EkBVYdZogvLubF4wcmo
         D2rZiDIevHB3V3ZmZEZELws3HbrqsMxBxbUUMYw8=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 06 Sep 2023 09:50:58 +0300
Subject: [PATCH v4 11/12] drm/bridge: tc358768: Fix tc358768_ns_to_cnt()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-tc358768-v4-11-31725f008a50@ideasonboard.com>
References: <20230906-tc358768-v4-0-31725f008a50@ideasonboard.com>
In-Reply-To: <20230906-tc358768-v4-0-31725f008a50@ideasonboard.com>
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
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=XUpZ1sa4som54e3a4sbbBeu8u2QabPMAMN6dfT5AT9Q=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBk+CFrGphoZYtbzABk2wlF1m3cpxJ82q2nsnlbt
 5i/2HJ2+YGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZPghawAKCRD6PaqMvJYe
 9WZzEACNP9evo+i3NNY0kbRgECfMObxK0+VBI90Xp1PP7KT8Zg6MMA/yJaWCVkrhdl/UJ76eh4X
 aVL20gw2dxRN1QAPp2zSIwmKYd39PjguaLKWeHq4dy0k5t3/3pmflSb0bTu9Gx07wwGYw2DcHhK
 yQU8v6+0FJGMWzJ3eDaWxywF0kJcjeje+3ELw7zQnVgEBm+Nkv4crTofpq1WiNXo3gb3UvBPNAo
 Te5vhINcPMDyXHVM9x/SvpFbvg6179C7t/UPobzzMSAzV7YFqZ9TdSSVzaYR1JDYtrtOzqOJkPZ
 P/Y7iXkis9TNtbm8dXFji0ODzJ6ysdA0qlYXuSUW4OM2ZEj/Xw8cgEUw6TKTX12vj9g4gQdVZMu
 6KN2Etu9KkEBX9Xo7ZN6P48lhKwALNXXH994eoHv9npO7Yp1K7nuedhloBMX7oq68aXg7YRE4kl
 KocmuRcHlWLmmiY18kx146/fqNgWO3DeaHI5d1e95EQFF0dBnQy045wSgrWuINBCswthl3yFAhU
 YZCpSq2hTHTu7R3uVGgjzuxMgBhhuJYH8uNCzOO5x9KS+lwG2TnHqKL9b8qurqjdfSWlrfqChU3
 rYB09T+p64Gi8YmfptksPB0ngD64EB6N1G9ZCBaNZSBiaI0iuTMRb8tafAMP50exYvFPPrgvsRf
 1hUuat8VnMo/pgw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
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

