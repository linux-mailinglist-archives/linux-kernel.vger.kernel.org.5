Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27DE812FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572907AbjLNMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572888AbjLNMGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:06:53 -0500
X-Greylist: delayed 687 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Dec 2023 04:06:56 PST
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B100B9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:06:56 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4SrWL23N3fz4xVbs;
        Thu, 14 Dec 2023 20:06:50 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 3BEC3JO0039139;
        Thu, 14 Dec 2023 20:03:19 +0800 (+08)
        (envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 14 Dec 2023 20:03:22 +0800 (CST)
Date:   Thu, 14 Dec 2023 20:03:22 +0800 (CST)
X-Zmail-TransId: 2af9657aef0afffffffff0d-394fc
X-Mailer: Zmail v1.0
Message-ID: <202312142003220684160@zte.com.cn>
Mime-Version: 1.0
From:   <yang.guang5@zte.com.cn>
To:     <kherbst@redhat.com>
Cc:     <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>,
        <cgel.zte@gmail.com>, <lyude@redhat.com>, <dakr@redhat.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <bskeggs@redhat.com>,
        <keescook@chromium.org>, <dri-devel@lists.freedesktop.org>,
        <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRybS9ub3V2ZWF1L2Rpc3A6IHN3aXRjaCB0byB1c2Uga21lbWR1cCgpIGhlbHBlcg==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3BEC3JO0039139
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 657AEFDA.003/4SrWL23N3fz4xVbs
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
