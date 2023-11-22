Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3B7F4929
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjKVOnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjKVOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:42:55 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A27497;
        Wed, 22 Nov 2023 06:42:51 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4232E641;
        Wed, 22 Nov 2023 15:42:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700664138;
        bh=m/zEIfXXTHvQjozZAyjiA6eqZQPUBkii1euXSnYoOvE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YP9asx6SDnlDNjkOD34Fz3GV/GuZuWTjB9tLPdQb3cvh1GK1PGI3jnm/eoIe+qFGt
         Diywgb9kB03JB7zlTkKO6R2NPSgJVqBuV1vtxTIN/2B1j8YAfFEoaZcek6ocFAHg8D
         o7I9SHopGhyZxZ4N8VMmkC9fjLblP1g+CHIv5hJQ=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 22 Nov 2023 16:42:22 +0200
Subject: [PATCH 1/2] media: rkisp1: Fix media device memory leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-rkisp-fixes-v1-1-1958af371e39@ideasonboard.com>
References: <20231122-rkisp-fixes-v1-0-1958af371e39@ideasonboard.com>
In-Reply-To: <20231122-rkisp-fixes-v1-0-1958af371e39@ideasonboard.com>
To:     Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Yichong Zhong <zyc@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Allon Huang <allon.huang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=m/zEIfXXTHvQjozZAyjiA6eqZQPUBkii1euXSnYoOvE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlXhNmoGXYrkOE3AdB7Fp5rvOueSko64nRBHCyK
 qKps9vLkRSJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZV4TZgAKCRD6PaqMvJYe
 9V4vD/9mS6a40zwMwT1NDJ+tXjKAo93DSsj3Q6ByOm9ye0/hPin7RMgZVFGa4q+ojuJnwwONjDb
 +TK2xaI3pQwgrd53zTS6cgTB0wcYLzShBoNMiDZpUP2jqM+p7vGfI/fAsGsphM67OoTNRh8VuBU
 oXYpKWgfgfIpiUujcLk9JbxzvnHQL8jZBV8xw2bjdxHuGovFWRGcegiCmF957Nyip8OJzNrP1tj
 X/wqq2vsdxdRmRTAF+WhqEAZBoJRlCCsV8k0R3hbemf/NgPoff+0Slnz9Iv8tIC1ffof83vNKu1
 U4nsbEEjIiCuOiVTWhE2+kTwcqThZXjWCPXzPJq3xNTugvYDmrCrl0l6cgti8n7XuhwqS7UJzvL
 BFuslCUgclBqOldOfLOFAMRm7tSlUqjdc3K2E3BZtCndzqO9zbrnCfSV4JqaUGAmfapIlm5ltRh
 NnIyIjIHo5t1v61964DsmBk+ezYh/uBBsNhvsi5vHJSo2JNqhUJWxw+1tZxqxuQ6QJ6rgXXHp6k
 lHOi0yBTgq9a4lbBdORqVHGG4WB2maQJq6egxHqmh1KU6N77c+Iw/5nNxqXHn/W/lmXQYV5Wrvf
 3BXb86pagpZjhXhsf7Qe7+CZ089UsFY+/dvlLlqtt5wWgZ/wxkhTiNLevHl9FJhIh+eDhsd8Q6L
 6VkHW9jMtVkw7AA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing calls to media_device_cleanup() to fix memory leak.

Fixes: d65dd85281fb ("media: staging: rkisp1: add Rockchip ISP1 base driver")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index c41abd2833f1..e10cc2881757 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -617,6 +617,7 @@ static int rkisp1_probe(struct platform_device *pdev)
 	media_device_unregister(&rkisp1->media_dev);
 err_unreg_v4l2_dev:
 	v4l2_device_unregister(&rkisp1->v4l2_dev);
+	media_device_cleanup(&rkisp1->media_dev);
 err_pm_runtime_disable:
 	pm_runtime_disable(&pdev->dev);
 	return ret;
@@ -637,6 +638,8 @@ static void rkisp1_remove(struct platform_device *pdev)
 	media_device_unregister(&rkisp1->media_dev);
 	v4l2_device_unregister(&rkisp1->v4l2_dev);
 
+	media_device_cleanup(&rkisp1->media_dev);
+
 	pm_runtime_disable(&pdev->dev);
 }
 

-- 
2.34.1

