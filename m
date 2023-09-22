Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CDD7AA68B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjIVBb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIVBb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:31:56 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADAD2F1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KQLUY
        a3KKK3ZT24Fs/QQWKicsaIGPOdPCRwIWIKrD1s=; b=luycWt4Zg1BUPG+yqMYIe
        WfdPUppsH7JDy5y1wIqUg0z5/yC1zB5zfZl394OPmr8RPrvKJyewqc1BjXdl67D8
        2uMBZUu+G7wZ8AyDo/e+xZ1q01c9vK/dSU4GWTC8PUIsVnMs0pDuD8tY5RK1+Mph
        f9caR/XRExSlgt2epdqVoQ=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wB3fS5X7gxlowDGAw--.9931S4;
        Fri, 22 Sep 2023 09:31:15 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     alain.volmat@foss.st.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] drm/sti: avoid potential dereference of error pointers
Date:   Fri, 22 Sep 2023 09:31:01 +0800
Message-Id: <20230922013101.3603005-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3fS5X7gxlowDGAw--.9931S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyUWw4rGr43ZFW7Jw13Arb_yoW3trg_G3
        WUXr1fKrWDKa1jqF4jyrn8JasY9rZ5XF48Xr1Iqas8ur4kAry8X347Wr1fWFyUWF18tFyq
        qa1xur90krn0kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNCzt7UUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFQXyC2B9oNhq-QAAsb
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of drm_atomic_get_crtc_state() needs to be
checked. To avoid use of error pointer 'crtc_state' in case
of the failure.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/gpu/drm/sti/sti_cursor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
index db0a1eb53532..e460f5ba2d87 100644
--- a/drivers/gpu/drm/sti/sti_cursor.c
+++ b/drivers/gpu/drm/sti/sti_cursor.c
@@ -200,6 +200,8 @@ static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
 		return 0;
 
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
 	mode = &crtc_state->mode;
 	dst_x = new_plane_state->crtc_x;
 	dst_y = new_plane_state->crtc_y;
-- 
2.37.2

