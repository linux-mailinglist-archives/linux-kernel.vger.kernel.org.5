Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C9780E08A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345603AbjLLA4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345586AbjLLA4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:56:00 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA0EA6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:56:04 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6d089e8b1b2so1013686b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702342564; x=1702947364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AS84DpIlnHadbg548UoBHWDlxNfb0zaNqIcRTC+jUtI=;
        b=YlSdnOyXMByLaQfNmdthP4sQNIx0oUxERCQngpCzx5282Q831WiOtJmQ0Tr4C5SW4w
         zRKv57i6UUBpWW/PpeZUuD80IbC+LQaxc/cMkJ0f5NQtLyMvejDtH1dmIlrOo9Lk+a8y
         aV0ymxy0PYGce8pBu0OvaXrTlJF8ilOZNxsMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702342564; x=1702947364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AS84DpIlnHadbg548UoBHWDlxNfb0zaNqIcRTC+jUtI=;
        b=beTuSs9MkEdM5Iccf7cRdXzFMGd+Q/MlifgsjtKtzBqeqlIdqxExj4k24giAyFDWCH
         xmYq8045xigNH/pz7HE9WBBctQEhEkadYk/qeWmqOzyQ0L8d0yfLm95t168Uk89beZLt
         JItaQWVPnhqhY01m6JNfXcxTyAlgZL0Q/dM39VFH8c4PkJzrRli/Tq+X9YlUIHx4DqvK
         9fpOlnB9TeKs/nZY+OaMSXHWWhfKmAmWRjT2SX5HeD8rqbP64YaoZY9PQydhpvHV/PSA
         mIqZV7HdbfIcKjl+qYWv3ZF78n3vbFlFFj7iJEUvToUOQrnXCnloIWqPmB3g5mIBCKV3
         yRaA==
X-Gm-Message-State: AOJu0YxkkkUkBAJWWxvbt9GdqkJdwFhsY4io7lRBClhE+TTiAERzGRG5
        zF+yd+0fWgU1VZAO3ZqEtawK/A==
X-Google-Smtp-Source: AGHT+IEImkGOKriQgUmpcCdrkAlZGOVMJy7dWUFL7Mf+hsw6l3dDIoDd8j4PpPAdxvC2/AV5oSW9hg==
X-Received: by 2002:a05:6a21:99a4:b0:18c:18d3:c8fd with SMTP id ve36-20020a056a2199a400b0018c18d3c8fdmr3061776pzb.14.1702342563762;
        Mon, 11 Dec 2023 16:56:03 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5c08:e1ed:d922:d30c])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902694a00b001cc311ef152sm7251271plt.286.2023.12.11.16.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:56:03 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <rfoss@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/bridge: parade-ps8640: Never increase the length when reading from AUX
Date:   Mon, 11 Dec 2023 16:55:26 -0800
Message-ID: <20231211165526.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing, I happened to notice a random crash that looked like:

  Kernel panic - not syncing: stack-protector:
  Kernel stack is corrupted in: drm_dp_dpcd_probe+0x120/0x120

Analysis of drm_dp_dpcd_probe() shows that we pass in a 1-byte buffer
(allocated on the stack) to the aux->transfer() function. Presumably
if the aux->transfer() writes more than one byte to this buffer then
we're in a bad shape.

Dropping into kgdb, I noticed that "aux->transfer" pointed at
ps8640_aux_transfer().

Reading through ps8640_aux_transfer(), I can see that there are cases
where it could write more bytes to msg->buffer than were specified by
msg->size. This could happen if the hardware reported back something
bogus to us. Let's fix this so we never increase the length.

NOTE: I have no actual way to reproduce this issue but it seems likely
this is what was happening in the crash I looked at.

Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX channel")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 8161b1a1a4b1..fb2ec4264549 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -302,7 +302,7 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
 
 		fallthrough;
 	case SWAUX_STATUS_ACKM:
-		len = data & SWAUX_M_MASK;
+		len = min(len, (unsigned int)(data & SWAUX_M_MASK));
 		break;
 	case SWAUX_STATUS_DEFER:
 	case SWAUX_STATUS_I2C_DEFER:
@@ -310,7 +310,7 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
 			msg->reply |= DP_AUX_NATIVE_REPLY_DEFER;
 		else
 			msg->reply |= DP_AUX_I2C_REPLY_DEFER;
-		len = data & SWAUX_M_MASK;
+		len = min(len, (unsigned int)(data & SWAUX_M_MASK));
 		break;
 	case SWAUX_STATUS_INVALID:
 		return -EOPNOTSUPP;
-- 
2.43.0.472.g3155946c3a-goog

