Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD79A7A4A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 15:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbjIRNBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 09:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbjIRNAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 09:00:48 -0400
Received: from out-217.mta1.migadu.com (out-217.mta1.migadu.com [95.215.58.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB01171C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:59:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1695041988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJIBmn1MRAFelLIOs/v4ao97mYf3xkRoyjgfFYfZY14=;
        b=Eis19EUqt8F5IEwvw8k8WICesKIk8mVKQTgQ2JtVlQ/Nd4QR4TvsAVTHDbc7M7b42hC7p0
        HS5d2/tBiclp2l0szNn3Okmly9q+c3ItDNH4jvU5omvCbV7IKjoubgcAtTLWHMJs1TA31C
        +WlvwkLUU08ypgbbDuXItBJsRZrGhswphsJlKkfbY5BoaoDtSPqEqUO9w+6X2mUgCAdoWG
        rVh6KTD3HCE1JP+1fNIXeyjTQ92DDOp2Sofq66TDpgiEkUdyPlGZBE47KfCFmhLfZb60Zy
        9bXFmY14ySAJWn4Rh91RL4BCJtw7WYIKn8egenwedBwEaekOLajEmgrVA7on9w==
From:   John Watts <contact@jookia.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, John Watts <contact@jookia.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/9] drm/panel: nv3052c: Wait before entering sleep mode
Date:   Mon, 18 Sep 2023 22:58:48 +1000
Message-ID: <20230918125853.2249187-5-contact@jookia.org>
In-Reply-To: <20230918125853.2249187-1-contact@jookia.org>
References: <20230918125853.2249187-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel needs us to wait 120ms between exiting and entering sleep.
Guarantee that by always waiting 150ms before entering sleep mode.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/gpu/drm/panel/panel-newvision-nv3052c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 2526b123b1f5..307335d0f1fc 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -289,6 +289,9 @@ static int nv3052c_unprepare(struct drm_panel *panel)
 	struct mipi_dbi *dbi = &priv->dbi;
 	int err;
 
+	/* Wait 150ms in case we just exited sleep mode */
+	msleep(150);
+
 	err = mipi_dbi_command(dbi, MIPI_DCS_ENTER_SLEEP_MODE);
 	if (err)
 		dev_err(priv->dev, "Unable to enter sleep mode: %d\n", err);
-- 
2.42.0

