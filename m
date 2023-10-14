Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA637C948B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 14:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjJNMPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 08:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjJNMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 08:15:01 -0400
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929C9A9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1697285697;
        bh=YQheIxJjOau1s9uk+wO2dkdpHL1+wExdCD1+23pg5Oc=;
        h=From:To:Cc:Subject:Date;
        b=aHgkbvsTX81K37sYgwyGDW1oDVk/2Hm/y3Stw7Y6MIqA0MuOafDWaaxHYZZ8iKC/q
         bTTKm4qU/E5AzIRC452sJn+FmUX9G8UuA+Ji80DIIVgBgGSrhJK8EjokFoCqO4QOnj
         S7q6+2OFjczStaEMvvQdQqu+Ut+xv0AqUJAojzyk=
Received: from KernelDevBox.byted.org ([180.184.49.4])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 3B6A8E9A; Sat, 14 Oct 2023 20:14:54 +0800
X-QQ-mid: xmsmtpt1697285694tghy4mbab
Message-ID: <tencent_C816151C508524D86E346A69B706C0D03C09@qq.com>
X-QQ-XMAILINFO: OGEC8BYa7lsBWWZ/vEd4TQyQV9TARh6WvGGkSsO7/3IuF9yTmPnEUCQIn8ey2z
         F64IQTFMZP37lymHUS6B2HZo4knNaarGV2AJKI0/yTUoLqfNF4afRuhhV4FTNaoSbeWeTktBa01p
         JD4VwXJudoABheJBhAln465jjNlbz+PN6oeSO6JNDmPskkFClQDABviiDTBWrUidCOn/iR6SKVep
         7P9tbTQhjAEBati0PEr7KJd0GzpWhIerLX/BtXOXLvC+fTwkCfM/Hj5SgJp9yum/bb1Qznc1tjE6
         3tMx7ExLXY1y821ipYkuuelfpdP31zq/zL3ipJuYIxBBHuGaWnnPq++I8dYdCV/Ture6ssLqk9qC
         qcCXEO9lC+0o5c68yDTu7NMukeKRl1O04UQQC2cA8N9Kr2qFbphyC1HIieIeJ6IfywqBlXKajofI
         O2x5CIeWnDQh+ONXQVm8VaB+Gt3U57AncYVPzbSHGuo/sRxPzwOyHT2IcqQmNtTv4iUqMme0TEl/
         CuZ63UASKrVN7Ylw6O/N2yqTpEdXvUyAk5RQRMBU1FdfIY3Wa6eHYSWxzgK3VMt9AVTkjt2FDT2w
         1encBQgxY5THYl1runLZR1+trSAJvHQiZ8gtGSJwmy5ole1jRD60lrSLrsoAzJcweW5jFIfEvVJ2
         quMcPFQzMVZiEOpGHUgrbsVbM2lpYXNPYT0TNGcZbowROSBnw/gEqK6XoY1SquAj0S2SGZrFnVEh
         rj+wdVDzIkbrNbojMWEv1G1JkWvt6gsdIWZZgCvkltWD8U/OdcOyRHnlgbJJncplq2uVO/sjNeul
         fw5AvqlFOJUW1rebBiLRw9F+xJy49ZA5xYdVZqEND1+p2VWkBEHCSzw9E8e8cr0ppCgKhdMAFmBm
         ymULOurlgBRfIeZKtH6SY/6KRUEsomydJTRfpNl5zmUjj40C0xNJ5k0SD1JQKkT6qgAH/po+Q1rP
         cfaacsbGI0CrhReW36tO2u3h4ZBtlznK+ZlUdGM6Ok9boHcJb3JuvvMCpr0qOVHOq3AyYnD1RGzF
         0YUZGzbA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     daniel@ffwll.ch
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] fbdev: fbmon: fix potential divide error in fb_validate_mode
Date:   Sat, 14 Oct 2023 20:14:53 +0800
X-OQ-MSGID: <20231014121453.3034941-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can easily use FBIOPUT_VSCREENINFO set fb_var_screeninfo, so
it's possible for a divide by zero error to occur.

Fix this by making sure the divisor is non-zero before the computation.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/video/fbdev/core/fbmon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 79e5bfbdd34c..bdd15b8e3a71 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1470,6 +1470,9 @@ int fb_validate_mode(const struct fb_var_screeninfo *var, struct fb_info *info)
 	if (var->vmode & FB_VMODE_DOUBLE)
 		vtotal *= 2;
 
+	if (!htotal || !vtotal)
+		return -EINVAL;
+
 	hfreq = pixclock/htotal;
 	hfreq = (hfreq + 500) / 1000 * 1000;
 
-- 
2.30.2

