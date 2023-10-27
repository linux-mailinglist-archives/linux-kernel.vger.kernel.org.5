Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327307D8D98
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345118AbjJ0Dka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjJ0DkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:40:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA81A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:39:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5b93ddb10b8so300723a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698377985; x=1698982785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74qqxidjqyd9XulDVkugPZl+GB+TldL/DBrAezqtgJY=;
        b=FjPwxficg555/vc9VQXDvykvw7zH6mCk1PevNpsgcx0Ja3expzXJxa1ZA9Es80lVBn
         e9mn0iskHiJSVssYxDPuvnWXQAusKyNRQ/b+Cse859XGfMXgWkqNS2scD9K8s/Pfqtdj
         yzwDVCfjsZJPUlcvXOUqrjPqL5p1d+KJtEoMu1SArWBFPvggNKQ/ZLRG2rRAf7mCEahV
         ZAe6YBwnCGNBaYj20qJVzbuviJ75z8S4UFAvjddhSscfOmlt3rCYyNrKM58UpazOACQX
         7tTbFB+0MzqB74413jrbiUYZzzr5TNg7xi2FbviCvNP4w6cVK5/eIGh1lZIW6a32HXAh
         4mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698377985; x=1698982785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74qqxidjqyd9XulDVkugPZl+GB+TldL/DBrAezqtgJY=;
        b=SN5ejL/YbpxZvE5PJLHHFIEZfxyo14RDDRAUBwhcy5GbFznR6R2WwfbmVdp+OHIBSU
         xuWwNUUa3HZugNwxm3BDP9uP9SJHE7/aPBYE4qyourSkNJtO/UI+Gc0QfTB3YJ7+id6p
         KgpmCM2jkLpftyUhhuSx9OplhWGQtPT5Pv9U8o7AzBn9ltj7OECE6TRHxVbbfTQXRS+X
         FiJerDNK2qHDCFpHI0ubzwA0oyg1QdGbXXtCE07PaUel3pB5+SZyFEjVfo0q2OwCsW0B
         UMV820LF6rj8Yd5/9PB2vxtZ4Plmmpc+6Aih6GAonuMQHriHDl3tyZzlfx5NPys+uQsU
         fpig==
X-Gm-Message-State: AOJu0Yx0NXzkUUsYa942xX3hwgCNHM6dEgkJ57Oz/GromaxaL2H9P1S/
        Dhm9TCtCHkLHJ3d2YMKbsziOkA==
X-Google-Smtp-Source: AGHT+IE0WBlgixccb7xQyscB6ftmdLDZ7xdSH5V+CyxdwveadRU+NlM0bptvnd1oQV9FJPaGCIUEEQ==
X-Received: by 2002:a17:90a:9708:b0:268:808:8e82 with SMTP id x8-20020a17090a970800b0026808088e82mr1969715pjo.1.1698377985415;
        Thu, 26 Oct 2023 20:39:45 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id ms19-20020a17090b235300b00267d9f4d340sm2345676pjb.44.2023.10.26.20.39.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Oct 2023 20:39:45 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 06/10] maple_tree: Update the documentation of maple tree
Date:   Fri, 27 Oct 2023 11:38:41 +0800
Message-Id: <20231027033845.90608-7-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
References: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the new interface mtree_dup() in the documentation.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 Documentation/core-api/maple_tree.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-api/maple_tree.rst
index 96f3d5f076b5..ccdd1615cf97 100644
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

