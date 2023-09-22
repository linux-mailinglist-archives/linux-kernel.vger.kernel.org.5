Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722A77AA67C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjIVB0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjIVB0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:26:02 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EC7F18F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FLR5V
        SYqhjZdAddiOMBK6+vIndH7dJAeROYe1W7Jiyk=; b=mj327/rSd056IG8uKrsAr
        PD62SZ/MEJHgtpbHLQY/NUk2ewOMdIeFRRgSrZbjhB2R/3asyjAvuCs8SPORHz75
        vAgF9jJhS2ogiKj1ozqBv6xbRGKClx/g47kUVPC6HJGkDv7h0InQr6gZiTl7q/+d
        8nqS4zqzAN2WEFOY0fMFtU=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g0-1 (Coremail) with SMTP id _____wBH6SQF7Qxlm6O9Aw--.10024S4;
        Fri, 22 Sep 2023 09:25:37 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     alain.volmat@foss.st.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] drm/gem: avoid potential dereference of error pointers
Date:   Fri, 22 Sep 2023 09:25:23 +0800
Message-Id: <20230922012523.3602764-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBH6SQF7Qxlm6O9Aw--.10024S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyUWw4rGr47XrWrtFy8Grg_yoW3trc_Wa
        1UXrnxCry7G3WjvF1jyws8AasYkrZYgF48X3W8tay3Ar40vry8X3y2gF1rGF1UWF4jqFyD
        ta1xC34YqF9akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM5l8UUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRnyC2B9oNhVuwAAs+
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
 drivers/gpu/drm/sti/sti_gdp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
index 43c72c2604a0..054ce8455478 100644
--- a/drivers/gpu/drm/sti/sti_gdp.c
+++ b/drivers/gpu/drm/sti/sti_gdp.c
@@ -638,6 +638,8 @@ static int sti_gdp_atomic_check(struct drm_plane *drm_plane,
 
 	mixer = to_sti_mixer(crtc);
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
 	mode = &crtc_state->mode;
 	dst_x = new_plane_state->crtc_x;
 	dst_y = new_plane_state->crtc_y;
-- 
2.37.2

