Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7975769C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjGRIdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjGRIde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:33:34 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CBEE76
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:33:26 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4sfW5rWYzBR9t7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:33:23 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689669203; x=1692261204; bh=9692ZzsrczkdihRNiWFTcjEgW54
        h208pZatp5xPJadg=; b=zsOBdYFusN0CaVsamgWdkXWQHhVVFz5+w0dZ2iIVMAT
        m/f6el4k34ESupKF1HomWsvKO6xjExtykVaK7TQoy3+Cf8PwrxC/Aqh9yebX4Q3/
        I+onZRDXZ95KoFqO5B8bksWHtp+dF6T4BcLv3REZEn9cbGvyeVh+kphWQj4AVZrZ
        x6dJLwbvT2SFAKdMEpaVI3Li4u35cgjPkSh4t+xkQGeTTURQnJJHy7lzQgzC19d1
        1h+EvIInp0f6Qm0caT5RYH3yWHWgJ/RXpbZvhN+MCyy7Pwr4RIMMjd8nmK0CTxJ2
        qYWbxye8YqBUpqF5O21XtIdYdMDb7QRc0Pq5ohebeXg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d0vfTQB8_6jn for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 16:33:23 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4sfW1qkXzBR7bp;
        Tue, 18 Jul 2023 16:33:23 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 16:33:23 +0800
From:   sunran001@208suo.com
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/dsi: add missing put_device()
In-Reply-To: <20230718083149.17178-1-xujianghui@cdjrlc.com>
References: <20230718083149.17178-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <225e67f32dbc423daa4a83bc0c4f2179@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Detected by coccinelle with the following ERROR:
./drivers/gpu/drm/msm/dsi/dsi.c:50:1-7: ERROR: missing put_device; call
of_find_device_by_node on line 32, but without a corresponding object
release within this function.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/msm/dsi/dsi.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.c 
b/drivers/gpu/drm/msm/dsi/dsi.c
index 81461e8852a7..5e3cc287f0d3 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -46,7 +46,7 @@ static int dsi_get_phy(struct msm_dsi *msm_dsi)
          DRM_DEV_ERROR(&pdev->dev, "%s: phy driver is not ready\n", 
__func__);
          return -EPROBE_DEFER;
      }
-    put_device(&pdev->dev);
+    put_device(&phy_pdev->dev);
      return 0;
  }
