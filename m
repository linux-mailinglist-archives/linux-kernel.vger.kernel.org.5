Return-Path: <linux-kernel+bounces-73586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8853785C48B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918D81C212FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671E13667B;
	Tue, 20 Feb 2024 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+/TeDAw"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA8612D7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456920; cv=none; b=HSGzH70oHYgB0irtyl+/8GLJitkx8DQx8Gg50BouiWqXB2gDdVNB9IaVakf14JOe8sgsfoQNVFERzDp+F8/QVMaa8J58zW12JE2BQUu6qk48zo4db2PbmvTEEG7c154HBjkOsTTVtENB2S3FNcqeSXOYV1hucE0ttMMAHkJJ+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456920; c=relaxed/simple;
	bh=TVoc7U+OlQVfHRvbnJMLWXD8zvvPQlQiEeYw9Wi+WtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kZiV3DwQBw18kABNZuJBdDpF++Behb/f0mtxBaaP6ZHtEPs0VQcd2gM4Gr3ZU20/8vym03dBhStKdkt7OiFvn79J4m9gcZhxEP8TFzBcr5O/d0vso/GupOuMT/fDpqgqd+RXSA5uqUie1vUOK0tGkxnfTg6KFVuqHG0D2AYJd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+/TeDAw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso11485e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708456916; x=1709061716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKIxyGvpgjhbt9c9GjpSxI7ejf61TndiqXinC1SQAmM=;
        b=k+/TeDAw1tyq2DpyQqh4uyWA4QmQTh8wdQnoVBWQEGgu3Wi/6vNRtzWrZ7SDKDgJ5o
         c8xBRIOZ4JysOS49gSPF15Ou+6et4LOasGzbjadXCmEEDKqI74Hm7rmCmLWRXrjmd9Hi
         +wfefLT9c4wWkUaHzTnWH6mKHuq8At5lCAQPhenCdcyhralS6qraRTP2OD9RtlFh+wEz
         4IMyFnfSnNRINz2ypz96N/jDBptJS1KMbzvzuOgqU4UcRdMZml8tbmE9cXCfX8PnwAKI
         bTSS31xKpfrnpqLPU722Rd1wgOJz+ux42CXABqNy6B7FiTh6L+cBXg6EXluYvxXf3uYU
         GbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456916; x=1709061716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKIxyGvpgjhbt9c9GjpSxI7ejf61TndiqXinC1SQAmM=;
        b=hL5qJi358X4gxex/8o8ZuURtgqd+IN10w6ZhaeenTXUoZGrobEYzMO47Mav9sjU6vZ
         D4R5qOqaCtjznxqMo2IUfX4Gr/9xWTTmMcuHbgn6tuUqBxUs5vTuH/1xgJoa0YeYVv7d
         wzBxK82LSi7d8ZzEraUUKPUXmlIDasq18A0krSyAprR3O0QuxzEPVyrUmoOFVaQDVWG6
         38yFDuBJFmwOVpw/uYg98PnnaniWX+l5+ZPlUvb2AC7t1kIHWiVLI1COV+nHlQ5AzjGU
         8ZFkdEdyqsaSAtgoPtCnCn7OkbZbi1I3ArYO/HKCQKkW8QRvUMsGx49xT5yDh98SvR5L
         MoQw==
X-Forwarded-Encrypted: i=1; AJvYcCXh8STUdzOHPvS8ZhOK7WrG18JN6wAgWCImiis7f20JJsoFDPjUuK812EF2bVeapzpxQOFhSL1tQ8tOkUp6gs2wgyvjUAKoDT4OjJHy
X-Gm-Message-State: AOJu0YxjWuzj5/aTLSH3Qz8pLq8cHmdBdChr/ZibmGGmOeAZJBhH1wqP
	sRiPZGDjHh8lf2IjHH2+K2OWZMY4W6ZJZ/b2W1vkh6ofYD22TIIBxakaTSRtYw==
X-Google-Smtp-Source: AGHT+IGZKDFS2LMVokdOt4RPUiUiOKYTUXdr3WQbMI3rHVMJLlZRdGxCkLP3ECcHpvMM33NfTSRCVg==
X-Received: by 2002:a05:600c:384c:b0:412:70cd:2607 with SMTP id s12-20020a05600c384c00b0041270cd2607mr10384wmr.3.1708456916436;
        Tue, 20 Feb 2024 11:21:56 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:cba0:1b55:6833:859e])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c451200b0040fd1629443sm15864760wmo.18.2024.02.20.11.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:21:55 -0800 (PST)
From: Jann Horn <jannh@google.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Jann Horn <jannh@google.com>
Subject: [PATCH 0/3] avoid unnecessary recompilations in x86 boot code
Date: Tue, 20 Feb 2024 20:21:41 +0100
Message-ID: <20240220192144.2050167-1-jannh@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's been bugging me that every time I rebuild the kernel, kaslr.o and
misc.o get rebuilt just because they pull in one or two things from some
headers that change on every build. So this series moves them into a
separate file that should be faster to build.

This doesn't seem to actually make a difference in terms of wall clock
time, I think because these compiler invocations run in parallel with
kernel compression; but when I tested with an earlier version of this
patch series, I saw something like a 500ms reduction in CPU time used.

Not exactly a major win, and I guess CPU time isn't really the metric
that matters here, but still, I think this makes sense as a cleanup?


Jann Horn (3):
  x86/boot: fix KASLR hashing to use full input
  x86/boot: avoid recompiling misc.c for incremental rebuilds
  x86/boot: avoid recompiling kaslr.c for incremental rebuilds

 arch/x86/boot/compressed/Makefile       |  4 ++--
 arch/x86/boot/compressed/dynamic_vars.c | 17 +++++++++++++++
 arch/x86/boot/compressed/dynamic_vars.h | 14 ++++++++++++
 arch/x86/boot/compressed/kaslr.c        | 29 +++++++++++++++----------
 arch/x86/boot/compressed/misc.c         |  6 ++---
 5 files changed, 53 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/boot/compressed/dynamic_vars.c
 create mode 100644 arch/x86/boot/compressed/dynamic_vars.h

-- 
2.44.0.rc0.258.g7320e95886-goog


