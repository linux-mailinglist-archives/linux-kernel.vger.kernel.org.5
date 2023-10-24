Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078B47D4A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjJXIe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjJXIeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:34:13 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA1210E2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:34:10 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b2ec5ee2e4so2865068b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698136449; x=1698741249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzccM6C4HLhaCIv/SAdijHFdTidMSXBWQyZ1w5RDJYw=;
        b=SNEB0fqkUuNyllJMMihVQAlGEvxlD846I1ZA7TkiLKmn/zyiO9QTOKglOHgTOcy7cw
         YaQlyKeiffS0uBl0lsyehChNpguuAEKJpZsQ442epIy4bfYmwaCX82TCvQ9KN0h3NGUV
         mxBJaH2rWV1QYqjdWxijJtnCIpnOTP9hu7rIzjFqVqMUYJZUP42NmhsYjTqDZpdFVIa2
         rH4ZlQYIjLZVgBGvDx1lkWCUz+ETFTNWdf3q5XYEi5MWtUfNqfG7SY9kwJI6VQ7LHvzy
         ccFB3SBBXl2A7Qla4vYnkGr+P0ogb5fKONd6b26qNaUv4Jvq4fW3EDpC0hAgGT5zTGbV
         NUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136449; x=1698741249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzccM6C4HLhaCIv/SAdijHFdTidMSXBWQyZ1w5RDJYw=;
        b=DJuO2ePYeNl5jQu59XzFHLr1A8ZrQj+1aZgHPNHhVyYaNiQMUEY2MoYJuiHWe3ql0W
         a8oGaNqSZUtBD4OAxMddPZkPhbOUamLmz0HTxNHWiHK/H/BoNCOZ5EQgpuW3IsLi41Cw
         qXCtO6WN9XtwfB9xP6hB/9G8q7xR1PiN6VVLBjv+TYuMWIfhbfayvR/XXRTyJ5xC7pGe
         xUlRJv5GUBXry7Xo48w4BnU9LAVYmawf4TGBBPk6FJQ7bvTOqiuZJauAk/g4koPii6Uj
         90gYTSdwiZMjjClZ66KW3cZC4e4yx5mj6jQV6/cAcUkOoh/yBP4TTJPfCeiwiE1QTc93
         c+Mw==
X-Gm-Message-State: AOJu0YwrlXDyUMfTBSoXIUgHWcyyO5oojOJmGJ/YAGQIbsAXqLCWNbLX
        XSezpLY84AcTaZpNr9m5SMU2pQ==
X-Google-Smtp-Source: AGHT+IFL9wgTTdwcf5iN1EU6ZDwg7/3PqxSbUY7aeR+GMticX3N3Q7oIRaxH4CtsM5Y8o0vT2v0b1Q==
X-Received: by 2002:a05:6358:810c:b0:168:d6cd:7b2e with SMTP id p12-20020a056358810c00b00168d6cd7b2emr7924030rwk.29.1698136449463;
        Tue, 24 Oct 2023 01:34:09 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y21-20020aa79af5000000b0068be348e35fsm7236977pfp.166.2023.10.24.01.34.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Oct 2023 01:34:09 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 09/10] maple_tree: Preserve the tree attributes when destroying maple tree
Date:   Tue, 24 Oct 2023 16:32:57 +0800
Message-Id: <20231024083258.65750-10-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
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

When destroying maple tree, preserve its attributes and then turn it
into an empty tree. This allows it to be reused without needing to be
reinitialized.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6704b5c507b2..b9e238e7a7af 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6765,7 +6765,7 @@ void __mt_destroy(struct maple_tree *mt)
 	if (xa_is_node(root))
 		mte_destroy_walk(root, mt);
 
-	mt->ma_flags = 0;
+	mt->ma_flags = mt_attr(mt);
 }
 EXPORT_SYMBOL_GPL(__mt_destroy);
 
-- 
2.20.1

