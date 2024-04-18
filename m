Return-Path: <linux-kernel+bounces-150008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160838A9906
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4727F1C216CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB1B15FA80;
	Thu, 18 Apr 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="F3/1XtfM"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DA15F411
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440996; cv=none; b=UeZKYWoGCJMEe/iBdbYWyWdcCyGzt8StgrJ8J5uIcM4RY/CORwb1++MylkNOk6GUWW3davFLP0l6sKlLhGXggXwzcw9w7lWxxLzDJld8ns3XghkA2eG0LUu+CqahUXee4fa1C1eFE1ywDUoPKe03maoepVbgI6Kn8oeJdo1W7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440996; c=relaxed/simple;
	bh=7LvMmGPTU4AT3iUhIC20+qZCbZuB71pb29O1u0aKTdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=reu3P2H8Svq/6AjTE4MeEgWkuFRd3qxMu+78vKylHbSOiiqygByrkxl2M4H8zoaeTLxl23gbfZoQl8P2n/kj0Y8M2P+K4VwbP3iGbasKGPns2N71a4oE8E+G90rBeDt4DUAIuuPsucrp3y6KGhnt0J2DqoD0C7xugVv1DEldids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=F3/1XtfM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so1317735a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713440994; x=1714045794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iqyoJWzuWR4+FOLKtd9tRL31vzpGg5YN4G5Q0FBkls=;
        b=F3/1XtfMbXEUAKc6Aak3E+ZZpeaB/xRmgGg5AUSWBcaGcSrMiGYNvfRPl8bqtIlTwc
         8rFEBqPQzK+kCdlB4NFODwBsFsMJrYmDWacHtrSEWkr6vx+Ongrv5q1AcIV2GVvvRJYg
         ldbJ9G9E2GURPqOmaf8oW3Cyh+TBU+mzcS6Jaqt5EdNdA9WM8ktqkOF5W865UKkp/KMj
         tXXJVjsWhzYZB0N2rRFBELGaxKxdsLlrNgjoEd50HgmFtH7hSb4MHrYIbCe9fjUE790i
         UUqzy+3mSasQW0RfDnTZCHj5K8Y1TBO2N1BhA4NCpfM9kcqlvTcK/Y7NOMW3GwTKf40I
         dJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713440994; x=1714045794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iqyoJWzuWR4+FOLKtd9tRL31vzpGg5YN4G5Q0FBkls=;
        b=exf9k7zXxNz6PIW0p7AyvXdL70eMMt3IrGdAf0f7+tflW6ASeu9syVOQf8vRoQLLwQ
         PF+wYbnBk5iq9E13Kd/s2CgLQkcf3JpvBerJgOC8w08igB0rIrjH2mB4iIwozSgPbVK8
         kFJQG6oLTaUD+N5LIdpTNgZorXqyM7dXtYCT1/SJQBgCf276OmVTL2qLfP2l3/oe1Yq1
         5MZRgXGR2n2o8W78/NRfzQ4N63mv570v4I9V7oCja0pxvisPqqycyGMDaPJ5GGRqpzzX
         rX20IqliPs0QRMd6Exe4wUsWwMSZSR04zGsMnMkwZDoqYzKKsLZznqR4E9S1TIeO2OP2
         iyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTo3JiRtn91MZIFwI+qw+kjvRrQOZ96+oL4YfLRDMqgyBwEaoduxtEeWEC54tiRaMazg2KxlPLu552uhOxLZa6YDMAit3hXgBL1eE/
X-Gm-Message-State: AOJu0Yzixf1gK3ZpPEWUbo0Q+BO5ih47Yw4buGArSaP3k2ojIOKdbvDh
	j5fB20npFgbeoOLB+GCfNa6QmWTX6gEJrzMOq527nMz3KKNi35jPH22BEiRbWHU=
X-Google-Smtp-Source: AGHT+IFzJX4vQg0mSbjsa4tzJvphqs9eiIY0dUdAoFpN3kI6aYxPZMplxn2RgSz5efj4pCHYSlZaMg==
X-Received: by 2002:a17:90a:668a:b0:2a5:6f5f:210d with SMTP id m10-20020a17090a668a00b002a56f5f210dmr3175018pjj.23.1713440993618;
        Thu, 18 Apr 2024 04:49:53 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090aa40700b002abdb19f499sm1032293pjp.26.2024.04.18.04.49.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Apr 2024 04:49:51 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	andy.chiu@sifive.com,
	guoren@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lihangjing@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC 0/2] riscv: Idle thread using Zawrs extension
Date: Thu, 18 Apr 2024 19:49:40 +0800
Message-Id: <20240418114942.52770-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a new implementation of idle thread using
Zawrs extension.

The Zawrs[0] extension introduces two new instructions named WRS.STO and
WRS.NTO in RISC-V. When software registers a reservation set using LR
instruction, a subsequent WRS.STO or WRS.NTO instruction will cause the
hart to stall in a low-power state until a store happens to the
reservation set or an interrupt becomes pending. The difference between
these two instructions is that WRS.STO will terminate stall after an
implementation-defined timeout while WRS.NTO won't.

This patch series implements idle thread using WRS.NTO instruction.
Besides, we found there is no need to send a real IPI to wake up an idle
CPU. Instead, we write IPI information to the reservation set of an idle
CPU to wake it up and let it handle IPI quickly, without going through
tranditional interrupt handling routine.

[0] https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc

Xu Lu (2):
  riscv: process: Introduce idle thread using Zawrs extension
  riscv: Use Zawrs to accelerate IPI to idle cpu

 arch/riscv/Kconfig                 |  24 +++++++
 arch/riscv/include/asm/cpuidle.h   |  11 +---
 arch/riscv/include/asm/hwcap.h     |   1 +
 arch/riscv/include/asm/processor.h |  31 +++++++++
 arch/riscv/include/asm/smp.h       |  14 ++++
 arch/riscv/kernel/cpu.c            |   5 ++
 arch/riscv/kernel/cpufeature.c     |   1 +
 arch/riscv/kernel/process.c        | 102 ++++++++++++++++++++++++++++-
 arch/riscv/kernel/smp.c            |  39 +++++++----
 9 files changed, 205 insertions(+), 23 deletions(-)

-- 
2.20.1


