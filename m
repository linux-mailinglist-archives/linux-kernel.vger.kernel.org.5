Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58627B44AF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbjI3XoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbjI3XoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:44:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B1FAC;
        Sat, 30 Sep 2023 16:44:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBB5C433C8;
        Sat, 30 Sep 2023 23:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696117444;
        bh=BEks8HaDvSubS8uxPTW2QSiBpwY7OijnnKFGqECTObg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KcDxKg5kNamfks/Id5aFchU30jWVqLW7FkC9wjYU5sZmr7XNqLQDSqgrOBxJwxVg+
         9+HYvS4RoAZG4299WqKpp/NhNfbn42wxeM01bR+kaPKQvimovSV1qE1Huc4goTPo5f
         uAAse1tZSUpDJrjeow1mnDqw36eoelabuZ0qXuZ/XjQhNjkGZ++EfLLA5oUhSEsVME
         sepFI+VW0OCV/wk2luxOmuXxyhyp8xyfyFf2QNYBv+c4hF11kCkxhIye/MA731H2my
         cHHQQnn8/Rw6ao5YrYjghk9m37ZRHuL4fMA3HI5wh/rejJHrJlDWDJlgwBbaSgx74Q
         A79EuIzmRkIaQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 01 Oct 2023 01:43:40 +0200
Subject: [PATCH 3/3] Input: qt1050 - Convert to use maple tree register
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-input-maple-v1-3-ed3716051431@kernel.org>
References: <20231001-input-maple-v1-0-ed3716051431@kernel.org>
In-Reply-To: <20231001-input-maple-v1-0-ed3716051431@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BEks8HaDvSubS8uxPTW2QSiBpwY7OijnnKFGqECTObg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGLK9iJCL4tJTga+xDHMZqbKIe1TesSPnVwMtX
 ptSnTMjBc+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRiyvQAKCRAk1otyXVSH
 0LycB/9hXFah9KqbRqYjjcBLcSuJ2H9YxGyTHq4/1MfbwNz4ffTCn7OpFXofQtFcl8WxzAnUZdl
 Qa2jVj1X9wC7lHQZoV0Pcl4S6NzwFulxef1ve4kC3pzD6psefwVY7qOXadL2/Qr7FObf0EgW0RU
 aGIkif5JQRGi8OnKiuZgfbIDsUJ+Fj2BaECXy1/rtMKUZyow+pzaK5w4smbE1/pt7a0Lzqc80t5
 GYKMu9njbrc+nDW0627itxBTK79CSxKBMLv80M9bBBD8caQJhYO7PkQYBzKeKUgME8VFqaqmAci
 IFJp2M2iY6ne6k6NFGzqv6VUhadbSMhhoZ/TXKxA2j53fFWL
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/input/keyboard/qt1050.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1050.c
index 6953097db445..b51dfcd76038 100644
--- a/drivers/input/keyboard/qt1050.c
+++ b/drivers/input/keyboard/qt1050.c
@@ -213,7 +213,7 @@ static struct regmap_config qt1050_regmap_config = {
 	.val_bits = 8,
 	.max_register = QT1050_RES_CAL,
 
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 
 	.wr_table = &qt1050_writeable_table,
 	.rd_table = &qt1050_readable_table,

-- 
2.39.2

