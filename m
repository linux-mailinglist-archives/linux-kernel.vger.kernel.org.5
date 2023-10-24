Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1297D4A51
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjJXIef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjJXIeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:34:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B711713
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6bd73395bceso3079606b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698136430; x=1698741230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFyp/FJQdSo4OvDS2koRMpNI0AcMCWskpm09jBYSG+0=;
        b=DFkldGMdV2JxmJtnJ2BwYAUGwWXjuXpH7vMPy9/txF2bmv7IAxzKNlda7tFnfBzhrE
         Z7pWAxLLI6z0aHZ9pJ3N4u2AiEcqqd0J3CzRIyyASI7VkE997XKLXtrWN/KMGzl6av5r
         K61YgrGTJA97Gs5yThZ1YggtD87zhHjGzq3XRBF6NsJJmB5vU7VO8WVUOgCFtdEmY59z
         gKN0xeDUcGgkUDHBiU3yxZ6jGIF25XZdFLc9dSDO4DrexPZo7pV+xNoy957cUer4tTwN
         HjNj3vtdAQ99teS4CFZ1Sv3c107vn+9NFYi0Iykdk3lkVbogEJdgilgF7oAvh6u0h1fC
         xP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136430; x=1698741230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFyp/FJQdSo4OvDS2koRMpNI0AcMCWskpm09jBYSG+0=;
        b=Wv7rHIXXCiqwvyLEWhzSakM3XB/m59b/ro9UZ+NXxqE+NgwSn6SJoQ62/onxXpVR3l
         9+WuUIThEBqtr1UucogZZ0TT75wX06o0pGHITQQ77HlWo27spIa3UczqbjOKH2XdCwyt
         ZMdS9+6VWkjJCfUPIiu2F/9E8hMtoJC6c/EE/GCjT1vEkbLF2dKt1YAwyL9Jgw5dIRwy
         tmlbKv8fREYGjMw00RWvGBBr4p+36fj4zM/jjz3UOjpg3ETYGUsu42HWGvWKMForRNhU
         WeM4XrKLgD8sm9b0Nbpvat0UtCyAUEHCf3+j8Uq5uEOT27cC1RgF9MmnIhqvuUSZ0ejm
         1KlA==
X-Gm-Message-State: AOJu0YzuPu6TyYBiUs2NqspoldqqWuoUPw4Kds1BxJtJO5hvT3pfKiEq
        VF+exTi1wb578gEWfcxkqBauEA==
X-Google-Smtp-Source: AGHT+IFGRqPLSl0xQjtZhF9R2vYQNinwziWDialz1aZ2psT6bnUbvTADzmyVrOS+Nnq8WOBVXot69w==
X-Received: by 2002:aa7:8885:0:b0:68e:2c2a:5172 with SMTP id z5-20020aa78885000000b0068e2c2a5172mr16021661pfe.6.1698136429778;
        Tue, 24 Oct 2023 01:33:49 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y21-20020aa79af5000000b0068be348e35fsm7236977pfp.166.2023.10.24.01.33.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Oct 2023 01:33:49 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 06/10] maple_tree: Update the documentation of maple tree
Date:   Tue, 24 Oct 2023 16:32:54 +0800
Message-Id: <20231024083258.65750-7-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the new interface mtree_dup() in the documentation.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 Documentation/core-api/maple_tree.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-api/maple_tree.rst
index 45defcf15da7..285e2d2b21ae 100644
--- a/Documentation/core-api/maple_tree.rst
+++ b/Documentation/core-api/maple_tree.rst
@@ -81,6 +81,9 @@ section.
 Sometimes it is necessary to ensure the next call to store to a maple tree does
 not allocate memory, please see :ref:`maple-tree-advanced-api` for this use case.
 
+You can use mtree_dup() to duplicate an entire maple tree. It is a more
+efficient way than inserting all elements one by one into a new tree.
+
 Finally, you can remove all entries from a maple tree by calling
 mtree_destroy().  If the maple tree entries are pointers, you may wish to free
 the entries first.
@@ -112,6 +115,7 @@ Takes ma_lock internally:
  * mtree_insert()
  * mtree_insert_range()
  * mtree_erase()
+ * mtree_dup()
  * mtree_destroy()
  * mt_set_in_rcu()
  * mt_clear_in_rcu()
-- 
2.20.1

