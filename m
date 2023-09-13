Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB2E79EF33
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjIMQrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjIMQrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:47:10 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFD949D8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:44:22 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gSyJqOeao1XYugSyTqLc1G; Wed, 13 Sep 2023 18:44:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694623461;
        bh=4tJWCiqWBtSChD2W3vJJ1lqy/lx4y9b9BGC/j3xrouI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RGYPGv4ElBKDitRaXHwvBONO3lX663NaEQ1P0kWZXNYxYELJpwBAbfp1tFiKRmU5U
         xTb1Qmo3WM/YvCAuAJjSPoO0ZzsF2hCFpCOrgOFHHd2PsVZSdY5rMDEAi1xuKrWsOp
         urgmJYTypZP4NsSLu4vlV+P3uUKTwidvd6fsWeK2ebQGuVuYwfpiyf/FGoGCm5uxmc
         rGYHCeaXcBIK1BUdFbmCSsr1mdoY7J5VljYHsICrUBix+3th7gPdQ7BiAfv+vAY6VZ
         cFkbKMHouZ3Jn4lybRJ2oITey+M0ALlAhcUiweU4G2pgdNJ+xqEJc89CvU9ZRCJLNp
         sLmqOirI5kAmQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 13 Sep 2023 18:44:21 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-bcachefs@vger.kernel.org
Subject: [PATCH 2/2] bcachefs: Remove a redundant and harmless bch2_free_super() call
Date:   Wed, 13 Sep 2023 18:44:09 +0200
Message-Id: <4318418c88f28b041af018ab2250f442cb9776ed.1694623395.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3ab17a294fd2b5fcb180d44955b0d76a28af11cb.1694623395.git.christophe.jaillet@wanadoo.fr>
References: <3ab17a294fd2b5fcb180d44955b0d76a28af11cb.1694623395.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a redundant call to bch2_free_super().

This is harmless because bch2_free_super() has a memset() at its end. So
a second call would only lead to from kfree(NULL).

Remove the redundant call and only rely on the error handling path.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/bcachefs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 7379325c428f..a9627e655666 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1609,7 +1609,6 @@ int bch2_dev_add(struct bch_fs *c, const char *path)
 
 	ca = __bch2_dev_alloc(c, &dev_mi);
 	if (!ca) {
-		bch2_free_super(&sb);
 		ret = -ENOMEM;
 		goto err;
 	}
-- 
2.34.1

