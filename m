Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F9D76F550
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjHCWC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjHCWCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:02:23 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D33A9C;
        Thu,  3 Aug 2023 15:02:22 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so1030488a12.0;
        Thu, 03 Aug 2023 15:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691100142; x=1691704942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHzqSThmy913fuGKpn4uXf/XGbug/XgU3SVaHteOTFw=;
        b=Ktbivmf1unMCf5Lfw6cU+ehdRCR9VHwUJJpt/z0XBJXfOLvfvaJbI1UkOCHdzcg/Gs
         9/o1P/B3x3FCEVNmkLWkumhFqN11In5fCIvCUUkeyMwMBvDxiX5iEJMaGbSz1LLSOprD
         rwsYXMy5+YRP8HJdfC7UMU1MBAlhEAW1kEThrsMj3NzYBbJj/TiUe2esFfezQ06YvAyt
         qiawcF5mHD1SRVUtc7hc+DK0y4NZc/CzCoUxcybbmTcUbdzKIxvj0TqAj1A1zGs3cwQB
         uAZqlu3/rvbZj8izwT2S/qH6DolxpUS2APHPEl6GYkXh8Kaw6vXwlly6BCRj9Y/g61ZR
         5ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691100142; x=1691704942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHzqSThmy913fuGKpn4uXf/XGbug/XgU3SVaHteOTFw=;
        b=fzdgRUwn1VLfR4I+/wHcay7Pbydj7LEPkb1p2mUAYzT/vi+SlsG3OoJ4ax45lprxPX
         iBTTjtLlFBxRkqiOPe0tDvJfNcRPk5p+50Dxl/yUcx6lQvqvxM5fqQQNwXDyaAVU3lXj
         +o3JlW+v3ONNWLjn+a5yUznZR47qOZnyv4dHp4P6chOdM106wlY7OhNVJCWd6xzi2Hyp
         Np6XjihdHA8STHHh9ZYM1H7249hAkK19KvwJJSnYLVegGiK3w5hxEovtTCYw/Fe4QiKU
         HHfiVak+pmN4kfdtgHEy+apkzjJ9a3eoMQFiEqGSxBlIhts2swIDGjGfySCqAPszprM/
         ECQQ==
X-Gm-Message-State: AOJu0YxNQdXnPPokMIJfWHHmqsm4/UnNiB/6FTLods/7gatC8lPAx7GY
        HhC1wUdB6m8scGtGHpB9ZmgZ5IOeNyI=
X-Google-Smtp-Source: AGHT+IG0EMAk3QzLGHjyK1kBBG+MKsuNGPfVOyaz6A+S75XyvoJ077wEJA+SRLoCx2VFa2/q3zovCg==
X-Received: by 2002:a17:90a:6f23:b0:268:f2e:b480 with SMTP id d32-20020a17090a6f2300b002680f2eb480mr27152pjk.11.1691100141639;
        Thu, 03 Aug 2023 15:02:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a654300b002641a9faa01sm2946499pjs.52.2023.08.03.15.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:02:21 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-pm@vger.kernel.org (open list:DEVICE FREQUENCY (DEVFREQ)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/9] PM / devfreq: Teach lockdep about locking order
Date:   Thu,  3 Aug 2023 15:01:50 -0700
Message-ID: <20230803220202.78036-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803220202.78036-1-robdclark@gmail.com>
References: <20230803220202.78036-1-robdclark@gmail.com>
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

