Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417FE7DD31E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346868AbjJaQt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346867AbjJaQtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:49:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAF7E6;
        Tue, 31 Oct 2023 09:49:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7200C433D9;
        Tue, 31 Oct 2023 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698770961;
        bh=hjO1thsBtNWKgoDt95oSE/97xbheY9O5MXtc459uiLk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=eO8w93dpaAwkGijK5tNBw//6sqqm8PohRQimWd7JyU27VhGzpEE3T5i9hG+55fYbh
         Al1BQqBsSkPmmrdBSfjgx/Abzdpnwm+IJpk0jh3Nnxi+nDaEiU+1ocymPTdzndUr5S
         cJY0x0erIvwHqVRv/0erjStDz8zasg3DsJ8PMs5q3kz53AymJgOSpcClaKQtVwSJOJ
         D91qYMpfaVH+5gQtJbsa+KNtG89KzvA8WCOkeGnOC55RoZ+SxzJusUis1ET5+aksJ1
         FFiLrTVWXAl18eR3jFG2z5LeZpJnmy8l2S0RXrimnv167HyU3NkSYNVpFAkqSPhwRm
         GdaOSs700Sk6g==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Tue, 31 Oct 2023 17:48:29 +0100
Subject: [PATCH RFC v3 16/37] drm/rockchip: inno_hdmi: Remove useless copy
 of drm_display_mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-kms-hdmi-connector-state-v3-16-328b0fae43a7@kernel.org>
References: <20231031-kms-hdmi-connector-state-v3-0-328b0fae43a7@kernel.org>
In-Reply-To: <20231031-kms-hdmi-connector-state-v3-0-328b0fae43a7@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hjO1thsBtNWKgoDt95oSE/97xbheY9O5MXtc459uiLk=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmO+vf27E3KXeoamlw1xXTrpl0b3YrvWKvzh+mvux63a
 vs1g+9JHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZjIeTaGPzwn2hKSjk74L1Hc
 WZoVVr6yoGHbpaYUqcXdEx5PlrTfvp7hv4fm589cBwUPcemYJGxW/7/N8NVD5TkCzdtsfsS01O6
 LZwYA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver maintains a copy of the adjusted mode but doesn't use it
anywhere. Remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index cc48cbf85f31..4f5844fc115a 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -62,7 +62,6 @@ struct inno_hdmi {
 	unsigned int tmds_rate;
 
 	struct hdmi_data_info	hdmi_data;
-	struct drm_display_mode previous_mode;
 };
 
 static struct inno_hdmi *encoder_to_inno_hdmi(struct drm_encoder *encoder)
@@ -498,9 +497,6 @@ static void inno_hdmi_encoder_mode_set(struct drm_encoder *encoder,
 	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
 
 	inno_hdmi_setup(hdmi, adj_mode);
-
-	/* Store the display mode for plugin/DPMS poweron events */
-	drm_mode_copy(&hdmi->previous_mode, adj_mode);
 }
 
 static void inno_hdmi_encoder_enable(struct drm_encoder *encoder)

-- 
2.41.0

