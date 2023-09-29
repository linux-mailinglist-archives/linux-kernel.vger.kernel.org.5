Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5127B3915
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjI2RpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjI2RpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:45:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E8195
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:45:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8141d6fbe3so21407860276.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696009501; x=1696614301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WeFol5pYV1Ko9ENqYbkHcdGhe+KDrfTUvOAiVPR/B44=;
        b=FHIpozDpiouYwczBPoWT5uHw1RXkkh/vJ/fEXIuszeyAgDI7oLeBACZV39SvVqlncY
         3WxeNmZeuizclZdRWgkL018ENmjgJixxi90mofv+CovFfkRRrymnoamShiOjU8xaqtYH
         s44XrQ+vhg0D/7fmzsKPEZxCiK0RoV1kjF0xx+MUY6bnVEtSOI6B0WWHnIop0qT+u016
         7WGQto0opBxK4+epdWwIZF5BwZnjrjZsbGVbI7hu2H6sPqVcH8Di5YWQNe83RvVLUsDT
         dLChnd7PwtsfJuudZOJ8finXSJ+9wnoRTK+ckWCjb1tpfOdcAQyhMQWzG34QrrA3m03u
         TkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696009501; x=1696614301;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WeFol5pYV1Ko9ENqYbkHcdGhe+KDrfTUvOAiVPR/B44=;
        b=TPKHCsYWhIrEgrCuIvVsnr+IdSkpIT9DWyBQG5azF1VvvB8kSxAOeY1fexNr3lg/98
         /7cJNKYlhhsFg+Ss2+8B+OLGIEWyYpXJBUvii2/Xh6wRlYZ34ygBlhh4px6ZpPRUclUL
         /jOuqqd0RfsAhGFqzA3/lDDCc9Y4SqY8onq9VCdrlvkO7qq2j1XxjUVOxkEwLuz0o0aO
         vZ+buVq3J7TGVoTRapU+Sy/JbSmYzY36DRxkCJDsWjWV/3wGv9PYkhA/w6X4thIysPeL
         6exBLHUuwSWxhwf7TPf4YiafR0DfOlpqO20kMXLVYVkDRWBy+J7TGMcxc+NHxRWafnaT
         SX2Q==
X-Gm-Message-State: AOJu0YziNhUtRwGfYPUG5p92Om/vmSdmHQYgLtR/F4/B4KNixe15Yzdu
        iQUXo//oz7AcNmH+KzzoyWcZkLZafSG4
X-Google-Smtp-Source: AGHT+IHKIT72vMk9HJY0OwCUd1WYkYptBpEbBznN2Ad7cY2/1+r3+ZHgx2VBvTiRMB8smhqc1oItalQ9wYNb
X-Received: from bjg.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:415])
 (user=bgeffon job=sendgmr) by 2002:a25:328c:0:b0:d77:8641:670c with SMTP id
 y134-20020a25328c000000b00d778641670cmr68797yby.10.1696009501381; Fri, 29 Sep
 2023 10:45:01 -0700 (PDT)
Date:   Fri, 29 Sep 2023 13:44:42 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929174442.1635558-1-bgeffon@google.com>
Subject: [PATCH] pid: Allow frozen userspace to reboot from non-init pid ns
From:   Brian Geffon <bgeffon@google.com>
To:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system has a frozen userspace, for example, during hibernation
the child reaper task will also be frozen. Attmepting to deliver a
signal to it to handle the reboot(2) will ultimately lead to the system
hanging unless userspace is thawed.

This change checks if the current task is the suspending task and if so
it will allow it to proceed with a reboot from the non-init pid ns.

Signed-off-by: Brian Geffon <bgeffon@google.com>
Reported-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 kernel/pid_namespace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 0bf44afe04dd..4a93a5063eda 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -321,6 +321,15 @@ int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 	if (pid_ns == &init_pid_ns)
 		return 0;
 
+	if (current->flags & PF_SUSPEND_TASK) {
+		/*
+		 * Attempting to signal the child_reaper won't work if it's
+		 * frozen. In this case we shutdown the system as if we were in
+		 * the init_pid_ns.
+		 */
+		return 0;
+	}
+
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART2:
 	case LINUX_REBOOT_CMD_RESTART:
-- 
2.42.0.582.g8ccd20d70d-goog

