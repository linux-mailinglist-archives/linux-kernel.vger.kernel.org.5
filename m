Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8C17C7B58
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjJMByd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 21:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMByc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:54:32 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3094BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 18:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5Tz6+
        l/Q7+gJHUeIVALmKaMD4X5CcMraadvh54wQsoc=; b=WHxvWJ2BWOQp3LI1ZmB2S
        av1mDSUnP9JWp0HX8NL1YhFI6gjTt47Pip0ahqsXo8Lm2y7jWDu5U2A7wWmAidWa
        iPsVUThkLvZOQhN4c0GJDTObTQG4p1PK5J7VzqMbRPI3wayvSyv8OCfS9Yd51H3u
        EaytMOawdDyZGsC/TYpNiY=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wDHr60poyhlbuSdAQ--.16620S4;
        Fri, 13 Oct 2023 09:53:53 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        guchun.chen@amd.com, yifan1.zhang@amd.com, Tim.Huang@amd.com,
        make_ruc2021@163.com, zackr@vmware.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/vkms: fix a possible null pointer dereference
Date:   Fri, 13 Oct 2023 09:53:43 +0800
Message-Id: <20231013015343.290456-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHr60poyhlbuSdAQ--.16620S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruryxAF1xKr43KFW5ZryUtrb_yoWftrg_uF
        W8Xrn3Zw43ZF10vr17Zw4fZwn0yF15Za1kGr1Sva9av3sFva17XryDtrn5X3WxuF17CFnr
        X34jgr13A3ZrCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKpnQ7UUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFR0IC2B9ofy3QAAAs8
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In amdgpu_vkms_conn_get_modes(), the return value of drm_cvt_mode()
is assigned to mode, which will lead to a NULL pointer dereference
on failure of drm_cvt_mode(). Add a check to avoid null pointer
dereference.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 7148a216ae2f..db6fc0cb18eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -239,6 +239,8 @@ static int amdgpu_vkms_conn_get_modes(struct drm_connector *connector)
 
 	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
 		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
+		if (!mode)
+			continue;
 		drm_mode_probed_add(connector, mode);
 	}
 
-- 
2.37.2

