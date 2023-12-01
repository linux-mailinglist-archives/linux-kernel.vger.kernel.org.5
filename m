Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B6380008F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 01:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjLAAwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 19:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjLAAwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 19:52:02 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD96210D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:52:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d12853cb89so26594897b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 16:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701391928; x=1701996728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D7rrSw0NQO055D8S8vjtnTn1EUTQ7K87+88fh2pqZsE=;
        b=WLHN/zDnudw72XGN7U34kCKpO9lItXRoXISxGG274BqlzUxYGE/vC8koDz324GYsvN
         TYFPJTlR+An7MSdXAmSV9aCshp/RtFPa86q7rrUFcSc5pKz8HcSq8hdlFGDWCBG6eM7J
         y9hGA+vJT9Ic2+29/gpVikI0kD1er6/+l32/amIKIg4oqELjW4AwqKGLdAEUw2UYE5Nb
         e5bVuiN1vTEJ2CAQGM8hBbqr8lFYfypzgKm8xBfr1OmuJ0F0deFNy2hmhGkHxrmNzGJI
         WPc4O8+spOEdwXZ3H9I5vvTHlEPzxxyuwmjcy5Cozz76ertBFfaj3ikaBjUjzSivZ1OO
         ihUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701391928; x=1701996728;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7rrSw0NQO055D8S8vjtnTn1EUTQ7K87+88fh2pqZsE=;
        b=WDo0VIOz4H8d7wFf183urUyqnHfbZk4+82Ywhggj+s5ENYadukB5uKx9QkHAqn6OHN
         1glPYNAaBEzgLTsbN+AxuEilviWUERQq7hgkDkkEHB+WKWL8qlenZaq/h9ErIgFuDtpa
         VFvYbNygMezuwihPndu6dQ0BuZIWeyw3Oql7scQHlCL3oEdI7wDlijfxoJpzp/bKjCxM
         gZE6BceuB0vi6okMXqx2U2+uv4a4ojQTfF45E4p9jw81a9b2SSfRIJ51oGyKvRtic4HV
         jYetZuWdT293v1O8nhyDDhL6fnIYiar4gXQLB/fi4s+jd8zdTz6VlHqj4num2pO9mWqj
         7oHQ==
X-Gm-Message-State: AOJu0YzZKJdOrzhQFOT1jdO0UGazM6tuPjsqLJm6O6ZBCzkBhhCVZfGk
        2XhMTU1/0A5PpLZ4SSlqOBKGOVBV2qJb
X-Google-Smtp-Source: AGHT+IFKvXNXIfoRHM0m0qB8MFcGuh4xxwA7sFtdSp36gULSAH59l3Gw6b036WI6Aep1yW9tQy/2NEcFOKdL
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2a3:200:6088:f608:a3e0:af40])
 (user=joshdon job=sendgmr) by 2002:a05:690c:845:b0:5a8:205e:1f27 with SMTP id
 bz5-20020a05690c084500b005a8205e1f27mr755718ywb.6.1701391928055; Thu, 30 Nov
 2023 16:52:08 -0800 (PST)
Date:   Thu, 30 Nov 2023 16:52:03 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201005203.309873-1-joshdon@google.com>
Subject: [PATCH] cgroup: Fix documentation for cpu.idle
From:   Josh Don <joshdon@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two problems:
	- cpu.idle cgroups show up with 0 weight, correct the
	  documentation to indicate this.
	- cpu.idle has no entry describing it.

Signed-off-by: Josh Don <joshdon@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3f85254f3cef..9debf02bcb39 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1093,7 +1093,11 @@ All time durations are in microseconds.
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "100".
 
-	The weight in the range [1, 10000].
+	For non idle groups (cpu.idle = 0), the weight is in the
+	range [1, 10000].
+
+	If the cgroup has been configured to be SCHED_IDLE (cpu.idle = 1),
+	then the weight will show as a 0.
 
   cpu.weight.nice
 	A read-write single value file which exists on non-root
@@ -1157,6 +1161,16 @@ All time durations are in microseconds.
         values similar to the sched_setattr(2). This maximum utilization
         value is used to clamp the task specific maximum utilization clamp.
 
+  cpu.idle
+	A read-write single value file which exists on non-root cgroups.
+	The default is 0.
+
+	This is the cgroup analog of the per-task SCHED_IDLE sched policy.
+	Setting this value to a 1 will make the scheduling policy of the
+	cgroup SCHED_IDLE. The threads inside the cgroup will retain their
+	own relative priorities, but the cgroup itself will be treated as
+	very low priority relative to its peers.
+
 
 
 Memory
-- 
2.43.0.rc2.451.g8631bc7472-goog

