Return-Path: <linux-kernel+bounces-137589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79F89E450
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9A01F2302E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7A115820B;
	Tue,  9 Apr 2024 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="W1aX+ESO"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D3157A42
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694149; cv=none; b=u78XXG1oPKbMgdRsrwReS8ZcM0EuuQWUbEhytS+8ZWx0gs981/uBIj2fE0rYhGH7ptB0tvFVqNM+131KEAt9UKSpEbmvi23fF5AresjlJdvdjpreBeduLCacZuWEx2nmoMuNiBvjYdxK+qQE4n+/s7f0Kzi4MMRw6aLc6GfQRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694149; c=relaxed/simple;
	bh=OyKQ9sJJ6C6VnOwLDCfS8LH7HDNugc1Wux7C2Pl0u4c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O7diFhBWPApaiPsjF9RChrNAP32cNq8f0gVD1PTLL3gZhIBxmKhvE0DlPPEDIdSonmjzjXMJuzFuW29+9zMEQRVz5vI0nIFW4IcO2OtF55F6+thmC2DAkpG/uKj7jEJcFjr3jPCgjwa3+J71Rc0dwwzEwCvtaM8vgAo2sk18koU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W1aX+ESO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a4b60f8806so3208883a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712694147; x=1713298947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ih/ZHhpIYD49Y538EsPcvifBS2/Zoe6MXjtzsgxjeVI=;
        b=W1aX+ESOuEUTZdx6V3aE2VNJ5rLGO4EAh7sdHHTxInmoxhCJvltU7B0actqVfApOyk
         vLC2c1J3gsgT/+MaeSC14EUiDRS2kx+A81agsVTxBGAe5nFey+xudJSbKamchGFLFp3x
         5IZo6XwqqsOhgNJ9K7u3HMvvYHN5qNpkcuosjztUEAc+Xi1ncmo1iQh+3Um/CGk42Wtq
         UFjYXkQKDYFcRuJlHEAs/YBQQjw8ceXt17BCJCOojwiwl4ln7MW8zIFeK1Jz1yQRS7rO
         xHp1sMqz7Y/16pxiHZW7lo/LoWeP6E7guAQ1ifnnMssUYwh6CbDuqJF+dPWX4SkLgLq1
         uXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694147; x=1713298947;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ih/ZHhpIYD49Y538EsPcvifBS2/Zoe6MXjtzsgxjeVI=;
        b=VS+JbqfpmfLL1ndulXL/dkiOb39f1u3PTOtHz/xyz1eYt6dNejFIfk+UsPF+XxYG9t
         5iSFKEaA5r0FFOqnk1VddcqjUSOOeM0k7Fwo9eoPBPDWUy9PtpWi/uzOe5tPn2Z/hnkQ
         ajv+gO9GfYFqhWOKRfQiETSovqQIcteldfkIvg3/wriJ5747i9YxMeFPfTP0eZIjmPMB
         uEQT7eHdwkatbIVOAl73oYtQ+VzJ+kb8s/yEe/BeryGZzmQHa9QzVBen0JIKiWrQPt63
         JT2Njal+l4kCckeQTqzn4TKoGts/A/ovBUborl4Tfz0r0rrP5ghkT0s4/sa7EWpVFzt8
         oCyA==
X-Gm-Message-State: AOJu0YxnmtZMGenacivZSY2oSZ6hpW1abtHXoI7bd3sfUiSrDJx1Nv72
	7JZSujUWLcVxarFEKOz4X/bKSz5aPTRP7JAV1cx5gho9z0RrBcDbJpEozWip1UiYey4uiPS8AJb
	NHRDrmFYJsl0dTefYpxGqmmfKpT8Qo+dMEgV2N31xl0dLPPa3BCSSwt18/7EhhIhpQiMIe8AJjX
	JUNoXGk6iJcxWRuCGe4NGExRgv6a2NUTYwyAIa1D841dFG
X-Google-Smtp-Source: AGHT+IGoWbaS5twejsOF39j/qOAoZI5wiTbn50PiLN504jBMF5YBvtg7yLuORdys8BuFqK3GIyZKmzkuzJXE
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90b:b08:b0:2a2:5cad:85c4 with SMTP id
 bf8-20020a17090b0b0800b002a25cad85c4mr2193pjb.0.1712694146758; Tue, 09 Apr
 2024 13:22:26 -0700 (PDT)
