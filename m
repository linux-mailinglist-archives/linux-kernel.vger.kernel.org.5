Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4B8772C53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjHGRMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjHGRMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:12:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D143172A;
        Mon,  7 Aug 2023 10:12:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26854159c05so2592830a91.2;
        Mon, 07 Aug 2023 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428321; x=1692033121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHzqSThmy913fuGKpn4uXf/XGbug/XgU3SVaHteOTFw=;
        b=d0/zb0EMxnUoF6U/8B+j/A8Klh0Grls+5POua5XjQontyDcF1Dptj+5fXjtQM453i3
         HOY05M8kH4CRzEqgoa9tQzaj4dwJ/WbIxdv97Pjcwd/5O0iFRva/arN2hmER7moWz/fr
         GozUW3ArYRsA4Irz0KpxglSulV+I9A+Q9abW/aiGGNCbsc/Gqi/Sf2NQp82zlxs1aoQy
         LeBt6YnWg8j2g7d3Jy6yoKwl4c8JFdKqslhbEJG52jq8j716NLsuLEJBHHzpLuqCecDf
         lt44aruIwNYfOs05lbntXlCyKWR6f4eqO/HoQyXfYUWzhLqvDGmZflVEacALtyKZDnZh
         IXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428321; x=1692033121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHzqSThmy913fuGKpn4uXf/XGbug/XgU3SVaHteOTFw=;
        b=LtHQYJxxBB/P6UxC6m4oWlfmyHJ13it4q+4MVxjZwlPLRDQoJ2fKEpRlT0KcCjaAKp
         AfiRC2hhDjiHc3QXDF2LLJE04HuIMt2nSvXETJhwbXeQjYMCwpbvQ2OuBi3AoqPK5cP3
         OBbDDk2snL0CpXXbxB/5KMLY8JT+i0cvmcIaPGGJZtE8oONc6s5Yuns05Pc5GPQHwafj
         RyoW16ZXhpImdVH5SKebR+j0mxdj/1Op2CFAJMspJ0NVJzlnzu5Ia4+F1ghQ0vvVEqrv
         +hWJmKqHYd/1TgouEdN9yN2AP8SqWkU5GvSg9FLFWxUQRCpewJCfGX/h4aGgk5rGVZkL
         y/IA==
X-Gm-Message-State: AOJu0YyKq56nVfup/Aqyi0oKMVhA+5HVlhdOSmo2pcgoHYWTWep5mhQR
        9Bc8gGYxeR949gGfbekOB5s=
X-Google-Smtp-Source: AGHT+IFxwbUQp6XTeg6maDVr4DwNqKkMmfCxg5D737RQsrcQ3dqe7O5HJxm0ZcPAwQVWquo/p75Law==
X-Received: by 2002:a17:90a:ca0d:b0:262:d7db:2520 with SMTP id x13-20020a17090aca0d00b00262d7db2520mr7831152pjt.26.1691428321159;
        Mon, 07 Aug 2023 10:12:01 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090ac40500b00265c742a262sm6224878pjt.4.2023.08.07.10.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:12:00 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/9] PM / devfreq: Teach lockdep about locking order
Date:   Mon,  7 Aug 2023 10:11:36 -0700
Message-ID: <20230807171148.210181-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807171148.210181-1-robdclark@gmail.com>
References: <20230807171148.210181-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

This will make it easier to catch places doing allocations that can
trigger reclaim under devfreq->lock.

Because devfreq->lock is held over various devfreq_dev_profile
callbacks, there might be some fallout if those callbacks do allocations
that can trigger reclaim, but I've looked through the various callback
implementations and don't see anything obvious.  If it does trigger any
lockdep splats, those should be fixed.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/devfreq/devfreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index e5558ec68ce8..81add6064406 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -817,6 +817,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	mutex_init(&devfreq->lock);
+
+	/* Teach lockdep about lock ordering wrt. shrinker: */
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_lock(&devfreq->lock);
+	fs_reclaim_release(GFP_KERNEL);
+
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
 	devfreq->dev.release = devfreq_dev_release;
-- 
2.41.0

