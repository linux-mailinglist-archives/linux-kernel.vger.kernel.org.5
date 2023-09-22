Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C577AAE7C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjIVJoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIVJoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:44:07 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230F218F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:44:01 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-57b635e3fd9so597624eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1695375840; x=1695980640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ91HAV4AfGqREIXXiggp4MFCdt74YPJIaeXpsiYtYw=;
        b=QUixBfjFXt+xD81yWtjozs7X6Qy+opdyf4CvW6tnK1BYRXwx/DhYtIYSb1xk1rWotq
         2pOWvNVdq0H514IrSJHfGSCicA/TR73zj3vq3C06ZDumyV0uXZjF0HQH9zZbghnz5Sgg
         /uSBoYBu+bctEelX65yX7UeBc8rBOLD6xbAKfnYh6/icwhW8X1jUFJPx3tsAM8zzpnKl
         cC2+fBwbeUAdx4LXDNkEYwmQRfnM9FYTQFXXEHzYPILBvtpRKx2yEr2TSV2e90Z9WycV
         VHwTw8kFZCAr9lH1BqpBldd8TnvVNgiSRQPtVhL+hWjCLOsUxtGv8kwEpgSloIlWm58p
         MpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695375840; x=1695980640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZ91HAV4AfGqREIXXiggp4MFCdt74YPJIaeXpsiYtYw=;
        b=dDzNwY/s9sxsiSm1k3rmtUrqzmUZVqBGGqMkKBUugWPBJrW8356AzCts+u9RsWYg20
         rzw1IrLiD4w99GMKN1oN7WzxauEYbeXeRj7U8ozIHK4tfQgt81VIYt3C0V+zI1bKu2Dy
         GU7dX9aCXq6t9Pnzn+AxQfvXQO9E0DgUIYR/2lV2a5XrmndEQRYcsUGJ1qOBvRZ9G6I4
         lmasKUocDoEIdl/5qkIqCTWhY4gYaoxj23qEy+kjWDYgqi3hqrzR4O3XTWD8UA8bcSaC
         PFZz6t7FLtwfFeEZ00aMH7dxVV/MXulSwbJpidwYfUYFRfJqH7rI2440XESSqEvZbl/8
         4OgQ==
X-Gm-Message-State: AOJu0YyMyg9fN+Z8QwpW8BXmub0IfMfp/f9+qmCKe+mI1vV0om4xy4RF
        1tw2/xJYwmXY1vpm3MFysvZ8Ag==
X-Google-Smtp-Source: AGHT+IGzy8dFnHWBpLOTxY3bGL51+VIbJqG8AyW06K+vjpUgbXDkK9Aya8JLd1harP/dtpQeDcEmHQ==
X-Received: by 2002:a05:6870:169c:b0:1d0:e3b7:395b with SMTP id j28-20020a056870169c00b001d0e3b7395bmr8558488oae.52.1695375839837;
        Fri, 22 Sep 2023 02:43:59 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id g11-20020a63ad0b000000b005709b5aea02sm2708363pgf.63.2023.09.22.02.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 02:43:59 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] sched: Filter root_task_group at the beginning
Date:   Fri, 22 Sep 2023 09:43:36 +0000
Message-Id: <20230922094336.394865-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
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

We can't change the weight of the root cgroup. Let's handle
root_task_group before doing any real work including acquiring
the shares_mutex.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a80a73909dc2..1ac2df87e070 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12594,6 +12594,9 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
 {
 	int ret;
 
+	if (tg == &root_task_group)
+		return -EINVAL;
+
 	mutex_lock(&shares_mutex);
 	if (tg_is_idle(tg))
 		ret = -EINVAL;
-- 
2.25.1

