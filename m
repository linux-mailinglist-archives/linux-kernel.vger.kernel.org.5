Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E007C9DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjJPDYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjJPDXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:23:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EF5121
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27d425a2dd0so2089438a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697426602; x=1698031402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFyp/FJQdSo4OvDS2koRMpNI0AcMCWskpm09jBYSG+0=;
        b=kCQ6ToiF4tK9Ah92GNg5TaAJH2qFerDDDeci+Dl8QIA4veI+7dF6r+thPfSwSjgPuw
         U0//5u/7iDbZV/sM1weFdoDACTZwbMou/Jd481oDYd7LXFNTbzixkHBuR8vTLBHT+ZkS
         U/oa9p9M37Xe8MgWDMpSwaKee3osY/BrU49JpLQtd3Gb05imftp3A1j+x1Ccoa0o+Q3z
         cCcCCvY32R+Zmwo0kZqUBMvLEuDv4gUi1Uq1Ysl1TbqxUmQ8o/ZTXzNK0id0oKd/wYiu
         s5bikXmmEINQF++9dUH4ths1yijV4Uos09tPr7uAjhGQAeHAf0WaNgkZ7ATYgZQlv70U
         /jpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426602; x=1698031402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFyp/FJQdSo4OvDS2koRMpNI0AcMCWskpm09jBYSG+0=;
        b=HQujiuCD4qfk9hG0IesLfZdri24P/+z6J0ArN7kDLbNb1eBiY/1LJrM3n5MCgpoa0k
         KEcHvFeFtMbWxtzB93b4XZ89kQggLO6oTNVHPoGnj7KwLkhSb8VVx9wRyQeJG9tOak4H
         4sKNZMxfGWvw1kSjbTlRgybaBYoA/HG6OM5UUV0HEhxNzAwL+/vyj2Rq3rtqgXCmvKIS
         5Besg4nlS1E2azNhFxEWgH9bhAMGm8sF7X/sIybK0woRu1b6CD6FPb91Atd+VFqa9kq5
         fe5OR45AIOsRCLoqxLuFGS8m1XFPoGADvJke593NWe5lrQUZQA7fez3VasJ533dxDoxj
         WCkg==
X-Gm-Message-State: AOJu0YwzDKa6AA2XMgFSgHAEKGu954wHKLjp/tFPit22dYyktgLACW7H
        /uMVJuWfeMwnNiUH8UOcTsIIuw==
X-Google-Smtp-Source: AGHT+IEmk/zJXO2kK7nOf720yU64zVWPpcUxkrQhPVMBOjATtllYWJlNEGVjqoAJdP0W8HkSSk7e1g==
X-Received: by 2002:a17:90a:f408:b0:27d:f85:9505 with SMTP id ch8-20020a17090af40800b0027d0f859505mr11824455pjb.24.1697426601858;
        Sun, 15 Oct 2023 20:23:21 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ae28800b0027758c7f585sm3452770pjz.52.2023.10.15.20.23.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Oct 2023 20:23:21 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 06/10] maple_tree: Update the documentation of maple tree
Date:   Mon, 16 Oct 2023 11:22:22 +0800
Message-Id: <20231016032226.59199-7-zhangpeng.00@bytedance.com>
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

