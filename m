Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0A975A8AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGTII6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGTIIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:08:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6966E172A;
        Thu, 20 Jul 2023 01:08:53 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4F710881;
        Thu, 20 Jul 2023 10:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689840477;
        bh=0RLflJGgT6hpPA6KHXfUk4/Ymw1X82gpzplVA8mUaZM=;
        h=From:Date:Subject:To:Cc:From;
        b=DzKy97fOAmM/EN+synGAuzAQBHV+X14N2kpQQ5uJk3pzh2L+bd6jVx4HjF4U2cKyN
         bjSim+ITeDeqgxqlqDVVBcSniYUT7E9qaNg/0syiiC2nPdDTuRsdQpUD+mfZSSbOaw
         rTrinGNnoUSJs6IGDCddkU1dEjXIeh0/xfSajhQI=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Thu, 20 Jul 2023 11:08:28 +0300
Subject: [PATCH] media: Documentation: Fix [GS]_ROUTING documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-streams-routing-doc-fix-v1-1-29ecfaa50635@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAHvruGQC/x2MSQqAMAwAvyI5G6gtLvgV8VBs1BxsJVERxL9bP
 M7AzANKwqTQFw8IXaycYoaqLGBafVwIOWQGa6wzrTWoh5DfFCWdB8cFQ5pw5htdaBrjqauo9pD
 rXSjr/zyM7/sB8fEr/2kAAAA=
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mention that successful VIDIOC_SUBDEV_G_ROUTING call will update
'num_routes' and remove mention about non-existing streams, which is
incorrect.

Fixes: ea73eda50813 ("media: Documentation: Add GS_ROUTING documentation")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst
index 2d6e3bbdd040..72677a280cd6 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst
@@ -58,6 +58,9 @@ the subdevice exposes, drivers return the ENOSPC error code and adjust the
 value of the ``num_routes`` field. Application should then reserve enough memory
 for all the route entries and call ``VIDIOC_SUBDEV_G_ROUTING`` again.
 
+On a successful ``VIDIOC_SUBDEV_G_ROUTING`` call the driver updates the
+``num_routes`` field to reflect the actual number of routes returned.
+
 .. tabularcolumns:: |p{4.4cm}|p{4.4cm}|p{8.7cm}|
 
 .. c:type:: v4l2_subdev_routing
@@ -138,9 +141,7 @@ ENOSPC
 
 EINVAL
    The sink or source pad identifiers reference a non-existing pad, or reference
-   pads of different types (ie. the sink_pad identifiers refers to a source pad)
-   or the sink or source stream identifiers reference a non-existing stream on
-   the sink or source pad.
+   pads of different types (ie. the sink_pad identifiers refers to a source pad).
 
 E2BIG
    The application provided ``num_routes`` for ``VIDIOC_SUBDEV_S_ROUTING`` is

---
base-commit: 28999781d15f94046e6c23a9a7d92ad28a436abf
change-id: 20230720-streams-routing-doc-fix-3d660ae81e5a

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

