Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3820175E026
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 08:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGWGlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 02:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGWGll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 02:41:41 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC0210F8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 23:41:40 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id NSmdq59F14DtINSmdqfFoy; Sun, 23 Jul 2023 08:41:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690094498;
        bh=Q7o0UQvRfkS/4+Mc6nSPTzH0IapT9/fEsaA6pwimGA0=;
        h=From:To:Cc:Subject:Date;
        b=N/o86135ANjyjKGmokuS7xBDhOlV15gvy89zRuss8Qpd7KKHc/I4AvMRy0vHpTNPP
         CdHlSFsd+qtazyI5QGlhGEa7t2s+ezl1Wb0N6mE9oRHSoYuvUBlBdxTuuwctbFxR2A
         9Zk5/e8z356kbKZSdmRnh2veOy8ewV5V48lDUyg0xuZHjeRIA/sxilDnSt8F7xqOnf
         4DmDV+b4GJow+4SNILdEJP+Bla9fs59NxWl1NOK80l4LU2T6INRhrrsH+zD1gGPb4e
         3J3PTblIWoQEMzg6a8hURf62+DuwkL5YE/vJoHpuj+ZKimoSeJBJVwoZCInRtvdcx7
         t0prBJ/xef2wQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 23 Jul 2023 08:41:38 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH] drm/msm: Slightly simplify memory allocation in submit_lookup_cmds()
Date:   Sun, 23 Jul 2023 08:41:33 +0200
Message-Id: <9861e8b1ce385a556e0c9c4533beee9c4a92809c.1690094459.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'sz' is SIZE_MAX, kmalloc() will fail. So there is no need to explicitly
check for an hypothetical overflow.

Remove the check to save a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 3f1aa4de3b87..6ca8f8cbb6e2 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -211,11 +211,7 @@ static int submit_lookup_cmds(struct msm_gem_submit *submit,
 
 		sz = array_size(submit_cmd.nr_relocs,
 				sizeof(struct drm_msm_gem_submit_reloc));
-		/* check for overflow: */
-		if (sz == SIZE_MAX) {
-			ret = -ENOMEM;
-			goto out;
-		}
+
 		submit->cmd[i].relocs = kmalloc(sz, GFP_KERNEL);
 		if (!submit->cmd[i].relocs) {
 			ret = -ENOMEM;
-- 
2.34.1

