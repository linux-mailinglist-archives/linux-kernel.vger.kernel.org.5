Return-Path: <linux-kernel+bounces-29984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0461B831630
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942DB1F23480
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A81F94C;
	Thu, 18 Jan 2024 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dw21sRWg"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB91B96D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571470; cv=none; b=p1pTZJXwOWnmj/8AmrdKrU0OlzqS5U8HLzfjpC/jORhAMkWR7G30bvIyemhSSkNOdxR7oAqiDPah1IhZ8wv3G6wGkIRE5PMrEPvoRHCNaap0RhG3TfgpV86sw9qHtSG0vy6kGM3k/MNMKNtIgMZPdmI/bbzoFUvoN59MbhPXYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571470; c=relaxed/simple;
	bh=s3vUMJLFHAD51DC2yFRfx7iE/+ob/GznEz4ar3z3+bk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=F4qsvmLr4Rr3xELrZ4xFuC5eawrG2vTCZaBAPWIOauf68gvBdlnyvQTp3c5E4OKoWaK/rPS9ep84+VGL7kXEsNaSQd3G/TYN1LNTCKRtyQW0lYvjiEgApqQFHQDEb+Pq8NzRSaoPcTsXkmXEguM5ZOJi46UYnibf0xK245BGqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dw21sRWg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gthelen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e744f7ca3bso188256057b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 01:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705571467; x=1706176267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RO6rdO7yon9JVy5o6uihMLS4VCKN6/zkfcB4kXn3j3k=;
        b=Dw21sRWgO25P5sGKQLu6OP4DyJdA36g7iapH1YdNEM0JzusJTk4F+HyTIVlF7CGt21
         B9rNP3gSAJ7iz81cw6MPcslp6AnPGlf9LVU/C/A2N4UxGtBg1c+DzVnra4c5Dss3XBN7
         pji35wkNFln3yfIGos8mRnGJzZW+ZnHJY9gncqHC+UdE+vSBDhORG0yyzUqqFsv/MWX9
         t6AZ1AeGYWcwlj2ob+wXQ/8d5F7mrGLHfU4JpC7FpoLTiLWSaRchAQW3tDu9zPcPs7rH
         YzjtVCIKPa6DvRxsb2rWt0Xgnz+cYfgQ52YMSlfiNE9JBoTg4G1hRidCRcLcX9xEJEW8
         iA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705571467; x=1706176267;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RO6rdO7yon9JVy5o6uihMLS4VCKN6/zkfcB4kXn3j3k=;
        b=IDunWPptxkReUnH0Kfh4nKkTqLlK3IgFYTKZP3UzGyaMQUq3aD3yli4/MMdXLsdB64
         k9/Mex6nwvNmoA+UwU6PTdfb/KZKLMvm4rAfU90bFEIef6RrHENq9/FHVDqoNWhFts2g
         FR0izzX9eq2El3MPAiUfuXegdOEF3g8XSKnrVnbl4Egr2RLpJwv4e8DrFesFL8tjvH0n
         cV9fFHta8U00rFgKrnCIxFAlMixN57VmHDUXCzmuLck6nLxHUbstP8N9+0Bv66nYT6V1
         OGhc78qwhBpWYNVCF57iPp42+N1HXvqDBMr4rvz8U6P7n64pjJV0NegT7XchFCwYpbMX
         iuPQ==
X-Gm-Message-State: AOJu0Yw38YvYzMfrrLbzZt+DfysR0Z2hWY1696o6KvtoDOQxFGKKKa5O
	CWYr4Bt0JvjS1Cj7Dcdj06VpFfnMj0ITMHnj2LMKJ+OAIphg6cmI6sjwi6VE8fOyouq1gEhWDYl
	RDaCI3w==
X-Google-Smtp-Source: AGHT+IGe18viwrppfstJfi4AUcP2ZanhxP9sww14HmVAsZgEBU6B1iIqZG6+djVghvja7wuNIfkQ57OeetYp
X-Received: from gthelen-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1b13])
 (user=gthelen job=sendgmr) by 2002:a25:b112:0:b0:dbe:32b0:9250 with SMTP id
 g18-20020a25b112000000b00dbe32b09250mr27546ybj.0.1705571466906; Thu, 18 Jan
 2024 01:51:06 -0800 (PST)
Date: Thu, 18 Jan 2024 01:50:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240118095057.677544-1-gthelen@google.com>
Subject: [PATCH] selftests/memfd: delete unused declarations
From: Greg Thelen <gthelen@google.com>
To: Daniel Verkamp <dverkamp@chromium.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 32d118ad50a5 ("selftests/memfd: add tests for F_SEAL_EXEC"):
- added several unused 'nbytes' local variables

Commit 6469b66e3f5a ("selftests: improve vm.memfd_noexec sysctl tests"):
- orphaned 'newpid_thread_fn2()' forward declaration
- orphaned 'join_newpid_thread()' forward declaration
- added unused 'pid' local in sysctl_simple_child()
- orphaned 'fd' local in sysctl_simple_child()
- added unused 'fd' in sysctl_nested_child()

Delete the unused locals and forward declarations.

Signed-off-by: Greg Thelen <gthelen@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 3df008677239..18f585684e20 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -44,8 +44,6 @@
  */
 static size_t mfd_def_size = MFD_DEF_SIZE;
 static const char *memfd_str = MEMFD_STR;
-static int newpid_thread_fn2(void *arg);
-static void join_newpid_thread(pid_t pid);
 
 static ssize_t fd2name(int fd, char *buf, size_t bufsize)
 {
@@ -194,7 +192,6 @@ static unsigned int mfd_assert_get_seals(int fd)
 static void mfd_assert_has_seals(int fd, unsigned int seals)
 {
 	char buf[PATH_MAX];
-	int nbytes;
 	unsigned int s;
 	fd2name(fd, buf, PATH_MAX);
 
@@ -696,7 +693,6 @@ static void mfd_assert_mode(int fd, int mode)
 {
 	struct stat st;
 	char buf[PATH_MAX];
-	int nbytes;
 
 	fd2name(fd, buf, PATH_MAX);
 
@@ -715,7 +711,6 @@ static void mfd_assert_mode(int fd, int mode)
 static void mfd_assert_chmod(int fd, int mode)
 {
 	char buf[PATH_MAX];
-	int nbytes;
 
 	fd2name(fd, buf, PATH_MAX);
 
@@ -731,7 +726,6 @@ static void mfd_fail_chmod(int fd, int mode)
 {
 	struct stat st;
 	char buf[PATH_MAX];
-	int nbytes;
 
 	fd2name(fd, buf, PATH_MAX);
 
@@ -1254,9 +1248,6 @@ static void test_sysctl_set_sysctl2(void)
 
 static int sysctl_simple_child(void *arg)
 {
-	int fd;
-	int pid;
-
 	printf("%s sysctl 0\n", memfd_str);
 	test_sysctl_set_sysctl0();
 
@@ -1321,7 +1312,6 @@ static void test_sysctl_sysctl2_failset(void)
 
 static int sysctl_nested_child(void *arg)
 {
-	int fd;
 	int pid;
 
 	printf("%s nested sysctl 0\n", memfd_str);
-- 
2.43.0.429.g432eaa2c6b-goog


