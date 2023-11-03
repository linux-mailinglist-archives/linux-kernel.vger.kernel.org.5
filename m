Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1F87E03A1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346544AbjKCNOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjKCNOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:14:43 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC7810D7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:14:25 -0700 (PDT)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 812957E1;
        Fri,  3 Nov 2023 14:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1699017245;
        bh=xvh2d5U42urNPpTVLrPHqnnQohefIEzDhgWLBqn84R4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=md8XVaGNJcNAoIJSUkmjHsee+W5rT7WUnAu/frOfntimOdTILaaPQJLnrC+s4+1iX
         kQYyAboeJy5Wk4wiUd5nl7G237ntAiVNmn1XLgZSon5GZBUrwsFua+x1UJ4ky6e4n+
         Jx9bS6+pHMqQg6R/Ped6LrG30BGpEZQKaX4RB0ys=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 03 Nov 2023 15:14:03 +0200
Subject: [PATCH v2 1/4] drm/drm_file: fix use of uninitialized variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-uninit-fixes-v2-1-c22b2444f5f5@ideasonboard.com>
References: <20231103-uninit-fixes-v2-0-c22b2444f5f5@ideasonboard.com>
In-Reply-To: <20231103-uninit-fixes-v2-0-c22b2444f5f5@ideasonboard.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Parshuram Thombare <pthombar@cadence.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=xvh2d5U42urNPpTVLrPHqnnQohefIEzDhgWLBqn84R4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlRPIrnmZo1zjRKv5d2MoQWEqetAoew50nTwIqf
 4dYQyqbaIqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZUTyKwAKCRD6PaqMvJYe
 9deJEACAmhSvKQOpGftUEQRGJaU5QM4IipaLrzmOLtkoZklkMeFjdjFJL7fbrnKSeoOJkQL7kBA
 H3Y5ejdcQmxVlVhQ/DGg9LVBCDf+9mFIeX6WhItd6mUD7fCiqj0hjlRl8uiYxjEqLiz/mVwJW5e
 tBmZr0EMycBkMWL2Iczj4c2HVgyUEb3qo48WgOMOWy6w5+Ko0JLgOCo7SZieFzIJ3mtc4uGGCNK
 ouKC0bUqInXKHzq1PJWOGQ6TZ84OUO4oLXTwoMzE5LBtTNifsly1AI8ozSKeFEz1tVB+X/AiG7V
 7UZ0Oz4hWPreJolS6miy96S+sJMuVtsHCb5tr5fieU1aHbnkZ56JK90nHoAbZ0d1N6Blvc3CsQE
 DmCW13ptjh868qfqsDoC8F2KQDPH7RqRTV7nLJD4lDmirRs2B0TTC3zd35sbs3ucsumS2Oavxr6
 FDogtoqiLKYDgLsvk7ARbrpk+krN7N+hTKCnktHyWGQS90I9R+nvCZh+pj4S71aXc2+jWQiU3QH
 PHvdQcf8km2KSi9YPz2qtjFfHdMtCZe1Wb5TmESVPxBTg8BDIwKD+CXkNNZeOwILtQWI64I507H
 Eb6d3WQz11814zPUipjoO6D2vuyAuWb66JROZGUHO3gTm8ZmukiZBYrd8Ztfcqjh60CqjM98BcW
 0oogiXp2RxzZEpw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 446458aca8e9..54a7103c1c0f 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -958,7 +958,7 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
 {
 	struct drm_gem_object *obj;
 	struct drm_memory_stats status = {};
-	enum drm_gem_object_status supported_status;
+	enum drm_gem_object_status supported_status = 0;
 	int id;
 
 	spin_lock(&file->table_lock);

-- 
2.34.1

