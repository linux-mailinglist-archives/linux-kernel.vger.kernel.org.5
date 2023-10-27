Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F447D8D88
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345244AbjJ0DjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345225AbjJ0DjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:39:17 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEA41B4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:39:15 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-578b407045bso1344995a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698377954; x=1698982754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3VhzpPT4L+mg3QuUru0Nd/vnRDIbmeOsA1YFHm0EaI=;
        b=G4ESRtUhL5ol07GTs/eqldGlm81dI3Q8VHXHAFYKMuHcpYoceNCPK3kRb2T0UL6hMi
         C33MG5JUA8eHtM9EtQ6lHygG7qM9S2tmaUP6LQkqzESLWjNR7pEQQBQ9wJb47yxazU7f
         qixDqGRMLR/CondHUPZ9HFHcqvE9mISwp/xMfjgsuNIibBQLIBYt56aDjEvb2dFpo5C4
         QCP/uqaMsydNF80AaoHnYppXHl5kWhYqph739nhSe3Xw36ioAdrAUxYBvfot6e1ENhgZ
         18iZ8Ofe8dwXFp+wCZ3Kp6lf6wCGtkSG3rCppqgh5rNQBXb0iHeXXhnM3YLnX5gL3o5G
         lHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698377954; x=1698982754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3VhzpPT4L+mg3QuUru0Nd/vnRDIbmeOsA1YFHm0EaI=;
        b=FfJFBun2TklhcuF4+sLivyUA754zpkryB29zIEM/OVT2CwD8xc/fw0yrypeL9TXOFd
         AQpY0FWV9f7SjiZdInqmH1LNLqlk+XtjJygt5kMtG8etABcI0vGptxpk/0GF0WulcPIQ
         0JdA+2e9U2Hg4jtQe2r7HiIzVffX+oLJWPy2TDbI7dAElUTwhXD2bttfJ1YMvvnl+Hly
         HHmaGyu4BKjBvBDkxhVFtBWr4hnbfXCgcBjmMOmqbbH8d7ypU0YY4oTL6FCgCN7i8UWh
         svrnzjhncjSyuJzmLDf4zCw2zs5VdSuBJb81AEewmsB94cajDF5d9agbuMmWH+CsnNIb
         1e0g==
X-Gm-Message-State: AOJu0YxP8jw7XO1crrmIVuXNNDLyitKVgem3UtK9FrQ+fKY6j+v63pC4
        F9b/FKmOT4C2DXKvgInUFTlgYQ==
X-Google-Smtp-Source: AGHT+IErUxQpQyE6ZDI+WeBZM1BwVdK0VivW/g4FmIFgZocyNbqWFR+q60M1qzJpJ7pOns/5IgyeQA==
X-Received: by 2002:a17:90a:bf04:b0:27f:f9e5:b8d6 with SMTP id c4-20020a17090abf0400b0027ff9e5b8d6mr1386794pjs.41.1698377954626;
        Thu, 26 Oct 2023 20:39:14 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b00267d9f4d340sm2345676pjb.44.2023.10.26.20.39.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Oct 2023 20:39:14 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 02/10] maple_tree: Introduce {mtree,mas}_lock_nested()
Date:   Fri, 27 Oct 2023 11:38:37 +0800
Message-Id: <20231027033845.90608-3-zhangpeng.00@bytedance.com>
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

In some cases, nested locks may be needed, so {mtree,mas}_lock_nested is
introduced. For example, when duplicating maple tree, we need to hold
the locks of two trees, in which case nested locks are needed.

At the same time, add the definition of spin_lock_nested() in tools for
testing.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h     | 4 ++++
 tools/include/linux/spinlock.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index d01e850b570f..f91dbc7fe091 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -256,6 +256,8 @@ struct maple_tree {
 	struct maple_tree name = MTREE_INIT(name, 0)
 
 #define mtree_lock(mt)		spin_lock((&(mt)->ma_lock))
+#define mtree_lock_nested(mas, subclass) \
+		spin_lock_nested((&(mt)->ma_lock), subclass)
 #define mtree_unlock(mt)	spin_unlock((&(mt)->ma_lock))
 
 /*
@@ -406,6 +408,8 @@ struct ma_wr_state {
 };
 
 #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
+#define mas_lock_nested(mas, subclass) \
+		spin_lock_nested(&((mas)->tree->ma_lock), subclass)
 #define mas_unlock(mas)         spin_unlock(&((mas)->tree->ma_lock))
 
 
diff --git a/tools/include/linux/spinlock.h b/tools/include/linux/spinlock.h
index 622266b197d0..a6cdf25b6b9d 100644
--- a/tools/include/linux/spinlock.h
+++ b/tools/include/linux/spinlock.h
@@ -11,6 +11,7 @@
 #define spin_lock_init(x)	pthread_mutex_init(x, NULL)
 
 #define spin_lock(x)			pthread_mutex_lock(x)
+#define spin_lock_nested(x, subclass)	pthread_mutex_lock(x)
 #define spin_unlock(x)			pthread_mutex_unlock(x)
 #define spin_lock_bh(x)			pthread_mutex_lock(x)
 #define spin_unlock_bh(x)		pthread_mutex_unlock(x)
-- 
2.20.1

