Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075577B4596
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 08:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjJAGVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 02:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbjJAGVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 02:21:00 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE36DA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 23:20:56 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id mpoyqui9X615Bmpozqjj2L; Sun, 01 Oct 2023 08:20:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696141254;
        bh=8VNyDNwvUj63WBSAVLx12j5A3luCQB3hSbdx06sW9dw=;
        h=From:To:Cc:Subject:Date;
        b=mZm6LI0qG50vdg0Uro8unjFDDj9mH+yKMAUMUQ2ocIobQyTbRkztvejkhx/9rI3jz
         Hl+ODEgwKZFYvl2X6ERvzj7iv6gsRXKfwqvRnDZw62N5+E+DI3QJp0tunDcRjQoYFO
         BRzMlDyHaol3lIdT0vaFhd6689GkUMYJa55fCjYYRB8Swp0U96eOtqnpaZJb77WxAL
         VZ/fJgqABRSSxmUCSls5JP5lA12rFNbDMJfl0/1I6f/28qBUjGUSWKKjpcuZXr95Vw
         esFvOZH7PFjQ8dgbdYYUjcbkFIZUDtrr6GszNWIzglg7UzEtixuwXls4uoB1WipZWT
         Mzl7W0rvq7JXQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Oct 2023 08:20:54 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Michael Shych <michaelsh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform: mellanox: Fix a resource leak in an error handling path in mlxplat_probe()
Date:   Sun,  1 Oct 2023 08:20:51 +0200
Message-Id: <8bd0a7944f0f4f1342333eaf8d92d8e9d5623110.1696141233.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful mlxplat_i2c_main_init(),
mlxplat_i2c_main_exit() should be called to free some resources.

Add the missing call, as already done in the remove function.

Fixes: 158cd8320776 ("platform: mellanox: Split logic in init and exit flow")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is based on comparison between functions called in the remove
function and the error handling path of the probe.

For some reason, the way the code is written and function names are
puzzling to me. So Review with care!
---
 drivers/platform/x86/mlx-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index 3d96dbf79a72..64701b63336e 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -6598,6 +6598,7 @@ static int mlxplat_probe(struct platform_device *pdev)
 fail_register_reboot_notifier:
 fail_regcache_sync:
 	mlxplat_pre_exit(priv);
+	mlxplat_i2c_main_exit(priv);
 fail_mlxplat_i2c_main_init:
 fail_regmap_write:
 fail_alloc:
-- 
2.34.1

