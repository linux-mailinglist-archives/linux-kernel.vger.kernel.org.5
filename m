Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8520277E04B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244506AbjHPL0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244487AbjHPLZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:25:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFEC2121
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:25:50 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 29871D92;
        Wed, 16 Aug 2023 13:24:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692185075;
        bh=3BEyrzp4IUiLGe9w3xtacn7Yy6nvFBbT4HOk9yd56NA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PwyClJyGiTaBplHC3RSEylTjB+qWvimMlOWACblDqNfEWk1Joqc7n17EtCH5vj5WA
         uF/awlU+fQ1pVaZrPyJy03XgPZNMUyfiZlI5Hnf33maF7LM49qYS/ZKTXxujHM7i7B
         h98qiem4VwpLm5JUEGj+hhGykvYB3fapNWWhwudg=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 16 Aug 2023 14:25:05 +0300
Subject: [PATCH v2 02/12] drm/bridge: tc358768: Fix use of uninitialized
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230816-tc358768-v2-2-242b9d5f703a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=3BEyrzp4IUiLGe9w3xtacn7Yy6nvFBbT4HOk9yd56NA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBk3LI0/EHCNZvMIu3aVBbp1Z7MswxNqg10WZwwQ
 FOTnz2j426JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZNyyNAAKCRD6PaqMvJYe
 9So7D/0YzkazixpuRfx6fd/gk7EGJztOFzgzCcSqp3qnbeg4nYfTnHY9GOgLWumkR6aqGbbM9+n
 13LWMb4iJt8rQZ5wz+kH3HdvN6GuxbiB5sjvtzlcir+QMcZd8yfyIXq1jnv9F+X2O3V4WA754Z8
 OE8sDEhOUhUW0lhu++q8sB4YmiZmov+lXlXCdSvwSo5nfSHx8WUY09hYuGnCP76QXKBz0NUJSCi
 SrVVrAO4GUPcn1KhXXd96/iSHXmbiCFel5SYGiqu9eSvXSLpVnuCCwEyBW2WJfLPhWGQBVMYGUx
 klN2QcoSwnVPMXGwjYGyyY9aDSOkFMT+3k0OhuNEeWfRXsdgLG9eNqrYOvPFs2bZI3oHLLOxVA2
 zPHsORvsUUtntFuei9ifb48Eb24aXq3Q8KDKWGSE/tOud6CP+QxeXyRClTJ5cejo0fE/LkgIBPA
 e2TC2XQ2R5bkIO5fx2vqF+qyHtnCWPWCaxVjdSUEl+RYjJjUSBtnM9A7XEKUYBXKl2z7CUZd7jm
 VvAc17epEkb6m5Lb1b5+mgK73DYsBuJKPd3jTaex3Tr4+93IQUGWHUewZjU9mHFYGl6mscAsaOU
 OlA0GrzvCoxOeMxf9y3P1tXNpnaVwO0hX5HVY/8NH6a+yxrGqbMDGV39TNxn5t8m2G4uCiBpgKg
 rerq44LQJOBdJuw==
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

