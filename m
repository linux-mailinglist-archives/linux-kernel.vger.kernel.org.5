Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2357ABECF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjIWITQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjIWITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:19:13 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEA0180
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:19:07 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3512614822bso2996555ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695457147; x=1696061947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=53y+MSASX7iIoRiw0N0MaPINtyDxfHQ2/xhc/ZQOZdc=;
        b=BAGk2HHKrLK2UGICWdY8buG7pDqs5uR9HbtIFuj4ToKGt9FTCzsPi4r3WdpoyH3EPE
         xbpIBLRg3df4Ah9DMtpiRHE5kPyT/4jzpl+hwyum31gNAWGC9aU1LNDMOPFsHpd/ez2f
         0Cqf1x+3+m3VJykXt/ed30ZmVzJD+ta8+CTSSaaFwx+O1qpBwmcJEc2jDErvGq9VN6XT
         HQ5+ppYZGAI5M9SrPnjdhEinMC3S19d5bbrD/eF2e4ZAV35tgAXA9WUa4kZ6mnIB/19o
         SQXDn6PI7qxJPNXXhuloHwV7J2CmlH2zPdzv6m2VQOOmqJRYTetQOc5WuuACkzXx9EA5
         M9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695457147; x=1696061947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53y+MSASX7iIoRiw0N0MaPINtyDxfHQ2/xhc/ZQOZdc=;
        b=Rl6z1qhjLCs8GXxD63YCk8Zagfo1JJ2WTBxEWdShVr8p2VrTUoHmm4g55eYulglQHz
         lslrwmI7mZfK4TXIwGIqlCUX6HIXJBcgDnpEWHDZjxuRTSNhijlZs3Vx4JdbEPsWhMrv
         SlngOy3fIWZvCAJ6y15gfOxQe7IdMEx2oDlIocFuSFC8ifoXbchnvYorw0p6+uc3ui9/
         A2+Obgjdf+isqCqNM6qg19Hrhr/3DOPRqfm60lTqMthlPtPg7RrLBnxr+bMpBglZfsc9
         OOzczcZ+k6CB3ISX1MReQK5H1+YuYSED5qeG/hn7sUwTeySjglf8C3UHgqcj99VVnyHo
         3aeA==
X-Gm-Message-State: AOJu0YwSVIJi8RA6/N6a1MSnq7m37n84zf4JXEiVdHp2DE2wz2WUGyHx
        8k24R4xVNdXg2KcWa+6XuQLTrQ==
X-Google-Smtp-Source: AGHT+IHBNbl6IYAGI8nr8YQtW/FP5fMEN/o90a3CpDDMTaYSF6PS3d98V+TNXLqc0Tu5l1jKXPiM4w==
X-Received: by 2002:a05:6e02:1c82:b0:34f:7e36:5f8b with SMTP id w2-20020a056e021c8200b0034f7e365f8bmr2693146ill.25.1695457147258;
        Sat, 23 Sep 2023 01:19:07 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id u74-20020a63794d000000b00565e2ad12e5sm4219928pgc.91.2023.09.23.01.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 01:19:06 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     roman.gushchin@linux.dev
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH RESEND] memcg, oom: unmark under_oom after the oom killer is done
Date:   Sat, 23 Sep 2023 08:17:39 +0000
Message-Id: <20230923081739.398912-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When application in userland receives oom notification from kernel
and reads the oom_control file, it's confusing that under_oom is 0
though the omm killer hasn't finished. The reason is that under_oom
is cleared before invoking mem_cgroup_out_of_memory(), so move the
action that unmark under_oom after completing oom handler. Therefore
the value of under_oom won't mislead users.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..0b6ed63504ca 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1970,8 +1970,8 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 	if (locked)
 		mem_cgroup_oom_notify(memcg);
 
-	mem_cgroup_unmark_under_oom(memcg);
 	ret = mem_cgroup_out_of_memory(memcg, mask, order);
+	mem_cgroup_unmark_under_oom(memcg);
 
 	if (locked)
 		mem_cgroup_oom_unlock(memcg);
-- 
2.25.1

