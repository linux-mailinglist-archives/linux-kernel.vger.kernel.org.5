Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDDC804BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344740AbjLEIKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjLEIKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:10:00 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D2211F;
        Tue,  5 Dec 2023 00:10:05 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 305AF4DB;
        Tue,  5 Dec 2023 09:09:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701763763;
        bh=LBo5JbsGnbR2WsOpAEu7E/zZBgullH/48QZtK26TE84=;
        h=From:Subject:Date:To:Cc:From;
        b=HG8dG+AqXVwiQyPqiYmya9Mifng3N9a8QJ9Z0dDtj0NpJt6qqmuOX+3LKcIAfe0p7
         9lK0NiTjCbAEWznaPmBEYTrpmaxkmPm9YnLdsvtvVXSGfs/MXET8RcU4OUoZh2D/Ru
         oGxn4VUmnNt1n8uqi01LTtYoh5Zr4mdxWbSTmT3E=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/4] media: rkisp1: Fix IRQ related issues
Date:   Tue, 05 Dec 2023 10:09:31 +0200
Message-Id: <20231205-rkisp-irq-fix-v1-0-f4045c74ba45@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALvabmUC/x2MSQqAMAwAvyI5G7ApLvgV8VA01SC4JCBC8e8Wj
 zMwk8BYhQ36IoHyLSbHnsGVBUxr2BdGmTMDVeQdVTXqJnai6IVRHmRHPnShaT1FyM2pnPX/G8b
 3/QBonC03XwAAAA==
To:     Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Elder <paul.elder@ideasonboard.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
        aford173@gmail.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=LBo5JbsGnbR2WsOpAEu7E/zZBgullH/48QZtK26TE84=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlbtrUj5VZRebXyHRSVoljHrBVDzmoMUPSIFx8k
 /xPcB8r22mJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZW7a1AAKCRD6PaqMvJYe
 9ae2D/9AuwDX4iqBukE8T3ay9UYyBvemxwdq4+ftsjLkKjqCn3iSTKsfOZRc0/WZwzASNSFLeZF
 x0gxzoscBHX9iAvWvgCCk/oY2pj0ogx7EcaSoA2axHbZzSCBvnfm8UMjcFBWyIxVS1dJLOLAAWP
 zaclpTbmD2QBMI12o69ydjh2eJ/PbrDQJKdbcRTV22bgMscE66dLuopWcgMeAmfvKUCFkNd+fYL
 XKrQZGO4Q8z2Xs8axCIiz/2P9CVOvYX+9cYksRxq+94l30bYFtmwGDMsefKvVZ5Oge9JiqxmQk1
 wCIqH9GORY5vq/3KadNS/i0jds59CxpqpVCVoh4cAszKOeS6rLJLJEf5TSQ/PEpLVorD2ig7O2B
 RFAlcm8G6RNNmU2hQnYtayAjS5df54nYTlyyuBYs1IASOiluoZbBnHcPZ+Pvqc+ZrYqqjcQAbxM
 FFYTpscnQc570dJhuxS7P7ys2K/Pxx8zOIRngOEHoFhuaElR28Lt5PoXA5yzg1NG/3TeD3fV9lR
 I0zt9KUGeuOwUuN3WHgfVdeSXGt3EmxPmV0A3x+lCJ7cdsg5zidVaQcfcr7X7tosI4xAflCHrlJ
 dSeHiGLaFFESaNJnLCNa7ZHGxIV/JJyo5dLPLsksdu5iWPlmcVPG+s8wg9awJ08LxhFXjrqWq6D
 uJFJfN1y/UeE6vw==
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

These fix a few IRQ related issues I noticed when testing i.MX8MP. These
are based on Paul's recently sent "[PATCH v4 00/11] media: rkisp1: Add
support for i.MX8MP" series, but could also be rebased on top of
mainline if needed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (4):
      media: rkisp1: Store IRQ lines
      media: rkisp1: Fix IRQ handler return values
      media: rkisp1: Fix IRQ handling due to shared interrupts
      media: rkisp1: Fix IRQ disable race issue

 .../platform/rockchip/rkisp1/rkisp1-capture.c      |  3 ++
 .../media/platform/rockchip/rkisp1/rkisp1-common.h | 13 ++++-
 .../media/platform/rockchip/rkisp1/rkisp1-csi.c    | 17 ++++++-
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    | 58 ++++++++++++++++++----
 .../media/platform/rockchip/rkisp1/rkisp1-isp.c    | 23 +++++++--
 5 files changed, 100 insertions(+), 14 deletions(-)
---
base-commit: dd19f89b915c203d49e3b23ca02446d4fb05d955
change-id: 20231205-rkisp-irq-fix-e123a8a6732f

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

