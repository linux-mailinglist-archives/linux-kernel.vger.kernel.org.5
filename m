Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DBF7D7F70
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbjJZJSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:18:24 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 49173187;
        Thu, 26 Oct 2023 02:18:20 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 5036A608E52BE;
        Thu, 26 Oct 2023 17:18:17 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     dan.carpenter@linaro.org, lukas@wunner.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch
Cc:     Su Hui <suhui@nfschina.com>, tiwai@suse.de, Jim.Qu@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] vga_switcheroo: Fix impossible judgment condition
Date:   Thu, 26 Oct 2023 17:18:04 +0800
Message-Id: <20231026091804.967960-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'id' is enum type like unsigned int, so it will never be less than zero.
It's better to check VGA_SWITCHEROO_UNKNOWN_ID too.

Fixes: 4aaf448fa975 ("vga_switcheroo: set audio client id according to bound GPU id")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
v2:
 - add check of VGA_SWITCHEROO_UNKNOWN_ID(Dan's suggestion). 

By the way, all functions of 'get_client_id' will never return error code
or VGA_SWITCHEROO_UNKNOWN_ID，should we remove this check or keep it for
future.

 drivers/gpu/vga/vga_switcheroo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 365e6ddbe90f..cf530094f929 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -375,7 +375,7 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
 	mutex_lock(&vgasr_mutex);
 	if (vgasr_priv.active) {
 		id = vgasr_priv.handler->get_client_id(vga_dev);
-		if (id < 0) {
+		if ((int)id < 0 || id == VGA_SWITCHEROO_UNKNOWN_ID) {
 			mutex_unlock(&vgasr_mutex);
 			return -EINVAL;
 		}
-- 
2.30.2

