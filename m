Return-Path: <linux-kernel+bounces-47708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E5684518C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E3E1F2B520
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8031F1586EF;
	Thu,  1 Feb 2024 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Yiv2h8UN"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091C273FE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769647; cv=none; b=tBUHzHlAOqgQBcmtmcuLLJfdYcTphROtVd2tHUV2WvntMXjAgBYoE3OQKDOl2CSbVBnt+8y2Nc8Z978V7i3WwEW3t+l57zD9DI6pvSqmzQSwouhc4Yn7uRHx2I7kqcvB9gSZOlwuA5O2Env0lhiGF1QFNFpbArfbqFBUhZ2yXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769647; c=relaxed/simple;
	bh=0A0EZZ7L95Ss35itIndFIHG4J0n0kRMyQ0DhF7dwS5s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IvOiqib1OZK924hEYpvZ++U+zQdwpbTMkxjhjk/eCn0721MNTzAyVrZOhAqLY34J6y7SSfM8M51Wlsq2tKalSSSX3mL5gEAMWRm1o8KZLfJSNDG/aLg6JL5iVCbYjvqzOxlo2NTpnbev1CGZbf5zSRMIff4vnJlg1+xZonShg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Yiv2h8UN; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58e256505f7so346249eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706769645; x=1707374445; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WtAlb93cBUuGmYqswMaNz+Fctsrood/l670QzNltOB8=;
        b=Yiv2h8UN2aNeFWzZETqn6GwZ1OEROr3ga1caZo0IJ5CcjQNF4rE5XwK+tn0vi68sEF
         jaoJH/p2Au+pOARq/Ft9i8L0rCcwS1Lp3qg2tZirSsKT4oRcEntiRtT3ZlOSCeuuPlJB
         TJi4d2s/G6vFds4Q62VZbF410avRuW9zh6+4Nqn6lq6Cs/szZQ/O7hkkqdi7ZhNwtnbH
         9xwVmssW5WAFd84GKgmec1z5UR/ag2agMwSMLTrZb6lQ9bUhcvJUCVIdNLVcOh2U9UVf
         fL6yVb27i4a01mTxvACKmWItgfVJ5gy7VeuNERyaAadpf6KlZwJe5ZRgOF+NYhcJqOBR
         ZyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706769645; x=1707374445;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtAlb93cBUuGmYqswMaNz+Fctsrood/l670QzNltOB8=;
        b=SGbly8/IS1NsbVz5IuOdxJSmdt8gnp1rCL46PqWbaHTCGT+mtkbtL8a0lx6+PMwolu
         9hctBvRGSuirhkzhfgInrA+9wp/w6gcEAHdCdFMR+Ah31b51uwnZsJjwUmKbrvj2+x62
         QcMUPVWtHFlNDe9+c6zwi3EKqTyo7XjhU2S0jHW6krq0lJzblDiBfCQrt1IQmy6TYsz7
         RkUeQeY2chQfFHCI8k4jHrcaHDX9Pm0SKo2Va6YsmpT7ajyS5HeeoCX+zJUAOsBMaBRp
         3fNihpq+BtAbVJlru01zdiB3V8tkvgLEJqo998UjcZil+1CNZ8+PJyY95/jpsH3dY91w
         RHdg==
X-Gm-Message-State: AOJu0Yx46otCet/4Sx044Wt09IEFlLaa7fFwTkdfLShKRa2AfJJyybjo
	oSnX//u0/WtSCdOLGLJOP2dU4udJGCOxh4UKHlmIEGf/jZidUe+ADGZdM9NJeek=
X-Google-Smtp-Source: AGHT+IGWuqFCnmYn/Enpi4Gj7UjtNzwB/7aM7UciT57NXsd6mW97qniSYk1sMlvGKTqf3at4rxGDxQ==
X-Received: by 2002:a05:6358:1901:b0:178:7556:11e6 with SMTP id w1-20020a056358190100b00178755611e6mr3582160rwm.27.1706769644871;
        Wed, 31 Jan 2024 22:40:44 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id y9-20020aa79e09000000b006ddc7af02c1sm10925764pfq.9.2024.01.31.22.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:40:44 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/2] riscv: Use CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS to
 set misaligned access speed
Date: Wed, 31 Jan 2024 22:40:21 -0800
Message-Id: <20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANU8u2UC/x2N0QqEIBQFfyXu8wqaRWy/EotYHu1Cq6EQQfTvS
 U/DvMxcVJAZhcbmooyDC6dYRX0aWlYbAwS76tTKtpNKK+G42HmD+VduHCKc2XOaYZYUPQchO21
 h9dD7r6Za2TM8n+9h+t33A0h4BwdxAAAA
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706769643; l=1017;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=0A0EZZ7L95Ss35itIndFIHG4J0n0kRMyQ0DhF7dwS5s=;
 b=SeGBVfFBkE4J7EYJovzsM69HMfy3aak+n9KCMy69XDFTQYJ7A+C6YXRsFT36I1J3p8NOCVMv5
 ak3R0x0n060C/9eGi+WkN7w7629bYXVojTs1C8/8+7zKwdX1PqCEdtQ
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is enabled, no time needs to
be spent in the misaligned access speed probe. Disable the probe in this
case and set respective uses to "fast" misaligned accesses. On riscv,
this config is selected if RISCV_EFFICIENT_UNALIGNED_ACCESS is selected,
which is dependent on NONPORTABLE.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (2):
      riscv: lib: Introduce has_fast_misaligned_access function
      riscv: Disable misaligned access probe when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS

 arch/riscv/include/asm/cpufeature.h  | 13 +++++++++++++
 arch/riscv/kernel/cpufeature.c       |  4 ++++
 arch/riscv/kernel/sys_hwprobe.c      |  4 ++++
 arch/riscv/kernel/traps_misaligned.c |  4 ++++
 arch/riscv/lib/csum.c                |  5 +----
 5 files changed, 26 insertions(+), 4 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240131-disable_misaligned_probe_config-043aea375f93
-- 
- Charlie


