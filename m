Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C2E7D8D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbjJ0DlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjJ0Dkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:40:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0CFD55
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:40:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27ffa7e32feso1021876a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698378008; x=1698982808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/TBSsqo/3PZG//kKjzBxqBhIhs+Qitm7vuazfD4aPI=;
        b=DDk4A7esaWB+86LNddvgqDFGUgvg28BtPxHclNVDfMg4e3q3fLwhP8/DGVObzZieaI
         /w7z3IrEiny0Z7GMRYS8WS6hhYXYzf6WkejXu8aJ5lzWacs4Vy8El4yX25hSWNC6YvwS
         utVcdaYgeReeIEfM8FE0CoUc1jCAvOpDQnw1aFpsakX6dkxB4mzjkBlghN/1ltsZPjDI
         If5DLS0+Jc+ER+3Swkg8YwzyumXanbouv4Q0BdgXJwIdtGdM0yDKBZWJLq8lEbVX3O7f
         MHODGKbBPvnAGdAVBqwrqNLi402k7beZvvnCiq6/BktDFqiId6l3XWX8sJU82Tub/OWq
         1SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698378008; x=1698982808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/TBSsqo/3PZG//kKjzBxqBhIhs+Qitm7vuazfD4aPI=;
        b=CEqMV7bZX4V7ugq4PcDh2TBwpAS6CtlEUG80Wisip1mSdxX7JDpYPwN3czHPo+BzcK
         GORqnYPrw68lWNrvCqCFjhrs/sUlole9U8oIlcKlC3mUrgc7GUOsMyOwZqR9ZjNTho3h
         YRKY39ewfbYaQibUw+mBON4RJ6TxCDHjvlwWB0T5vFlGq0/6fhnGvy+5vHnAUt5N+h8j
         XuZE0uTQqKbKMfvbpkR+xf2Adj9SYcqAlpoGHF3xHvB7TwpD8KE5n4eUz9e6h/hvTYxJ
         9SVplmuNrb04WQNvNO1ZLW+iZCD2I5DVOOuHpCg1dsqYqwjmdu65MAwqzKG/w73pLSCM
         pntw==
X-Gm-Message-State: AOJu0YzGTvyOgwkzw9SK2sNh8OAnd5zehbJdNUS5ZYWPAdyVv4+dKxqe
        5I9nWOqI+8VsTLyc6x/FXy1n3Q==
X-Google-Smtp-Source: AGHT+IExlg2G7fYOUnFWtBHLrBsW1lyYgFaUWIXf6NstZ6E0c++iEGcYR48s2/F7tPuX752NBLahNg==
X-Received: by 2002:a17:90b:18e:b0:27d:2663:c5f4 with SMTP id t14-20020a17090b018e00b0027d2663c5f4mr1538778pjs.47.1698378008501;
        Thu, 26 Oct 2023 20:40:08 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b00267d9f4d340sm2345676pjb.44.2023.10.26.20.40.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Oct 2023 20:40:08 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 09/10] maple_tree: Preserve the tree attributes when destroying maple tree
Date:   Fri, 27 Oct 2023 11:38:44 +0800
Message-Id: <20231027033845.90608-10-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
References: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When destroying maple tree, preserve its attributes and then turn it
into an empty tree. This allows it to be reused without needing to be
reinitialized.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 718a222cc090..4439469442c7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6763,7 +6763,7 @@ void __mt_destroy(struct maple_tree *mt)
 	if (xa_is_node(root))
 		mte_destroy_walk(root, mt);
 
-	mt->ma_flags = 0;
+	mt->ma_flags = mt_attr(mt);
 }
 EXPORT_SYMBOL_GPL(__mt_destroy);
 
-- 
2.20.1

