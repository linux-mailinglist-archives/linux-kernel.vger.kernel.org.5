Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81947EC863
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjKOQVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjKOQVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:21:05 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C3B1BD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:21:00 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-357cf6725acso26707475ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700065260; x=1700670060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTFJnUE02Fl/erP4woMg7FCRUhqR44wUotjmE1ijPSg=;
        b=E3OXM9IscpCbdG0whh1LM+tDmt9fJlxiGMSJXfrGUPZk//C0vc/o7Noe+uY6NHW40q
         ltxQ0ZJBfuOCLWeZs3cs1YCfFvnI/FApGQoyXT6YvonCKuZ5Y8386X1CzDawAApBbLGn
         dMYsemcdeO63NIcKS83GXHvreEys9e9fTUMgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065260; x=1700670060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTFJnUE02Fl/erP4woMg7FCRUhqR44wUotjmE1ijPSg=;
        b=PkusoPh01QxdoYlhMeUGyB8CFEuxquCTNge0jR69MHukGXErZqi9jnIg1xIK0MytHx
         VXOHnyFFoD7/avHl1gZMcvmBw63PFLwCLKWmm0zwy7wcE0TEMXH0xqAwY2rqj3RQtxV6
         /pUTvxp8dPekeWPQZ2kJ+07cvzYyWvjEQPle8iMabYxPuMDmwP0aeln3Dvu0y/B7NehH
         r6y/7jPqXUHfXNM5rY9wt7HuUrSKodfbsfSfAoLpmbQrbD8GsVToV7/1JoNHGwBmFVwe
         zC4uuzXGERatDOzBdpMHgKjfR1ZTp9dET121+jZJiEG/bqhlgrcPPSF0LVwppRP9nijb
         Yy+Q==
X-Gm-Message-State: AOJu0YwDaT8c8Bz6/KPLyY81JrwjIMFxjKGF/6ZYpbwbFstvlS9mxxD2
        0yiJxWW32GisHGgM2i2ioSuUJV4wfGwphL3f5hQ=
X-Google-Smtp-Source: AGHT+IEQfGCSbzgsXlVEtw+4pIN/s1f2VziN8iZBz3Kt/hFHx8nWNO7LKYqHriHT3La4Y7GhbMaaPw==
X-Received: by 2002:a92:c24a:0:b0:35a:b0a5:23ab with SMTP id k10-20020a92c24a000000b0035ab0a523abmr13217526ilo.21.1700065260120;
        Wed, 15 Nov 2023 08:21:00 -0800 (PST)
Received: from timvp-p620-9115096.bld.corp.google.com ([2620:15c:183:200:31f9:945d:f7f2:bd55])
        by smtp.gmail.com with ESMTPSA id r1-20020a92c501000000b003574cad1598sm1215050ilg.33.2023.11.15.08.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:20:59 -0800 (PST)
From:   Tim Van Patten <timvp@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     markhas@google.com, Tim Van Patten <timvp@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org
Subject: [PATCH] cgroup_freezer: cgroup_freezing: Check if not frozen
Date:   Wed, 15 Nov 2023 09:20:43 -0700
Message-ID: <20231115162054.2896748-1-timvp@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Van Patten <timvp@google.com>

__thaw_task() was recently updated to warn if the task being thawed was
part of a freezer cgroup that is still currently freezing:

	void __thaw_task(struct task_struct *p)
	{
	...
		if (WARN_ON_ONCE(freezing(p)))
			goto unlock;

This has exposed a bug in cgroup1 freezing where when CGROUP_FROZEN is
asserted, the CGROUP_FREEZING bits are not also cleared at the same
time. Meaning, when a cgroup is marked FROZEN it continues to be marked
FREEZING as well. This causes the WARNING to trigger, because
cgroup_freezing() thinks the cgroup is still freezing.

There are two ways to fix this:

1. Whenever FROZEN is set, clear FREEZING for the cgroup and all
children cgroups.
2. Update cgroup_freezing() to also verify that FROZEN is not set.

This patch implements option (2), since it's smaller and more
straightforward.

Signed-off-by: Tim Van Patten <timvp@google.com>
---

 kernel/cgroup/legacy_freezer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 122dacb3a443..66d1708042a7 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -66,9 +66,15 @@ static struct freezer *parent_freezer(struct freezer *freezer)
 bool cgroup_freezing(struct task_struct *task)
 {
 	bool ret;
+	unsigned int state;
 
 	rcu_read_lock();
-	ret = task_freezer(task)->state & CGROUP_FREEZING;
+	/* Check if the cgroup is still FREEZING, but not FROZEN. The extra
+	 * !FROZEN check is required, because the FREEZING bit is not cleared
+	 * when the state FROZEN is reached.
+	 */
+	state = task_freezer(task)->state;
+	ret = (state & CGROUP_FREEZING) && !(state & CGROUP_FROZEN);
 	rcu_read_unlock();
 
 	return ret;
-- 
2.43.0.rc0.421.g78406f8d94-goog

