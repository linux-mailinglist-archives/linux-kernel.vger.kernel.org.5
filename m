Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E254D7E4993
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbjKGUHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjKGUHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:07:35 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE02102;
        Tue,  7 Nov 2023 12:07:32 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2800E0007;
        Tue,  7 Nov 2023 20:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699387651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X5zLXwv1zLutIAnOzFga8a+rwat8HmE09YhK+lKrRuQ=;
        b=OM0r64U46VjduZJb/Zir0CyHZ9akZpO7sQe4VpGkDu1dED3804kM0sdAyD3sf5H69x/+aU
        MpmXzjHJOtUtGdCz7bufhYBTi7BhR97aCiVptcFB01K0UI0ngaJUDG+BN3Az7RiXuPBuk6
        n4QZZVqxyHlc2vfP3ae5nNGW3BUJzwhQzYSb3Won9VWC8pboutBKAVQsJh30j9AM8xV5Ic
        DpAlnRhxo/v+11ujQEMEFkPVVoLeC6QW3XwPrNt31hjdbLHXa8NlXPzN0yA8GQ42pu2h42
        l7Md+d3iVoOwClylz+XX5UOf6ksyUtSCmRxVhNYGZjfufNtJWQxmtTJN+hOpqw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] media: cedrus: Update TODO with future rework plans
Date:   Tue,  7 Nov 2023 21:06:28 +0100
Message-ID: <20231107200628.485227-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: paul.kocialkowski@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current TODO list of the cedrus driver is now outdated as most of the points
it mentions were already tackled. In addition it is no longer considered
relevant to wait for a stateless encoder driver to move it out of staging.
The hantro/verisilicon driver was already unstaged without this condition.

However the driver suffers from a bad initial design that showed to be very
limiting. It was also not a very good fit for a video codec driver either.

Since a rework of the driver was already carried out for the purpose of adding
encoding support, update the TODO list with a description of the rework.
This reworked driver will be published soon and transitional commits from the
current driver will be submitted upstreamer after that.

It seems best to wait for the rework to land upstream before unstaging the
driver, since a major rework is best operated on a staging driver instead of a
fully upstream one.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/staging/media/sunxi/cedrus/TODO | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/TODO b/drivers/staging/media/sunxi/cedrus/TODO
index ec277ece47af..00aa304a7e36 100644
--- a/drivers/staging/media/sunxi/cedrus/TODO
+++ b/drivers/staging/media/sunxi/cedrus/TODO
@@ -1,7 +1,16 @@
-Before this stateless decoder driver can leave the staging area:
-* The Request API needs to be stabilized;
-* The codec-specific controls need to be thoroughly reviewed to ensure they
-  cover all intended uses cases;
-* Userspace support for the Request API needs to be reviewed;
-* Another stateless decoder driver should be submitted;
-* At least one stateless encoder driver should be submitted.
+This driver suffers from a bad initial design that results in various aspects
+being intricated, making it difficult to scale to new codecs and to add encoding
+support in the future.
+
+Before leaving the staging area, it should be reworked to clearly distinguish
+between different aspects:
+- platform, with resources management, interrupt handler, watchdog,
+  v4l2 and m2m devices registration;
+- proc, with video device registration and related operations;
+- context, with m2m context, queue and controls management;
+- engine, with each individual codec job execution and codec-specific
+  operation callbacks;
+
+This will make it possible to register two different procs (decoder and
+encoder) while sharing significant common infrastructure, common v4l2 and m2m
+devices but exposing distinct video devices.
-- 
2.42.0

