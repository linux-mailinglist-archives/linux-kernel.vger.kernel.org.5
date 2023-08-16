Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C12B77E052
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244600AbjHPL0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244564AbjHPL0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:26:07 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA56D26A1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:26:03 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2F570D92;
        Wed, 16 Aug 2023 13:24:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692185084;
        bh=V/DMo8p5jJ8+UtiQ3KTL91bfgqjlzonLkdA5+0U3ogc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ERltfdu2eBnpmL/LBoit72Hru9VBNcX47Lo1zx1ccPyZft0YP2LkbhIZoxpkIGHGL
         52JVyDtKk44gkv4B5lUjvFx+/XAqKVzc3mV1CGvgrflZoEvjsal7ZuWilrYnbSFuk/
         mOnEUvjXYdp6U+I4DZPS+KJLH4TuLmLtd1sf7aIw=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 16 Aug 2023 14:25:13 +0300
Subject: [PATCH v2 10/12] drm/bridge: tc358768: Fix tc358768_ns_to_cnt()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230816-tc358768-v2-10-242b9d5f703a@ideasonboard.com>
References: <20230816-tc358768-v2-0-242b9d5f703a@ideasonboard.com>
In-Reply-To: <20230816-tc358768-v2-0-242b9d5f703a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=900;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=V/DMo8p5jJ8+UtiQ3KTL91bfgqjlzonLkdA5+0U3ogc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBk3LI3zCHuO6AmxVhkUJGJFXofoGAsxytMXWp9P
 arfgWl12GmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZNyyNwAKCRD6PaqMvJYe
 9VYjD/4sMcfAdNbGdhnKHr0OSe9t2N96tQd5xl7nJ0/QhduZXNKyXr9fYrJnhA9+JuR/jeD5TGq
 TLYSxH1CURmXkIDIGDhrNALFcyei8Ypd6rWd9Mty80vwbH/L7Bny3JwHa3mjv0yJN1EI0Sel3hC
 lGD2h2VBQeKo2NaKIHChPAbzNcIyomW+SYkm4jn+k/tlGj84dyDXyy1TcuhVPsjAs2pGm1bGzvv
 xrYyBeIl5z2QC2H+q9lDhmSCvWJauztkfhWJlka6N3mSD+DtxAcNfX62oSv8iB0TUWw7l2dlSwG
 0PiWHGzm8UklqQbo15R4VAxAm6uSod8lFxjgrGH6rp3Ws483IbIkr2jz0jujvL3TCm+kK4ru+Fn
 Hff2AmoObx6kKWqs1uyHlALGi/YOB63BnNMRI+askPFSVwIY9U2HmE+rZWbMvedT54SY23o8ZS6
 Wup76E1AWdcRi6C1eQ4V2cR8inFSYdtAL8l8KRhzwcg4l6t2X6LSRIN8/K3xriSEq56WQOJyvfI
 aJN3xZ1qFstbMahyQ4syXdWVvz+y52MX0OyEGvaURaJ+I4fe8DSYf4v3ZFU9WSZvON0o+hjEImB
 UPjJB2Ffno+wV2zggrgnXSau4ymuaMHVkR9PwEoFMg/DLQb0F91qDUfe8AF1DVadu7GGaPeQW7M
 oMVpAHeEAeqpyuQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tc358768_ns_to_cnt() is, most likely, supposed to do a div-round-up
operation, but it misses subtracting one from the dividend.

Fix this by just using DIV_ROUND_UP().

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 9411b0fb471e..dc2241c18dde 100644
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

