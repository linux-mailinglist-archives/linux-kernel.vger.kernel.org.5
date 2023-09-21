Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1D67A9E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjIUUBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjIUUAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:00:52 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45F6760C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:30:12 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so20934451fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1695317402; x=1695922202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFVgUoZXc2lZ26/cSu4xiqrrdHCsCggsCjjkAVBqrLs=;
        b=RQBNfQbSoeR+FOsIo7kA3hfXblQiD1PSqpKe7uiKa6f8gQHhT0CnQ3ZuvKKg2Yrt/F
         28uXqr05qZDzgE/V0OVryUceJ15tcjKcLiOkCxNRt3dqXtNKp/rtsV25a4uiEG9aeS/R
         25lVLlaykaj9YBhssdx36sRbJfIcUfONbEq//mryGqayD/4q5hg+pTlkGTulPTLA6y83
         m9aOs3N429KfHsKOX+lbp8W3AsLBvgDhkY1j+o4YBiZuyMAKaIAvJD8J/uFu70aSbxBd
         YA3RiOpDwHCgNfXAmoZOadWjJuGoLXsyycZBBljQj8kTj72gLRODBg+1bpUHT/lQDmvu
         zllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317402; x=1695922202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFVgUoZXc2lZ26/cSu4xiqrrdHCsCggsCjjkAVBqrLs=;
        b=CbErjyoVKsaBKI7VRFbYCLi9Ycn3O2ZeIvruP2D5fVQy+XZVJDGGXhWNf2Az5VU2Qg
         nJPDThdoyztYnwRVATs4UL99szrfrxvIaLYwyONqhV87sZNHTnseGw0mxC+uXZ+FwwlF
         Azm58KOLtzOmQ18FtfkgdV1Ij2lOZYFytH11f7ksBM+HeJvirIYqYKS4XkqdKOPm8uh3
         Bbg+dR+3j2B61EafQNU2L/Jp22PpOIgJb0Nc0bDCm+nGbkc57OCthI1kVF9HfIiUx3lM
         jTA/mR6apzR/b1kiMBs5vUjIruzjxqyxcl8hE2Bl1FXUhCFvHnag6yeKLMUcXjzLNbGv
         lUGg==
X-Gm-Message-State: AOJu0YwFUFkNNrPhuFHaQUo8NAjgtxFcsY5UjwhXmxmN/bQt5muYlTw7
        MRebpYByyjm2EZ8xs9wvk8jUj6hqkIzsR6JdU2c=
X-Google-Smtp-Source: AGHT+IG+jYIPjkgn0M12s8Ys2ja5dB9bWaQ5rSJsS5l6XeLlbcGnwF3n1KXzusjdihwBHP9XfXeXwA==
X-Received: by 2002:a2e:878d:0:b0:2bf:ec8e:97c9 with SMTP id n13-20020a2e878d000000b002bfec8e97c9mr4738193lji.17.1695302098400;
        Thu, 21 Sep 2023 06:14:58 -0700 (PDT)
Received: from lmajczak1-l.roam.corp.google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id l20-20020a05651c10d400b002c01ff8442fsm337732ljn.130.2023.09.21.06.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 06:14:57 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Radoslaw Biernacki <rad@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, upstream@semihalf.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lukasz Majczak <lma@semihalf.com>, stable@vger.kernel.org
Subject: [PATCH v2] drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()
Date:   Thu, 21 Sep 2023 15:12:01 +0200
Message-ID: <20230921131201.157767-1-lma@semihalf.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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

As drm_dp_get_mst_branch_device_by_guid() is called from
drm_dp_get_mst_branch_device_by_guid(), we need to check mstb parameter,
Check mstb parameter, otherwise NULL dereference may occur in
the call to memcpy() and cause following:

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

