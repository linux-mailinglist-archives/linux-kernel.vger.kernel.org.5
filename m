Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BA080931F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbjLGVI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbjLGVIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:08:51 -0500
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5A1719;
        Thu,  7 Dec 2023 13:08:57 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b37405f64aso44411539f.2;
        Thu, 07 Dec 2023 13:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983337; x=1702588137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mJOqg3+xAvM9f6KK768X58MK+6lOJSs4ZpbCqNq8kc=;
        b=bOfTXr150LjyXg/4wfdc/W2o6Ie9+NcNwwh6royulFcBM6akVz0kEjm2gukDoFWdJE
         Q76g7l/sYBWIEedjuN6ayeXCMekjr6E/KvvCYzhUoQthfLCWGWsGHolqhhnZnb5/Cuvw
         R13dF1RcIVNIN/pzZD0nsAhJ3Iu90u2ia7OereI8p+abhVQEoLw5dyL/6+QwRMXIT9kw
         Ccp7d5agY9buk4RClVLJSlZitEo+inErmiIINzyw+I52+MOHLwGzoeuEwxG9KVmiX+Ob
         ZtvGXnKAtL8HkkLs9d/jAAWZJQcGkAPzS73or5D+gQVeY5h7QQvpFphmUuxKFkdTyM3T
         btrw==
X-Gm-Message-State: AOJu0YxtkIpsPfFoxapJKogv/G0FeiaM2XWCqYvDgxpx5VgWZMQcX1dE
        ugdUbu8ootfviNgvo82K+/QwTmo2tMUY1LFA
X-Google-Smtp-Source: AGHT+IGkDTH6918Om38gACwKcVpSczHLJTV1sqKE0lavWzE4WWx1VSuKkyGCMaqiUZF5ySLUSXkcfg==
X-Received: by 2002:a6b:f80f:0:b0:7b6:e765:1d17 with SMTP id o15-20020a6bf80f000000b007b6e7651d17mr2661506ioh.40.1701983336753;
        Thu, 07 Dec 2023 13:08:56 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id f12-20020a02cacc000000b0042b530d29c3sm119386jap.164.2023.12.07.13.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:08:56 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf: Add bpf_cpumask_weight() kfunc
Date:   Thu,  7 Dec 2023 15:08:42 -0600
Message-ID: <20231207210843.168466-2-void@manifault.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231207210843.168466-1-void@manifault.com>
References: <20231207210843.168466-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be useful to query how many bits are set in a cpumask. For
example, if you want to perform special logic for the last remaining
core that's set in a mask. Let's therefore add a new
bpf_cpumask_weight() kfunc which checks how many bits are set in a mask.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/cpumasks.rst |  2 +-
 kernel/bpf/cpumask.c           | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/cpumasks.rst b/Documentation/bpf/cpumasks.rst
index a22b6ad105fb..b5d47a04da5d 100644
--- a/Documentation/bpf/cpumasks.rst
+++ b/Documentation/bpf/cpumasks.rst
@@ -352,7 +352,7 @@ can be used to query the contents of cpumasks.
 
 .. kernel-doc:: kernel/bpf/cpumask.c
    :identifiers: bpf_cpumask_first bpf_cpumask_first_zero bpf_cpumask_first_and
-                 bpf_cpumask_test_cpu
+                 bpf_cpumask_test_cpu bpf_cpumask_weight
 
 .. kernel-doc:: kernel/bpf/cpumask.c
    :identifiers: bpf_cpumask_equal bpf_cpumask_intersects bpf_cpumask_subset
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index e01c741e54e7..7499b7d8c06f 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -405,6 +405,17 @@ __bpf_kfunc u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
 	return cpumask_any_and_distribute(src1, src2);
 }
 
+/**
+ * bpf_cpumask_weight() - Return the number of bits in @cpumask.
+ * @cpumask: The cpumask being queried.
+ *
+ * Count the number of set bits in the given cpumask.
+ */
+__bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
+{
+	return cpumask_weight(cpumask);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(cpumask_kfunc_btf_ids)
@@ -432,6 +443,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_full, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
+BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
 BTF_SET8_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.42.1

