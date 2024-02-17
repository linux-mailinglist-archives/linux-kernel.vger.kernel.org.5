Return-Path: <linux-kernel+bounces-69684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB76858D3F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04401F21E6A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1EB1CA8E;
	Sat, 17 Feb 2024 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HSAL6gG1"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA81C2AF
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 04:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708145620; cv=none; b=hyL77/sEo1w1UVXsw9OkzvPbOJNGhKiOjgT2tYhsMeZAP/lgQEeIJBwKSTqEpuwzkV0LaWqgYK38dvbp2iJfNdwremYlAqJTrRSnu/Hrj307xxsqHgecOk5QeG02UKaHqqYvijLpMI2eBCUrAn5M4SB+314I5ULaGQqZtILJ+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708145620; c=relaxed/simple;
	bh=zRpD3i14j/2w1ZsYki0VbB7I7bNWgKIPU4c0cpGG3xY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DYrk2M1U7e+CqOs6Ayc4mP0GPnmeh2W+mG6V6o8jhBNmsCyQGtoAwynaFe4+55BninMTHDzfna2EFA3LUoxCtyr6BZ8aVFO+B7j3df/N2F78WKY7DwYBTlJ/dzD0On0V4GFZcgxCnfMz1BdQgpBSO1HFFt0UI+CfqVUO3L89Q9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HSAL6gG1; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e125818649so1338205a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708145617; x=1708750417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pre8rdxQFTXsJMOmbo4q2vB4alhDjD0VEGxZ6UooGwo=;
        b=HSAL6gG1ntFsT5uPB5pn97va67f0Sqk9Nx9RwRl8OfJnSCex4wN4QWdF0MtBTK0Iyn
         3IXeK/zNj/1sbsElyPGarHHStxMTkYN/BSEnqa5vki3/nnJq3FPwsa4mLIUss7K+wo50
         aP+ugiPlwcRqwrMcj5ilQ4DEgJ3KyWMAoUOOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708145617; x=1708750417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pre8rdxQFTXsJMOmbo4q2vB4alhDjD0VEGxZ6UooGwo=;
        b=q6it6qjkvyp8neyAB7YHFekey0iUgCNwT1PIOYrZ0sdOV4lNlNw1W6OOMitd2UbMoi
         cpB4gAT9L95ZNJfPv0z/hWdZZJ8IWorq6x2EVB2Ccau2WGITEWx42M0Fi0z5woO8GOPY
         nq3P4DhS1wJGfc5Yi3spG3XRBwKJbcDZI4MBwNCZ5U/HZq1+tfXVLrT/TaWOn77n4Tom
         mh1bmzioWPKZPlWuLqtykYdHK2V7Ns476v5k7DCeNSsGSw8eOkBQe38A5Et61NNfW1Qq
         xJzzJyEEnF5GpfFUSTdKvUy6JBtK8S4OW5vdUk2hyudKEGQY//jSZW5ddmGVK6syLlC6
         uvOg==
X-Forwarded-Encrypted: i=1; AJvYcCXQWKUaHYf216PFlcHBKfLGfy9QJvw4nYdY9IzGeGaXxqdXlfCUqyG29+T/ULgOj9Gdy34ZbryjHl4hcXiK5pd5TWeJSOE/hClTSnoo
X-Gm-Message-State: AOJu0YxjnsRpf37XgcT8LXqCqqLXpeayqq9o+m5E6oTLB0ZmVEKZ8Tos
	qVD/QO+6DJBOl5JKYa5H4lxDOqwXiKNltMfZEJoHrcmZaB5VRL6QLad+e0rt1A==
X-Google-Smtp-Source: AGHT+IGDIOA8s7DcZ2JWhv5DnHy/V7d398TBqBZ99yg/VvpEy7OQgasOf5c0GBUPTRQ9Dbabcxe0aQ==
X-Received: by 2002:a9d:6f91:0:b0:6e2:f006:47fd with SMTP id h17-20020a9d6f91000000b006e2f00647fdmr7007844otq.14.1708145617638;
        Fri, 16 Feb 2024 20:53:37 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fd3-20020a056a002e8300b006e0dd50b0d0sm781429pfb.8.2024.02.16.20.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 20:53:36 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Puyou Lu <puyou.lu@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH v3 0/5] fortify: Add KUnit tests for runtime overflows
