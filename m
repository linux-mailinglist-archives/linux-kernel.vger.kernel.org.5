Return-Path: <linux-kernel+bounces-34543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2F1837EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36082981F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5838E13B7A9;
	Tue, 23 Jan 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XGH8bbX5"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B311272CC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970762; cv=none; b=j5St2Y7usGnxy0JH5fgCAVxFeoaaISa8gKNSE7s6oAwPhi5X5FM2b+I5IcV+USFuezKhdNX/JRkYaOAF3YEa7Sx39itjjqeyuo8590wG//hpf+opWbWgnrRpmzS0l2kyr4dNQuKmIjtiByveTrMz8qPpPvbIpIQ71EoAuyyBYvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970762; c=relaxed/simple;
	bh=cmItHHDJ2/yorzOokW4wLWtGAZ57hv5idzTs6y53l8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tup38QUXfNJUY8CCT4BqIaRQ1dznjiToJPXUgQqEQPPB7FSPhis/xK2JXhvecDxMcvVvh7HuCmXZ84pY0lGiGEYoB2kLKr81M/NgaAT5OzU3geETu2h7/smCY+is7jZTsRwf1INvYN2C+M6GYyycz9ZGPgM93Ce5uBMnBa5BBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XGH8bbX5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6dbb26ec1deso3894338b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970760; x=1706575560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw2b3tHeJEx9a76sk3FUumHURyBJJwj65NrMowk875Q=;
        b=XGH8bbX50dKD/LNZcdxj+jrFHSVD8nYifl2SGv+MYAtVxPyjHYryStFOrD767hbrUe
         GtskbhS/uzdFqJ5rcTltcvGpsMf9p6fZxMuEPowXsvPGIjMGA2aBS8PwVMKN/y8W/9mK
         Ju26un/oZVQPE9C29V0+Parje4ArmGhLc9dcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970760; x=1706575560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw2b3tHeJEx9a76sk3FUumHURyBJJwj65NrMowk875Q=;
        b=leuMaxkDIQ0WLMrXvMLDPg7Xke/snFR+Ax7clPRdm8iM+PDozTTRwM6ZMfZ+7QtrY2
         SF/shILrpJycGTIXBoAUV43WmtZ2YRUVy2kOFyRVx+SPEqGo57mwG83yo0sRk3G1F9Ir
         sbNHVZihEI0jHn30Djlepco6b2vKEuUI9fSdLXHbPjJrIdfgB0C8yErt6s9KRVjNJf0U
         YZ+HEo8mvFG9wujmKnuijMVBY8KIwQ8PAxkzbMkWFPPYbDNYbeaJJTe12UnCz/ibJKJi
         SXiz9526MHYFwKjHagQnaDbRxkzh5SNV8wr0Z504CcKLZVDNkKD70/5HKfFLGB2zjQGC
         ri5Q==
X-Gm-Message-State: AOJu0YwsOQirkrUfEzuPk0OqRiEVDKWlA3g6rcUQb5ChD1boYI8/z4cd
	PNXaICvroLsrEFaA5w2+UlozYvf/M9R1TDn3Hk/aFvdr3FECrr9aPIbiY1lL8w==
X-Google-Smtp-Source: AGHT+IFpnmN5NeFDZoCtNSPJnK9l8YLwar/VS6Y7pK5lbfaQcHzj8ixTBuINNoXW+BgKQQm3i/BUKQ==
X-Received: by 2002:a05:6a20:354d:b0:199:e237:1497 with SMTP id f13-20020a056a20354d00b00199e2371497mr4858984pze.65.1705970760341;
        Mon, 22 Jan 2024 16:46:00 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b006dae568baedsm10164690pfn.24.2024.01.22.16.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:45:57 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Nico Boehr <nrb@linux.ibm.com>,
	Philipp Rudo <prudo@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Tao Liu <ltao@redhat.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 30/82] s390/kexec_file: Refactor intentional wrap-around calculation
