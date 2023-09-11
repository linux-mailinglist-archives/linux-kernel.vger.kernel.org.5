Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EA979B06D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359509AbjIKWRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbjIKJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:46:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF22ED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf1876ef69so11138165ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425562; x=1695030362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEaLNFUhwmRxiNXJvWOPc9Z79QJgQluJlkgX3lFWQho=;
        b=gOxko638HsLgsWcQM8ZBxit1ohP69BYgLCBujdoJ2To0duqKxeriBW+3V5k4ouTNJV
         grBw30CtJ9hALTxxprwQrY38B4wX8PCdXfzSbZ3FaA0CNcLtPEkyuD0+NIPj2CPvTy6t
         wVKhCUe+JKt56Ec/dYr/S9HUE7FgxkFb3X7RAl73ba/3IRrKFCbwmg4mruCg+6Uh7OXY
         6zX2nbgMNeJxzZe2ymp/I/UY0KLd7LHnAcNTpdaJ9Gw3R4Fo/EV1fTrNoAxC+3Yv9dwi
         1GmXsW1HglVJyqSzmTaI/OuanvXaChxuUKZvzAhbDvn+8V3/uzCR7Rq76vmd6Xn6HVKK
         y7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425562; x=1695030362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEaLNFUhwmRxiNXJvWOPc9Z79QJgQluJlkgX3lFWQho=;
        b=U99wgIO4g+T76jgfFTKrHjagCdwd0GMXinnQwt3X+M5LpSE2x+QyqSeARtqsRKm7hL
         fBv2LusdLSj7oRCIswdnm4MBbULXQ7niSFuJvGT4R+d1ZzM1WyOoMV5UK66CfACS0g6T
         zLEwnH6b8yP5p1+2jBPf0n4/8fT6XFOp85yGZOW9RmVbdFCPSQJVzws6CPh0JFAlgwms
         IdheaiYNdWNhgrxxJSCHhz+uI1n4ouXM0bMBGmlm22viaMam+1TXw8ANtcGhmnCh/7zR
         PehjZ+BMgBkz83EHGntJD+dguHsuyBdVvLe0b1ZgK3dsGSIrrmt0ye+ZlIVynpJcfS6R
         TsAw==
X-Gm-Message-State: AOJu0YxctlhX1oKhudib4QIHj/7RDomN9T8EqWto3AvIdar6+12CXCUy
        Z3E/JNF3gdi5PNAL09Fl02vQJQ==
X-Google-Smtp-Source: AGHT+IEEe7OKLpAjWZ6ZHMp4sopalHLkAI6pc9tZjZALl4cTsdDgpaoyKPO/MAR6mRgsc+S+sQMbZw==
X-Received: by 2002:a17:903:3386:b0:1c3:8dbe:aecb with SMTP id kb6-20020a170903338600b001c38dbeaecbmr8865820plb.2.1694425562720;
        Mon, 11 Sep 2023 02:46:02 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:46:02 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Chao Yu <chao@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 06/45] erofs: dynamically allocate the erofs-shrinker
Date:   Mon, 11 Sep 2023 17:44:05 +0800
Message-Id: <20230911094444.68966-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new APIs to dynamically allocate the erofs-shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: Yue Hu <huyue2@coolpad.com>
CC: Jeffle Xu <jefflexu@linux.alibaba.com>
CC: linux-erofs@lists.ozlabs.org
---
 fs/erofs/utils.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index cc6fb9e98899..e9c25cd7b601 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -270,19 +270,24 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	return freed;
 }
 
-static struct shrinker erofs_shrinker_info = {
-	.scan_objects = erofs_shrink_scan,
-	.count_objects = erofs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *erofs_shrinker_info;
 
 int __init erofs_init_shrinker(void)
 {
-	return register_shrinker(&erofs_shrinker_info, "erofs-shrinker");
+	erofs_shrinker_info = shrinker_alloc(0, "erofs-shrinker");
+	if (!erofs_shrinker_info)
+		return -ENOMEM;
+
+	erofs_shrinker_info->count_objects = erofs_shrink_count;
+	erofs_shrinker_info->scan_objects = erofs_shrink_scan;
+
+	shrinker_register(erofs_shrinker_info);
+
+	return 0;
 }
 
 void erofs_exit_shrinker(void)
 {
-	unregister_shrinker(&erofs_shrinker_info);
+	shrinker_free(erofs_shrinker_info);
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.30.2

