Return-Path: <linux-kernel+bounces-85467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F89286B672
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F7328B89D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124D815E5BC;
	Wed, 28 Feb 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="q+5OvfTk"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF315DBC1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142718; cv=none; b=YLOUX5gD+mdQp+AsM7btBbWyCLRi7F3Bl8rURqXBhOkpBwVWCNrmkYc0KS4zHzOiGIQ9OtbwPbtJi6GP4MvquoMoxiI1cYCdGR6pI+V8iwIOu6EII31pdKec0EmVrx1VFASRG7Tuq8MfujCm5Ln3kRBOCy/s5xOGmKPyyEaDPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142718; c=relaxed/simple;
	bh=DYg0LXB04IOIyfloSAJ7RhMuraWDe4p86DhfIeb4hC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DAIHeo8G8rYlfcuMePtzLRyrMLhtMlSbKw3A67l6++jxwlRXP98aPH2taxht3VA1tjfs6U+2+Y/qUrdQIqWjbaU5NTpY5o81ITf7n9RPLkzz5tK+DRzGfztfN98CjzFAJUqKww24rTLMX2r535vS+uW8AQR9VorhSLdUHbBCQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=q+5OvfTk; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d094bc2244so70571191fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709142714; x=1709747514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2PXWhKeObjvrv5a0sp4dojdugZSvAvimHcwo4W++JCk=;
        b=q+5OvfTkSQ/neuhhx5Q0jFSnztg1vpt3gWh4/SFdi74J+3codoxO0txrzjdShKsu1R
         HCsBYu6B0mr402b+kTaCrhfMkvasPz8VUTX38YTBU1/jJ9UgwdzHTB6sMnNKpk/ELt5B
         1g0h0QY0gUDOaqoaqZTZEyB5TU+nCH1N5fAhtTOFjMAQwIduLWgi+Y9bMJl9GCSBiOwO
         gr0YJ2tBCj671JkaVTtsOyUTS5B5QHtR9nW8DCmxRR2RAglEIg9Iu5VDbN8QjaP21YJX
         5KFKM6zUOOVhQVm7abrDJ0BZEdbTueAlxePLkrwznjNoNZLQ/n4EeJmZZ6hnN+D7wVQM
         GsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142714; x=1709747514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PXWhKeObjvrv5a0sp4dojdugZSvAvimHcwo4W++JCk=;
        b=vV+nRTYAqEWPeHuvmHUtMIgwCEBVy0sG5NeOoWzTIKI2lEitX+3kwSnHWJ33TkYKL4
         DZy1/nFZPHSFaWoYUvXYEAL26dN5ydH59ZSmY4VAE2JVXpa8ETgBMBEAF4K/H3BM/22e
         RWei32+8CBZkceqwJzqgKTnhrG4iheytIiuv4egOBvGNuq6yeY91F15EiZYvAISWDcO5
         NUAG8sQGoN6GzTs4oGmrUm4VyrcCEyherJ55FVBI6ut/3b7vSU4xijFkirvt0qC2gl4y
         k2ef3rUrxrejgitizneaHlCJVbbYNplVszEsz5/I4koAuS2sY2K43HnRjWyrESvf+a8+
         kv7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQwKjTVMtLJ6YHc7Tl+1rXvBsPiPGEMsSfGCsSDIzHMJgxnh44d4ynwFq3L4DHDtVVv7lAMXY0sOtMqTzMR5OthN7LeLetq/Z6w9Uz
X-Gm-Message-State: AOJu0YxTpj9TxtbhgCn3w9rmAyOxhy3mfnc+Zfe040G08JAsMPB6rLAJ
	Vb8sRnFyVl/l5nW4zJGV2Vazohw7fG+XQOwGB9VNVtRRo+RZDnpDbGA1eBnaXwg=
X-Google-Smtp-Source: AGHT+IHx7VzXebFCK9PVoydXjk9GVjtk6uMFBqmfk4DW/VbXqUm0WiQ9809xGiewPieJ0e9vq8pkKg==
X-Received: by 2002:a2e:994c:0:b0:2d2:3017:c144 with SMTP id r12-20020a2e994c000000b002d23017c144mr8654944ljj.39.1709142714369;
        Wed, 28 Feb 2024 09:51:54 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bca54000000b0041290251dc2sm2706543wml.14.2024.02.28.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:51:54 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/2] riscv: fix patching with IPI
Date: Wed, 28 Feb 2024 18:51:47 +0100
Message-Id: <20240228175149.162646-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

patch 1 removes a useless memory barrier and patch 2 actually fixes the
issue with IPI in the patching code.

Changes in v2:
- Add patch 1 and then remove the memory barrier from patch 2 as
  suggested by Andrea
- Convert atomic_inc into an atomic_inc with release semantics as
  suggested by Andrea

Alexandre Ghiti (2):
  riscv: Remove superfluous smp_mb()
  riscv: Fix text patching when IPI are used

 arch/riscv/include/asm/patch.h |  1 +
 arch/riscv/kernel/ftrace.c     | 42 ++++++++++++++++++++++++++++++----
 arch/riscv/kernel/patch.c      | 19 ++++++++-------
 3 files changed, 50 insertions(+), 12 deletions(-)

-- 
2.39.2


