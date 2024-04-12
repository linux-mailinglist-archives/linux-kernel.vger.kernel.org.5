Return-Path: <linux-kernel+bounces-142662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0841B8A2E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0ED1F22FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41075A4D1;
	Fri, 12 Apr 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Do472uni"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694D205E2B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712925437; cv=none; b=Zot1rW2auIJem9vsSkD1OBtyeQ7VociHDLDls7vavNji+YJY35fPojtiiZLbhRkCgeUbY08GBc8Wg/avwOc5GmOcQzrJssCx+wsFc5pvemK2HYxQ9JYkENaak+Hst5uuSwPpD0HinZcRObcNRv/apt9kT91+ZdE2Bh1lA/ZP5xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712925437; c=relaxed/simple;
	bh=TOAT4TTAOWZXp1h7q54paBib/TPxqqPYt/m0hPrKDjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7kWEQKFwjm9r5o56CoaPy9xM+zOxaiapAW1nUe+ZiHlEFEIIv/qsrsck5pA8jMbJVjWJ1Ic8jcUr+zjXMZMXAh5yIcAYPoW9IMwER8xsPHEAmKWcmZSpYWY9kH0uU0fme0nDVRZcVeoD/uMqQ2vUjJrJPng/mJZIdkChRtmKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Do472uni; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712925434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G73VCC5q7JEsOcm9nuCMvIK+kF0cB2PArLXaQyavNe0=;
	b=Do472uniqkROiZYXJax8mdptbrz3rThguAzcst7eff90nr+5U15ZQufaeCdRvYzn4nKNG2
	G3XFbC1MlCFe2qYrnYjSsWIkNMqWI/5Km6bUXNpLP1zILvOgomro7gVSUckIvlZO70dI5Z
	IQ6cicrmWltYGJqqezGCGpGjWzswe4M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-HdPWaD0fNQeNnOeMpYxRCw-1; Fri, 12 Apr 2024 08:37:11 -0400
X-MC-Unique: HdPWaD0fNQeNnOeMpYxRCw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B505B802E4D;
	Fri, 12 Apr 2024 12:37:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id 73C72492BC7;
	Fri, 12 Apr 2024 12:37:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 12 Apr 2024 14:35:44 +0200 (CEST)
Date: Fri, 12 Apr 2024 14:35:36 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Mark Brown <broonie@kernel.org>
Cc: John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] selftests: fix build failure with NOLIBC
Message-ID: <20240412123536.GA32444@redhat.com>
References: <87sf02bgez.ffs@tglx>
 <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx>
 <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com>
 <f0523b3a-ea08-4615-b0fb-5b504a2d39df@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0523b3a-ea08-4615-b0fb-5b504a2d39df@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

As Mark explains ksft_min_kernel_version() can't be compiled with nolibc,
it doesn't implement uname().

Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_timer_distribution()")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/f0523b3a-ea08-4615-b0fb-5b504a2d39df@sirena.org.uk/
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 tools/testing/selftests/kselftest.h           | 6 ++++++
 tools/testing/selftests/timers/posix_timers.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 973b18e156b2..0d9ed3255f5e 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -392,6 +392,11 @@ static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
 static inline int ksft_min_kernel_version(unsigned int min_major,
 					  unsigned int min_minor)
 {
+#ifdef NOLIBC
+	ksft_print_msg("NOLIBC: Can't check kernel version: "
+			"Function not implemented\n");
+	return -1;
+#else
 	unsigned int major, minor;
 	struct utsname info;
 
@@ -399,6 +404,7 @@ static inline int ksft_min_kernel_version(unsigned int min_major,
 		ksft_exit_fail_msg("Can't parse kernel version\n");
 
 	return major > min_major || (major == min_major && minor >= min_minor);
+#endif
 }
 
 #endif /* __KSELFTEST_H */
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index d86a0e00711e..878496d2a656 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -241,7 +241,7 @@ static int check_timer_distribution(void)
 
 	if (!ctd_failed)
 		ksft_test_result_pass("check signal distribution\n");
-	else if (ksft_min_kernel_version(6, 3))
+	else if (ksft_min_kernel_version(6, 3) > 0)
 		ksft_test_result_fail("check signal distribution\n");
 	else
 		ksft_test_result_skip("check signal distribution (old kernel)\n");
-- 
2.25.1.362.g51ebf55



