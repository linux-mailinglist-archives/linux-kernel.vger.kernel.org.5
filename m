Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D517E773E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345851AbjKJCPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345853AbjKJCOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:14:40 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565B74EFD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:52 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a828bdcfbaso22017017b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582431; x=1700187231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QsiXyox+rGQhiB/Za0Yz/FRQCQ9gMcg4U4njvPOlEGQ=;
        b=OYUNIous6w/DVODToQCGzn5Ctp6jhfLxdAakTa+L6eAb4sbQgBDJVLU4joUPCaz57P
         wtekKSiCAiPYFQTxwAFSRnd37UdUSKXCpFSI2kNs3ktzoeN8UOqOveyuUGM331ZevrZ3
         I6Y90/CKz+ACo1O9NbGcH3bR3A0La31yilOTPdb5tPLeRNFGKUHQGTWl2ZHwKvR2Bp9z
         kQ4phvbVL0z1mzl8FEb+SEPUk0IEDY9IREDoBRc4ourghWBioHl0TvgRPuREDGaSzOEX
         14X5vHipWSnxSoOdOLKRt41ycQ4Tm3VROCAqDGqlP0ctky9RE++E7tEG/vktCDo9tVHm
         v4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582431; x=1700187231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsiXyox+rGQhiB/Za0Yz/FRQCQ9gMcg4U4njvPOlEGQ=;
        b=pY/VV2nDd6gJ1leT6ZHOOhDi2mUIjljAidJtywdK+Idf0K91rL/iHcrkAGz9pTSPg9
         EU6F0cbnev7eEvasXwjQmgYV17pdvVRF75FcNO8QjrygYngahSCnpjTr6DKrNzM3jyhp
         Uv3MLvSWhuiOXnXppt/hxtjd+EFDWZXD4xfdBtU6QTnmfIASxPbiw1jTgsiObvVSTcBd
         2M0aKuyz0OsoqMRidXM1GIutN7nTcJ8rlycq2HjXDryUrcI0fF3vPraOaYB/30L7Ub8a
         1Z5Xce52jRH0JUhbLJomHMl3xuDbbkymoSWMHjl9/r0iLMaEpcR/+IsJ79lbq4WKM9ED
         KefQ==
X-Gm-Message-State: AOJu0YwfjxC2rTPtLWa5HEsnoZofK+7wzeUZTwpDBISZUrstGVONxbDu
        T9o72H4VE1/iz2pg5on9n708CUzaDMc=
X-Google-Smtp-Source: AGHT+IFTeRPJpaa7FeNaVxyAzFNQz2Gao4FLG7pA0d2I2Blj11X9hrzBEX+Uqv3V4mTTtN3DFJ96nogtkkM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:7c5:0:b0:da3:b96c:6c48 with SMTP id
 t5-20020a5b07c5000000b00da3b96c6c48mr194656ybq.9.1699582431526; Thu, 09 Nov
 2023 18:13:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:13:00 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-21-seanjc@google.com>
Subject: [PATCH v8 20/26] KVM: selftests: Add helpers to read integer module params
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

