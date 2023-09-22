Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76AD7AA922
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjIVGe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjIVGer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:34:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1047883
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:34:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5041335fb9cso2901584e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1695364479; x=1695969279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0X0BQrsVOxiQjDtIc1DCYhpQrHoUJ1FNBPQ6K4eAiM=;
        b=SzhoGtdChgxsxHrm+kWRv2zz0g4zFicJwE9TLt1wbSDnfLgRw0DgC88gWkg6OzFM1d
         qi4o5mWTxjZY11az08COuz/PUl5zmVYOB8g6gcBjtH2h0+h2/zKNbNMSta71pp7L4GYh
         n22syFjx4iRFVOJUsngVNrhPfuuOB2EgDy+R5ZitWtqxuGWUCHc9D0JPEkHkkLoSV7d+
         Rit/MlVLG8JCHqpjcdHTqHIX1QzmEppd5VyqRYlBujfAQEJl/y+hzp5zCdm1RAVLsM0k
         km8x44FF94DO+F8rZ617L6b5oN/fanOjAQznBy7FC46ZXQwi2vGFsUQbDFrWV+jCgjEE
         NJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695364479; x=1695969279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0X0BQrsVOxiQjDtIc1DCYhpQrHoUJ1FNBPQ6K4eAiM=;
        b=uMuYXsUt+LWQuPtlGlhyrwXjRqGe/DZFfma+Jiwv+X965vh5OLRe0DVUK5ehVKX84Z
         5MHCYZQylGGWtSe25KzwIG43t2/g3WMOx5EcruBWEfiyQcbNfqwWuPBpcikYy1ZK/vCJ
         tqTNlnb6/5B5hbityTtquI3/QiXLQA1JHvcqV/aE78o/idX3TL+E6T2srThBOIcCCE3+
         YCs6RlyM8G6X06gp6HbhOp4p03qnOVvc6nKrGUl59fBOG2vAB4ZIQw5V1DfRZwx+eFNP
         9O9xXLJO1bi4+2GANIp7LO2w2elleTLgHr4LfUhQnVlFPEtPJZxzPtWw50XTSFZBZwop
         a86A==
X-Gm-Message-State: AOJu0YwM/itF/nwuIGMQlCzvEUVsxVu5ROHyhDUci4IW9ryNBuGvwj9z
        Mo92efCxVCdHjQPB46va+iO8GBsaFdYauT1YV6Y=
X-Google-Smtp-Source: AGHT+IHIBbiTE5xvp6VdZFE5vYOK4NhSyuG2r1s6YRy3GBiGfUmu9KZWjlhVbjMROpC6z3Eo5K9uMg==
X-Received: by 2002:a19:5057:0:b0:503:2561:c8b with SMTP id z23-20020a195057000000b0050325610c8bmr6555667lfj.33.1695364479071;
        Thu, 21 Sep 2023 23:34:39 -0700 (PDT)
Received: from lmajczak1-l.roam.corp.google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id w29-20020a05651204dd00b00502a96484absm612105lfq.99.2023.09.21.23.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 23:34:38 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Radoslaw Biernacki <rad@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, upstream@semihalf.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lukasz Majczak <lma@semihalf.com>, stable@vger.kernel.org
Subject: [PATCH v3] drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()
Date:   Fri, 22 Sep 2023 08:34:10 +0200
Message-ID: <20230922063410.23626-1-lma@semihalf.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921131201.157767-1-lma@semihalf.com>
References: <20230921131201.157767-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As drm_dp_get_mst_branch_device_by_guid() is called from
drm_dp_get_mst_branch_device_by_guid(), mstb parameter has to be checked,
otherwise NULL dereference may occur in the call to 
the memcpy() and cause following:

[12579.365869] BUG: kernel NULL pointer dereference, address: 0000000000000049
[12579.365878] #PF: supervisor read access in kernel mode
[12579.365880] #PF: error_code(0x0000) - not-present page
[12579.365882] PGD 0 P4D 0
[12579.365887] Oops: 0000 [#1] PREEMPT SMP NOPTI
...
[12579.365895] Workqueue: events_long drm_dp_mst_up_req_work
[12579.365899] RIP: 0010:memcmp+0xb/0x29
[12579.365921] Call Trace:
[12579.365927] get_mst_branch_device_by_guid_helper+0x22/0x64
[12579.365930] drm_dp_mst_up_req_work+0x137/0x416
[12579.365933] process_one_work+0x1d0/0x419
[12579.365935] worker_thread+0x11a/0x289
[12579.365938] kthread+0x13e/0x14f
[12579.365941] ? process_one_work+0x419/0x419
[12579.365943] ? kthread_blkcg+0x31/0x31
[12579.365946] ret_from_fork+0x1f/0x30

As get_mst_branch_device_by_guid_helper() is recursive, moving condition
to the first line allow to remove a similar one for step over of NULL elements
inside a loop.

Fixes: 5e93b8208d3c ("drm/dp/mst: move GUID storage from mgr, port to only mst branch")
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Lukasz Majczak <lma@semihalf.com>
---

v2->v3:
* Fixed patch description.

 drivers/gpu/drm/display/drm_dp_mst_topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index ed96cfcfa304..8c929ef72c72 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -2574,14 +2574,14 @@ static struct drm_dp_mst_branch *get_mst_branch_device_by_guid_helper(
 	struct drm_dp_mst_branch *found_mstb;
 	struct drm_dp_mst_port *port;
 
+	if (!mstb)
+		return NULL;
+
 	if (memcmp(mstb->guid, guid, 16) == 0)
 		return mstb;
 
 
 	list_for_each_entry(port, &mstb->ports, next) {
-		if (!port->mstb)
-			continue;
-
 		found_mstb = get_mst_branch_device_by_guid_helper(port->mstb, guid);
 
 		if (found_mstb)
-- 
2.42.0.515.g380fc7ccd1-goog

