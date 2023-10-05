Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B327BA474
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbjJEQFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbjJEQED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B27C660F2;
        Thu,  5 Oct 2023 07:51:26 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4c53:5fd0:f25b:b0dd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CFC116607332;
        Thu,  5 Oct 2023 15:51:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696517480;
        bh=8E9tatO7XF3qA6yFPN13hUYBUv5FfV7BEJl+01O2HNE=;
        h=From:To:Cc:Subject:Date:From;
        b=ZhaVFHLeSCV0wkWBCRlcchb7HcokXa6OUJGAtEevwIq7LrpHacYltDGrk8rRFcCDU
         oBNbqJu4I/bqQau24FMLCp7P9+DVl+khhcRIw5R415LWXRUaKY0YaRwEUnDTn6xMEc
         4zXk/w5A/ulPVFprS1OyAHIXngyxO9+WW70F0LvkXLDNWFaXlbhn2pKKmLdMk91S2N
         jnjO1lhQnm80EFbclxjG/jKQNe1DY28dnuozgRS07GMgiUJYZxdNSAqbssDpCQVTyz
         6r1DoC1Z1aBpejtZmfsxzeO2pijk9g6LhTLpzL1ZIGmz9K+NM1upwYcfcUAbJkSheY
         UIqUb4apP6NpA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: verisilicon: Fixes clock list for rk3588 av1 decoder
Date:   Thu,  5 Oct 2023 16:51:16 +0200
Message-Id: <20231005145116.169411-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mainlined RK3588 clock driver manage by itself the dependency between
aclk/hclk and their root clocks (aclk_vdpu_root/hclk_vdpu_root).
RK3588 av1 video decoder do not have to take car of it anymore so
remove them from the list and be compliant with yaml bindings description.

Fixes: 003afda97c65 ("media: verisilicon: Enable AV1 decoder on rk3588")
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 816ffa905a4b..f97527670783 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -648,7 +648,7 @@ static const char * const rockchip_vpu_clk_names[] = {
 };
 
 static const char * const rk3588_vpu981_vpu_clk_names[] = {
-	"aclk", "hclk", "aclk_vdpu_root", "hclk_vdpu_root"
+	"aclk", "hclk",
 };
 
 /* VDPU1/VEPU1 */
-- 
2.39.2

