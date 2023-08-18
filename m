Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2092780E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377889AbjHRPBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377994AbjHRPBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:01:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73074CD;
        Fri, 18 Aug 2023 08:01:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31977ace1c8so914122f8f.1;
        Fri, 18 Aug 2023 08:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692370863; x=1692975663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oUObAblvfLP9rsjJtUMFKffZ4hlMmB39YapsTL/V6WI=;
        b=nZXdFutToZq80kEOn11H6ZYPz8AR+EzTzNEfIhgp7it6KkiyIV0Kw6gMS3xug+HfIT
         w1DvhAxv9Pgr8UzTD3fr/zI1d+6E9ANqoF02bfvrWmnx6gN29uUNe1A6JYXwc5virlzD
         ixFt/loVmT9NHMkvV6ejgBo9HHl8I1Eq8hyIdR3c826NdYDISQjCkiC97YtgqKUtGe5I
         Q7ZWVBQne2gGTiFOpZbNCs20ZF8I7U3GKMOobtFZE2DFzIufVvUJoe5PW5XAl//7HxbS
         QDwjgl7jA1a+OgR8c4qlHX5vSvakt1I2zw9Z3XO6tRBqmuX0BCQq9loI5dMr8xRQFmGc
         F/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692370863; x=1692975663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUObAblvfLP9rsjJtUMFKffZ4hlMmB39YapsTL/V6WI=;
        b=jcMoO6uXWcc6m/r1aRTJxq2nC2AicataxVCY99BlWaOgyVBJtcsxRcNUURBagGMWxb
         fo1w4fRtBxo+Ta6PvZS4iw6gDVBcs4MEscJ5NtxRkKNEgB/Bw+uslpC5AAWkBJa3ryPu
         yzUe50Cq5wiT46uwyLQspkM9YbfbWtVF9YwUyjQZr1X6PEQqOZsO1P3l5miN1JuA92kH
         YOz529eKrcnwbIlto1BbTGhIZCjk7SC9PC2CZ8n06DygTxX5nNlSZK3z71KeFQiRF4sX
         PSnK++JFy0pGaK6DdfXc5jKUe6PTck6k/n43xoKvmLdgaZg02a39YDm41ieryaIs+6vj
         4SRQ==
X-Gm-Message-State: AOJu0YyYoLkOpPq7u4xa4noYBFVLjaus9MN84v2B0mJtn0vo4EOq97Cx
        O2mw7k7sSDdGP/J5HlCf9Kkjt/B3v4o=
X-Google-Smtp-Source: AGHT+IGyxcmhl/x938ugMTqpE1VDJ2270Rjbn4jaudhCg6XnlS+PAwhNXyHUs8VD7ParQwRdv1W9Dg==
X-Received: by 2002:adf:e985:0:b0:313:ecd3:7167 with SMTP id h5-20020adfe985000000b00313ecd37167mr2145149wrm.42.1692370862804;
        Fri, 18 Aug 2023 08:01:02 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4d07000000b00317afc7949csm3070116wrt.50.2023.08.18.08.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:01:01 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Christian Brauner <brauner@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] jfs: remove redundant initialization to pointer ip
Date:   Fri, 18 Aug 2023 16:01:00 +0100
Message-Id: <20230818150100.1208648-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer ip is being uninitialized with a value that is never read, it
is being re-assigned later on. The assignment is redundant and can be
removed.  Cleans up clang scan warning:

fs/jfs/namei.c:886:16: warning: Value stored to 'ip' during its
initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/jfs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 029d47065600..57d7a4300210 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -883,7 +883,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
 	struct component_name dname;
 	u32 ssize;		/* source pathname size */
 	struct btstack btstack;
-	struct inode *ip = d_inode(dentry);
+	struct inode *ip;
 	s64 xlen = 0;
 	int bmask = 0, xsize;
 	s64 xaddr;
-- 
2.39.2

