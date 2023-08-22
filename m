Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4FF7846EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbjHVQUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbjHVQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:20:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58397137
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:20:05 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D1C7836B0;
        Tue, 22 Aug 2023 18:18:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692721125;
        bh=H9tKJAtqfyF3Tg+LrApw0c7XP90L7b2wllmYTxOJ35w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ndqigfXnut1kEzuR/hcGMtal8PW1O0+gCoO2JCZrG8aUGdUb+qWy2CzWOeDtmtGWX
         gxVf/QzytMw0j0KXQ91XB7Fq2LIrIGJCXJwqYY7TjbuOPDzk9OT2d/XdZP5cPRIzY/
         DIkd5seolSSoC6tkaAJNMI8ufn5eVeGmQf3ztbWE=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Tue, 22 Aug 2023 19:19:35 +0300
Subject: [PATCH v3 02/12] drm/bridge: tc358768: Fix use of uninitialized
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-tc358768-v3-2-c82405dac0c1@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=965;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=H9tKJAtqfyF3Tg+LrApw0c7XP90L7b2wllmYTxOJ35w=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBk5OAr2Jb15icUZGZo0Hl9/ue+3pkcbi4HlgH7B
 Tmv48jgIBGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZOTgKwAKCRD6PaqMvJYe
 9V6VEACakcIJsHgJjcr2+GAA7F7X27NlUhZEIzY77K8qGEdkCdBckE7GllkTNo2qoXMhv80njGS
 5ZC/E7QxEAWWjZzfjJsg2cMgf1zIrXr8b6GAJlXxHpJjwQj/9KLA4hmEUqpAsctmMx0QOD/5P9j
 SZ2ozfGiZIRzQgESVtBgWWzye/kqVzW98RnMa1Ztyv9OeMo58xrAgzW0t8JW3sbFGdLI1n/x8l3
 dZ832wby6NrY/h7ZA/g1RlzlLFFT7yXScL3xz+009iOt2ehFi112/jdzoDkXalxhT5dymyhpSCM
 N1sRcex+HiZCtKBS7ghqspNj8u86YZdBQwUC2q6/DeXEFYBww834jOhZhUS9cW9vwzFj5ozpMpg
 mvUHe+y1DMiWcGDebJd77UksSQMUKtgjlZs7OxBH3a5pg0DXlFPW+lpdkVLZdDUFCJaXeHsI2ns
 fWs/YR39+1w/WvpyLhUShEcVoaRehtF3tzg1qvsXYnd662rUEl8LxzSeqNTQ5NRRHhXuG6fmvLE
 g0manHm5v8CKSo5I043WDOrS+JVxic5/ZBqes6zKmtcHMoTArvhT3Y2+2asbwnYKbEZISSQAVtH
 5qepUgw3uEPF5JVi4p1bbdlLby86b9PIfYSmS+bRb/VMLHJ04pguEpoGuI7jsdUD2PVc/bmHMBX
 lMfxCCmCfdYz0dw==
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

smatch reports:

drivers/gpu/drm/bridge/tc358768.c:223 tc358768_update_bits() error: uninitialized symbol 'orig'.

Fix this by bailing out from tc358768_update_bits() if the
tc358768_read() produces an error.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 819a4b6ec2a0..bc97a837955b 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -216,6 +216,10 @@ static void tc358768_update_bits(struct tc358768_priv *priv, u32 reg, u32 mask,
 	u32 tmp, orig;
 
 	tc358768_read(priv, reg, &orig);
+
+	if (priv->error)
+		return;
+
 	tmp = orig & ~mask;
 	tmp |= val & mask;
 	if (tmp != orig)

-- 
2.34.1