Date: Tue,  9 Apr 2024 13:22:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409202222.2830476-1-jstultz@google.com>
Subject: [PATCH] selftests: timers: Fix valid-adjtimex signed left-shift
 undefined behavior
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Lee Jones <joneslee@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

So, the struct adjtimex freq field takes a signed value who's
units are in shifted (<<16) parts-per-million.

Unfortunately for negative adjustments, the straightforward use
of:
	freq = ppm<<16
will trip undefined behavior warnings with clang:

valid-adjtimex.c:66:6: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
        -499<<16,
        ~~~~^
valid-adjtimex.c:67:6: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
        -450<<16,
        ~~~~^
..

So fix our use of shifting negative values in the valid-adjtimex
test case to use multiply by (1<<16) to avoid this.

The patch also aligns the values a bit to make it look nicer.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Lee Jones <joneslee@google.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kselftest@vger.kernel.org
Reported-by: Lee Jones <joneslee@google.com>
Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/lkml/0c6d4f0d-2064-4444-986b-1d1ed782135f@collabora.com/
Signed-off-by: John Stultz <jstultz@google.com>
---
 .../testing/selftests/timers/valid-adjtimex.c | 69 ++++++++++---------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index 48b9a803235a..9606d45767e7 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -62,45 +62,46 @@ int clear_time_state(void)
 #define NUM_FREQ_OUTOFRANGE 4
 #define NUM_FREQ_INVALID 2
 
+#define SHIFTED_PPM (1 << 16)
 long valid_freq[NUM_FREQ_VALID] = {
-	-499<<16,
-	-450<<16,
-	-400<<16,
-	-350<<16,
-	-300<<16,
-	-250<<16,
-	-200<<16,
-	-150<<16,
-	-100<<16,
-	-75<<16,
-	-50<<16,
-	-25<<16,
-	-10<<16,
-	-5<<16,
-	-1<<16,
+	 -499 * SHIFTED_PPM,
+	 -450 * SHIFTED_PPM,
+	 -400 * SHIFTED_PPM,
+	 -350 * SHIFTED_PPM,
+	 -300 * SHIFTED_PPM,
+	 -250 * SHIFTED_PPM,
+	 -200 * SHIFTED_PPM,
+	 -150 * SHIFTED_PPM,
+	 -100 * SHIFTED_PPM,
+	  -75 * SHIFTED_PPM,
+	  -50 * SHIFTED_PPM,
+	  -25 * SHIFTED_PPM,
+	  -10 * SHIFTED_PPM,
+	   -5 * SHIFTED_PPM,
+	   -1 * SHIFTED_PPM,
 	-1000,
-	1<<16,
-	5<<16,
-	10<<16,
-	25<<16,
-	50<<16,
-	75<<16,
-	100<<16,
-	150<<16,
-	200<<16,
-	250<<16,
-	300<<16,
-	350<<16,
-	400<<16,
-	450<<16,
-	499<<16,
+	    1 * SHIFTED_PPM,
+	    5 * SHIFTED_PPM,
+	   10 * SHIFTED_PPM,
+	   25 * SHIFTED_PPM,
+	   50 * SHIFTED_PPM,
+	   75 * SHIFTED_PPM,
+	  100 * SHIFTED_PPM,
+	  150 * SHIFTED_PPM,
+	  200 * SHIFTED_PPM,
+	  250 * SHIFTED_PPM,
+	  300 * SHIFTED_PPM,
+	  350 * SHIFTED_PPM,
+	  400 * SHIFTED_PPM,
+	  450 * SHIFTED_PPM,
+	  499 * SHIFTED_PPM,
 };
 
 long outofrange_freq[NUM_FREQ_OUTOFRANGE] = {
-	-1000<<16,
-	-550<<16,
-	550<<16,
-	1000<<16,
+	-1000 * SHIFTED_PPM,
+	 -550 * SHIFTED_PPM,
+	  550 * SHIFTED_PPM,
+	 1000 * SHIFTED_PPM,
 };
 
 #define LONG_MAX (~0UL>>1)
-- 
2.44.0.478.gd926399ef9-goog


