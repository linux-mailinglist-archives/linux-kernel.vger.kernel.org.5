Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1FC7E8CB4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 21:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjKKUpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 15:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKKUpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 15:45:36 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3122D73;
        Sat, 11 Nov 2023 12:45:31 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40838915cecso24756385e9.2;
        Sat, 11 Nov 2023 12:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699735530; x=1700340330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1GkldlTDmPluuvc25beXnNrRPdT3yBfUXiF7PvmZBoU=;
        b=igikoE07FWz+f0R7yAYolVossedFUBOmjV37o8cwYHUBDIk/x5Jmq57bzeIIHoPaql
         LiJUhZACoGZJ4rmCavLpeUR16+Zl9Srye3NbTg/UuxYjKWah4Y6uHatvYMVfDtsKqv/R
         LvXrnJjId3KndWzozdiznVRe6G+Z0nnGG8PjjI2GjAMZPi8W7cEJiIc2r3Qt+OwyLOBu
         DgVQtJOBK7ejZ9AFMmGQxeJHFomlrDolKxCxEOnWagDykovKhPa1zwaTzPmQelfDTfRY
         GTRLGr2JTWbZhCeabS20rNp4kGFBLgmn0nLHkTdu49yatphuRpugZ7I6VfXJ91aSofPA
         6h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699735530; x=1700340330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GkldlTDmPluuvc25beXnNrRPdT3yBfUXiF7PvmZBoU=;
        b=HDQ2SwNidDdR5Zw+urfmcyxv6JtcR+8vPvsmF1GoB785TxhG3TkwMLM13xiHKlbYYh
         6QHTZVhAciPeYh6LNdxfHszoxjqpbMo+5/Q6lR8GlVhLjNJh1WZVuA+DkUTTUODLza5B
         eP9vOE7GZUsSvvZvWwNGPsvyTwgtM0Kd4IQzvFnKDaFoJ4KaAG6DJtRkDCLjU9rdye/9
         84yGW6lAMjHJRXohUKbYZ6tIouzjw5s3/ErH3Mwn1nF7X0anafso246IvvMYNm/bR7M1
         xa2TzyExCAaByDyqNhFI9/tPP6ctIC6fGnhdaqyuCILSSmJb5flRub1lZmoUkEZ+sEsd
         /Asg==
X-Gm-Message-State: AOJu0YypRnBpjshuyjR5/BG+hxE9X4MOowfakHeIZPwq4TjP4whvC0h3
        ujm+Bb2Hs4Rq7NHdhlEju3s=
X-Google-Smtp-Source: AGHT+IEnG0zD2f7qH3b+zOSNLBJ3Zr1VKfrMVYdqbVgJgmSEwlnGeKJ9RWtK/ctqWpAANAnUP0wnsg==
X-Received: by 2002:a05:600c:6022:b0:409:c1e:7fe8 with SMTP id az34-20020a05600c602200b004090c1e7fe8mr2295978wmb.19.1699735529845;
        Sat, 11 Nov 2023 12:45:29 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b004068e09a70bsm3042688wmj.31.2023.11.11.12.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 12:45:29 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] bcachefs: remove redundant initialization of variable level
Date:   Sat, 11 Nov 2023 20:45:28 +0000
Message-Id: <20231111204528.339603-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable level is being initialized a value that is never read, the
variable is being re-assigned another value several statements later
on. The initialization is redundant and can be removed. Cleans up
clang scan build warning:

fs/bcachefs/btree_iter.c:1217:11: warning: Value stored to 'level'
during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/bcachefs/btree_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
index c2adf3fbb0b3..bd04aeda37bb 100644
--- a/fs/bcachefs/btree_iter.c
+++ b/fs/bcachefs/btree_iter.c
@@ -1214,7 +1214,7 @@ __bch2_btree_path_set_pos(struct btree_trans *trans,
 		   struct btree_path *path, struct bpos new_pos,
 		   bool intent, unsigned long ip, int cmp)
 {
-	unsigned level = path->level;
+	unsigned level;
 
 	bch2_trans_verify_not_in_restart(trans);
 	EBUG_ON(!path->ref);
-- 
2.39.2

