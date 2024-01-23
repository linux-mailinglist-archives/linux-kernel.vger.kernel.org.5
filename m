Return-Path: <linux-kernel+bounces-34550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF1837ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB44029A331
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234AA16418D;
	Tue, 23 Jan 2024 00:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WNPSVRLb"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78913D519
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970769; cv=none; b=irUMP+eLmIxp7Qj/a4Y4fMi5b85KcdTy54YpPtm+eelPT4xQE8SrepkiTPZnFkn0oaXIESv0aJRv/zdp+RR7pt/+xYRz/6sEkkhZ1IWA5agnaGo+6iAonstiHagMN/YBFfyA6bRru6GJYm1Mu55AY+tWje7jnVWr/+Ayq9JIwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970769; c=relaxed/simple;
	bh=fB/vJlhvA9krznQ56xe/F9UTpDDJWr+0HII6dSIL9Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OklEQIUVCdDj3Fh1ged+MAgbT8Fv/8KiIQD3pXD4u8w7GpQNcDShctsVkuC/FO59uuVbSixi7BW4/iUW4xgCJgalZLXW/FipZ0bQCo7oDIpADVo5AChCz5m52LjJfDC9V7fNbKDFhqetZoqQ7Fu4cAtZEwaTTurJ8zOftxcyTG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WNPSVRLb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dd6c9cb6a8so19354b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970767; x=1706575567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeFy9ObsKdupjGxJomayoIpMA4DTjdZekNe8mU5qwlA=;
        b=WNPSVRLbGoHiG5MgcqmT7CzbjdHAV2zjOA+nWVjqgOy85P/xFgoCHnnsZXTEzfIqjT
         xcq1Z+6hWeI+wc5ciYo9azrmeOXzJBsf10DrCSINXf84tc5LFkP3kZ79ajLuTVYfkDGt
         LDuy1osU5QpLdRvIUJ257HMNwOgdC2lqVKjmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970767; x=1706575567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeFy9ObsKdupjGxJomayoIpMA4DTjdZekNe8mU5qwlA=;
        b=KEhb3PNbwwReobRoO0Fk0MWFJyN8Jyvxhz/LA/UhFr7fZPbXNos32ROUCEL1tYkXRC
         54UoY6kCSEUnNZs+OTSjCbzVxnNJ2Sy7H9qmAp8F/apztSkEwZQT2USVNzKfWPREM+1H
         TCGi7B664XPEr+GLAyUMJRc5RLc9fxsyDOYnWaetz4lH5TzqPr6gXpVK3chg0JQKFoNJ
         wTQg2dF6CjBzrY1JIN3pYVuWyxCOvbWUMTwMZi7hFORSrUZm72bR2mJVvWh7lWPl9CUM
         3j6y82XlboQzQqooScFoXNUgEPSSfZdaIcWnvI2G/mHW+F4DF2h4tkgmZDHtnEkicHSy
         IE5g==
X-Gm-Message-State: AOJu0YwoBot7JmlqlUsGe1dicEMJ3ym6Ds7mfF6ab4rcclMXoh3CMRkQ
	OWdeQ/5dItcGztefpuyfpOtnVPIMZrZdZelLVOLo6h3VIAXmliEVX2bXKIx+VQ==
X-Google-Smtp-Source: AGHT+IHIo+QmX5SKs1eURQTgF6xjx1ivZ9dGJ20X5CSUJXxEMYCvOi1XFZ6jAhdY2cgab1CibcxQ2A==
X-Received: by 2002:a05:6a20:e116:b0:19a:f6f1:c643 with SMTP id kr22-20020a056a20e11600b0019af6f1c643mr2625807pzb.26.1705970767073;
        Mon, 22 Jan 2024 16:46:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kt6-20020a170903088600b001d755acec64sm2112193plb.189.2024.01.22.16.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:46:03 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Vasily Averin <vasily.averin@linux.dev>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 34/82] ipc: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:09 -0800
Message-Id: <20240123002814.1396804-34-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179; i=keescook@chromium.org;
 h=from:subject; bh=fB/vJlhvA9krznQ56xe/F9UTpDDJWr+0HII6dSIL9Rk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgHUrb+Pn30CFNG/PpuZxRTSyun9OKDLc811
 y0OFWm3o9WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBwAKCRCJcvTf3G3A
 JkMAD/4l1He8Fl/Q5+UzintLb5ZAHreICrIvS38FaRAsRYin9PCIVE7R4QNAOgkUyOHy6/e82p4
 /LIzbTFYbGFCrcSkmQDoUut5ugYgmTsp5Zqy/pXkVLc+mbPkf9gcurcEQosUKumAxCNc2trCrFw
 okS0qbY8OC4HEYRVGgt+l2ylO1/KJ9sOziIDJIrwB3lHcSycnJiSmpHVanMkwQfKH0yF9btCWjO
 01oWUd4v52bx4ifqCleVxV8fbE8xrJxHjhMn0yqt7ONgPfySTR1ReOoVIaTK4SfgtQY9JkVN28C
 g2sOOOKzFYfPLr53vbfINFNulEl9mgIHMXiCo/yKFVxSnYyT9oCtEVd38MF1FhjY5+dOYug7fF3
 6Ne60lEOpmqIU/SgsY9pEt/YhlzFczZR9TMkn9OzBToVC7/tRx5rcdaa9QSiiJU5A+im9lLphn5
 khTkun6IVSlXKgX86MlCBGpJjD/kH1X6j3ND/vLePIgaJrTZFOpiZsa6oEfibcx9D1J8IkJahQx
 xKdWe7MM28oJ4stfbWkOIV/jOaQDjvhV1PnFn7pyz2jOqL0RrMOrQaPSsmSkz1ApWVL7aAPcqy1
 AdmQPabeL/NacbRL1LzSDCOm6CP/GMNam0Qie6oUUiWEiupKHafsqBVhAlIp+rwMElFlAmtrajF 5Vc8hYcSaLxYkJA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded unsigned wrap-around addition test to use
check_add_overflow(), retaining the result for later usage (which removes
the redundant open-coded addition). This paves the way to enabling the
unsigned wrap-around sanitizer[2] in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Vasily Averin <vasily.averin@linux.dev>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 ipc/shm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index a89f001a8bf0..227a1610628a 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1650,11 +1650,13 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 	}
 
 	if (addr && !(shmflg & SHM_REMAP)) {
+		unsigned long sum;
+
 		err = -EINVAL;
-		if (addr + size < addr)
+		if (check_add_overflow(addr, size, &sum))
 			goto invalid;
 
-		if (find_vma_intersection(current->mm, addr, addr + size))
+		if (find_vma_intersection(current->mm, addr, sum))
 			goto invalid;
 	}
 
-- 
2.34.1


