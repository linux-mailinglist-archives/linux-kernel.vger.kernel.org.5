Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5259B7C4750
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbjJKBeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344233AbjJKBeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:34:20 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5D7691
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WIGsW
        AH/iA3oJPpW3K+uYoJ9SzV46v5QlbmbaUJ1e3A=; b=hpwCytQPT6y4uIuhxlcTO
        GtPuYOYjDD4hpsUMwH76G9WQ0RHFIH55gSiHAaYxgALiZYmgxl7vXuxKeRJVE5VJ
        3P7DcdplD+F9++G75VdRhgIXvmZbtmzV9uP6zEriNnfUNp8LntZLx3xLA6Jn2Wun
        gtcZoaL0/KywX40nw25AEw=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g0-2 (Coremail) with SMTP id _____wDn76Jd+yVlvWboAA--.39607S4;
        Wed, 11 Oct 2023 09:33:24 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] drm/edid: fix a possible null pointer dereference
Date:   Wed, 11 Oct 2023 09:33:16 +0800
Message-Id: <20231011013316.4091845-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDn76Jd+yVlvWboAA--.39607S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW5Zr1fAry7KF4Uuw48Zwb_yoW3Wwc_uF
        y8X39xGrnrua48ArsrZayfZrySyF1rZFW8Gr1Uta4Sy3yDCF15J347KFnYqryxWa1jyF9r
        Ja4Uua1fCF47GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKhL07UUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyAUGC1p7MF401AAAsv
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drm_mode_std(), the return value of drm_gtf_mode(),
drm_gtf_mode() and drm_cvt_mode() is assigned to mode,
which will lead to a NULL pointer dereference on failure
of drm_gtf_mode(), drm_gtf_mode() and drm_cvt_mode().
Add a check to avoid null point dereference.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/gpu/drm/drm_edid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 340da8257b51..e2c154c2b896 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3381,6 +3381,8 @@ static struct drm_display_mode *drm_mode_std(struct drm_connector *connector,
 				    false);
 		break;
 	}
+	if (!mode)
+		return NULL;
 	return mode;
 }
 
-- 
2.37.2

