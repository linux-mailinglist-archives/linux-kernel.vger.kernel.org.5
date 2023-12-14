Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3928812F80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444171AbjLNLz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444112AbjLNLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:55:26 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F9EB2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:55:31 -0800 (PST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4SrW4s501Cz8XrRD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 19:55:25 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4SrW4j6tW6z4xVbs;
        Thu, 14 Dec 2023 19:55:17 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 3BEBtHWY033480;
        Thu, 14 Dec 2023 19:55:17 +0800 (+08)
        (envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 14 Dec 2023 19:55:20 +0800 (CST)
Date:   Thu, 14 Dec 2023 19:55:20 +0800 (CST)
X-Zmail-TransId: 2afa657aed28ffffffffd6b-a5429
X-Mailer: Zmail v1.0
Message-ID: <202312141955202416240@zte.com.cn>
Mime-Version: 1.0
From:   <yang.guang5@zte.com.cn>
To:     <lee@kernel.org>
Cc:     <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>,
        <cgel.zte@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRybS9ub3V2ZWF1L2Rpc3A6IHN3aXRjaCB0byB1c2Uga21lbWR1cCgpIGhlbHBlcg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3BEBtHWY033480
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 657AED2D.001/4SrW4s501Cz8XrRD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use kmemdup() helper instead of open-coding to
simplify the code.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 drivers/gpu/drm/nouveau/nvif/outp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/nvif/outp.c
index 5d3190c05250..6daeb7f0b09b 100644
--- a/drivers/gpu/drm/nouveau/nvif/outp.c
+++ b/drivers/gpu/drm/nouveau/nvif/outp.c
@@ -452,13 +452,12 @@ nvif_outp_edid_get(struct nvif_outp *outp, u8 **pedid)
 	if (ret)
 		goto done;

-	*pedid = kmalloc(args->size, GFP_KERNEL);
+	*pedid = kmemdup(args->data, args->size, GFP_KERNEL);
 	if (!*pedid) {
 		ret = -ENOMEM;
 		goto done;
 	}

-	memcpy(*pedid, args->data, args->size);
 	ret = args->size;
 done:
 	kfree(args);
-- 
2.25.1
