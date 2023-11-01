Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0699F7DDFBE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjKAKt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKAKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:49:57 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB6103
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:49:53 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id y8nGq7z314QsMy8nHquUN7; Wed, 01 Nov 2023 11:49:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698835791;
        bh=2aMI4kaZmSRgyVFOxUmjlKR0UB3Yi5s4GgkvE78ZjEk=;
        h=From:To:Cc:Subject:Date;
        b=T9ffKPOEJxbuViGzfFTHIVaSl3YNHy06fGUxFiCi7i5faO8Gl0+r1nO7E87oWuFhe
         qM9j9M0OYXNJH6UYiqYK59ZHAxvSX1Ml4JdkAdSZk+SEACj/uRcx626tABaKIioR9s
         NwOrUp+mXZ3zDlkoQgCkFMGtCoeZt4hz76EcUoS6Nh88geZ1R9CQ4MVnAGnWOlmY9L
         QSZQ3XO0VCGyF76JzVw4Utsj/FazyT37KvHr1Ic0CzSXC6c3ZjeyOOikUkEl8rNxUA
         oH75VEzI9pzpR8bH22PFnV6rp/W4feAYqkRH3dvTDmkR4nc5XI899dGkd5vvciOncA
         l/IMGuRwV/7ow==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 11:49:51 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Hans de Goede <hdegoede@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] vboxsf: Avoid an spurious warning if load_nls_xxx() fails
Date:   Wed,  1 Nov 2023 11:49:48 +0100
Message-Id: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an load_nls_xxx() function fails a few lines above, the 'sbi->bdi_id' is
still 0.
So, in the error handling path, we will call ida_simple_remove(..., 0)
which is not allocated yet.

In order to prevent a spurious "ida_free called for id=0 which is not
allocated." message, tweak the error handling path and add a new label.

Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/vboxsf/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 1fb8f4df60cb..9848af78215b 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -151,7 +151,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (!sbi->nls) {
 			vbg_err("vboxsf: Count not load '%s' nls\n", nls_name);
 			err = -EINVAL;
-			goto fail_free;
+			goto fail_destroy_idr;
 		}
 	}
 
@@ -224,6 +224,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
 	if (sbi->nls)
 		unload_nls(sbi->nls);
+fail_destroy_idr:
 	idr_destroy(&sbi->ino_idr);
 	kfree(sbi);
 	return err;
-- 
2.34.1

