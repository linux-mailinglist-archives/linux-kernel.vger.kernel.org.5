Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E5878490B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjHVSCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHVSCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:02:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9D0CD7;
        Tue, 22 Aug 2023 11:02:34 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc0d39b52cso31428515ad.2;
        Tue, 22 Aug 2023 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692727353; x=1693332153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHzqSThmy913fuGKpn4uXf/XGbug/XgU3SVaHteOTFw=;
        b=WPZoI+C/3/TAgQYvvcQN3m8uDX7PrfAY02kIgdL0Oz9khOGf+e8dzjXhTDYiVuc9Bk
         DUaUbyZ1NO3qataURGw8oCNtmXl5E9xzTCYEa8GS6krPVvd9IgMBN1dUteEHAWOV74pd
         Me89kMXmtLHqKx7okwKC3CWYKkUIA/gRf/diLBrvf7Q7AHME/4vDRy99D2eKMuA/r+bS
         9HYEbFHW7hu/1+TiAvjKZOp+TUQPGZnMAgbSRGaT4HI59DfoGKIvmWuYUqZpMxJBoaii
         6EY4fesEl1gdxAe7MZvh6USiVcO9QnZVbyZxsTMDg+DqOLSAeWfOTbp0atTPWyptegbg
         5XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692727353; x=1693332153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHzqSThmy913fuGKpn4uXf/XGbug/XgU3SVaHteOTFw=;
        b=EuGwcHLN+sillOtvhj9O1J028iPKCFSRW3Yayj5uKNdUnFjiBcn4Ojt0vy+lCP3TS1
         FW03VOr9hqMJcEZXobzT/Wqfe91OhRLCc8c5q8rLVCfZjfTZbLksSgUed/swsRAaV3yH
         tw5hMYcmj/eTi1buO0IBvYtauw8byWSnYTvJF/ZfU4lbyMbVlwy+0pMtPjHcGn9I08BZ
         8DiZOJPWEciiIreKTf0HZzqKK7kJON0L0vN1BgJb7uEVIs4vjGuQepiPnLR2usN2Wa7U
         cIMuobFXkFbaAnH0aObRcIxW+fA+IFsQ+PnHCL9JLxB2p3LfC5OkgsZCx6fOkKTXURtY
         gyVw==
X-Gm-Message-State: AOJu0YxaHm2iRaAZ3MSg/SAbW7XwUvtyoJHBJ5Q5IJH3daYrY5jHjrfm
        bdZnyi+b2FjQEkicFKeXn6afaOlC+V8=
X-Google-Smtp-Source: AGHT+IHJD1eQ/G8YKK/mS9Iz26wqBwKUfs1uHyXTORe1dqpKt/R9XL71xbqqG0PZqx/D0SSK0BXcMg==
X-Received: by 2002:a17:902:a414:b0:1bd:b8c8:98f8 with SMTP id p20-20020a170902a41400b001bdb8c898f8mr6778141plq.4.1692727353437;
        Tue, 22 Aug 2023 11:02:33 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b001b898595be7sm9347196plg.291.2023.08.22.11.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:02:32 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 02/11] PM / devfreq: Teach lockdep about locking order
Date:   Tue, 22 Aug 2023 11:01:49 -0700
Message-ID: <20230822180208.95556-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822180208.95556-1-robdclark@gmail.com>
References: <20230822180208.95556-1-robdclark@gmail.com>
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

