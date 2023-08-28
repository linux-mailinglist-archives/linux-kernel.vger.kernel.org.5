Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E495478B412
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjH1PJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjH1PJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:09:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134D0EA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401ceda85cdso4861735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693235356; x=1693840156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkrzJ6nrXmVMKGdRpiGhMw2iKfFp7Za5H8zwt1x/uYE=;
        b=Gcfsc20eRAp56OKEVtMEAhiDJbVxd/eH0D9DHi7azczCvXZzjwAaYRmxarKUIMR+vQ
         2XanoZWuX5BE9LnjXukHoeIX3vcDykgOXzBvFzYHi1NfOQfyLIgn3bbw3Ck9WAwB0Isi
         39eyQXmVEHzX3V6dpy2y9FTf1Yo/Bpgl5L9hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235356; x=1693840156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkrzJ6nrXmVMKGdRpiGhMw2iKfFp7Za5H8zwt1x/uYE=;
        b=EHUyJxKaYnwhyMXVr8F2T+yYGSwbIelcDDITzXIzL6ziLVI4gcTy1n4cxMaD7f/iSv
         IqV4XmVnGxEDhEw260dAgbkfLSR2L+3sHeHMDZXyT0/XPB1ot89IZmXs3kH3sITk0MAh
         DZcK7AOqa8e+3/oV2nW5HTBwC1oH5OJrCeVBY6m4cFsklKYogb+ovTbj3cuX2xNY0Oui
         h3iOgLtYeIJr5T2chHHr3vX7Rdjg6khgBUh/0FurWZ65+UPePlu4Wn6W9n71s715qx4E
         1dMuT7FExZJjQAefZvPwQ5zOS5MqOJSDPTGCgro4c+a9CkVh/Y8QNWxc2iWY61i1sSp2
         mQqw==
X-Gm-Message-State: AOJu0YwdlL1Wj8AU+9m2UXcbc+Tqrf4ZWTqHmBOid1Ji7ssHXA1AA09m
        qVLmio6cvOcy3HOqgiIRmnZ4c4hL7UesIUbk5i0=
X-Google-Smtp-Source: AGHT+IFPERDSa8GnxhdBv9hLnJGAV2jLF6UJnAF68SaqVArOPcEFQgITwMNi2q83UONR6SeCgjDrOA==
X-Received: by 2002:a7b:ce91:0:b0:401:4542:5edf with SMTP id q17-20020a7bce91000000b0040145425edfmr9094986wmj.0.1693235356077;
        Mon, 28 Aug 2023 08:09:16 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:40c6:6cff:63b:c70a])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d43c3000000b003140fff4f75sm10730522wrr.17.2023.08.28.08.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 08:09:15 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        ayush.jain3@amd.com, Florent Revest <revest@chromium.org>
Subject: [PATCH v4 6/6] kselftest: vm: Add tests for no-inherit memory-deny-write-execute
Date:   Mon, 28 Aug 2023 17:08:58 +0200
Message-ID: <20230828150858.393570-7-revest@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230828150858.393570-1-revest@chromium.org>
References: <20230828150858.393570-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some tests to cover the new PR_MDWE_NO_INHERIT flag of the
PR_SET_MDWE prctl.

Check that:
- it can't be set without PR_SET_MDWE
- MDWE flags can't be unset
- when set, PR_SET_MDWE doesn't propagate to children

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/testing/selftests/mm/mdwe_test.c | 114 +++++++++++++++++++++++--
 1 file changed, 108 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index 1b84cf8e1bbe..200bedcdc32e 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -22,6 +22,9 @@
 
 TEST(prctl_flags)
 {
+	EXPECT_LT(prctl(PR_SET_MDWE, PR_MDWE_NO_INHERIT, 0L, 0L, 7L), 0);
+	EXPECT_EQ(errno, EINVAL);
+
 	EXPECT_LT(prctl(PR_SET_MDWE, 7L, 0L, 0L, 0L), 0);
 	EXPECT_EQ(errno, EINVAL);
 	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 7L, 0L, 0L), 0);
@@ -41,6 +44,84 @@ TEST(prctl_flags)
 	EXPECT_EQ(errno, EINVAL);
 }
 
