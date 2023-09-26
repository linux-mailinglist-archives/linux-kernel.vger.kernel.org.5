Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903A47AF0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjIZQh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjIZQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:37:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89968FC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:37:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9adca291f99so1128588166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695746237; x=1696351037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PDQZ6VUDnoTTKC96aCmIgqY/EHvU1MbBCnEVpCOMyPY=;
        b=TkvJDazRArnR7Gib2w5YNpCxfoDM4wEd8MSwJVbzcCfOHU8wvI3wjJOjowbNI+cTYH
         AIgNACCMwVEZFXCOyknv6N5yaV/XHqElsahQfwMxNC9KTB829Xc63Unp3myEtm0mGyUZ
         onYXWs0taPfDXEJaOP2R9HAhTHVAuKgfRcto4CyIqOeLgFLfH/bxCjpuIi+yttpIFUeI
         RyAVrnmXC3Ix6w8mzgrtUCh2s0Oo14XHAkgxxzpx9g0wVVW2pdS/z6cgzCBowf9qokD5
         bEPExFepbAK/0kUyW6Hk7D8Vtbs/ZWGIFNdHGK4mdkOsuFUztY+Yrqk3mg8Q5bdVwG9f
         SYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746237; x=1696351037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDQZ6VUDnoTTKC96aCmIgqY/EHvU1MbBCnEVpCOMyPY=;
        b=KYMtN382YHaD6sYMI/0yrzQva4zZvfFkUw/KMAYCxovZ2KXxsDJF5PlqGn4uc2qLPB
         bMKDgwlxftLP+UB30UU5JGAAFHFAC2gwHkbT6IUfrXDRarXSQMJLbob7ojN+8DibTXM+
         yM8rMcKk+U4Qu3pjGh3b7SidbImhfpRl3CjpxnRTTQCLF53wdyiWU5SSVdR1z9AHkFTJ
         8yDS61muqI/BQRKqCwekn74q3fnDlV+a0LkH749LVcrq4ZccbLVQbszPLW+Ff3i7GSb2
         phiIy6IDw+tLjpSph2AUSSqvMcNnsxrdMEqaUJi/jCzWBYB2pv8nDUqDyBhjJpiz6DdE
         q+Bg==
X-Gm-Message-State: AOJu0YwxZzwwBD/SRQHv9fRSWfTYIYvWlGtTo9I36QgJBN0qTADxjYQa
        MeZ6ovU7f3OuQbxU1Oa2yXo=
X-Google-Smtp-Source: AGHT+IHztCpV0zwYGO9mtUGJh7/73Xp2TUG6349qGUHIfcMufXXnbuIM4V5idrhCOM7H38Mdi3f9AQ==
X-Received: by 2002:a17:907:2d0f:b0:9ae:4e81:4580 with SMTP id gs15-20020a1709072d0f00b009ae4e814580mr11549589ejc.66.1695746236663;
        Tue, 26 Sep 2023 09:37:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:8c00:3664:cd3b:be94:a5ef:c18f])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709064f0400b00992f2befcbcsm7938688eju.180.2023.09.26.09.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:37:15 -0700 (PDT)
From:   Nik Bune <n2h9z4@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        skhan@linuxfoundation.org, Jakub Kicinski <kuba@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Nik Bune <n2h9z4@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] include/linux/dcache.h: fix warning in doc comment
Date:   Tue, 26 Sep 2023 18:36:31 +0200
Message-Id: <20230926163631.116405-1-n2h9z4@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When run make htmldocs there is a warning appears
./include/linux/dcache.h:311: warning: expecting prototype for dget, dget_dlock(). Prototype was for dget_dlock() instead

The comment over the dget_dlock function describes both dget_dlock and dget functions. dget goes right after dget_dlock.

Removed "dget" from dget_dlock function comment.
Copied the same block to the dget function below.


Signed-off-by: Nik Bune <n2h9z4@gmail.com>
---
 include/linux/dcache.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 6b351e009f59..47adb8dda4a9 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -300,7 +300,7 @@ extern char *dentry_path(const struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- *	dget, dget_dlock -	get a reference to a dentry
+ *	dget_dlock -	get a reference to a dentry
  *	@dentry: dentry to get a reference to
  *
  *	Given a dentry or %NULL pointer increment the reference count
@@ -314,6 +314,14 @@ static inline struct dentry *dget_dlock(struct dentry *dentry)
 	return dentry;
 }
 
+/**
+ *	dget -	get a reference to a dentry
+ *	@dentry: dentry to get a reference to
+ *
+ *	Given a dentry or %NULL pointer increment the reference count
+ *	if appropriate and return the dentry. A dentry will not be 
+ *	destroyed when it has references.
+ */
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry)
-- 
2.34.1

