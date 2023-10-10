Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C25E7C00E3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjJJP5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjJJP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:57:50 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E603993;
        Tue, 10 Oct 2023 08:57:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bfea381255so71186761fa.3;
        Tue, 10 Oct 2023 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696953466; x=1697558266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r29Bejb38/E5bMBxM2v8OnxR5nKOLQVj6E9r95ZtaSs=;
        b=hC8vBMEt2oM3TtejqBTkg27Ow5r2kpYG96kjDNdhTJeaPiDRiUTJ2sSvDVSyp2lw62
         qSTuaVugjzEmpQ+HcMFkn4PRWX0b/NuliEyofarHUdlHM4HSAY6829ztPkfjOBwL08ng
         wA1Xh86Jg3BRVpFEY69qIhrINp8m0CT4HlXSKsqMpZwxwrv5hS8ujEfquRD65HRHlU6s
         TRKhl7cvVVa9HotXt4vS3ujUB+V3k4zTLhO2ckronRAVdZLjaqXfR1M8wF2r+EiEleM1
         2aisxe7Hmq8Pmmey/YDJuJOIMaoM22ta9wexem6VLhdijqeaVZvqCriSKNDkx6dGZf8r
         geJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696953466; x=1697558266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r29Bejb38/E5bMBxM2v8OnxR5nKOLQVj6E9r95ZtaSs=;
        b=BlxURR3AW+IaoSP8KbJd3bFxCtqp7vLn+9WnHmMknsZQR811vqoT6kfYRRvp+pHVLm
         0hwVhVmeawX/LWvmPvyHTthRICFILacWlPFm75EC0y+lp8uSXJY5FhglZ0/VLhdOc6ce
         W3GV3P4WQiFR/0xKPo7nDTkRZeZXcE4Tt/acbKlsDlWnN5cjGkpUv2HKCWtWXsdWozyZ
         zhJ24zeGmFPNZ7U3cGrOeDOhKwkhocolZWaKcpW0jh6MxY2ttaVJvNTbKZqvVdp3LE2Q
         FOgb9WIz3t7gIN4MKn6ATSR16GZKg2oGhOM9u+XszroulIghW60YXxU+NoUjxCTlgh5R
         u59w==
X-Gm-Message-State: AOJu0YynRqX9y99Sj6O2vwf6WyJwlWtDUdNrytjcKB1FnLNulBhGGzcd
        duKybPpTze8+09SKhdjno+o=
X-Google-Smtp-Source: AGHT+IFgBSqh/rAuvcgnrQy/qBrlPqhwgM3eAS70Rq860irNeZkw7l7abwr3CE4NHAvNls5zv9vl9Q==
X-Received: by 2002:a05:6512:3450:b0:501:c3ee:62ec with SMTP id j16-20020a056512345000b00501c3ee62ecmr12822172lfr.12.1696953465901;
        Tue, 10 Oct 2023 08:57:45 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v6-20020a056402184600b005333922efb0sm7826678edy.78.2023.10.10.08.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 08:57:45 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] sched/headers: remove comment referring to cpu_load since this has been removed
Date:   Tue, 10 Oct 2023 16:57:44 +0100
Message-Id: <20231010155744.1381065-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a comment that refers to cpu_load, however, this cpu_load was
removed with commit 55627e3cd22c ("sched/core: Remove rq->cpu_load[]")
back in 2019. The comment does not make sense with respect to this
removed array, so remove the comment.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/sched/sched.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index faf9031422e1..65cad0e5729e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -948,10 +948,6 @@ struct rq {
 	/* runqueue lock: */
 	raw_spinlock_t		__lock;
 
-	/*
-	 * nr_running and cpu_load should be in the same cacheline because
-	 * remote CPUs use both these fields when doing load calculation.
-	 */
 	unsigned int		nr_running;
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
-- 
2.39.2

