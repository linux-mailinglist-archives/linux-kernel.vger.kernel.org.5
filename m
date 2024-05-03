Return-Path: <linux-kernel+bounces-168082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26CA8BB36B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0BB1F23822
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39C112EBF1;
	Fri,  3 May 2024 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="wBPbdiUO"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0AD51A
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761900; cv=none; b=KtZctOYQaALjHCSG73HUHrx6mANwQoCPwCDyzn57tuTtaV2EQBZVBK02cyhBfqFXZQV7NFTIkIdBw4850zGiaQVtRH/BeGNmPi5N9WEkqkbv5geR/k9J9zCdbohGOZfPk5fk+BXnIUBjK8as5CGAuv8e4vyXhx8YFfA1VHSba+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761900; c=relaxed/simple;
	bh=DpLbOXcsDefc9eadWLyevH6SV5/Lj+N6zdbxsM8MFjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lLUKKuFD4u9M5iAdIrqHhGJ+LcAzv4ZuwtQQZ27AdnMn1+5HPfTzP8uWP4Iy87QRIApmK/YvbRZs+GG9xqUlfVT86e+0KPvX2CSMiH7+oO1rwT8vAL3iXdQcwUMBrZB6Lu33qZXmGV6Hc3vCSTc23sRzaNTV3IEL7nZAYQVXWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wBPbdiUO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ee128aa957so26587b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714761899; x=1715366699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c4xhm1GLSMgZL12H1tRWafB6PB4QZWb78tjxuvu5l88=;
        b=wBPbdiUOZEVBSRlwGj6qGKxjxteeYyiaGmhN33d7Lvr+Sj3cV4GndEv1Csq6auSynU
         0vCgHw8vy9x7rCufvi7PCD0ag++UVeICvA92F8HhKwhkVTc1loCUr1pQqJ6/koDAhHGV
         D1ieSLi0MDS0ic20fGc5PsfbFduUgr07HGkeEEZYbDUpqg+SS1detBJZwXsQFmqyj/Ea
         U0WkszyFtxZNgQq752ckFZV85G57otHFCcJ1PFprRwmMNgMQWd2abr/BqEOAB7XTKSjE
         47c6xx5+70WK3SQqHp0FoiaDbS3YNc3RI2T9W6rlr0ZBEksADFiVol0d109xiIQLQZpc
         gQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714761899; x=1715366699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4xhm1GLSMgZL12H1tRWafB6PB4QZWb78tjxuvu5l88=;
        b=gk4iN2VK5MXLlAqo/kih9UBuc/UC0/uV/62ipDOavN/7q9EJM4vTuL2OXT+atXXJdz
         rTdZL9bDb2fxQvdMsSLmNX96ZREuNoOEvkIGq2zFpwKaBO7Vfu9SCr3I44Ii2mR6fr8I
         LYNA1hV4aZNAL8eLPtmqtaJjdc8fg9zzqmqp+woZHk9JmMeORQvRZrpoCajGhvJ5dRnB
         jaSSWC9q/um4uACSJKHPDfRcu/xMY772uPnMIjKulolOMaa/SafZTjnzgD+WZvhoSvpd
         4lYVEisLnP+xiDJndiTSqfkGaDm+AyinOZhV21M3r1IU1XJvMeJIm5CZx0bV+QclWWqw
         o3jw==
X-Forwarded-Encrypted: i=1; AJvYcCX90KadT/tutUxgED5NuoOOkcwudAdK0jjfgEUY9dL+jcc/7K4Eft5a5FzE6dDEGj5OYX/VB7U+L6o0os/P1+TL+8zTtAuhkIcJrcja
X-Gm-Message-State: AOJu0YxVEEq/k3B/GV9LsyQfGfQ3cRCpeusakuv0DRaV2C4egWGH11hu
	Q/pNyeelI5vFJYY2yTr7c+QVbrjwmkh0yqOS85ssWafQtvGlN2Xlq2SM9h6wa/p/ndw+nglutkl
	vYw==
X-Google-Smtp-Source: AGHT+IEVA+Aa/pdkpL7D6dSdvrtJeHXSYi4PpImkwV6isZQpPqnUDsVT7EPB0AlT6V7chnPW8/lfRatMF+k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d8a:b0:6f3:84f4:78e4 with SMTP id
 fb10-20020a056a002d8a00b006f384f478e4mr115865pfb.4.1714761898541; Fri, 03 May
 2024 11:44:58 -0700 (PDT)
