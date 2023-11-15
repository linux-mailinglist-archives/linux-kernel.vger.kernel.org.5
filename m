Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5E67EBC3A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjKODlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjKODk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:40:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDBEEB;
        Tue, 14 Nov 2023 19:40:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3832EC433C7;
        Wed, 15 Nov 2023 03:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700019655;
        bh=tVgL1iVBYEHLvnBl1jIyCmnRPWjf5BlC0AfaKk93HBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HiTcSslF8Bo8X70rFCFtJvBQjAjFLjWq4XHd2i+3kFRaSVhZS8fY9P1TTGpKuryF7
         ufF9AYFe70zkQtSmX5MPOvjeRRE0XN3lZVgzRY62zJPcnsQx5jP66rWFjydxrwjk5i
         +X0Su1rmciYFwCCHpLJbvXW3mB+8eKcFe6ihJGhmabMTGgIgaUe6ZhDXLdjI60Dsrt
         lkvb/Il4xbLnc/VN20jE1v1dwLSvTmsJU5+BXwTy/szpi9vJFquI1rX/LQqD/g+tmM
         rf30B2JzDS10azJ5uW2FQccZbgivWuJngRREn7Bgfn82Q0w8Mh12A1ir0INQ/IVL+2
         YguGA0o/BmMWQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zongmin Zhou <zhouzongmin@kylinos.cn>,
        Dave Airlie <airlied@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>, kraxel@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch, virtualization@lists.linux.dev,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 2/4] drm/qxl: prevent memory leak
Date:   Tue, 14 Nov 2023 22:40:12 -0500
Message-ID: <20231115034024.1236659-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115034024.1236659-1-sashal@kernel.org>
References: <20231115034024.1236659-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.138
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

[ Upstream commit 0e8b9f258baed25f1c5672613699247c76b007b5 ]

The allocated memory for qdev->dumb_heads should be released
in qxl_destroy_monitors_object before qxl suspend.
otherwise,qxl_create_monitors_object will be called to
reallocate memory for qdev->dumb_heads after qxl resume,
it will cause memory leak.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
Link: https://lore.kernel.org/r/20230801025309.4049813-1-zhouzongmin@kylinos.cn
Reviewed-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/qxl/qxl_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 9e0a1e8360117..dc04412784a0d 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1221,6 +1221,9 @@ int qxl_destroy_monitors_object(struct qxl_device *qdev)
 	if (!qdev->monitors_config_bo)
 		return 0;
 
+	kfree(qdev->dumb_heads);
+	qdev->dumb_heads = NULL;
+
 	qdev->monitors_config = NULL;
 	qdev->ram_header->monitors_config = 0;
 
-- 
2.42.0

