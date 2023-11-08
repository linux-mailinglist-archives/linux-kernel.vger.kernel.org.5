Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784E77E4E22
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjKHAdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344044AbjKHAcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:32:45 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F801FD5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:32:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cb4de3bf0so7624317276.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 16:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699403531; x=1700008331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QsiXyox+rGQhiB/Za0Yz/FRQCQ9gMcg4U4njvPOlEGQ=;
        b=Pa+CN6zBsJjkdBE7W/FQCYsPXuUUXms+Q+EM3mILSUy9m/l8WThH2O21CoZq61Wer2
         i83p1K4/9tsAqzIK1SpKvILU7gA4BRofHs15mG9AKYnsA6oI5DagRYHAWZ9vClXHBCLr
         rumE7WG8LUrvHF6nK655o8MeU9va8+FHot8BvTSzyM9oT9+RwFqtImBJH9avRHFX956l
         EuI+DgeBV20KEBV5Kuydz1U+PTWNSG/M2RdzgW/OAHF1i4kLw1rmAp5zpi4kYVIE8MvL
         alTPEEbbSlDfmnqLaHdHuZP74zizyXtJtVIEllSmKUhIInH4iJslU511d7mPsffw0wOE
         XCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699403531; x=1700008331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsiXyox+rGQhiB/Za0Yz/FRQCQ9gMcg4U4njvPOlEGQ=;
        b=Bog2DaWAOXFk49LhbaWdGVGKnlkQzTW2jDVe+o9ofEpZUIhPDbfiAEb24E0XAWv9hW
         JtrPMExsV2QEb6P2OnXnwPtNWmK1kPZDDIoxIRXSvFltkNP+LkgZtet510WyGvmSQiwq
         cMOVnfzqOOt88kcpkXQ6UK5kBWD9fqfOdSmGw6sU+kbMeVJVt6lh6jGZeemvM/L8OUUT
         sXt6Hx2L8x1IlMBYjJqiViwNdJBK5UGN8RfvyW0gG0u3Bbo0aLrNZDy0gLxKgwE/FowY
         O/9F+stkuPocyFj1AMgM8tPowMocOHFFEk3Ihj/XrOp1otCiEGuM2C0FrjpU6egQq94E
         5xrA==
X-Gm-Message-State: AOJu0YynKBg00buj/gZxQcel6Zcv1RjR7e2yad1cHuxcr59XYvGiEHSM
        G9uzCqMQD4xZmlKeCZuJx2nLpbDtjAA=
X-Google-Smtp-Source: AGHT+IEIYbxgLZ79qUUZVIIRbM2ufp4UOmWtxJ+E8uenp5I3K9DrbcYHSjdWkJmQ/dqMU2G1STZARBy5Tp4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ef0a:0:b0:d89:b072:d06f with SMTP id
 g10-20020a25ef0a000000b00d89b072d06fmr5890ybd.7.1699403531496; Tue, 07 Nov
 2023 16:32:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 16:31:32 -0800
In-Reply-To: <20231108003135.546002-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108003135.546002-17-seanjc@google.com>
Subject: [PATCH v7 16/19] KVM: selftests: Add helpers to read integer module params
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers to read integer module params, which is painfully non-trivial
because the pain of dealing with strings in C is exacerbated by the kernel
inserting a newline.

Don't bother differentiating between int, uint, short, etc.  They all fit
in an int, and KVM (thankfully) doesn't have any integer params larger
than an int.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  4 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 62 +++++++++++++++++--
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index a18db6a7b3cf..46b71241216e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -238,6 +238,10 @@ bool get_kvm_param_bool(const char *param);
 bool get_kvm_intel_param_bool(const char *param);
 bool get_kvm_amd_param_bool(const char *param);
 
+int get_kvm_param_integer(const char *param);
+int get_kvm_intel_param_integer(const char *param);
+int get_kvm_amd_param_integer(const char *param);
+
 unsigned int kvm_check_cap(long cap);
 
 static inline bool kvm_has_cap(long cap)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 7a8af1821f5d..65101c7d1a1a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -51,13 +51,13 @@ int open_kvm_dev_path_or_exit(void)
 	return _open_kvm_dev_path_or_exit(O_RDONLY);
 }
 
-static bool get_module_param_bool(const char *module_name, const char *param)
+static ssize_t get_module_param(const char *module_name, const char *param,
+				void *buffer, size_t buffer_size)
 {
 	const int path_size = 128;
 	char path[path_size];
-	char value;
-	ssize_t r;
-	int fd;
+	ssize_t bytes_read;
+	int fd, r;
 
 	r = snprintf(path, path_size, "/sys/module/%s/parameters/%s",
 		     module_name, param);
@@ -66,11 +66,46 @@ static bool get_module_param_bool(const char *module_name, const char *param)
 
 	fd = open_path_or_exit(path, O_RDONLY);
 
-	r = read(fd, &value, 1);
-	TEST_ASSERT(r == 1, "read(%s) failed", path);
+	bytes_read = read(fd, buffer, buffer_size);
+	TEST_ASSERT(bytes_read > 0, "read(%s) returned %ld, wanted %ld bytes",
+		    path, bytes_read, buffer_size);
 
 	r = close(fd);
 	TEST_ASSERT(!r, "close(%s) failed", path);
+	return bytes_read;
+}
+
+static int get_module_param_integer(const char *module_name, const char *param)
+{
+	/*
+	 * 16 bytes to hold a 64-bit value (1 byte per char), 1 byte for the
+	 * NUL char, and 1 byte because the kernel sucks and inserts a newline
+	 * at the end.
+	 */
+	char value[16 + 1 + 1];
+	ssize_t r;
+
+	memset(value, '\0', sizeof(value));
+
+	r = get_module_param(module_name, param, value, sizeof(value));
+	TEST_ASSERT(value[r - 1] == '\n',
+		    "Expected trailing newline, got char '%c'", value[r - 1]);
+
+	/*
+	 * Squash the newline, otherwise atoi_paranoid() will complain about
+	 * trailing non-NUL characters in the string.
+	 */
+	value[r - 1] = '\0';
+	return atoi_paranoid(value);
+}
+
+static bool get_module_param_bool(const char *module_name, const char *param)
+{
+	char value;
+	ssize_t r;
+
+	r = get_module_param(module_name, param, &value, sizeof(value));
+	TEST_ASSERT_EQ(r, 1);
 
 	if (value == 'Y')
 		return true;
@@ -95,6 +130,21 @@ bool get_kvm_amd_param_bool(const char *param)
 	return get_module_param_bool("kvm_amd", param);
 }
 
+int get_kvm_param_integer(const char *param)
+{
+	return get_module_param_integer("kvm", param);
+}
+
+int get_kvm_intel_param_integer(const char *param)
+{
+	return get_module_param_integer("kvm_intel", param);
+}
+
+int get_kvm_amd_param_integer(const char *param)
+{
+	return get_module_param_integer("kvm_amd", param);
+}
+
 /*
  * Capability
  *
-- 
2.42.0.869.gea05f2083d-goog

