Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45515808DD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjLGQZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjLGQZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:25:09 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0EA132
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:25:12 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1fb104887fbso669437fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966312; x=1702571112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BG8DXABI26khRo/Cvsu7QCsP0TBGt0vEQX0MbHKakig=;
        b=Mrr5w2jQtT4j892ibPpJCArJ3N2+m9cqdRkrIqfjQVBzIY1rcQug4L0yMGRgmsfQSD
         hjD1OUaXKHE6YBmVhGvXJWC0caLaM7cHmxutBzVu8Pn+uMq/CY9HqyII+FyzwkczlXMU
         Tucid3VHrcAezpQ3KwlBM+Re6jD+H7qq05vupIzOjMa2xxovNTi9yUiRTInpSiHECp0C
         cd9HacoqikqakoedgKqKpGSqjmBDgw5wxiM4iI0+lRi2lumbyVWvd3iTEI/n+XW6VsdO
         hWc1yseckeduBNRbTH+cGzp9ol8P1bDa/wQCroN6FnFN6ZMETZOsd/t6O2Ae4qyQfKiq
         WMpQ==
X-Gm-Message-State: AOJu0Yx/bjE8TUCGuNqt9vSY0OlPzYihPziiX+EqLqsK0leHCOw+LQJI
        PxswMZhxUINgjuQX6NV7DgGRGs5/oA==
X-Google-Smtp-Source: AGHT+IHDHo4nv2MT6E4HyQ0LIW+PExIE57JufBhvs/5LPfc77PCn6XBFLsr9P8vg6b2GGTfVvI8Y9A==
X-Received: by 2002:a05:6870:d60b:b0:1fb:2f58:f1c4 with SMTP id a11-20020a056870d60b00b001fb2f58f1c4mr3178764oaq.48.1701966312074;
        Thu, 07 Dec 2023 08:25:12 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id pf11-20020a0568717b0b00b001faebb7ff77sm20912oac.56.2023.12.07.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:25:10 -0800 (PST)
Received: (nullmailer pid 2631917 invoked by uid 1000);
        Thu, 07 Dec 2023 16:25:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: aux-hpd: Replace of_device.h with explicit include
Date:   Thu,  7 Dec 2023 10:25:00 -0600
Message-ID: <20231207162501.2629952-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. Soon the implicit includes are going to be removed.

of_device.h isn't needed, but of.h is for of_node_put().

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/bridge/aux-hpd-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
index 5d2ab3a715f9..1999a053d59b 100644
--- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
@@ -6,7 +6,7 @@
  */
 #include <linux/auxiliary_bus.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 
 #include <drm/drm_bridge.h>
 #include <drm/bridge/aux-bridge.h>
-- 
2.42.0

