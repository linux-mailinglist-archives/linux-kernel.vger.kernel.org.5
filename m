Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEE27FCE56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376945AbjK2Ff0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376940AbjK2FfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:35:21 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA38919B7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:35:27 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5c604b092a6so281324a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701236127; x=1701840927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgQkKxfbfB1dQHkl0UdeF9VBFXfuQafglyd43X0xZ5I=;
        b=Q9HJgTB+Qa/OGdbAEZsVhwmNvI14FI/T9fVPN41e/7gGqf7yKeczk8BukkVYr7wUp6
         RKVNsKy6d9qIpHTKbooiYxonlv5mV5X5r/lx9zNUG7qeT2vE9Y+frRy65/S/cBD62e8O
         kQ2uOx+Zx0EmTI2yTA2RV15aVgIeYigI3hohnt89ieaor5YY6hk+jOnktfbDJl0hwcvk
         SYlVU7oHaDHI19DC66kGxZ82yI4QDjdS4VVqt6qe1eLsuEnhu4Aa0tR+blr7CmX1qe9F
         0lPcD4TZmtTT0HJueIWczp0qwVdmTDlkmssIKEPKp6JNj2rUFsFKeXqKdmFh3fJPQgCz
         ldtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701236127; x=1701840927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgQkKxfbfB1dQHkl0UdeF9VBFXfuQafglyd43X0xZ5I=;
        b=EYVrl/ANCZu7TE4+QERgHQ1Rz12sZqs/58YDyrQu3gYTRZbd0+K7ioPGhKkVc6X1m7
         eNovZ1m4WvqOWO4rpWVAn4deEyGRj8cwKVSWJxd2pvMklfK91zNp2F1NfBvBpDs1FGxP
         HJn+A5d4A5Wyt22Hzt4RypuaPzTE6UCQKdRC60sjzYs4s34mscA4uoPLeiWZIZKp6BAb
         2+Vwl9SdoaRXLpY8rRJ9w+pSCovIAHI8CW9OvcVRsg9PftCQIdwveLzqEDqvE69OuEw0
         FxemoNUjI8pCc7Vnr7JRte4PqXXnpT+/Szgv8r7+d0g2LVm64R8ZqxegkH1hn+drqAz+
         /xNA==
X-Gm-Message-State: AOJu0YyPAnoRjcIHKkVw9z8kfzELgTqtGgoBQfREFhCdiEC3LkAzZvl9
        Ck71Y1jMOiHo8KFdrSdIDTAbfR2kYTEbcg==
X-Google-Smtp-Source: AGHT+IHqVK+ATOxjmy6GWlz6Ri5iiOxE7mucUIAdlzFeplutaG34BDnZ2MJ4pcBj87Fcy3mZca+Dqw==
X-Received: by 2002:a17:90a:d482:b0:280:4af4:1a41 with SMTP id s2-20020a17090ad48200b002804af41a41mr30356151pju.15.1701236127124;
        Tue, 28 Nov 2023 21:35:27 -0800 (PST)
Received: from ubuntu.. ([43.132.98.44])
        by smtp.googlemail.com with ESMTPSA id gj6-20020a17090b108600b00285a2d14184sm660717pjb.0.2023.11.28.21.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 21:35:26 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        alexyonghe@tencent.com, hengqi.chen@gmail.com
Subject: [PATCH v3 3/3] selftests/seccomp: Test seccomp filter load and attach
Date:   Wed, 29 Nov 2023 05:34:40 +0000
Message-Id: <20231129053440.41522-4-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129053440.41522-1-hengqi.chen@gmail.com>
References: <20231129053440.41522-1-hengqi.chen@gmail.com>
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

Add testcases to exercise the newly added seccomp filter
load and attach functionalities.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 38f651469968..66eb72e6c1a3 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4735,6 +4735,77 @@ TEST(user_notification_wait_killable_fatal)
 	EXPECT_EQ(SIGTERM, WTERMSIG(status));
 }
 
+TEST(seccomp_filter_load_and_attach)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	int fd, ret, flags;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret)
+	{
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	flags = 0;
+	fd = seccomp(SECCOMP_LOAD_FILTER, flags, &prog);
+	ASSERT_GT(fd, -1);
+
+	flags = SECCOMP_FILTER_FLAG_FILTER_FD;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &fd);
+	ASSERT_EQ(ret, 0);
+
+	flags = SECCOMP_FILTER_FLAG_FILTER_FD;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &fd);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EEXIST);
+
+	flags = 0;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &prog);
+	ASSERT_EQ(ret, 0);
+
+	close(fd);
+}
+
+TEST(seccomp_attach_fd_failed)
+{
+	int fd, ret, flags;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret)
+	{
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_GT(fd, -1);
+
+	/* copy a sock_fprog from a fd */
+	flags = 0;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &fd);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EFAULT);
+
+	/* pass a non seccomp filter fd */
+	flags = SECCOMP_FILTER_FLAG_FILTER_FD;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &fd);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+	close(fd);
+
+	/* pass a invalid fd */
+	fd = -1;
+	flags = SECCOMP_FILTER_FLAG_FILTER_FD;
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, flags, &fd);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EBADF);
+}
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.34.1

