Return-Path: <linux-kernel+bounces-147790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D697D8A79B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126C51C221F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ADF7F8;
	Wed, 17 Apr 2024 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1TMTNnk9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1D365
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312913; cv=none; b=eEL2T1bbz4AIDx59byr0iQFr61wn8K2cosOH0lM+iy5QAgUQEVpdAd5rAC4bUs7C9inRMM51XbGbzDJQRC7clWlDgNvM11GLXxjS3QRfsNOIhgJlUabtHr4yS4fv6saAEFjYhiP6H7aebcGMINajrKEk6KCASz5y7P1pj+hYS/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312913; c=relaxed/simple;
	bh=yXOznEMjUaHsSz2UyCDB+IdA+tJMf00GLmlQT2osTQc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NzhQz8VlxrDrmekVTzIR959FZPbjZ1TPmQb8RYAPNpasq3VWICvRUxeSM7iV5ytCYVcx+3CBq6kbuoRKN5XmLLfnyzWNP8jMBzBcfkkDMD37wT9N0pzgiBLq/z3yJyNtVDYBD8Rlj9nAUCLdarIdVSWm9pmL6ipwHZHzuYrQNMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1TMTNnk9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so6321710276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713312910; x=1713917710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlkW+nIwVSw4BTVsNXamCh2hwkYNTyK7FnVS567kQj4=;
        b=1TMTNnk9rAGlnCV5sBLcVdkj3DKZye7ISyq64C3HQv5idgSuUyf4gmIvcqovTmoYMj
         /lxxLxf69XKJl3TWaBoI2mv7ePH1SVlqzFkgjC8adsIlCqEaUCu0bKTx3fajvP1zKog+
         hMnoKgcXk4GUIDGqSHCfEZxHNqqize+p3raApoaGe4WyUcmB6le1icu4V3QgyzgGyVUi
         c+WB5eWje8MhImx934DXtWcAukBmM/oG5399eTe3NvbmhO4uTMnNOVw94y4849GfmycK
         cj7Y0cOxwVsY5SUi2JtVE1KZ8MO2bW3YBN4inOqG6j1sv2E3NJmakTrcNwR93wudpqLf
         kxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713312910; x=1713917710;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlkW+nIwVSw4BTVsNXamCh2hwkYNTyK7FnVS567kQj4=;
        b=QMwjOwqiK7mEBPCD7bsbrHG0l9raaD3w/lkl8Rw6LAE+hBoOPD1n+ARTn55dBagfzz
         TRH9r+YJMMjZj66PQckAoADvJNkex8sXJ3CdlXfvmwqvxiWpzIDQzKUft8KcjXLYPJew
         +Axl2gbqF1UBoYYlXr+PuepYsmip3dWMpmPuT29FYVkScmkddT/Q1tTqw57g6LA1ikLp
         P529I5yZ19fDR1PJkGV8gIWUB7jU+wqGjbXKZuY5Xd+jNOGy/2lQ1aRIeRPvSjH7crXA
         D3Ihmj91FDi8mYS/wPLUyWxfrw/pACzG8x3V7iU6A+2O3Fi9GPwHtVNZuaSlWY/vUIka
         UzYA==
X-Forwarded-Encrypted: i=1; AJvYcCVxOnmRFpUGip4JwC3FWnkS0k/fADiNCJhpsVJ7ls6HHXVF8TYKKWFrat2yNtr5oRzK7H3UxVV2yMM/RleH0PJwywTZhxKcLnk7I893
X-Gm-Message-State: AOJu0YzXl1i7V0O4n5DKMUYVF8vBFTUdoTi4g4yiotMfit2xwQAbAojr
	GS4glZvmVnufAnJdQ5fwWpp+pEeOm/Yaq+mhxcYPc3H6BNGZLEdMctqiEUljJurOYRvDJLUpXCt
	5Ug==
X-Google-Smtp-Source: AGHT+IEdmf1SGIjHtSCIoaLgYkiimkweLFjtKb7IDa4/RKIuG/9GEHrLiSYMXrVfP+zURKA6f1KCN9rfg1U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c13:b0:dbe:30cd:8fcb with SMTP id
 fs19-20020a0569020c1300b00dbe30cd8fcbmr953201ybb.0.1713312909965; Tue, 16 Apr
 2024 17:15:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 16 Apr 2024 17:15:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417001507.2264512-1-seanjc@google.com>
Subject: [PATCH 0/2] cpu: Fix default mitigation behavior
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

This is effectively v2 of a previous series[*] that was intended to be
x86-only, but accidentally disabled CPU mitigations by default for every
other architectures.  Unfortunately, the buggy code has already made it's
way to Linus' tree.

Patch 1 fixes that goof by adding a generic Kconfig to control the
default behavior.

Patch 2 disallows retroactively enabling mitigations via command line if
the kernel was built with CPU_MITIGATIONS=n, i.e. with
SPECULATION_MITIGATIONS=n on x86, as it's infeasible for the kernel to
provide sane, predictable behavior for this scenario.

[*] https://lore.kernel.org/all/20240409175108.1512861-1-seanjc@google.com

Sean Christopherson (2):
  cpu: Re-enable CPU mitigations by default for !X86 architectures
  cpu: Ignore "mitigations" kernel parameter if CPU_MITIGATIONS=n

 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/Kconfig                                | 11 ++++++++---
 drivers/base/Kconfig                            |  3 +++
 kernel/cpu.c                                    |  6 ++++--
 4 files changed, 18 insertions(+), 5 deletions(-)


base-commit: 96fca68c4fbf77a8185eb10f7557e23352732ea2
-- 
2.44.0.683.g7961c838ac-goog