Date: Fri, 3 May 2024 11:44:56 -0700
In-Reply-To: <25cc89b7-822f-4735-bec5-59458ec18a49@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240426114552.667346-1-thuth@redhat.com> <ZjPrlLNNGNh2mOmW@google.com>
 <25cc89b7-822f-4735-bec5-59458ec18a49@redhat.com>
Message-ID: <ZjUwqEXPA5QVItyX@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Use TAP interface in the
 set_memory_region test
From: Sean Christopherson <seanjc@google.com>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 03, 2024, Thomas Huth wrote:
> On 02/05/2024 21.37, Sean Christopherson wrote:
> > On Fri, Apr 26, 2024, Thomas Huth wrote:
> > I like that we can actually report sub-tests as being skipped, but I don't like
> > having multiple ways to express requirements.  And IMO, this is much less readable
> > than TEST_REQUIRE(has_cap_guest_memfd());
> > 
> > AIUI, each test runs in a child process, so TEST_REQUIRE() can simply exit(), it
> > just needs to avoid ksft_exit_skip() so that a sub-test doesn't spit out the full
> > test summary.
> > 
> > And if using exit() isn't an option, setjmp()+longjmp() will do the trick (I got
> > that working for KVM_ONE_VCPU_TEST() before I realized tests run as a child).
> > 
> > The below is lightly tested, but I think it does what we want?
> 
> Not quite ... for example, if I force vmx_pmu_caps_test to skip the last
> test, I get:

..

> As you can see, the "ok 5" line is duplicated now, once marked with "# SKIP"
> and once as successfull. I don't think that this is valid TAP anymore?

Ah, IIUC, it's because the test reports a SKIP, and then also eventually exits
with KSFT_SKIP too.

> > I also think we would effectively forbid direct use of TEST().  Partly because
> > it's effectively necessary to use TEST_REQUIRE(), but also so that all tests will
> > have an existing single point of contact if we need/want to make similar changes
> > in the future.
> 
> Ok, but I wrote in the patch description, KVM_ONE_VCPU_TEST_SUITE() does not
> work for the set_memory_region test since it does not like to have a
> pre-defined vcpu ... so if we want to forbid TEST(), I assume we'd need
> another macro like KVM_BAREBONE_TEST_SUITE() ?

Yeah, though we probably don't need BAREBONE, e.g. KVM_TEST_SUITE() would suffice.
The "barebones" terminology exists for VMs because the vanilla "create VM" helpers
do waay more than the bare minimum, whereas I don't think we'll have the same
issues here.

> Not sure whether I really like it, though, since I'd prefer if we could keep
> the possibility to use the original selftest macros (for people who are
> already used to those macros from other selftests).

The more I fiddle with the kselftests harness, the more I'm opposed to using it
directly.  The harness code heavily assumes a "simple" environment, i.e. a test
environment without libraries.  E.g. including kselftest_harness.h without invoking
test_harness_run() fails due to unused functions, and including it in multiple
compilation units, e.g. to allow using its macros in utilities, fails due to
duplicate symbols.

It's obviously possible to split kselftest_harness.h to get around the immediate
issues, but that doesn't help with SKIP() (and other macros) only being usable at
the top-level TEST().  And using the undersored globals and functions params,
i.e. the "private" stuff, directly seems like a bad idea, e.g. the odds of KVM
selftests being broken by changes to the common code would be too high for my
taste.

While I agree it would be nice to not diverge from the common kselftest framework,
as far as things like SKIP and ASSERT macros go, that ship sailed a long time ago,
as TEST_REQUIRE() and TEST_ASSERT() usage is ubiquitous throughout KVM selftests.
And given the limitations of the common framework versus what we have in KVM's
framework, I don't see us converging on the common framework.

It's not perfect, but the best idea I can come up with is to trampoline the skip
out through KVM's harness and on to the common harness.

---
 .../selftests/kvm/include/kvm_test_harness.h  | 11 ++++++-
 .../testing/selftests/kvm/include/test_util.h | 31 ++++++++++++++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c    |  2 ++
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |  3 +-
 4 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_test_harness.h b/tools/testing/selftests/kvm/include/kvm_test_harness.h