Date: Mon, 22 Jan 2024 16:27:05 -0800
Message-Id: <20240123002814.1396804-30-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3531; i=keescook@chromium.org;
 h=from:subject; bh=cmItHHDJ2/yorzOokW4wLWtGAZ57hv5idzTs6y53l8w=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgHS1qljwX0OBc821aP1oPgrqcP/CIrbF9OK
 s6Ar47XlguJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBwAKCRCJcvTf3G3A
 JmY8D/4lOAfDyZzxJuod1mr8o99HqUKS7ycJ2w+BmUnwdIT7FhMHPjXYoOdI4ma1NGPbJghRMX1
 KQh4FV76MnS1guDFLwXwYDsJKWpS3LyA+nT73MbsxUuacxblqt5Hh3MLWsexvC3I5rq8UnyZ8Rz
 OxP9Q7+HCEtVVq95HnnbN4NH0ssyF02BVeyeP3cg1KVo7MMrKpR3oRkKY5uQ4ANfxACiQP8ERkC
 45YM4DwsS1FmhsgCHCGraTPD7DYb2sV5bhvL21RPfNaXig08zMT/5ZUQ9ZjYwxIoSByFzm7Il77
 JwwfaVVgTNG7P3Rs9WKhVNOmxa3xDsgK9dTuvm72SLUQI+Zwb8997/d7vjECwWEeGWfRUiMrguP
 vBRHMDpNBBg5NNXV7zCvcPmyv++hO8F98tw3mLfrc3I/zJJ5p1F3Df0LKZ2x/4WL2WDIcolRjFz
 +AOJQe6vXf62QuIPIf5w7zvk0yyUTLqdvT3OWqxqmCnvHsze82MBf8A+ZYHr3YxF6u3exhea9t8
 b0oMGLlaiEtp+HYdg27KcvRIktdQeyqQj1+pUWLNuoSWK4xIpaTmoHwpNyigdAUI/I6sw+LKfKe
 L0szrDlREhEFJ1ygZbsZfF5wnN2NSu6FsohS1ZFZt+JaQP/V4vq/nnABS/LJxgLyTU9lzo+nMcu NTXqQzK2ZrdRSTg==
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
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Nico Boehr <nrb@linux.ibm.com>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Tao Liu <ltao@redhat.com>
Cc: Alexander Egorenkov <egorenar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/include/asm/stacktrace.h    | 6 ++++--
 arch/s390/kernel/machine_kexec_file.c | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index 31ec4f545e03..3ce08d32a8ad 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -34,11 +34,13 @@ int get_stack_info(unsigned long sp, struct task_struct *task,
 static inline bool on_stack(struct stack_info *info,
 			    unsigned long addr, size_t len)
 {
+	unsigned long sum;
+
 	if (info->type == STACK_TYPE_UNKNOWN)
 		return false;
-	if (addr + len < addr)
+	if (check_add_overflow(addr, len, &sum))
 		return false;
-	return addr >= info->begin && addr + len <= info->end;
+	return addr >= info->begin && sum <= info->end;
 }
 
 /*
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8d207b82d9fe..e5e925423061 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -238,6 +238,7 @@ void *kexec_file_add_components(struct kimage *image,
 	unsigned long max_command_line_size = LEGACY_COMMAND_LINE_SIZE;
 	struct s390_load_data data = {0};
 	unsigned long minsize;
+	unsigned long sum;
 	int ret;
 
 	data.report = ipl_report_init(&ipl_block);
@@ -256,10 +257,10 @@ void *kexec_file_add_components(struct kimage *image,
 	if (data.parm->max_command_line_size)
 		max_command_line_size = data.parm->max_command_line_size;
 
-	if (minsize + max_command_line_size < minsize)
+	if (check_add_overflow(minsize, max_command_line_size, &sum))
 		goto out;
 
-	if (image->kernel_buf_len < minsize + max_command_line_size)
+	if (image->kernel_buf_len < sum)
 		goto out;
 
 	if (image->cmdline_buf_len >= max_command_line_size)
-- 
2.34.1