+FIXTURE(consecutive_prctl_flags) {};
+FIXTURE_SETUP(consecutive_prctl_flags) {}
+FIXTURE_TEARDOWN(consecutive_prctl_flags) {}
+
+FIXTURE_VARIANT(consecutive_prctl_flags)
+{
+	unsigned long first_flags;
+	unsigned long second_flags;
+	bool should_work;
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, can_keep_no_flags)
+{
+	.first_flags = 0,
+	.second_flags = 0,
+	.should_work = true,
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, can_keep_exec_gain)
+{
+	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN,
+	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN,
+	.should_work = true,
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, can_keep_both_flags)
+{
+	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
+	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
+	.should_work = true,
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_mdwe)
+{
+	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN,
+	.second_flags = 0,
+	.should_work = false,
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_mdwe_no_inherit)
+{
+	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
+	.second_flags = 0,
+	.should_work = false,
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_no_inherit)
+{
+	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
+	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN,
+	.should_work = false,
+};
+
+FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_enable_no_inherit)
+{
+	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN,
+	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
+	.should_work = false,
+};
+
+TEST_F(consecutive_prctl_flags, two_prctls)
+{
+	int ret;
+
+	EXPECT_EQ(prctl(PR_SET_MDWE, variant->first_flags, 0L, 0L, 0L), 0);
+
+	ret = prctl(PR_SET_MDWE, variant->second_flags, 0L, 0L, 0L);
+	if (variant->should_work) {
+		EXPECT_EQ(ret, 0);
+
+		ret = prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
+		ASSERT_EQ(ret, variant->second_flags);
+	} else {
+		EXPECT_NE(ret, 0);
+		ASSERT_EQ(errno, EPERM);
+	}
+}
+
 FIXTURE(mdwe)
 {
 	void *p;
@@ -53,28 +134,45 @@ FIXTURE_VARIANT(mdwe)
 {
 	bool enabled;
 	bool forked;
+	bool inherit;
 };
 
 FIXTURE_VARIANT_ADD(mdwe, stock)
 {
 	.enabled = false,
 	.forked = false,
+	.inherit = false,
 };
 
 FIXTURE_VARIANT_ADD(mdwe, enabled)
 {
 	.enabled = true,
 	.forked = false,
+	.inherit = true,
 };
 
-FIXTURE_VARIANT_ADD(mdwe, forked)
+FIXTURE_VARIANT_ADD(mdwe, inherited)
 {
 	.enabled = true,
 	.forked = true,
+	.inherit = true,
 };
 
+FIXTURE_VARIANT_ADD(mdwe, not_inherited)
+{
+	.enabled = true,
+	.forked = true,
+	.inherit = false,
+};
+
+static bool executable_map_should_fail(const FIXTURE_VARIANT(mdwe) *variant)
+{
+	return variant->enabled && (!variant->forked || variant->inherit);
+}
+
 FIXTURE_SETUP(mdwe)
 {
+	unsigned long mdwe_flags;
 	int ret, status;
 
 	self->p = NULL;
@@ -84,13 +182,17 @@ FIXTURE_SETUP(mdwe)
 	if (!variant->enabled)
 		return;
 
-	ret = prctl(PR_SET_MDWE, PR_MDWE_REFUSE_EXEC_GAIN, 0L, 0L, 0L);
+	mdwe_flags = PR_MDWE_REFUSE_EXEC_GAIN;
+	if (!variant->inherit)
+		mdwe_flags |= PR_MDWE_NO_INHERIT;
+
+	ret = prctl(PR_SET_MDWE, mdwe_flags, 0L, 0L, 0L);
 	ASSERT_EQ(ret, 0) {
 		TH_LOG("PR_SET_MDWE failed or unsupported");
 	}
 
 	ret = prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
-	ASSERT_EQ(ret, 1);
+	ASSERT_EQ(ret, mdwe_flags);
 
 	if (variant->forked) {
 		self->pid = fork();
@@ -121,7 +223,7 @@ TEST_F(mdwe, mmap_READ_EXEC)
 TEST_F(mdwe, mmap_WRITE_EXEC)
 {
 	self->p = mmap(NULL, self->size, PROT_WRITE | PROT_EXEC, self->flags, 0, 0);
-	if (variant->enabled) {
+	if (executable_map_should_fail(variant)) {
 		EXPECT_EQ(self->p, MAP_FAILED);
 	} else {
 		EXPECT_NE(self->p, MAP_FAILED);
@@ -147,7 +249,7 @@ TEST_F(mdwe, mprotect_add_EXEC)
 	ASSERT_NE(self->p, MAP_FAILED);
 
 	ret = mprotect(self->p, self->size, PROT_READ | PROT_EXEC);
-	if (variant->enabled) {
+	if (executable_map_should_fail(variant)) {
 		EXPECT_LT(ret, 0);
 	} else {
 		EXPECT_EQ(ret, 0);
@@ -162,7 +264,7 @@ TEST_F(mdwe, mprotect_WRITE_EXEC)
 	ASSERT_NE(self->p, MAP_FAILED);
 
 	ret = mprotect(self->p, self->size, PROT_WRITE | PROT_EXEC);
-	if (variant->enabled) {
+	if (executable_map_should_fail(variant)) {
 		EXPECT_LT(ret, 0);
 	} else {
 		EXPECT_EQ(ret, 0);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