Date: Fri, 16 Feb 2024 20:48:23 -0800
Message-Id: <20240217043535.make.664-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353; i=keescook@chromium.org;
 h=from:subject:message-id; bh=zRpD3i14j/2w1ZsYki0VbB7I7bNWgKIPU4c0cpGG3xY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl0DqctI0mx20hHHhmadUsrvuh0OTaGgyzHOFy6
 FSuahTJRSqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdA6nAAKCRCJcvTf3G3A
 Jlc3D/9VDNUP82RbsQ7PRTxtIAEJZw7ZbJP1Dv4HKergyingJKkG0gvnVqc+iIWlznrnLjq7k6x
 InDEYdELraJvCAI8EAofWD+lN/ECQJ7F/ItkrijKGJRvJ8guO602oGXIdlzD0qjnDPAf8HoAlRl
 v+0DxCV+HoEOHcNknGTBsrbvGEYjcfOHxcbc0Gog31000YXqe9CAiu2vvjlNXw3hsj6ol0k2CPX
 gSIyrZb2b0l1eDcPlP/YyOrf7tD5ibzmLcHiIheJ60WV1eCmvmzkpter7jBqwYUpFrvU5G5zbeC
 HYf7AXLXXQd5X1kmJq9EPHOcMl5EXCTTFFD0eSveJ2UMrmCyIFCLNfgVBcjzOzPMDO6sbNurvMZ
 iK1dcVJwtNPxQ+5zkhnV70iov8QuYIFjGVOLlCmX+zE+6KjrGSQKc4L6SjAuUq4dWrW4maSAlGh
 vcdgzrtvUvotsZX8fFVg/lUwINWvaiLVandW0LcvSiO2YgUl2IyWoxHmPFPR4hfAn3ySkeyTUjw
 zziZonywo1HczNweOA5W8NnGZtBiCX40TQrzLMyIGK572rhnljvAgKcxZeWPJnmA0De+WbZTW/i
 pUyu+OKQhD+BHxEKsRJnWr0SbLxh4OEzxSNGJyyw356tvONJj1VeZvIIlDDsbMqjSU7ZxIJkIj6
 5OLIjFf bta9meKA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This series is the rest of the v2 series that was half landed last year,
and finally introduces KUnit runtime testing of the CONFIG_FORTIFY_SOURCE
APIs. Additionally FORTIFY failure messages are improved to give more
context about read/write and sizes.

-Kees

v3
 - rebase (goodbye strlcpy)
 - avoid extra macros for replacing fortify_panic() (nick)
 - generally clean up macro usage
 - avoid build warnings when testing known overflow conditions
v2 https://lore.kernel.org/all/20230407192717.636137-10-keescook@chromium.org/
v1 https://lore.kernel.org/lkml/20230405235832.never.487-kees@kernel.org/

Kees Cook (5):
  fortify: Split reporting and avoid passing string pointer
  fortify: Allow KUnit test to build without FORTIFY
  fortify: Provide KUnit counters for failure testing
  fortify: Add KUnit tests for runtime overflows
  fortify: Improve buffer overflow reporting

 arch/arm/boot/compressed/misc.c |   2 +-
 arch/x86/boot/compressed/misc.c |   2 +-
 include/linux/fortify-string.h  | 100 +++--
 lib/Kconfig.debug               |   2 +-
 lib/Makefile                    |   1 +
 lib/fortify_kunit.c             | 662 +++++++++++++++++++++++++++++++-
 lib/string_helpers.c            |  26 +-
 tools/objtool/noreturns.h       |   2 +-
 8 files changed, 761 insertions(+), 36 deletions(-)

-- 
2.34.1


