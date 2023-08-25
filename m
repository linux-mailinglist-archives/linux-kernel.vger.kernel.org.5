Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6D4788557
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbjHYLDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbjHYLDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:03:32 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024751BC9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:03:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PB30el008638;
        Fri, 25 Aug 2023 06:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692961380;
        bh=pFsncRId2Li4lFUoNT42s+0VDtLf48JGN1Hoc7R28Z4=;
        h=From:Date:Subject:To:CC;
        b=f4Wi1u470XsMHu2whcmfwwlT4btS3MhorHLLvGaJH7o8tpSAOlVftoFA1zuXTqF9f
         ivkJBwGZ+zSerzCBhH2VHoW5KykEnbXWPyRQ/DmMxGlJbG919ICelrYL2wR+KgmTSw
         hzblHRe7CiNnRyqefYWD1NTlApqsRp5QcMEdIhP4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PB30hd031045
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Aug 2023 06:03:00 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 06:03:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 06:03:00 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PB2xpf129788;
        Fri, 25 Aug 2023 06:02:59 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Fri, 25 Aug 2023 16:32:14 +0530
Subject: [PATCH] drm: bridge: it66121: Fix invalid connector dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230825-it66121_edid-v1-1-3ab54923e472@ti.com>
X-B4-Tracking: v=1; b=H4sIADWK6GQC/x3MQQqAIBBA0avErBN0QrOuEhGVU83GQiMC8e5Jy
 7f4P0GkwBShrxIEejjy6QtUXcF6zH4nwa4YUGIjLWrBtzEK1USOnTBEndWqtdIuUJIr0Mbvvxv
 GnD9fTW9WXgAAAA==
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Belin <nbelin@baylibre.com>,
        "Andy.Hsieh" <Andy.Hsieh@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>, <devarsht@ti.com>,
        <nm@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=kY/mIB6mrYJ/fDB8nsf4jCfUQ4TGTeiTF0gmX+Q1uqs=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBk6IpigIQx52k+CRuU8WRogDuAGfZVyc2Zzv7Ku
 rt1Ysi8vHaJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZOiKYgAKCRBD3pH5JJpx
 RWmZEACd6dZsgfGKvaRljr69D0wWnNir9wuEqt1VHKsk3xC93MR+AqxNJh+xUftyibbG6PRqwkM
 0Mi9KeUvNURcDPV8qRKxa9Mg7mO81I55fIuG7dZx+t3WdvGQvzl6/40Z8Jyt9/4yA+fM1oCIWxQ
 YzIY18S+HbrVmNlXI/X1zU1lkTKgIjAXlH+/wh+NtXXBMbyC6zlN5e5jl2TTUU2QYDP0aUW1tUS
 rgC8yD2/xApHZsuRNEVKZuC05mFuXs5Pp4E1l24U67C+WKGPWExs5pMfURIc7juv+Sf+s84MfLR
 2L56efyro6hXSLRhTGHwkTTtm2q1HHvVoJgoBaIqw5IQcKwZYOJJxobpgJf6t9LWlf4NTMEO955
 5YSnqD4hYrwDYrj53sE49hXwnQOdQtjZiHvKMJ0L8VUW1hSIl5eACOEXdfQcf1FlH7ea3FXjKOv
 uCBBNGLvvORqpWbL8/HATpBK0hSutDadI1lHlqEzN38WMPbLfJQ49IooNVEeAROdTiBrhwSHAVh
 9ngJ3xaofZDcT81GxFLxLwMWoUODMmbRH/qmhYNlRwAhABVJP/0CXbWsJbAOGU7C5RRnzyOD3rX
 SRdhNLK6p/RdK4h2XxroGeIRjC6MPTTU/YU8F5NA6Rnt2oBnGkgnoYsdwfJ/xIpwrs7qltyVhsG
 fyanZHL5pbY3cTg==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the NULL pointer dereference when no monitor is connected, and the
sound card is opened from userspace.

Instead return an error as EDID information cannot be provided to
the sound framework if there is no connector attached.

Fixes: e0fd83dbe924 ("drm: bridge: it66121: Add audio support")
Reported-by: Nishanth Menon <nm@ti.com>
Closes: https://lore.kernel.org/all/20230825105849.crhon42qndxqif4i@gondola/
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 466641c77fe9..d6fa00dea464 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1446,6 +1446,11 @@ static int it66121_audio_get_eld(struct device *dev, void *data,
 {
 	struct it66121_ctx *ctx = dev_get_drvdata(dev);
 
+	if (!ctx->connector) {
+		dev_dbg(dev, "No connector present, cannot provide EDID data");
+		return -EINVAL;
+	}
+
 	mutex_lock(&ctx->lock);
 
 	memcpy(buf, ctx->connector->eld,

---
base-commit: 6269320850097903b30be8f07a5c61d9f7592393
change-id: 20230825-it66121_edid-6ee98517808b

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>

