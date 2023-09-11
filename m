Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCA079B5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355617AbjIKWBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbjIKJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:02:54 -0400
Received: from out-210.mta0.migadu.com (out-210.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B20ECD3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:02:50 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694422968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEybRG/z/QiYL8x5ls+wYPU1myIjvupP8IAsRIKh5xg=;
        b=L4zZ4w9E6I3vJ/yHBEDZ7bNzpDYIxT6oC471yPAYUPUVy8khFrdLFoGbR4WnLs5hsEKiSB
        yHusLh1PHnuyZPA4BNjhQBBidEshgfx5A1dEMNboZAcGagMxOFU01LEPA1AhaKM0pNg4+T
        5nup4MOhOpwkbTG3+NfIxAg1IaJukZKvnmP/o9Sd2LGDG4Wp9T5zYTAh9vWlDXqO40veRm
        UTNMhxi2NR7MUecIEaC/BmngFO7QdNK3jP2iIgbRBiGGA8JVXo7DrkU9dgyTsqn6Tdo7Zs
        dxjoikuMXmYExpEv8H61JgiNqhxL+cRz+YzU810n4zRb9NmmP0v+LKEwvw86Gg==
From:   John Watts <contact@jookia.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, John Watts <contact@jookia.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/8] drm/panel: nv3052c: Sleep for 150ms after reset
Date:   Mon, 11 Sep 2023 19:02:01 +1000
Message-ID: <20230911090206.3121440-4-contact@jookia.org>
In-Reply-To: <20230911090206.3121440-1-contact@jookia.org>
References: <20230911090206.3121440-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code waits after resets for 5 to 20 milliseconds.
This is appropriate when resetting a sleeping panel, but an awake panel
requires at least 120ms of waiting.

Sleep for 150ms so the panel always completes it reset properly.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/gpu/drm/panel/panel-newvision-nv3052c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 90dea21f9856..2526b123b1f5 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -258,7 +258,7 @@ static int nv3052c_prepare(struct drm_panel *panel)
 	gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	usleep_range(10, 1000);
 	gpiod_set_value_cansleep(priv->reset_gpio, 0);
-	usleep_range(5000, 20000);
+	msleep(150);
 
 	for (i = 0; i < ARRAY_SIZE(nv3052c_panel_regs); i++) {
 		err = mipi_dbi_command(dbi, nv3052c_panel_regs[i].cmd,
-- 
2.42.0

