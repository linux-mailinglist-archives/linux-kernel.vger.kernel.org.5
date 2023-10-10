Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BB77BEFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379300AbjJJAvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379284AbjJJAvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:51:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AAAB4;
        Mon,  9 Oct 2023 17:51:41 -0700 (PDT)
Received: from Monstersaurus.local (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2602BF0C;
        Tue, 10 Oct 2023 02:51:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696899094;
        bh=gaWQ9+vNu5E0S40zJ98ILSdv6vdUDu9g/y/qreNcGv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMyOMzOqmHBulm0ToE9kVYxEO0YjWXyclZnxFwBpvNai2AoxgaXGaOn1UazmDH3uo
         /n6a74k3N1f7D4IyxySQ/3j8lfu9nxJ1Nyf5q0n6+khaMBAR40bexMNdzM9erTdk5g
         NT0QettZzdL69NvhbjQAtKGIg7W/AgQf9M87Q3l8=
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] media: i2c: imx335: Fix hblank min/max values
Date:   Tue, 10 Oct 2023 01:51:25 +0100
Message-Id: <20231010005126.3425444-5-kieran.bingham@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V4L2_CID_HBLANK control is marked as readonly and can only be a
single value.

Set the minimum and maximum value to match the mode value.

Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 026777eb362e..1a34b2a43718 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -1043,8 +1043,8 @@ static int imx335_init_controls(struct imx335 *imx335)
 	imx335->hblank_ctrl = v4l2_ctrl_new_std(ctrl_hdlr,
 						&imx335_ctrl_ops,
 						V4L2_CID_HBLANK,
-						IMX335_REG_MIN,
-						IMX335_REG_MAX,
+						mode->hblank,
+						mode->hblank,
 						1, mode->hblank);
 	if (imx335->hblank_ctrl)
 		imx335->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-- 
2.34.1

