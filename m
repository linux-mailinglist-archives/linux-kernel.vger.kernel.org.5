Return-Path: <linux-kernel+bounces-139531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981018A0403
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97EA1C21A58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80A38DE5;
	Wed, 10 Apr 2024 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xQC5MJhR"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B538DD8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791605; cv=none; b=s4wN8LYVYXvfwFzTRqZJEFKm7QEwEc7GEB9oFlzC4DKqd9y3nKu9xzGLZJeErgaDRx7ropRypjvbwaEMIGNtCLNg1JJOFv5H0ASiKSnYaqJzcgRwgXL7bWu/eSeIsBseCFA4WrlFj0WRX7B3tapkyE1/8hsAO/U+vivLqGdzInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791605; c=relaxed/simple;
	bh=5Uh22vIKOPqTl08nz2cIcEKFa+Ku5iV4cUKiaiK6UwA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hPATgjQinlJ1Q/XUeJ+qZZ0wZXGPI9klyJhChpqrGNofaS59ITHevg+SKHVyVkG6VwQNvBVCl3c5+htdCOrA9Ptd9iEuhHL2mkn+w8cbudVo2EUeJwhZzRHJC09UxZcktnyVefIaWKWGo2ZjnNxilSxrXIguOSdjVda0RQtWEJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xQC5MJhR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so9189211276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712791602; x=1713396402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7JUe0tFRaoQ0RUO8nlo0bS/Trq4cm4/yvOCnk0PY7Tw=;
        b=xQC5MJhR8h16ucTxDkSCS0kzlCzvIGb4c/lM4x7/hgiNv6msb6mBXrxe3ZnHBB+U1u
         dvHKh132tWkCey+vRuwgAjQhTrM7FP+Sz51ZFvv+5pZ+KHRnO6Fum9SD7CU/EnugHNpX
         p6vc2VNhd/iDFrS5J2ePxqVfBzQU4LJEU3To13fBjQa7vdwVNW0tgNcGCdY/RKM8DycF
         eJjjS+npP5fAMAeCTsGqwSpacmS0jSJ5AuBvAP6e9yZkNcFH0b4KfPwQGpjVn6ztKH97
         y8Iq8d/rZI/ZxoH9U8Jjp54/MNbZc62rXXCIBNF3zf9j/0exPwKotDSOEGV1lJTKG3TG
         n+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791602; x=1713396402;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JUe0tFRaoQ0RUO8nlo0bS/Trq4cm4/yvOCnk0PY7Tw=;
        b=cKOa35WcWDWC49lDxTUkMrktoXf22j7wwnL8AACh4yWsX6af6hlkOHIzWN9dSpJn1A
         2sWkAxPJdXlodXKf9vO0le9rndQTpMKJlYp07c1l9gaZ2Aaazair3y3OPR2lQWw9rjcn
         IPF1RMgiqqD+LESosEyV+lHNQjuyYxuldl/oLsqF6S9GRqima5IvCRfbgMw2FEHrySD4
         TjRvdcdI3Kdmu46RDyoyNKWupPd8smBQzBgUh0QmqJXIOm3mgPR9fejzhg1kwxqugbvh
         n8ldchZD3Ndld2+05rarQ67XG5i4l5s6iupgenc/tdDbjcWFUqYfX9DfRd7YSjNWrhOF
         hIvQ==
X-Gm-Message-State: AOJu0YwLCgpy02Hp37vUUL9ilCVP0PBOq387x3Aq1Txif55jvOHNjjec
	6oCF02q1/xFLBTNxIaP+MFXYvcdvFbgi496cHwRSEB4XWFa50N4QVuFpmR7PrnfbhtCLyK5NAWF
	ZDAOvOPtwcTBqNcn2F+4/MUX0MfUCGHR0RgX0MHvRLh21v5to/Xa5j8ZZuMaRSvKgiGEWpmEsJq
	3iEjLnTMAkPaY9Rnxs+2GS+LvylFR90+NggP+/9BUWezJM
X-Google-Smtp-Source: AGHT+IHn3qElAk799zrmqQpVWrjI3Xobk90HnjvS6MfZsB7fQ82snexs+qbkA8nn2poKmRJTuL3bOeMuPJfp
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:18ca:b0:dc6:b813:5813 with SMTP
 id ck10-20020a05690218ca00b00dc6b8135813mr358269ybb.9.1712791601994; Wed, 10
 Apr 2024 16:26:41 -0700 (PDT)
Date: Wed, 10 Apr 2024 16:26:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410232637.4135564-1-jstultz@google.com>
Subject: [PATCH 1/3] selftests: timers: Fix posix_timers ksft_print_msg warning
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

After commit 6d029c25b71f ("selftests/timers/posix_timers:
Reimplement check_timer_distribution()") I started seeing the
following warning building with an older gcc:

posix_timers.c:250:2: warning: format not a string literal and no format arguments [-Wformat-security]
  250 |  ksft_print_msg(errmsg);
      |  ^~~~~~~~~~~~~~

Fix this up by changing it to ksft_print_msg("%s", errmsg)

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
 tools/testing/selftests/timers/posix_timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index d86a0e00711e..348f47176e0a 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -247,7 +247,7 @@ static int check_timer_distribution(void)
 		ksft_test_result_skip("check signal distribution (old kernel)\n");
 	return 0;
 err:
-	ksft_print_msg(errmsg);
+	ksft_print_msg("%s", errmsg);
 	return -1;
 }
 
-- 
2.44.0.478.gd926399ef9-goog


