Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D69A7BD63D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbjJIJFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345849AbjJIJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:04:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F07310B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:04:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so3096524b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696842282; x=1697447082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54w8Wcln7nae9IbjCMSOqwvs+RMz0++Lh1/ZpbM0xiI=;
        b=f2DWQqj3SkSdkdLTab30oLpi4Y8Kawjhs2tG4cyJWvrMCRFpT7wzt/9/G9TU8s47uT
         iGUokyT0cRllLpKrf3BkPc0wW3pkCrgZpG31yUca8v8SuH8NX3WwsNAQd0J1ITDNGm44
         0EAGKlSlAby4sSV8zVXDQC/XTbwjcAyomW1owGH0E+6wJB/MwfQx3xA3GFqDnv7/bx2p
         cLunqfBdQ6vmIJ6ZHYRq9Hx4tRgVMAkgt9w1sJPSO/demnCs7HadFvpe6BYWAJ3/UGut
         R45+V9tsVqtT031UPv8gW3Uvuqc5oUQH3TmzVGA30GItE4n6TLx6pnE7M4fHHUCItPTQ
         WnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842282; x=1697447082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54w8Wcln7nae9IbjCMSOqwvs+RMz0++Lh1/ZpbM0xiI=;
        b=hh5zjH0mTp2PcV6LG2krIE0Cn8V//OGlhTyaGUSwC08NPvXPfr2+TZqorZYHj9B2VZ
         bVqbPIzargS5rBduunmhcvZJocqwl8L6Cc5l/C+ma57araVazRnVgyT6Y/rMt6fJ5uLd
         8fdBEyHgesvcBAbhplgy9oEjPInuj3oKsoMyYwxPMbtLQQOJhKe7nLlBVXuf6c1qqAZT
         x9qYlYTdzcOfraxa9dJTa9lSTEPkSncOWTxaMDFiWr0MlZkqYWo+iXwaJQIUtgQPInOn
         BX6l5a9+sOvH9xkCbsjeZaFfv+jtX88xAGZxiX2FdADeHU88OiRCrpwD8P7HFlUFLzY5
         WB1g==
X-Gm-Message-State: AOJu0Yx0XlDWcNJoan+yrziBF74oFzf/+OvS3CVKdAO1tDTpidxro67i
        9xwSro/e7gi24Ww33RiuLDae4A==
X-Google-Smtp-Source: AGHT+IH4ASgVACf0DF0bhjU6o17uphbOiGw/lY/A6lPr5sbkTIKGbp1G2HkSuztTS2B+TAnqtzva5A==
X-Received: by 2002:a05:6a00:1346:b0:68f:e0f0:85f4 with SMTP id k6-20020a056a00134600b0068fe0f085f4mr14645034pfu.25.1696842282594;
        Mon, 09 Oct 2023 02:04:42 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b00690ca4356f1sm5884847pfb.198.2023.10.09.02.04.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Oct 2023 02:04:42 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 09/10] maple_tree: Preserve the tree attributes when destroying maple tree
Date:   Mon,  9 Oct 2023 17:03:19 +0800
Message-Id: <20231009090320.64565-10-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
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
index d5544382ff15..1745242092fb 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6775,7 +6775,7 @@ void __mt_destroy(struct maple_tree *mt)
 	if (xa_is_node(root))
 		mte_destroy_walk(root, mt);
 
-	mt->ma_flags = 0;
+	mt->ma_flags = mt_attr(mt);
 }
 EXPORT_SYMBOL_GPL(__mt_destroy);
 
-- 
2.20.1

