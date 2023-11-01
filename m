Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833B67DDFC1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjKAKuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjKAKuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:50:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C17EE8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:49:59 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id y8nGq7z314QsMy8nNquUNu; Wed, 01 Nov 2023 11:49:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698835798;
        bh=ZFoT46jhWC+OotEkeda4BBrZIJT+3NpRAKetJm3pBjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=E8ypWe7QgSH/1hVNdu7NjKwR6dgkPxmlT6wOrOuy+qIK8qWSkzW/in+i1zDWc9/eu
         sdH7yEEQTPrkmlVN7ZjOA4DONg64WFIS8EFuXXmM732OOb6S3MHo9fxxmQVnca+eR9
         aX/AIA9S2BaUtXguHsf4hqAn9ArijpRLukoYpS0OnvyAsBQYAY5O32aU/nGU6DOQWD
         N/5B1xKkyjd/ToWslTf2CcI+xF9JiwgGjz5mIMYBzAa5Ux18Tg6J9O70Z3aZCfKWci
         IqtBFU07TJKh4AZ9mmpruRlQFtzx+TLpIEw8fbIe1g+XHoT07GN88kC+36ocS9iRBz
         VHbrGWbtQfNIQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 11:49:58 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] vboxsf: Remove usage of the deprecated ida_simple_xx() API
Date:   Wed,  1 Nov 2023 11:49:49 +0100
Message-Id: <b3c057c86b73f0309a6362031d21f4d7ebb60587.1698835730.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
References: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/vboxsf/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 9848af78215b..0f67f2d8b651 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -155,7 +155,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 	}
 
-	sbi->bdi_id = ida_simple_get(&vboxsf_bdi_ida, 0, 0, GFP_KERNEL);
+	sbi->bdi_id = ida_alloc(&vboxsf_bdi_ida, GFP_KERNEL);
 	if (sbi->bdi_id < 0) {
 		err = sbi->bdi_id;
 		goto fail_free;
@@ -221,7 +221,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 	vboxsf_unmap_folder(sbi->root);
 fail_free:
 	if (sbi->bdi_id >= 0)
-		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
+		ida_free(&vboxsf_bdi_ida, sbi->bdi_id);
 	if (sbi->nls)
 		unload_nls(sbi->nls);
 fail_destroy_idr:
@@ -269,7 +269,7 @@ static void vboxsf_put_super(struct super_block *sb)
 
 	vboxsf_unmap_folder(sbi->root);
 	if (sbi->bdi_id >= 0)
-		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
+		ida_free(&vboxsf_bdi_ida, sbi->bdi_id);
 	if (sbi->nls)
 		unload_nls(sbi->nls);
 
-- 
2.34.1

