Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4046280E346
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 05:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjLLEVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 23:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjLLEVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 23:21:22 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ED2ED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:20 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5e180547bdeso8182947b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 20:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702354879; x=1702959679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdhzPeT3AA9HptxSHcMzOSBTny61/xtguzzqnxzNv6M=;
        b=Ff6LXL2mmXdHFhM2dDVobDBS+ra3e849llVqg/aOU3YDKtqmNwIS0Ckip0d6bvJ8qE
         WYCJdzU0ISBzUdtvmwpZu6g32YBg3rLE8yhCY/+k8ToBsBby+x1k3L+e9gAwmbbKBt1X
         PU9QuWxy9gfqpeccvTV9zAnUpEIpEQZ4X4IhL3RjsKT8hyXgaFweDo2V2v7ZgGoD/P4k
         5jUUS4RWiyu0JHbmbM8D3KsFHtu4ejuw/2cYX9J1VQvSWYQ+y8H7zPdaT699mFLvW4Rn
         7PVz2LtsMfKeVec9JjkOil89LRxOn2FYK0G+4s4ttYYys2SqWHrdDWCfN+Sx1mt6w5jx
         oyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702354879; x=1702959679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdhzPeT3AA9HptxSHcMzOSBTny61/xtguzzqnxzNv6M=;
        b=wkSTsAvtSaypiKucJdrTgLspVOTS53dVSklSlquclHKtNv14DMFU2hKjj3osadffC/
         1BeV8IC2mdmwlecJ3jvrFxkCrz0SftqehREhiFNiX09UaOFuhK+pbnf5wQM1dRU8Mgvq
         uoRUcmCKZ8Pbj0J1Ux8+8cpDg66VvKp21C0cJz0/WMJCoVkwB0ANOt92vKSsZ93JuqTK
         5sN8uZHlUhylZxOP0tySYsGAegzQLapHdYaLGOqyUikIPUIzcC/Q7cSlCbd6YzogZwWU
         Jk2GZN1OCfwZKy4vEOAhhGgw51zy0W9+KMjLf1U2AparI5JJf7E4echFhhHC6cejjV9R
         yPCQ==
X-Gm-Message-State: AOJu0YxZM6d0Ib7jLsDXyX2ieYSD+6XmPid8DSzGsq/fnCtgZHS397sF
        QZWeRkk/gTcFriHr5Hokmo4=
X-Google-Smtp-Source: AGHT+IExfnPyAJ5PLQqQOEJpb87ZUtep7+F+6LrM5ia0x5oyyOAvC78bzvYcK2XUjAd6dQq4r+fB7w==
X-Received: by 2002:a05:690c:2c01:b0:5df:5d59:5539 with SMTP id eo1-20020a05690c2c0100b005df5d595539mr2477617ywb.44.1702354879588;
        Mon, 11 Dec 2023 20:21:19 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id f68-20020a0ddc47000000b005d16b6edfffsm3495210ywe.120.2023.12.11.20.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 20:21:19 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 6/7] lib/group_cpus: drop unneeded cpumask_empty() call in __group_cpus_evenly()
Date:   Mon, 11 Dec 2023 20:21:06 -0800
Message-Id: <20231212042108.682072-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212042108.682072-1-yury.norov@gmail.com>
References: <20231212042108.682072-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is called twice. First time it's called with
cpumask_present as a parameter, which can't be empty. Second time it's
called with a mask created with cpumask_andnot(), which returns false if
the result is an empty mask.

We can safely drop redundand cpumask_empty() call from the
__group_cpus_evenly() and save few cycles.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index c7fcd04c87bf..664a56171a1b 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -252,9 +252,6 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct node_groups *node_groups;
 
-	if (cpumask_empty(cpu_mask))
-		return 0;
-
 	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
 
 	/*
@@ -394,9 +391,14 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 		curgrp = 0;
 	else
 		curgrp = nr_present;
-	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
-	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  npresmsk, nmsk, masks);
+
+	if (cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk))
+		/* If npresmsk is not empty */
+		ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+					  npresmsk, nmsk, masks);
+	else
+		ret = 0;
+
 	if (ret >= 0)
 		nr_others = ret;
 
-- 
2.40.1

