Return-Path: <linux-kernel+bounces-118715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE6688BE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9B1B1C3C041
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD96BB37;
	Tue, 26 Mar 2024 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1AtP0dK4"
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B34F890
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446705; cv=none; b=KZXIzdJ5oEL6aCGjuAFWM26r5Pg0Voj65GKTXxUhKJ5dwOgSu2Rjm8ygfsjuMyvq0ej4m0nuOEb/m0SZqRCSehH9ikkkxxbTBAPaZ7VKUI6/dM7sRsHuuttcMYBUDNc3LvqR2zvsnIWyLMREtwrC7rfps1zJqZg4mMbCvK52Fy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446705; c=relaxed/simple;
	bh=Y/Fe2nuAfbquShRDARDpQDHohV/57OtC56bvtHvFkQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1Fn7928Y6ZDus8hxPBi7556d2BAVMqF3NLLMQViBhK4+Gl++Z4a/U1CYWJNejVouo0nU3c9awAGwUoVvbrJO5Z9uw1wX5tuWtmlFdRf3UQnb3wLIQ80a400zEKdUvWTE44S2XOUIOuZaC79UeQZMd81fO+qnPoispSvJkOYQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1AtP0dK4; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V3lSX6rTmzdbd;
	Tue, 26 Mar 2024 10:51:40 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4V3lSX10Q6zr3;
	Tue, 26 Mar 2024 10:51:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711446700;
	bh=Y/Fe2nuAfbquShRDARDpQDHohV/57OtC56bvtHvFkQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1AtP0dK4lGWiJBWrC6gdBjuStkRbjbhImxROzZHC0nMwtvBS2EpG7j8RN9dDDPUhi
	 53sMgMi/qpmTJ9qkmUels/+60Noy+K7HUN9LGdqs5dXy4/BATJOPIdSXgBvwQsqp4Y
	 +1lmwy7NXcJ+NFlwsTRhftchRgJF3iUi4KPspEck=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <keescook@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>,
	kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org
Subject: [PATCH v4 5/7] kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
Date: Tue, 26 Mar 2024 10:51:16 +0100
Message-ID: <20240326095118.126696-6-mic@digikod.net>
In-Reply-To: <20240326095118.126696-1-mic@digikod.net>
References: <20240326095118.126696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Fix KUNIT_SUCCESS() calls to pass a test argument.

This is a no-op for now because this macro does nothing, but it will be
required for the next commit.

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Rae Moar <rmoar@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240326095118.126696-6-mic@digikod.net
---

Changes since v2:
* Add David's Reviewed-by.

Changes since v1:
* Add Kees's Reviewed-by.
---
 lib/kunit_iov_iter.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 859b67c4d697..27e0c8ee71d8 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -139,7 +139,7 @@ static void __init iov_kunit_copy_to_kvec(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -194,7 +194,7 @@ static void __init iov_kunit_copy_from_kvec(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 struct bvec_test_range {
@@ -302,7 +302,7 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -359,7 +359,7 @@ static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 static void iov_kunit_destroy_xarray(void *data)
@@ -453,7 +453,7 @@ static void __init iov_kunit_copy_to_xarray(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -516,7 +516,7 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 			return;
 	}
 
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -596,7 +596,7 @@ static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
 stop:
 	KUNIT_EXPECT_EQ(test, size, 0);
 	KUNIT_EXPECT_EQ(test, iter.count, 0);
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -674,7 +674,7 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
 stop:
 	KUNIT_EXPECT_EQ(test, size, 0);
 	KUNIT_EXPECT_EQ(test, iter.count, 0);
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 /*
@@ -753,7 +753,7 @@ static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
 	}
 
 stop:
-	KUNIT_SUCCEED();
+	KUNIT_SUCCEED(test);
 }
 
 static struct kunit_case __refdata iov_kunit_cases[] = {
-- 
2.44.0


