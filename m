Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686E07F4B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbjKVPvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjKVPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:50:36 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23310D42;
        Wed, 22 Nov 2023 07:50:33 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C84F2641;
        Wed, 22 Nov 2023 16:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700668199;
        bh=GWSvmigvhbqxxKwsO8s1wxYTODF1EHzXekCVLlbZGxI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hwzEUySDhdg7+rV4lAQv1SLbaMq4f5LP3XGp0v8sHnCVXjnUyl0SO7+KttWy3qd2V
         ONCgstHK1hey+zQcUHwkd7jQB80umbQ68bN4Z1oIfOBPCFBF3Fb1GgBwHFHmMTjTby
         0u85d2oWQM5WqA6W6rSwkwJa2jMvx9VPIjAT6N+I=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 22 Nov 2023 17:50:08 +0200
Subject: [PATCH v2 2/2] media: rkisp1: Fix memory leaks in
 rkisp1_isp_unregister()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-rkisp-fixes-v2-2-78bfb63cdcf8@ideasonboard.com>
References: <20231122-rkisp-fixes-v2-0-78bfb63cdcf8@ideasonboard.com>
In-Reply-To: <20231122-rkisp-fixes-v2-0-78bfb63cdcf8@ideasonboard.com>
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
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Tommaso Merciai <tomm.merciai@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=940;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=GWSvmigvhbqxxKwsO8s1wxYTODF1EHzXekCVLlbZGxI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlXiNCOLg/ZNZkH5JNt4+lP3cqdiX2JgWJ0yFPo
 ckl7sgXzkyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZV4jQgAKCRD6PaqMvJYe
 9fWRD/9StEmHs8CUsFrm3u/UhmQD6eVyKBwAImdgigY4oTPn41xWao/S59SXpr3e88F9bXGxcMZ
 6rnSXhmN7BDKXLKnWttYjjKhkYpLSaxegHh55Z4xtfr3u0wXzdWcC3NEH6HS94P48DjKHuHzzBU
 Gr04pONVTSW+ns9cdVhJynYL2qzL4V2BFb7hQYKS1rAazEYhCVoUaC1EfEs0xm6wt5nk2HQGlP0
 tIpbqw+/2Jld19VUWran31Omv5uB+Z0RjRLRodX4vu0505piKnTt78v4Kly6xUU73WgIlh7YCp+
 9rknI0dcamE4ZCdv+dlCjENspgLNgfP1/09L2urGYQTcd6ggOttdO2Qg0KBfzcDTbrBVp64qQMn
 qFF6wovam1VktcLAFtH9crxOKWo+ZP8OU53xXj9IqpVQDO0mKZ5kYhKBzjU6t6tzXu2Z2d5uWgk
 TuSwTAfKKFRgjBn23rCbc3xzX53yKDURqxeNH6ZbTmA54ulm0vAlKwKb8uXgk1axttXuXaNMkoe
 Qp0vaz6pijRptgcMSEjMpeKY0xgjMsz8cCWG377otml93uq9BKemmP0IAZMNLb5d4KBs40Vz725
 y81xyOlm4aUtZfRvZvRNkx8Y22HHL2YhtupQjAel9hxFF1W3kcuGso4wuqky0GaAz9Qqf0zHZEj
 5JAOoWZlF2PmAFw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing call to v4l2_subdev_cleanup() to fix memory leak.

Fixes: 2cce0a369dbd ("media: rkisp1: isp: Use V4L2 subdev active state")
Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index 88ca8b2283b7..45d1ab96fc6e 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -933,6 +933,7 @@ void rkisp1_isp_unregister(struct rkisp1_device *rkisp1)
 		return;
 
 	v4l2_device_unregister_subdev(&isp->sd);
+	v4l2_subdev_cleanup(&isp->sd);
 	media_entity_cleanup(&isp->sd.entity);
 }
 

-- 
2.34.1

