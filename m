Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2676B675
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjHAN4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjHAN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:56:38 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D06A2134
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:56:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-406b9bcad5dso28475751cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690898193; x=1691502993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJLGW04mxEToFfRDeoOpyp00hE8LNX9fFBjKrCRhwps=;
        b=iLH7vqnb28PIkYe34u+mDj70sMwzhlg2Nc9Lt2f4INh+KceFZ4zMmArs8alLU4u0W1
         xuDos8oBmOj2eI8hOcKxNyjB9tlUl5gULORkj9AFCEfX0mZRPKbeVkBWvQtw3rU0aFZL
         qGVxwxzioM5kQNEUjBSr/VS4Yudj1ZSYn+Pk67O/2OGEHBnObl0Oxjqh5w56/qFguZeF
         0P4o7c44YclUPTxHlqXaMpNGRbK83ZiiVTuS+udod4EI3YUzNvZi7AAMVqNq6u/dr4Mv
         NoUhcNOKuM2pesfsikO7xYyIiTwESwnALMqSuZQOqB6X+3xxzvPkTuuBoUokQu/Pu+Gu
         /KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898193; x=1691502993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJLGW04mxEToFfRDeoOpyp00hE8LNX9fFBjKrCRhwps=;
        b=AGMfqMG5jNtHIavMYjW1EwxCE2SXDgOqSmpSD71VJk0HK430wNWLmnI+jbzztCdYz1
         aO/PT6oxV6hpcKl46KveXIYYEL/HQMRdbNhfdVyOr1aVF6jGu1J663Z/Ea0wZ8jLbnrb
         /EGapzIhzG5Iv/jAH7602UoaQSkLsGPmac66KHUJZ0AtMGMg2x5I5/v3YuJqJhnx8gQF
         e2y1dN137Uj4Eam5QxNXyV91K6WIpssmo7U5E86N910sitln1OCg7QeYq0aAAlns42nT
         ag6AO+/N4Km24KuVHbX9/c0Bjc4BMtrYSjIfjRpsTFwQbJDk+neUSwzFdNE4seHE57lk
         4PJw==
X-Gm-Message-State: ABy/qLb6jQEw3xOIYK7dqDydpuQzowlfztDDILeAU2xbFq8NkuziNP1R
        yXMdfcUYv1dXUQUIlhW8NZCScLwBpDxEyygY6weQdA==
X-Google-Smtp-Source: APBJJlHENlK+WateqGlF3CA9rHgN32+u2UbuYvusGApJRTWPvSgkpYMrWjdUy8Nk/EukrVLPAteZTQ==
X-Received: by 2002:a05:622a:1a18:b0:402:4bf3:7f41 with SMTP id f24-20020a05622a1a1800b004024bf37f41mr12515923qtb.29.1690898193176;
        Tue, 01 Aug 2023 06:56:33 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id c27-20020ac8009b000000b004054b435f8csm4446390qtg.65.2023.08.01.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:56:32 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: cgroup: fix test_kmem_basic false positives
Date:   Tue,  1 Aug 2023 09:56:32 -0400
Message-ID: <20230801135632.1768830-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test fails routinely in our prod testing environment, and I can
reproduce it locally as well.

The test allocates dcache inside a cgroup, then drops the memory limit
and checks that usage drops correspondingly. The reason it fails is
because dentries are freed with an RCU delay - a debugging sleep shows
that usage drops as expected shortly after.

Insert a 1s sleep after dropping the limit. This should be good
enough, assuming that machines running those tests are otherwise not
very busy.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 tools/testing/selftests/cgroup/test_kmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 258ddc565deb..1b2cec9d18a4 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -70,6 +70,10 @@ static int test_kmem_basic(const char *root)
 		goto cleanup;
 
 	cg_write(cg, "memory.high", "1M");
+
+	/* wait for RCU freeing */
+	sleep(1);
+
 	slab1 = cg_read_key_long(cg, "memory.stat", "slab ");
 	if (slab1 <= 0)
 		goto cleanup;
-- 
2.41.0

