Return-Path: <linux-kernel+bounces-141707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451C38A2235
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B2CB2238D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A819647A5D;
	Thu, 11 Apr 2024 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2z3aX3YQ"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0147A74
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877600; cv=none; b=XtnDwCb423YVw5iUqbgblVwsZzypzAPCUCYaWEgBY33ScDtOT7CzJBqQCSumKzf/RMclmDQ61rCw9L1tmTOupvFS/VyOQtPy8F3LAzSuzW66BW3L3OfP+vUwzWn6bHqlmwgXer7ZqyiCTNv/32GQUtI9gYTImEzmhlVXmT+m/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877600; c=relaxed/simple;
	bh=ls0xJJ270NTOYnvfFdGUV1ok/VYXdsyzhUfyHVXx5Rs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uTvBpAhbmnfBF9SOEabMSXweU2hKVkqC5fzrc3vW3Ckoz8LbxyAn1NVjsy7f5ca86JtI/Ja6umEnSgjHLqj4wdVQRIqvdfkvzLp8jOHWXVZkchT/6iuqmGekKo70mGGbjFFUdu+yH4FvkpOfR6+vgjkDiQuN6fl1mf+nnRpfo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2z3aX3YQ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ed25eb26d6so303847b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712877598; x=1713482398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5zpMelPR/Q05P4yZbANW3smZq3nLKCEwEnHHYOEX7BY=;
        b=2z3aX3YQ6piP8rDYoYguR7rMQALcw/AUTz5NMdibUahd+1UKz/rk7rWw2JAEDAFt2A
         mOKIEjaRVuQzx72ZBFwUrxnogRxHkXLTEwWFxmkZsE3FMyca6ALA8iZCRoMWfP+hO8/N
         TD50A6M7BxmnOStTZjvcTibAgq08l4P5yr1WGYmxz5hiCBJvMkiGwf1lCyru08L86iTq
         ALZMMMM7l0xpzhnj12Mdd2woddTXExyK2trdm7aIo2FRroSBmUuHHFgVz7WqD22XiOnR
         CroAoAHgayj9+NK67eDaW86ap1V+hIPOShJmEBlpOBVRDtD/FCCS9Wmfk6K0mwNgZA/1
         wzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712877598; x=1713482398;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zpMelPR/Q05P4yZbANW3smZq3nLKCEwEnHHYOEX7BY=;
        b=TxqGzUItTMnBemXoxZcd1z6WYIFWoJcxUnCejeunVFRBpi3jrWZJmIjLMKXUGdqZem
         GVp8PaDAMle1IQdsOg6/+VgUFrTMD+7CH9tJl2F2+CRkPNIRMw/TVqRUI7p9dHjTrgab
         dGkQP067PmYOVzxSpkkHiE8mN5D8JWHiv0qwOOtwGRY/fq/KE+NEmst+7RubyJPa5ZMu
         OfbpSNFztvgu6Ivq9wiwPSLX/hlWNjqSgPvM3LzkQhS0aHzC/h9UiNT9AyoeG8hkaAYG
         Twn2aKKTYlC6x+WW8gR9vY9UJJeE5+ZgkQu89JjYtCQ32sHDWPw5F8dZts+0rEmfgAsz
         qU/A==
X-Gm-Message-State: AOJu0YxOCg24SzgK65RdY12Pp6d7151IUaFdCxI493wmdYzXdO9I3dAY
	44o22HXyGmTMSIqtii90u3g8QQN3sQexSbK4jyM5RN2ajCVLExN2Dw8NVmhBeEzxRtXRTRnwrVy
	Ldk22V3QWWTL7TFyKaGmiHpeJMH2GEPG3l41/Coo+xUkh6ULQvPAtY6x06yednYGs0TBAdocr+A
	V89VtxpCuqMSiC1XBLQ+kGnBIN29z9gC3VqpWuH7GY
X-Google-Smtp-Source: AGHT+IFLfDrP1amVJB3d3HaxnBLnZmZqMjR5reHrOoeYxEPUItc4VJwMrhhWU2YhVGvypmJmcL1x4zlOcQA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:a16:b0:6ea:8a0d:185f with SMTP id
 p22-20020a056a000a1600b006ea8a0d185fmr70673pfh.2.1712877597805; Thu, 11 Apr
 2024 16:19:57 -0700 (PDT)
Date: Thu, 11 Apr 2024 23:19:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240411231954.62156-1-edliaw@google.com>
Subject: [PATCH] selftests/harness: remove use of LINE_MAX
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Android was seeing a compliation error because its C library does not
define LINE_MAX.  This replaces the use of LINE_MAX / snprintf with
asprintf, which will change the behavior to not truncate the test name
if it is over 2048 chars long.

See also:
https://github.com/llvm/llvm-project/issues/88119

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/kselftest_harness.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4fd735e48ee7..70fedd2411ed 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1156,7 +1156,7 @@ void __run_test(struct __fixture_metadata *f,
 		struct __test_metadata *t)
 {
 	struct __test_xfail *xfail;
-	char test_name[LINE_MAX];
+	char *test_name;
 	const char *diagnostic;
 
 	/* reset test struct */
@@ -1164,8 +1164,8 @@ void __run_test(struct __fixture_metadata *f,
 	t->trigger = 0;
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
-	snprintf(test_name, sizeof(test_name), "%s%s%s.%s",
-		 f->name, variant->name[0] ? "." : "", variant->name, t->name);
+	asprintf(&test_name, "%s%s%s.%s", f->name,
+	         variant->name[0] ? "." : "", variant->name, t->name);
 
 	ksft_print_msg(" RUN           %s ...\n", test_name);
 
@@ -1203,6 +1203,7 @@ void __run_test(struct __fixture_metadata *f,
 
 	ksft_test_result_code(t->exit_code, test_name,
 			      diagnostic ? "%s" : "", diagnostic);
+	free(test_name);
 }
 
 static int test_harness_run(int argc, char **argv)
-- 
2.44.0.683.g7961c838ac-goog


