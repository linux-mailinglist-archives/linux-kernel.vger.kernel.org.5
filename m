Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F2E7D5A20
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344079AbjJXSH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJXSHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:07:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC2C10CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:07:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a824ef7a83so61314687b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698170841; x=1698775641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KvKHj6lvKcZf5ivgAXSc25U17UutcrInn/p/8kAPU0M=;
        b=FcOTLCs0TUpC9xBu4DwT84KPBtfvV1MBMXUfIS9zn3Ikn2X0CMi7OI2foIErI4uUv9
         bupyWNYzkZcuGLImd/f2XvrpxyOmPCQ+nlOcdx4g+wXSLTkCDeKT6WAiSWrKF43pzoGv
         +B700ywd9Cv6q2KFRVSDl35V+Ux1GD355waLfSCKq16hpmROeEY43C1KjxEMlVMUdseR
         lSRF0qdswveFlgTCsY4AZUrTfc6L4Dr3tx4ggHBuHMOQqIAEeCClEwZqET8EvmeaB2ip
         gSstcJcX8JgcVanstqZ/CBJItpwP4akK+QxoOXNUB0dF1lCLKSf3epBsUwZSWTBFMf3u
         MERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698170841; x=1698775641;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvKHj6lvKcZf5ivgAXSc25U17UutcrInn/p/8kAPU0M=;
        b=CEZH0lS67ywcfjZQDIK0MYvOb0CrW+vPrR68EebdLPIMRi+e/TW82dIRr25JtZJAbt
         lyI39wsb3TcfxVlYuzqfn8O+M0EgM85HMx/R+2QSUmGsh+UEPoeefS4bVNdZP7FvgYC+
         vr1i0E9yKwFyStGJU/FEPS/J1Kx/ZIah0XAwquUxU+ikiLkQC3lTApTaejbrkmrXwwIx
         Y5iXOKpBvyhr34FFEzgW83+uBYpnP4QgGvtfZ+YhuJNttmH/jfzkotZskhYX0xAoSIHm
         EF3fEuUQ4mahroEyYbHWeHLV4y4U3FOx6iFa8MKOBkuqqtYLa+RaTEwXZXyPIdrl7XzU
         q+7g==
X-Gm-Message-State: AOJu0YxiiLPzyvMG+7eGiNhzbGY9trxJUCk9XLkKV0I+9vlGXQqulRkh
        froHQyKnp/LhKslxi46/tZYyum1AvflJ3LEnOw==
X-Google-Smtp-Source: AGHT+IH2CaY4CHQBl3xO+aXc8ZEjFL8lcYqzhwM13eTCN17SWbYpWwJ5gmGZj4Je3zYYikmzIl/EFwaZCHKkyHRlUw==
X-Received: from kalesh.mtv.corp.google.com ([2620:15c:211:201:f00a:a475:d412:628f])
 (user=kaleshsingh job=sendgmr) by 2002:a81:4ecf:0:b0:59b:d33b:5ddc with SMTP
 id c198-20020a814ecf000000b0059bd33b5ddcmr250113ywb.4.1698170841481; Tue, 24
 Oct 2023 11:07:21 -0700 (PDT)
Date:   Tue, 24 Oct 2023 11:07:17 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231024180718.626055-1-kaleshsingh@google.com>
Subject: [PATCH] PM/sleep: Instrument start of filesystems sync
From:   Kalesh Singh <kaleshsingh@google.com>
To:     rafael@kernel.org, harry.pan@intel.com
Cc:     kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems, such as Android, that implement opportunistic sleep from
a userspace power manager service need to guard the acquisition of
new wakelocks (incrementing a counter in userspace) while attempting
a suspend (write to /sys/power/state).

While attempting to suspend, processes attempting to acquire a
userspace wakelock are also blocked. If the suspend is blocked for
too long it can cause a watchdog bite in android.

Some device vendors reported this issue in cases where the filesystem
sync is not fast enough (sometimes > 100s):

[ 2742.247785] [07-10 15:08:02.247] Filesystems sync: 107.127 seconds

Commit b5dee3130bb4 ("PM / sleep: Refactor filesystems sync to reduce
duplication") introduced ksys_sync_helper() which logged both the start
and end of the filesystems sync.

Commit c64546b17bc9 ("PM / sleep: Measure the time of filesystems syncing")
improved on this by adding the elapsed time, but also removed instrumentation
indicating the start of filesystems sync.

Re-add the log indicating the start of filesystem sync. This helps to
identify when the above scenario has occurred in production devices in
the field.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Harry Pan <harry.pan@intel.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 kernel/power/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index f6425ae3e8b0..b6a88b43b6da 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -87,6 +87,7 @@ void ksys_sync_helper(void)
 	ktime_t start;
 	long elapsed_msecs;
 
+	pr_info("Syncing filesystems ... ");
 	start = ktime_get();
 	ksys_sync();
 	elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));

base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
-- 
2.42.0.758.gaed0368e0e-goog

