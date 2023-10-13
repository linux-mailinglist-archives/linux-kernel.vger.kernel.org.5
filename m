Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA777C7BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjJMDLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMDKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:10:55 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC97991
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:10:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-79fe6da0049so66330739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697166652; x=1697771452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TsY2oClvKo7kprulGqoF1UimrGsaQgD/VvrbzM3GhTw=;
        b=PUrqbi3m8OQ7oHAEsYLnI2dw/vsVL3p1196gqwLQH0blKVa/A+UDXq9Mgn7d4M0a6P
         z1Zw3zlqkUpkq+iqTJMtP84DaLv6Ty5APtrKYBchlr/n8z6+LMkNnRe080tjjN2l+xNR
         dVIYlYcT/r1uvkuNiQleCJ0SzXJ94kTS6gKmZkDm7TQ5M/hz4taOqjwBgjd1v1jl4j/8
         7O9oEgKEyC4hvZYWCV8HLJBeT1NHqVbjm04H2LdKocJ21pLxGj5HxhW9j1u1l4wgHkXr
         w0PQ+lUa5E0n5VK7+CfkBuTlA866wgKLtChwTiZte69+Lq13+dKzVAgjeUdCy0iYxkd0
         eEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697166652; x=1697771452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsY2oClvKo7kprulGqoF1UimrGsaQgD/VvrbzM3GhTw=;
        b=nfNheQ65aQZN8WQ20mqOS2h5IUt+MNwOdqzV3ms1oEGHdC8KwjNwPXRxqjyWL+CES2
         vS5jbhS/5GXxy/7Sk+k2qSPioZC74AYJ7UGBcpyQg/LZHArLULPzzuJ63G6YddEawdHA
         b6snzGjsx56+7T8s651T72LBJqCT2t+v2kvnTMp4zDyGkMfjXQ/eEe5H6fId1vAoFnaE
         TqUb/TPQEMhoentaJTtDIjUdTKX/V1ebGvjawXKJPBdJIlZVCruO12vXm78eFDv5F6hf
         OjGI7S0rbVZta+8MCA+fcAG5VTvWgmEm+GVCjnEcvnziGOAE+OTIWiAs9czB7KwTjdKa
         W57g==
X-Gm-Message-State: AOJu0YzHsBexohDX4ufFiViexS7z8PHMSsYo7NCej0RrvFxHfbwA/Hup
        l1THDje8hwTSO5xvRts5bbM=
X-Google-Smtp-Source: AGHT+IEuffesM8AN7N3wU2MdIgERDVEEEWATCJRRxrGyYBSB71aTI2qSladEUOIIj9hoG3k3YOVpYQ==
X-Received: by 2002:a05:6602:39a:b0:790:f735:4d30 with SMTP id f26-20020a056602039a00b00790f7354d30mr30694824iov.13.1697166652023;
        Thu, 12 Oct 2023 20:10:52 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:4979:b5dc:3d65:edd2])
        by smtp.gmail.com with ESMTPSA id n3-20020a5e8c03000000b0079ab2787139sm4691058ioj.7.2023.10.12.20.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 20:10:51 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, marex@denx.de,
        Adam Ford <aford173@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [RFC] drm: bridge: samsung-dsim: Recalculate timings when rounding HFP up
Date:   Thu, 12 Oct 2023 22:10:40 -0500
Message-Id: <20231013031040.152282-1-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using video sync pulses, the HFP, HBP, and HSA are divided between
the available lanes if there is more than one lane.  For certain
timings and lane configurations, the HFP may not be evenly divisible
and it gets rounded down which can cause certain resolutions and
refresh rates to not sync.

ie. 720p60 on some monitors show hss of 1390 and hdisplay of 1280.  This
yields an HFP of 110. When taking the HFP of 110 divides along 4 lanes,
the result is 27.5 which rounds down to 27 and causes some monitors not
to sync.

The solultion is to round HFP up by finding the remainder of HFP /
the number of lanes and increasing the hsync_start, hsync_end, and
htotal to compensate when there is a remainder.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
This adds support for 720p60 in the i.MX8M Plus.

NXP uses a look-up table in their downstream code to accomplish this.
Using this calculation, the driver can adjust without the need for a
complicated table and should be flexible for different timings and
resolutions depending on the monitor.

I don't have a DSI analyzer, and this appears to only work on
i.MX8M Plus but not Mini and Nano for some reason, despite their
having a similar DSI bridge.

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index be5914caa17d..5564e85f6b63 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1628,6 +1628,26 @@ static int samsung_dsim_atomic_check(struct drm_bridge *bridge,
 		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
 	}
 
+	/*
+	 * When using video sync pulses, the HFP, HBP, and HSA are divided between
+	 * the available lanes if there is more than one lane.  For certain
+	 * timings and lane configurations, the HFP may not be evenly divisible.
+	 * This can cause HFP to round down, and it ends up being too small which can
+	 * cause some monitors to not sync properly. In these instances, round HFP up
+	 * and adjust htotal to compensate. Through trial and error, it appears that
+	 * the HBP and HSA do not appear to need the same correction that HFP does.
+	 */
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE && dsi->lanes > 1) {
+		int hfp = adjusted_mode->hsync_start - adjusted_mode->hdisplay;
+		int remainder = hfp % dsi->lanes;
+
+		if (remainder) {
+			adjusted_mode->hsync_start += remainder;
+			adjusted_mode->hsync_end   += remainder;
+			adjusted_mode->htotal      += remainder;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.40.1

