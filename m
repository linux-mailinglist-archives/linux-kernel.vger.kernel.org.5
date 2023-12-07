Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9626D809289
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443958AbjLGUj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443936AbjLGUjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:39:06 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E647E1725
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:39:11 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d34f8f211fso12694467b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 12:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701981551; x=1702586351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdhzPeT3AA9HptxSHcMzOSBTny61/xtguzzqnxzNv6M=;
        b=fbxVQMCBh6aSDW4fc5TmMHCIc+n8Se2z7D5ZprxNWPEcFxIM9uPVNQ+JS6oQjxJ31P
         3t0k1sbxPjMGmgqqqn+KKnPwvTPrKAjGtYcEay8RvFEgFVr3dHb9QIOMbE5y/0xPJ5JW
         JR58N29bl4LAPZkajCme4vs5Ls8SCRwgWOQQzZCnxJPY8epMUXknvbOxEV9jaz9oxSNr
         kamv2vu/+Qnd80aYuBYkSbBjpZ1wpJQrNK3jfw/33SLFRnvMjuAeoeNb0KwpnrPxSmgl
         ww1BEZ/N85cewpFMR/VFwgGi/1pVsTf4DFtEEhiHfdWhn6j/7B9g99Uj7wRzDj4J/su8
         m3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981551; x=1702586351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdhzPeT3AA9HptxSHcMzOSBTny61/xtguzzqnxzNv6M=;
        b=B2GJHTknxypwbdcXGNr+He1vTNiFJarPjFL9smNMZBIDDhmEzFXbtgUG+p0BYrX9BZ
         L3rfAq9yGbBxkkH4Y85TdlZwIZtyGPEVvP8BQTDCy4//hA5O7tEEnpGDfrtKqgI6y4lJ
         sDAV2S6Hgv4zt1t5p/xvnEa/Ztp0qoRa9UP2YsKUjeLMVxCClMJFEAA3FqsBSZ9XHIF8
         1v7ZtGogh8w5bjfjBT/H8QqOg9aPrcpjqwDpGNPwlD/vHSeKkjtH2pQEYDzETaOvCjbS
         nUJ21WIwJSARtpkcP5qvrJesXzYZUZLnvt5CXqXIkXIQZwAbPK69hvBqcnSPyv3wtrUl
         MWNg==
X-Gm-Message-State: AOJu0YwinTWVzjdoLp2JIQhoo1jLbDyFL1eyZSh7hmK1daA0xscd1bIb
        q5q/e+h8xcCrtU+bn7bWyJQ=
X-Google-Smtp-Source: AGHT+IFoRR+fMAQqHguc39v63CeE4a68qBPyp6WkyZssDcAd/eM9gVm70j8RBrJTh88u+YpFV7wLkQ==
X-Received: by 2002:a81:6cc3:0:b0:5d3:464d:18d9 with SMTP id h186-20020a816cc3000000b005d3464d18d9mr3060800ywc.21.1701981551006;
        Thu, 07 Dec 2023 12:39:11 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:8f7f:efcd:5388:af4f])
        by smtp.gmail.com with ESMTPSA id n186-20020a0dcbc3000000b005ca4acaf181sm145636ywd.32.2023.12.07.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:39:10 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 6/6] lib/group_cpus.c: drop unneeded cpumask_empty() call in __group_cpus_evenly()
Date:   Thu,  7 Dec 2023 12:39:00 -0800
Message-Id: <20231207203900.859776-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207203900.859776-1-yury.norov@gmail.com>
References: <20231207203900.859776-1-yury.norov@gmail.com>
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

