Return-Path: <linux-kernel+bounces-91072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D603870935
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BF41F2671D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3CD627E1;
	Mon,  4 Mar 2024 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgdEiJpv"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E79D626CB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575919; cv=none; b=qIddNg9k9D8B7xJQ7tBD3HKYMpfdLf2fkybozgTlI69YDNrqad2/LCQhz1X1YSf9EDx8bXxo4bUqy/zlLUS7m0VhU5NfGRruGoMjKgYkaK7Ahq9Xckt/svDiGALMl3IYKmL60UTYO2XqzBczc5GCy9rWLwQsy5E1tCO5PbO5cKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575919; c=relaxed/simple;
	bh=FqLV9lNiSU7gSVzmh0RUNwWYr0jxygkZHnJe2yCKIHk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EnY+e2Np1EepXK2W+IAcl4DnQENcd/gVFBe0l9DNvXQj8xUmF2P9ysvFCoQk0oxRSYe8lfd8eQ0Dpzdl+0WDeDQj7pEfmGVI18QRPWkgEN3EGgthLRJ00NMpHSXsoWVyggeUbWB2Ot2k+cNn1oomFB0Mt35hlKmLx1ItiQB0Msg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RgdEiJpv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e4867c8ea5so4741845b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709575918; x=1710180718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+K8qGGJZU0dVFlAnq42rJW59Laz5svfdA3lu6VKJprE=;
        b=RgdEiJpvj3Bmgib+raIdYN4WBa77xy6L6FhaoQOrogFyHQj5JCmOM1w8oNTLfqiRtB
         uyUTtm2hVM4A16ZbrViQGNo8Jz/I+HVoMwFWYQ4OSS4TUa9qfDpKK4c9ZH34W9LuvZRV
         NL8bQDrfUl/1HB1yN3CZCMx8hXFE31j1+B768iEeKPNc6t5sSoRPOtPkm7jG1ovfYYDU
         wioFoQeuaU1xdqIbCiySvUE05cuWEznqW4uM6+7It+Rh04WDgXedYf4xMp0P97nlXXcj
         w3T4/L1yDfYCJlLYus+bs+NlCysjmR3XLUGIZ52KPqT7IFCDfCllSMoKbWXzN+D0OuVc
         8aBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575918; x=1710180718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+K8qGGJZU0dVFlAnq42rJW59Laz5svfdA3lu6VKJprE=;
        b=Jp09IITzLlD6ouoeuuNVSo1d4cR4VfoI/62OYEZ/GDAmnruOJ8BSq5ye5EzkU9ozOA
         5UWnd08JXL1ewYMyR7lfARfEXrhg0VQcowLI8nTEkL7OFSlpMMeEP8hsVLFm9EjCy3kB
         CazVm0tv0nt2HlveHrpmf2D/CG+6hau8bsD5lFnSSBmygvxyrS1+KsyUgMTNCVCxx3dx
         4o13RU1Em9y6zdef4tgZhpaV06Qrmtscg1QBn1ibup+noAJj8pauDf4ZxciBbVBrc+9K
         iCkv/Le3NvhYvvemgnP7vst/yYFGq0ySncFBZZr9cNcphKXdjkWDuUr+ZrHzrsVjkW8R
         NrJQ==
X-Gm-Message-State: AOJu0Yx/FV/tY3D+l0OgDni8QB8eVmowY9ErYZtRg1zhDkT8tvArdyRs
	CXJY8GjPNNR72PZQTljKmtHaXb7FVqIGQvracTuHfomUVEK9/qX46DCmgNGq/P6X+LFTgso6BiT
	aYjjuCllKSIEx+MEShpBka8B2szw42NcYhoT3JoZ7CON5ew5X6NIdnkkUiJmyC6+0KvWPfvKC2q
	vL+cvNzgc6jeno4lRBF+WP7i6FTD3T8Ak7Gr+V0HND
X-Google-Smtp-Source: AGHT+IEBwRfcpn5x9AGNzJLGA/hp7XJkS1FIgFGPUMaa1opevJ7wVveO9HifQjBfzJMQbCakv4yNwPEcBGY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:27a0:b0:6e5:8053:af92 with SMTP id
 bd32-20020a056a0027a000b006e58053af92mr788006pfb.4.1709575917445; Mon, 04 Mar
 2024 10:11:57 -0800 (PST)
Date: Mon,  4 Mar 2024 18:11:34 +0000
In-Reply-To: <20240304181140.644212-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304181140.644212-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240304181140.644212-4-edliaw@google.com>
Subject: [PATCH v1 3/3] selftests/timers/posix_timers: Use llabs for long long
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fixes clang warning: absolute value function 'abs' given an argument of
type 'long long' but has parameter of type 'int' which may cause
truncation of value.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/timers/posix_timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 0f550fc9e879..78b4b2d3dc44 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -82,7 +82,7 @@ static int check_diff(struct timeval start, struct timeval end)
 	diff = end.tv_usec - start.tv_usec;
 	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
 
-	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2)
+	if (llabs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2)
 		return -1;
 
 	return 0;
-- 
2.44.0.rc1.240.g4c46232300-goog


