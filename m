Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982BA7C9DCF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjJPDYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjJPDXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:23:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65AD19D
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27cfb8bc7eeso3269886a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697426621; x=1698031421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVtomugZIRVe5XO/IomDBee5ri378ZRM5/INN5nVYsk=;
        b=ldXmvkonFc0oiRTa3tuI17TeE/i5DRDVkQ099+h4xoCEQKH/OUMGK9IGih3zfhX1ts
         BkJAi9wcx46uomc/yOdmAclf6OE/lQ9eVqYIM4+Cb73UjmVkx9DcDY10Qv4yn+z3lGDd
         cao9Ouzf10x0ug40yO9UYynQ/kv7Sy9MGBtnFalBE+TObIGDy1mEot2XEBlHwv3yBrZa
         oAqgKELyfPoKnsXiiq67dn7FywAJzYZTVellFmvhkxs9N0hxvOJm2V7JPNoos88uh3Hz
         vK0DiTCnpbo3WS1zAhUqcoeMggBhBboRZbwu0yNp/PKfC/EA7Xeg7HVOagM+rm9IDqcL
         DtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426621; x=1698031421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVtomugZIRVe5XO/IomDBee5ri378ZRM5/INN5nVYsk=;
        b=L2OQMJmZv/KlN+YUoem6hgLzKH9rf/or+jwxAYe9pVn9+e5z8CNTSkwL+++8Ir8XNf
         WD8+qsRnHPdFOgm42wAqjSUhOy8TRZXN4pGVx9ESflPKxfiHXr7UVHJcKuaDg2yVhTXI
         eHaeFmFvsUxer8aQYOeafgdNNlgANA9EJgF5c/mLd9LKmVvL1KRnvzEH2Mi2lzucVFlh
         9Dmf5yNGUl8z2riWxfMlfpEBul1OaZssGEYGhUoHfkliNaXqhLVF5QDKEjtKLwvsZhZ7
         i/51tiD7mp/Ge/DS/dC86EKXLJDBjjc5TwZh9QCU2NzYFQ5E0o7aYXYsNn8qZH2wgJBt
         3clw==
X-Gm-Message-State: AOJu0YyzKssVJzMK/l1oQZOXXpkH/GQksVSkNFWzfqcB7nwzBDoPD15D
        zadpBoj/kLMh6g1HANZZBGZjcw==
X-Google-Smtp-Source: AGHT+IHSb0DNGBGR2h/8IDjSmu+jqGvudTUl4FEPI1UTDCPUIrsebdcLp2Rpr+bgZ6cxOHBljaILuA==
X-Received: by 2002:a17:90a:d48b:b0:27c:f2e5:a82 with SMTP id s11-20020a17090ad48b00b0027cf2e50a82mr15318761pju.15.1697426621551;
        Sun, 15 Oct 2023 20:23:41 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ae28800b0027758c7f585sm3452770pjz.52.2023.10.15.20.23.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Oct 2023 20:23:41 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 09/10] maple_tree: Preserve the tree attributes when destroying maple tree
Date:   Mon, 16 Oct 2023 11:22:25 +0800
Message-Id: <20231016032226.59199-10-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
References: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When destroying maple tree, preserve its attributes and then turn it
into an empty tree. This allows it to be reused without needing to be
reinitialized.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6e0ad83f14e3..9b5e5580b252 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6779,7 +6779,7 @@ void __mt_destroy(struct maple_tree *mt)
 	if (xa_is_node(root))
 		mte_destroy_walk(root, mt);
 
-	mt->ma_flags = 0;
+	mt->ma_flags = mt_attr(mt);
 }
 EXPORT_SYMBOL_GPL(__mt_destroy);
 
-- 
2.20.1

