Return-Path: <linux-kernel+bounces-139532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4684A8A0405
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BD8282588
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4CF3D978;
	Wed, 10 Apr 2024 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="B8nxfyCx"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44E36B08
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791606; cv=none; b=DNXrG9WI1ZJWjBq9dMGDVPhmV10FLoKAfa1QthsRl4rWLPw+QzJKjHdJZeyGBuenOUfPrFPxDoEghvVFnMwous1hTONXkxVuisZ7mAZo8x5cUO9A3Eg9jNlcfM1lLbDk9GLmVmui1otHkRwOsH2MGmsecb8LPgzQchWksLDHKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791606; c=relaxed/simple;
	bh=VoLCsCIDC0AKpRM6tLqdI9FChyNA7KdpvNzq3N9K8Qg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JTe3BtPhq7mGRYKZVF1bZFN/Yn0wkCvY6ndpRdoHZcpvjqLh69PhBTMEr238kgyUY+JEaVP9t46GR6yFcZFE6espwim1AHrfKv6pouDgxFOLwQyRNwSwzLXVFZxSWDzllU9n6BPuIHKKJH4N8C6aRO0PlRNvqglhgkUAdV+aV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8nxfyCx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so11634051276.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712791604; x=1713396404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zlurd5WmAU6KZdndMyIzN+3lsSewcbke/BSJIsyJm9I=;
        b=B8nxfyCxhDMThVF8zrt7SlovVFFHXvqnZ3GmzKuwzdPdWMG9HPNltDFwfxYkkCiRxU
         NNIK+zVM0AIDmui549+UA/PEgS801IW0MJlyVDye3dCdHUTd+o5R9SmDQ7LleNbATH8L
         EcQVo9AGQ59obMXD4eT8A1oRES0Rbuxd2pcvdW6Y/58tWuhnotdjrph3G++4ncTGYlg/
         J2hfQkGmQVImjSkEuamjDFFyNC36nEP0rscpSG9Og7COoOql5Ya0LvwusPsXAo4RFPUe
         dOqCXd0II4ZGmVtPMmz7v6cnFxvnBiwW09SZHxxSfZbV7vMmuKJOt8bnuflCyPAlsn8c
         vK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791604; x=1713396404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zlurd5WmAU6KZdndMyIzN+3lsSewcbke/BSJIsyJm9I=;
        b=lyrDSK6j1scKOYcPprQh9eH4Pgi5aWDfjjiDwXj0+OFMmglogVCf4385k7EFgCIVSx
         lmGlGzTksGzbN579LxBWtyk0982IxdmJIyFI3YCkcZMAbthS6Dmnf/u4+UPjFAj6F3eP
         qZS855uRrf/+sShtoFCp9Ka7vKJxWXOk8ACJ72Yv+bRODJIZsv3emV7WHAzGOG5LtdoM
         3ry/Ni0UD6koUOwr8l9vq2wKxcJu/Gy4wIzN8Ba3Wyx78U0GdETyqKSyna+5PnYhGBmm
         PdzlOXs7NuM4BE8vvekr4oxzMh4x+1pEyIlzH9wMX8mz3irbpHbZv5JJV2GdZYopCltu
         w2Sg==
X-Gm-Message-State: AOJu0YyA6qdOWM+1PCDyUXy9R89V3iaBenhmqGPkQhuk6ZgS8W4aEQzW
	cjqm3BIdk1OyueFURT3LOEx9BU40dG1Th3Fu2cOGVd3ObzubKvAfEK8pnZT9KfZnyrwOh0L0ZQ8
	aImBYpDjaGf/kGyNU3tdlGrMP9n9vgi6hEZJq+GpVFj5bxZwWpCDv1BOFrjT3SBQtMFtIjLwEwb
	kR8I0CkXfK764oVcNw/5S/BVukBV/mxzwY2XdVKtAKsuqr
X-Google-Smtp-Source: AGHT+IHlbDC6ToGv1bXxA7Ao7B2WmThFk0HhdVs5BWSwsysizqGhpLzvpd+POKg06SuokF65H5Kbm0yuXOGl
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:a124:0:b0:dcc:54d0:85e0 with SMTP id
 z33-20020a25a124000000b00dcc54d085e0mr1134663ybh.11.1712791603824; Wed, 10
 Apr 2024 16:26:43 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:26:29 -0700
In-Reply-To: <20240410232637.4135564-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410232637.4135564-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410232637.4135564-2-jstultz@google.com>
Subject: [PATCH 2/3] selftests: timers: Fix uninitialized variable warning in ksft_min_kernel_version
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, kernel-team@android.com, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Building with clang, I see the following warning:

In file included from posix_timers.c:17:
/../kselftest.h:398:6: warning: variable 'major' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
        if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
            ^~~~~~~~~~~~
/../kselftest.h:401:9: note: uninitialized use occurs here
        return major > min_major || (major == min_major && minor >= min_minor);
               ^~~~~

This is a bit of a red-herring as if the uname() call did fail,
we would hit ksft_exit_fail_msg() which should exit.

But to make clang happpy, lets initialize the major/minor values
to zero.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Edward Liaw <edliaw@google.com>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: kernel-team@android.com
Cc: linux-kselftest@vger.kernel.org
Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_timer_distribution()")
Signed-off-by: John Stultz <jstultz@google.com>
---
 tools/testing/selftests/kselftest.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 973b18e156b2..12e2f3ab8b13 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -392,7 +392,7 @@ static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
 static inline int ksft_min_kernel_version(unsigned int min_major,
 					  unsigned int min_minor)
 {
-	unsigned int major, minor;
+	unsigned int major = 0, minor = 0;
 	struct utsname info;
 
 	if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
-- 
2.44.0.478.gd926399ef9-goog


