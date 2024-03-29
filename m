Return-Path: <linux-kernel+bounces-124366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E4C891647
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524D41F2310C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081AE5025C;
	Fri, 29 Mar 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVSL5i1v"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A654D9E4;
	Fri, 29 Mar 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705767; cv=none; b=tIP+gJPJkpCc/lN85nZp0c88DsiuKE/BzHk5UOrbMm0iaycyGReRYOYQt4gQjG4NAR5AQ2r/Kzb6oJGgmS+PAw6rMWhw3Sg927BHTCWn+6bxZFSRtPZSKO93U19VXc7I0p6FiGN8Or+FPyjgsexStmOve8rJtA+xZnr62lOoJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705767; c=relaxed/simple;
	bh=DvUbrtPIF4GBmAsevCPo7ZbTOF7jHWk2TFBBpRZ2HfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FgtaqaNs4s1VZLwAyCLRKs8FbNm6qNcaZssGXfuCsa4GmWuirSJe4PGBQKT8HNVCSCKe9zXMMYVUlSPz6pWA+AjOLekoEj4rDR2vfYe0aK0QqDLYCm6QIdfWH4rfZqXR8HmidoR3PdXndldr9hVeGEl4WhHLm38DM6IfmMfgv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVSL5i1v; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso2100704a12.1;
        Fri, 29 Mar 2024 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711705764; x=1712310564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jHuZMAvqETWpA2oAM/qjqgqoLGUBb7pOip+JvCK0Qno=;
        b=LVSL5i1vP5Z0UcGpPjjwyjSxptleJyEOTwBla+95OxY4kkyKmtMq5dVl6hr7i+JG+m
         p1vRw/JR2fIophcDmfStMwep4MTUUHlRfcdV5k4wCvrkPVFYX8oxqTN7AJlYNczqyQ5R
         fLwqiHWOjJ3nVWmRR1gFtv79nGXnHLglvC2ynpuPdLlt3mvU5PieecLnWnP+WcjPc9lc
         GdHGyj68GqWIVR1p1idv5klY+AFTQE7IW2qv5vmEK3sZ9krAtGBtoM4YoNLFv4GEuZ2e
         7AcCxSOIp2T5a0mC8Ij46GkntZKoSi4/XsWMvyp30Bhzt8+kH6TdW0DhYSCgikccY7Bg
         9dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711705764; x=1712310564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHuZMAvqETWpA2oAM/qjqgqoLGUBb7pOip+JvCK0Qno=;
        b=jU7dFtbych6vZTGhwn78J9tAmibdDCFEQD72ru2m0mPfQK6KLKk4xgzOHkPHyBuu4x
         158dUiSHWnx7JUKUIW3quVNC6/Yv/NxX/dvUJo5HyyAZyOgqJzTZiAyMdJz9kqB+XXW4
         OCTcTf3Tzi9nVXh8bbhCXw1k003XGb95E3KUbdKjc69BL6AyxQArHZVp5Dpytrhvl+ia
         V7iy5BiEcEBmrEtWxLMoDtsGuLRJj/cCiC91ZSwpQlOyh3pcg8CkRHQ6IizIXT1p28ue
         f9zKYIgYTNAnA8iJ2JHeylIA2L4Au+NRpsP8zPFmXkZdpvuFy/XRZRjamUXkMX8biBt/
         jN+w==
X-Forwarded-Encrypted: i=1; AJvYcCX8zP6IdrekPR6XbTRVSDkl2uk+2qAkY5IymBDR5MzFX/EoWQgCew8JhN5EyQRxMC6C9W2LnYrhhxw8sqFksiSJLP6jaJan2m/OwHAJJHuzCHx5NSkgPefLmx8RbflcTS3v+1/0prPLHH0/WEHjaVTFvcU9bWXdYXJd
X-Gm-Message-State: AOJu0YzwXOpHDngbMtDdphJI7bYJ9F3xM7+svrSMcwPtSngu00uJd1q4
	4D7gV0QkmMnHW5rvsvqbT/7JUrg8QzuGq3d/IHczvOyEAC+Wf8VuOL3ZQSaPnlY=
X-Google-Smtp-Source: AGHT+IHoVn8hIB47ZCKxyMTgTq6t93yCHp4FgQTK3MkjlvHnU/TvWN699cAYQPO0H2u3PPM2GtATiw==
X-Received: by 2002:a05:6402:35ca:b0:56b:b5a1:4685 with SMTP id z10-20020a05640235ca00b0056bb5a14685mr1393321edc.27.1711705763631;
        Fri, 29 Mar 2024 02:49:23 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id b4-20020a0564021f0400b0056c1cca33bfsm1829733edb.6.2024.03.29.02.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:49:23 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
Subject: [PATCH RESEND bpf 0/2] x86/bpf: Fixes for the BPF JIT with retbleed=stuff
Date: Fri, 29 Mar 2024 10:46:16 +0100
Message-ID: <20240329094906.18147-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joan Bruguera Micó <joanbrugueram@gmail.com>

Fixes two issues that cause kernels panic when using the BPF JIT with
the call depth tracking / stuffing mitigation for Skylake processors
(`retbleed=stuff`). Both issues can be triggered by running simple
BPF programs (e.g. running the test suite should trigger both).

The first (resubmit) fixes a trivial issue related to calculating the
destination IP for call instructions with call depth tracking.

The second is related to using the correct IP for relocations, related
to the recently introduced %rip-relative addressing for PER_CPU_VAR.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Joan Bruguera Micó <joanbrugueram@gmail.com>

Joan Bruguera Micó (2):
  x86/bpf: Fix IP after emitting call depth accounting
  x86/bpf: Fix IP for relocating call depth accounting

 arch/x86/include/asm/alternative.h |  4 ++--
 arch/x86/kernel/callthunks.c       |  4 ++--
 arch/x86/net/bpf_jit_comp.c        | 22 ++++++++++------------
 3 files changed, 14 insertions(+), 16 deletions(-)

-- 
2.44.0


