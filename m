Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFF67A49BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbjIRMdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbjIRMcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:32:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC297107
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:32:33 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9338e4695so70772651fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695040352; x=1695645152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqgSIBXgk25i53ApRC28zb/oSMjI8zuN4nMgi5m6KPw=;
        b=AbRNqM/fiJM/bE7wY1el3fMd89AufNmuIbzAXyP/5QHlTsHOg+ARZf6trUrHZq/Xhb
         BOFmIayEZTp+3s60XpqS0STJrjVchDiFxTD3tG33H9va2Dt6TwMsYLeByHvtgc0oM2l4
         4C3/nzpD/NmS0UUlAYbhNQH7T6WVofV+cYp4ivcg7IXJ88YL79qbe+42uql8bznCzYwX
         lR4LPgcbgy4kOfQBQ+PCmYruQX7WvNkqRaNzvQGRruSZUiP+NTfx5tQbv8sofQ7pNiBS
         aQ5ZZPEHQia9sKjA+AeKEE7FEg37lGwZ3Jw4v8TIxU9JlnQ8n4oIwCNYL33gqhqqw6jo
         Obbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040352; x=1695645152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqgSIBXgk25i53ApRC28zb/oSMjI8zuN4nMgi5m6KPw=;
        b=o/CqDTTSQH8pUkEdk3IsRFAC/hI68ShzFh0ddOtAjYNoouAHOwdOrzF4N21jgS366r
         d3y09HBcjwgvPYY6ihCO17X8h4G6KvRh3AfdmaQ0XEKM50dnzad1rCfF/tcMgY4ixyvC
         5Qnmd7rFxs29EnSjjvJSu1kM90sEVDx0cCU7ZKbexO5JG5pATZ1wezbSjZ0tgLZL7vtP
         uoVgHRPK6DHlBp9upun8lHC2Mjd5XQEvv/a1hpZ1/2ArF+bsqGJDKaZ/lLgIpcbEAmjO
         bVneqvzoaOtAeIXDOsvlGqe29COirLEc0753CI+o96y8kW7lg9rTcWn0WxmuUV9GpwG4
         8d3w==
X-Gm-Message-State: AOJu0YzlEPQOwx3jjVi+mRVlbAavoY8TnpYcQ3sFhv0YD87zdhbmGf+N
        QN8OYm7FOUXlpewj5APjC17QMg==
X-Google-Smtp-Source: AGHT+IHyITxWOKyii08edYjtBP+VDisXRQZsIpqTV7m77hz2QxO+vF6oAgcMFre6E+YBeNChO1fUgg==
X-Received: by 2002:a05:651c:1727:b0:2c0:1cfd:8698 with SMTP id be39-20020a05651c172700b002c01cfd8698mr679905ljb.36.1695040352145;
        Mon, 18 Sep 2023 05:32:32 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id sd5-20020a170906ce2500b00992a8a54f32sm6328834ejb.139.2023.09.18.05.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:32:31 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     amir73il@gmail.com, max.kellermann@ionos.com
Subject: [PATCH 2/4] inotify_user: move code to do_inotify_add_watch()
Date:   Mon, 18 Sep 2023 14:32:15 +0200
Message-Id: <20230918123217.932179-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230918123217.932179-1-max.kellermann@ionos.com>
References: <20230918123217.932179-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparing for inotify_add_watch_at().

To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
To: linux-fsdevel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/notify/inotify/inotify_user.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 1853439a24f6..b6e6f6ab21f8 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -727,8 +727,8 @@ SYSCALL_DEFINE0(inotify_init)
 	return do_inotify_init(0);
 }
 
-SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
-		u32, mask)
+static int do_inotify_add_watch(int fd, int dfd, const char __user *pathname,
+				u32 mask)
 {
 	struct fsnotify_group *group;
 	struct inode *inode;
@@ -774,7 +774,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 	if (mask & IN_ONLYDIR)
 		flags |= LOOKUP_DIRECTORY;
 
-	ret = inotify_find_inode(AT_FDCWD, pathname, &path, flags,
+	ret = inotify_find_inode(dfd, pathname, &path, flags,
 			(mask & IN_ALL_EVENTS));
 	if (ret)
 		goto fput_and_out;
@@ -791,6 +791,12 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 	return ret;
 }
 
+SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
+		u32, mask)
+{
+	return do_inotify_add_watch(fd, AT_FDCWD, pathname, mask);
+}
+
 SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
 {
 	struct fsnotify_group *group;
-- 
2.39.2

