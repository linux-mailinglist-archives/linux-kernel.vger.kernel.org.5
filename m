Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3127D93AD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjJ0J3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0J3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:29:43 -0400
X-Greylist: delayed 606 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 02:29:40 PDT
Received: from s01.bc.larksuite.com (s01.bc.larksuite.com [209.127.230.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD9AAF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=dingdao-com.20200927.dkim.feishu.cn; t=1698398370;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=TV5y0friYH6HbXqokPo9rMztc3feSByAfx6Q6GDDtx0=;
 b=t8dCWO16iW+U4zgIxZbRsNc/FJKvjfXlglhcPPOsNMmWwH1gt92vhnMrmx34M/dG+/aQkc
 24UXLNZrFCAkNDYN8HztMQNONHPwsqrakm7Iw7tKi5bqM8fctfNFreexE/RkiBoMVNmsSJ
 2byTCFfaqiuttwn5j2bUE3o4L22Pf/1sFRwswyizetMu7/7Gjqnqb06jpk4JakaBXMzAVu
 e546m8lmJHJ225+JJTuQXX2UOvEo72wzLP0x2NmZfOOVfvhl1vEgHYjKWSEN4Sndo0B4yn
 upf0PdrYPmJtVg9BWYGJbRf+bZdha888lY/bbdSiXqj5z9yiE6x5Ok4YjZXCpg==
Subject: [PATCH] gpu/drm/drm_framebuffer.c: Add judgement for return value of drm_get_format_info().
X-Original-From: Peng Hao <penghao@dingdao.com>
Cc:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <penghao@dingdao.com>
From:   "Peng Hao" <penghao@dingdao.com>
X-Lms-Return-Path: <lba+2653b80a1+0262e2+vger.kernel.org+penghao@dingdao.com>
Message-Id: <20231027091912.1244107-1-penghao@dingdao.com>
Content-Transfer-Encoding: 7bit
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.37.1
Date:   Fri, 27 Oct 2023 17:19:12 +0800
Mime-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since drm_get_format_info() may return NULL, so a judgement of return
value is needed to add.

Signed-off-by: Peng Hao <penghao@dingdao.com>
---
 drivers/gpu/drm/drm_framebuffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index aff3746dedfb..be7dd1998c04 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -194,6 +194,10 @@ static int framebuffer_check(struct drm_device *dev,
 
 	/* now let the driver pick its own format info */
 	info = drm_get_format_info(dev, r);
+	if (!info) {
+		drm_dbg_kms(dev, "no matched format info\n");
+		return -EFAULT;
+	}
 
 	for (i = 0; i < info->num_planes; i++) {
 		unsigned int width = fb_plane_width(r->width, info, i);
-- 
2.37.1
