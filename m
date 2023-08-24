Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB59786A58
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbjHXImc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjHXImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:42:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED051709;
        Thu, 24 Aug 2023 01:42:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26f3e26e55aso2931655a91.3;
        Thu, 24 Aug 2023 01:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692866519; x=1693471319;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZW4K+Cn+SXlhogHR/A6HeXM5kEvI/OHjyj47UoaxmE=;
        b=lxd7+41A9xrJ/bPvXOGOsy6CupHrmM1aZkoSs5csmsn8A6ogFRsaSEgPljZFx/cLUY
         e41F/4tJlr7ijNe0MED4UvSxNPU8oDvX9GDrw/QdcBbHVlOpHE6e9Q6by5zSf/KQXQlC
         ZawYUa+e/jUP6JzuKsDNGiuujWnPbzjkPMoanBJ+T9EM8pcDo0btLM5GGFvVUNMJFfPL
         FKvcsfhmhaceIXP3qQU3PSTxxCfSTzu+bZIC7yAHqXsMrXdH4whyYMETThBrMlL/gEzd
         ZkB5Xdr2nUNmA9K+RSKaSVv3sDTmJIyKD8hOMhqTMjLQdurivi69WKMVuVXs4zpuG2+m
         CE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866519; x=1693471319;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZW4K+Cn+SXlhogHR/A6HeXM5kEvI/OHjyj47UoaxmE=;
        b=mIp7EAfzZPTiIpymx/w9w7YrQTJzbNAiwthmtpkDaOQ8czb7ZJ8I+FOwzuUa3wbanL
         2aM2StNcLV7ms3yY+3d2VQmw4SMQVM+2JMcZ9pVrSTPJK5TpHrmdzc75BVP1bwMjbW69
         jCAjhj3PPl17dyJjO1X1SWBpBaI8bHmozaBTdVo+zBagz/f1iaQeutogNVRgH9qTVNWm
         UzMQyjznOlDqW7oZmn2KW99uIB6yx1RsLv31ZRHQvBEz3YE4sjdQfO+fm4cB1GX84gV/
         rKeQItYZLv/8giiyYnAgHim3llRxnKU4yba1Bt7kDjpQsKRGuLLCK/bYvvvHEgMJ7jSJ
         kqkg==
X-Gm-Message-State: AOJu0Ywr4WhoAJuYDwkBc5yhe5YZrfrXUqBA9Aud/NbYmhekyb0uqDDQ
        vudn7Euqqpz0hua4SZXdbntqk4A+xfA=
X-Google-Smtp-Source: AGHT+IFKtsyAGaWHI9nSg2J8KHxznkSRbLVtB1mvkDRNX9qFRISnftw2qFs/l8qbMuKD7drkXryg9A==
X-Received: by 2002:a17:90a:318c:b0:26d:20ef:1d32 with SMTP id j12-20020a17090a318c00b0026d20ef1d32mr12046994pjb.38.1692866519231;
        Thu, 24 Aug 2023 01:41:59 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a019100b0026b0b4ed7b1sm1131078pjc.15.2023.08.24.01.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 01:41:58 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     paulmck@kernel.org, joel@joelfernandes.org
Cc:     qiang.zhang1211@gmail.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in rcu_nocb_toggle()
Date:   Thu, 24 Aug 2023 16:41:49 +0800
Message-Id: <20230824084149.21692-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the maxcpu is set by traversing online CPUs, however, if
the rcutorture.onoff_holdoff is set zero and onoff_interval is set
non-zero, and the some CPUs with larger cpuid has been offline before
setting maxcpu, for these CPUs, even if they are online again, also
cannot be offload or deoffload.

This commit therefore use for_each_possible_cpu() instead of
for_each_online_cpu() in rcu_nocb_toggle().

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index a58372bdf0c1..b75d0fe558ce 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2131,7 +2131,7 @@ static int rcu_nocb_toggle(void *arg)
 	VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
 	while (!rcu_inkernel_boot_has_ended())
 		schedule_timeout_interruptible(HZ / 10);
-	for_each_online_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		maxcpu = cpu;
 	WARN_ON(maxcpu < 0);
 	if (toggle_interval > ULONG_MAX)
-- 
2.17.1

