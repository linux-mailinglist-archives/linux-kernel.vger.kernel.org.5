Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B479952E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbjIIAvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242875AbjIIAvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:51:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036F12109;
        Fri,  8 Sep 2023 17:42:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A593AC116B3;
        Sat,  9 Sep 2023 00:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694220073;
        bh=+yXZM9YgbhoGVXuCBgduM9ctGvPOR4zaGUTwEejwbQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/vA/4lFwN3OvArf97vlPE/+eulmqRF06SxSU4OxiXLjNekYsuRg0Pf0tjaANU8Vw
         aNzeMbRNKjAzJjFWL60Z1+ehwQi3HS1g87Tlgqogl/95KYLb+Nr8+UJ5zPDC0mjxvj
         K0ywJ5sHSF8VYo1YPPTFiuE3oJDsadM1rLCb9Q67zBTi5jZvp4dvupZdvOxwetEZiI
         /7enV0Cm0fN1nLy5/u6EZadHmWCIuB6rn2/ppxQacjhYHa4Bly1UpGt9ZliojYKoUz
         I8j+VTCBLwMOnRxgcIKEb4BixvhSrC1e7mn/Hib3l8Q5wzDtHL7AyzKm23divH2GR1
         M4FYlvRrxELyQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, yong.zhi@intel.com,
        bingbu.cao@intel.com, djrscally@gmail.com, mchehab@kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 13/14] media: pci: ipu3-cio2: Initialise timing struct to avoid a compiler warning
Date:   Fri,  8 Sep 2023 20:40:44 -0400
Message-Id: <20230909004045.3581014-13-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909004045.3581014-1-sashal@kernel.org>
References: <20230909004045.3581014-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.294
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 9d7531be3085a8f013cf173ccc4e72e3cf493538 ]

Initialise timing struct in cio2_hw_init() to zero in order to avoid a
compiler warning. The warning was a false positive.

Reported-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 070ddb52c8231..2c037538c7d8f 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -361,7 +361,7 @@ static int cio2_hw_init(struct cio2_device *cio2, struct cio2_queue *q)
 	void __iomem *const base = cio2->base;
 	u8 lanes, csi2bus = q->csi2.port;
 	u8 sensor_vc = SENSOR_VIR_CH_DFLT;
-	struct cio2_csi2_timing timing;
+	struct cio2_csi2_timing timing = { 0 };
 	int i, r;
 
 	fmt = cio2_find_format(NULL, &q->subdev_fmt.code);
-- 
2.40.1