index 8f7c6858e8e2..fa4b5f707135 100644
--- a/tools/testing/selftests/kvm/include/kvm_test_harness.h
+++ b/tools/testing/selftests/kvm/include/kvm_test_harness.h
@@ -9,6 +9,7 @@
 #define SELFTEST_KVM_TEST_HARNESS_H
 
 #include "kselftest_harness.h"
+#include "test_util.h"
 
 #define KVM_ONE_VCPU_TEST_SUITE(name)					\
 	FIXTURE(name) {							\
@@ -28,8 +29,16 @@ static void __suite##_##test(struct kvm_vcpu *vcpu);			\
 									\
 TEST_F(suite, test)							\
 {									\
+	struct kvm_selftests_subtest subtest;				\
+									\
 	vcpu_arch_set_entry_point(self->vcpu, guestcode);		\
-	__suite##_##test(self->vcpu);					\
+									\
+	kvm_subtest = &subtest;						\
+	if (!setjmp(subtest.buf))					\
+		__suite##_##test(self->vcpu);				\
+	else								\
+		SKIP(, "%s", subtest.reason);				\
+	kvm_subtest = NULL;						\
 }									\
 static void __suite##_##test(struct kvm_vcpu *vcpu)
 
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 3e473058849f..2fce7b2ed07c 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -8,6 +8,7 @@
 #ifndef SELFTEST_KVM_TEST_UTIL_H
 #define SELFTEST_KVM_TEST_UTIL_H
 
+#include <setjmp.h>
 #include <stdlib.h>
 #include <stdarg.h>
 #include <stdbool.h>
@@ -18,8 +19,22 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/mman.h>
+
 #include "kselftest.h"
 
+/*
+ * kvm_selftests_subtest is used to trampoline from __TEST_REQUIRE(), which can
+ * be called from any context, e.g. KVM selftests library code, out to the test
+ * being run, as the kselftests harness only allows calling SKIP() (and other
+ * macros/helpers) from the top-level TEST_*() context.
+ */
+struct kvm_selftests_subtest {
+	char reason[1024];
+	jmp_buf buf;
+};
+
+extern struct kvm_selftests_subtest *kvm_subtest;
+
 #define msecs_to_usecs(msec)    ((msec) * 1000ULL)
 
 static inline int _no_printf(const char *format, ...) { return 0; }
@@ -36,10 +51,24 @@ static inline int _no_printf(const char *format, ...) { return 0; }
 #endif
 
 void __printf(1, 2) print_skip(const char *fmt, ...);
+
+/*
+ * Skip the test if a required capability/feature/whatever is not available,
+ * e.g. due to lack of support in the underlying hardware, running against an
+ * older kernel/KVM, etc.  If a subtest is running, skip only the subtest,
+ * otherwise treat the requirement as applying to the entire test.
+ */
 #define __TEST_REQUIRE(f, fmt, ...)				\
 do {								\
-	if (!(f))						\
+	if (!(f)) {						\
+		if (kvm_subtest) {				\
+			snprintf(kvm_subtest->reason,		\
+				 sizeof(kvm_subtest->reason),	\
+				 fmt, ##__VA_ARGS__);		\
+			longjmp(kvm_subtest->buf, 1);		\
+		}						\
 		ksft_exit_skip("- " fmt "\n", ##__VA_ARGS__);	\
+	}							\
 } while (0)
 
 #define TEST_REQUIRE(f) __TEST_REQUIRE(f, "Requirement not met: %s", #f)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 6b2158655baa..9601eed3ed57 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -19,6 +19,8 @@
 
 #define KVM_UTIL_MIN_PFN	2
 
+struct kvm_selftests_subtest *kvm_subtest;
+
 uint32_t guest_random_seed;
 struct guest_random_state guest_rng;
 
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 7c92536551cc..a58e0b1c2ee5 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -195,8 +195,7 @@ KVM_ONE_VCPU_TEST(vmx_pmu_caps, lbr_perf_capabilities, guest_code)
 {
 	int r;
 
-	if (!host_cap.lbr_format)
-		return;
+	TEST_REQUIRE(host_cap.lbr_format);
 
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
 	vcpu_set_msr(vcpu, MSR_LBR_TOS, 7);

base-commit: df8e458e70ce925b533ff33f1e8979650cf44e3e
-- 


