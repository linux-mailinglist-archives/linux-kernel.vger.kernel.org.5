Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F73809287
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443949AbjLGUjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443923AbjLGUjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:39:04 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7038E171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:39:10 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1451425276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 12:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701981549; x=1702586349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqzdM1JWQlsu7k/N7xBtV+SLaOrDoqGHT+SByeHgWqU=;
        b=eY5ZlxwE1hSRnhfKQrV24Asbw4s4UPiuLDhy/aKiQj49IPXodCdeunRlPOLo8JMaNS
         0sOZDG2WIyim06uB+hi66gsxpyUeTvD54SE4bmbRuXmd+NoY5u6nhCQ8fDp3MzVscJeo
         yeYN47pH4Ps72xWd99Ati6TWtoqQdXRumx7E87bOvaicaZN3zHH57z6vntgd7OH1mYCN
         wu/zTKXwAsesaT7cWruCDIBBQAUO7KIWg0gQqYlnc/QfXP3NZUFQz7bc/QuYC9ORBOtI
         +hcQOYNQawUsG4ritMFzpa4vahqVbji+eZGlYGrpNzJsdvZIerXZ1UI8t6hbnA7TUntL
         JbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981549; x=1702586349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqzdM1JWQlsu7k/N7xBtV+SLaOrDoqGHT+SByeHgWqU=;
        b=vpcs1v0z0/FZygKiJxF0wvIUoOjlqRwy0AlWhZ+qZ1TFHU3Hoh90+YSMX1eSubTzQm
         Au5oMIFx9yhyRmmfIXs3t2XrccelUV+a3CID56aGPxrXPx4udYKTyyMAqeNeYGu702s8
         Zj3+tYvlb+BjLI3OSxOKeM484WZnEA7WSGJbMiiU/lrncljZ4tuiimQArVUHZqXC7ezQ
         CgH11Q3gGob3VDqQQxBeLjeBm2OwWceMuDIH4hnD78FFp18qslDH/BQLEqMCX3p3+jp4
         lzRu5p+0EXBoor3e3HIehese4W8G+O1LbubLxCKM+kg8rICR6mv+ICiZUYEr8DCc/OOj
         UPFQ==
X-Gm-Message-State: AOJu0YwW44dbQIJO67jJEUoQW9NKROrAv5NiP7h+BT+jv//EMcqmlskZ
        lcfKUTvXeb6hSxzwKVCK3XM=
X-Google-Smtp-Source: AGHT+IH+tKfirfTfmD2dg4eYtMxnJm2/WGGr9CaK2O7JxG9U/sPfP1dhWUdUy23PTlCq/IILz+U1Tw==
X-Received: by 2002:a25:c2c5:0:b0:db5:4cc0:68dd with SMTP id s188-20020a25c2c5000000b00db54cc068ddmr2565491ybf.21.1701981549533;
        Thu, 07 Dec 2023 12:39:09 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:8f7f:efcd:5388:af4f])
        by smtp.gmail.com with ESMTPSA id 186-20020a2505c3000000b00da0c49a588asm146925ybf.8.2023.12.07.12.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 12:39:09 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 5/6] lib/cgroup_cpus.c: don't zero cpumasks in group_cpus_evenly() on allocation
Date:   Thu,  7 Dec 2023 12:38:59 -0800
Message-Id: <20231207203900.859776-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207203900.859776-1-yury.norov@gmail.com>
References: <20231207203900.859776-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nmsk and npresmsk are both allocated with zalloc_cpumask_var(), but they
are initialized by copying later in the code, and so may be allocated
uninitialized.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index cded3c8ea63b..c7fcd04c87bf 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -347,10 +347,10 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	int ret = -ENOMEM;
 	struct cpumask *masks = NULL;
 
-	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
+	if (!alloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
-	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
+	if (!alloc_cpumask_var(&npresmsk, GFP_KERNEL))
 		goto fail_nmsk;
 
 	node_to_cpumask = alloc_node_to_cpumask();
-- 
2.40.1

