Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDFB76FF22
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjHDK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjHDK71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:59:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72FA198C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:57:56 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C3CBA12E4;
        Fri,  4 Aug 2023 12:56:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691146610;
        bh=VTa2EburIeC7ChqorcZc2l1A1SMNu4ojq6nMgbI61lo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AKn77msnpIlD0Kk6tKgFEdJoRb15t1vRLnKPfJ5vmmpIXUJyDAPJTIqAZV1wzA9Qh
         fcClpWeiOvsrxIXd7QlWI8PJBk6JBzViFy9P51ChDyZvhSequ6LWLZhLj7sP6o51V8
         zUux3gI6my0VJP6M+fXmXbU8kY5fF1PszC5u3cc8=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 04 Aug 2023 13:57:39 +0300
Subject: [PATCH 1/2] drm/drm_file: fix use of uninitialized variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230804-uninit-fixes-v1-1-a60772c04db5@ideasonboard.com>
References: <20230804-uninit-fixes-v1-0-a60772c04db5@ideasonboard.com>
In-Reply-To: <20230804-uninit-fixes-v1-0-a60772c04db5@ideasonboard.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=VTa2EburIeC7ChqorcZc2l1A1SMNu4ojq6nMgbI61lo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkzNmwdMlu13HRR98mkzzHgHB0EiqVgIVKqSq7s
 clqaDQDXVWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMzZsAAKCRD6PaqMvJYe
 9fTAEACZDQ+ZDxBGR8CbKBIYz1KuqsVqKDRqlKhnuxPO0kt3B/gE1u73OlhZUlEkf2ahK1wzTj0
 QiYUNhfSdSaQQZvqQpvsBuoisn3reW+j5rYdZ6jz58Q405tB0/do46Zlkx0MT4fW8o1FrJUcVGU
 ZEtBbJ/0RDfQkA4Pxc/U9ivBRZEWmrVY1rSGbtsSfh04hiDzPEL+oJT5dQgLHJqLPXDrOLvMy/j
 8mjgAsAN/PcBw+SnEBRyA06JRGwNMMEMSxL/dUHaLqXiAmzeQgQIpRdtVHAgYkyYbSppWV12wmh
 6K+TSMo+akuRlP1ZBQczvsMP+pBibQ+ORc/Gyja+AqI5cnhz3hGgMLsR3QqqWmsWjYUa+/TDFOi
 M3xGvfS0kxam1Q6dawd0CpPUX7ZuN9Na72Tc+UDOmS7SScskLOV8PEet5hGMoQkiPes5ouh3Fwx
 /7XXcahbPiPr3mqz70V3kdeSAQQTV75fLPKJ5qg3E1GEd0NT49qeoSPtLS5y63h/u78iw2kJjI4
 x3nZ27xIFqlXaa6mX9SEypsWS7n3KUVEOCo0MKPZRet/Vx0NckQg5l4QxYuiQ120R006oAtdSrx
 MM9dVaKokccfbCf9HUoCK3C0w9Ynj+awarH4WhCJszXBkEBl08afzJ2YohwwxvwDxOLx/5wu16x
 ZdBMGhqrsxPq6QA==
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

drivers/gpu/drm/drm_file.c:967 drm_show_memory_stats() error: uninitialized symbol 'supported_status'.

'supported_status' is only set in one code path. I'm not familiar with
the code to say if that path will always be ran in real life, but
whether that is the case or not, I think it is good to initialize
'supported_status' to 0 to silence the warning (and possibly fix a bug).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 883d83bc0e3d..cc06e1836bf5 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -924,7 +924,7 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
 {
 	struct drm_gem_object *obj;
 	struct drm_memory_stats status = {};
-	enum drm_gem_object_status supported_status;
+	enum drm_gem_object_status supported_status = 0;
 	int id;
 
 	spin_lock(&file->table_lock);

-- 
2.34.1

