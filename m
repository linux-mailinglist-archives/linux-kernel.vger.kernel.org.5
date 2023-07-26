Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E0B762FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjGZIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjGZIcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:32:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164CB6E86
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:22:56 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1ADB466015A0;
        Wed, 26 Jul 2023 09:22:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690359774;
        bh=2FI4H4ZuB88bJj5ThgiVFOLbFXbRfR4pQKiai84ySXE=;
        h=From:To:Cc:Subject:Date:From;
        b=htPJevGv9woHxVLnVshT+DxXQ5Qw8YdZjOtXszz0ml3btE1K0XA7IPUhfVbs9XjPh
         QzdxoOiMk4L2UZo17kkxO8JGF7UBJy0rPPkLsOMqzI69EYcJFD+94a1vu2zDqY6fJm
         rC2oqWJAaH+oHnrBtVzJxlPDLP6Lc5ud5TYMjaEsHX+AOs6Vk9OdXuMjavwthuWx3m
         tAVNnzjbFvM3wycKbTaxR+Y0jLqSs6rqBZ6c2svDMgUj0wY3TealqIAX/54mOBC/hv
         C1OcuptPopAWpMFyFlemQ2QSH7WdeY4kxWZZS0vh7xIoMnl7hhVWt3Y7GFmFMrC9P0
         dX1l16lkpjqzw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        fshao@chromium.org
Subject: [PATCH v3 0/6] drm/mediatek: Small mtk-dpi cleanups
Date:   Wed, 26 Jul 2023 10:22:39 +0200
Message-ID: <20230726082245.550929-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 - Fixed removal of mtk_dpi pointer in mtk_dpi_remove on patch [1/6]
   instead of patch [3/6]; thanks CK Hu!

Changes in v2:
 - Removed drm_bridge_remove() call in patch 1
 - Added dev_err_probe print to devm_drm_of_get_bridge()
   call error handling
 - Switched to devm_platform_ioremap_resource() to remove
   the useless pointer to struct resource in probe function
 - Added a commit to compress struct of_device_id entries
 - Added a commit to switch to .remove_new() callback

This is a small cleanup of the mtk-dpi driver, switching it to devm
variants where possible and where it made sense, and reducing lines
while retaining and improving human readability.

AngeloGioacchino Del Regno (6):
  drm/mediatek: mtk_dpi: Simplify with devm_drm_bridge_add()
  drm/mediatek: mtk_dpi: Simplify with dev_err_probe()
  drm/mediatek: mtk_dpi: Switch to devm_drm_of_get_bridge()
  drm/mediatek: mtk_dpi: Switch to .remove_new() void callback
  drm/mediatek: mtk_dpi: Use devm_platform_ioremap_resource()
  drm/mediatek: mtk_dpi: Compress struct of_device_id entries

 drivers/gpu/drm/mediatek/mtk_dpi.c | 100 +++++++++--------------------
 1 file changed, 32 insertions(+), 68 deletions(-)

-- 
2.41.0

