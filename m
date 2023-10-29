Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0E37DB085
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjJ2XHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjJ2XHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:07:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB8C6A45;
        Sun, 29 Oct 2023 16:01:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE17FC43391;
        Sun, 29 Oct 2023 23:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620475;
        bh=dOPID+WAHBe+1C/wlvaKW7GPyApeXN5OKVtbv1qYIlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3eyOualJXhzWHe5RlJaWiU+/gT8CdoFVth8C37P7ymeMqNSRawqyihbjKzJ76pkV
         uuE4vqm5Fzlfq7ijeyhTY7Y2TMRI2UpzT8otxJhHT1tzNyYXY+Uj7eggUprqv8Nbot
         uLvOxjpPHOTKEC4gNVf5Rt5RCLW67+RTOeFCRJ2s2I8BofT52UFZe1ZOzwQJx/19AB
         5jCJWMZ4PHlveXAe9gLQ/9AZHPzzSuQL2Fw95AyoMcmU/Wk3QlwszspsoZzSZAHkD0
         nZQ09pBV21z5/l9dV3Tyw1jTpN0iLxsdG1qL67kuzt9sZiuPNGKfq3YUMO47VffU/M
         0LsmViNFbDKZQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>, daniel@ffwll.ch,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 09/13] fbdev: core: cfbcopyarea: fix sloppy typing
Date:   Sun, 29 Oct 2023 19:00:42 -0400
Message-ID: <20231029230057.792930-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230057.792930-1-sashal@kernel.org>
References: <20231029230057.792930-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit 7f33df94cf0156f64eee9509bd9b4a178990f613 ]

In cfb_copyarea(), the local variable bits_per_line is needlessly typed as
*unsigned long* -- which is a 32-bit type on the 32-bit arches and a 64-bit
type on the 64-bit arches; that variable's value is derived from the __u32
typed fb_fix_screeninfo::line_length field (multiplied by 8u) and a 32-bit
*unsigned int* type should still be enough to store the # of bits per line.

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/cfbcopyarea.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/cfbcopyarea.c b/drivers/video/fbdev/core/cfbcopyarea.c
index 6d4bfeecee350..5b80bf3dae504 100644
--- a/drivers/video/fbdev/core/cfbcopyarea.c
+++ b/drivers/video/fbdev/core/cfbcopyarea.c
@@ -382,7 +382,7 @@ void cfb_copyarea(struct fb_info *p, const struct fb_copyarea *area)
 {
 	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy;
 	u32 height = area->height, width = area->width;
-	unsigned long const bits_per_line = p->fix.line_length*8u;
+	unsigned int const bits_per_line = p->fix.line_length * 8u;
 	unsigned long __iomem *base = NULL;
 	int bits = BITS_PER_LONG, bytes = bits >> 3;
 	unsigned dst_idx = 0, src_idx = 0, rev_copy = 0;
-- 
2.42.0

