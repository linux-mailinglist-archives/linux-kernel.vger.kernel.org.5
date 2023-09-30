Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813537B44A6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjI3XnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjI3XnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:43:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D08DD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 16:43:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C427C433C7;
        Sat, 30 Sep 2023 23:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696117399;
        bh=P+CU77of+9iupwufY51FvYLK73grANH0fCCMTcn7m4I=;
        h=From:Date:Subject:To:Cc:From;
        b=FbBQsEviAFg9YIFQzYge1wlh2ZnElxhOWYUo5SbkYZ0OoM5Ox9HPyG1YVWFtC2t6w
         QzvAc55n3SAYMqIw6YvxQNN4IzX3d1ElPQXIhj1jrDxqEGrFHCQDFdVoEsXALiVBWv
         o3rzWg0HGMXrmyDbkyTDy8z+wcf2fNlT3G4FulySN35wNWE2wG0ybDGjO6gdgfhYT0
         zLA5HsShKc9sdWLPTQFS7HN2uUrvm2q68mEJp/mR0VmTMW/S/rwFST5T+uce4/+2BR
         L/2/Mb9fUoyuNQmwDpNydpdw/eoCCu306jDk9Ot22F1z7auxi2eSiZypXjrFGh30bY
         tszMQpX42BuDA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 01:43:13 +0200
Subject: [PATCH] drm/bridge: tc358767: Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-drm-tc358767-maple-v1-1-f759fcc4bd98@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJCyGGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSyNL3ZSiXN2SZGNTC3Mzc93cxIKcVN2UJEMT4zQzM3NLUwsloMaCotS
 0zAqwodGxtbUAmWASz2QAAAA=
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=broonie@kernel.org;
 h=from:subject:message-id; bh=P+CU77of+9iupwufY51FvYLK73grANH0fCCMTcn7m4I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGLKTDr2oEaWLCCRIny8LjYcqhPhOBsy/j6eEl
 1pWyD2gEsWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRiykwAKCRAk1otyXVSH
 0GOZB/0Yw8yKj/bMXwFG0frDXxnFZ5wsxYSR4108sES36/PaJrpBi6MKmILmrq13A21uYfo9wxm
 QE3mTXX2RgVvsM0eCSdD4/X61bgVLwYRRG9Th65Fzos54oYvrFaVTXMkoZpE5WhEv1mQs4BwUNz
 72S75ckLNcyevIBvWcC7hP6wY3hNexCXc7VtpMOE0j7y7/mnFGEOv4/r0OnLKcCASSN+EWyapch
 TjLT5bXR1C+I6WcEmTWUn61mwcYlla5Of6LFLDlFmpDGomSgD2ePWHnc9WEtpb5BdK+bNZmApkC
 k9Htvz9CWLlK2qh6Gq7QtXDEjmC1+YCgzH5m75Ny0yqWOVYT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index b45bffab7c81..ef2e373606ba 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2005,7 +2005,7 @@ static const struct regmap_config tc_regmap_config = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.max_register = PLL_DBG,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.readable_reg = tc_readable_reg,
 	.volatile_table = &tc_volatile_table,
 	.writeable_reg = tc_writeable_reg,

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-drm-tc358767-maple-db143f667958

Best regards,
-- 
Mark Brown <broonie@kernel.org>

