Return-Path: <linux-kernel+bounces-48993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 986DB846474
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5446E283D9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAA247F4D;
	Thu,  1 Feb 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fmfvKA2k"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CBF47F41
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830251; cv=none; b=Zd+3Q/ei7Nwb15jr+SPrHgPVCfkzKQfA/5w9aGpfc9Ku+XRtkDRIHzHbpA6TP5cmz+JIWQWdziyoRqZ4+NDUJ9gKKSp+/KNP/spVr0TGmzP8yseDhfRiOOCcMp7KIxmK8XtSwPlsim4akD9yK9c8Eq7ktmxjsZisOPmO6403aBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830251; c=relaxed/simple;
	bh=F3p4nG4PxoO2+hFv8J8UCk8zaUW8suFbDDH7G9TcVVo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b1nQw3FBKLEzJVCYbMTlcnj+pkXLxcn4to0nSWqTpdhIFkXKz1BN7Vcc2gZRB1Ce9GPs9DcuDuifjc3RtZbSiXAaF8vjPVZbl+75hY/i+oeWQYXAnJI9L0AT/K3NgW1zyS4RMnQQQaKAm0Kb/onxxY0IYtIDLNfGt4lnsw27V/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fmfvKA2k; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1462899a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 15:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706830249; x=1707435049; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12qhkQnAsKWLfzWt/2hyVMymoIBV11wZGrf2gJtkQrU=;
        b=fmfvKA2kpFnK+lXTU+pO2gvIzxFH3fklZkEOv8i6FP7f45v6Y6yHMzYhF2u848Pcft
         BwUnv0cmeddYWIAf9krx23QQAPoS9cp0sX2aZU5QHuC50UOaCxd4gntbVN0h2sHltbJL
         17FyR7dNpIyVcaAv8L/ma4wsnrCqzgNkx/Dx7QTyBPD7J4kEpvW1g4cM2k99w5C3/5ka
         h8jHsvFDpXbGGtF/wksnt6O28vg3BnEdsz0w800p42YulFgqriORoTyUWrYUG5YnxrQU
         tgnPECMI7qYbfyvbfpavREs8LtUHyZx5PTzRxzijbHLO1upqSCyAgm2Jl/e+gcxq7vzX
         FUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706830249; x=1707435049;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12qhkQnAsKWLfzWt/2hyVMymoIBV11wZGrf2gJtkQrU=;
        b=d5qwAMnWdtF1WiIpSBa/E+pXac8V9Y2xZ658xys/4aCJhWcYFZFvbPSsHYAK5dM1OO
         uF3VOzvS/dSgnALFbbITBoSkoa8d287cLeg9j+GBq1ShxCSwXuzX9MlPA7Do9z3YrML7
         wMhqcmYaz9CBipBOYhiYzp0IXimUCiKr9MC930v6ooa5VZ3+QMp1I7293TnJ3QSQqxT7
         trZG9ecUtrkndfhPq2q7hPt1hgpHVWHq8Kl8rs/PFK9J7r7OpOVmupYcj/WHraXN77r7
         OKC6wxfFxzT16mL5NvYS7UkZExIu0G5d+SG9NBaZHV+n68hQ/GZXztKVP8n1k2DYNFjJ
         DgeQ==
X-Gm-Message-State: AOJu0YxGY5lLpq5oHexNHtJxpTZ5xOsvZirjzqK86bCBGjFheSs/TSkb
	d7F8UTZcr+XlcCckEc7lDa9MHZDOl9/ZRy+K1koIcsvR7E7vbJEwrCtikklU/1Y=
X-Google-Smtp-Source: AGHT+IF7ynI89U+P641xK19eggYd+e8mqqBJoQ82q32/W6ptRo+YUyV7WujFf4BcPnUPElD0MpsMyw==
X-Received: by 2002:aa7:864e:0:b0:6db:dc74:d6e with SMTP id a14-20020aa7864e000000b006dbdc740d6emr722991pfo.17.1706830249170;
        Thu, 01 Feb 2024 15:30:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXelcoK7TkVoH3x8OSV3QeVFvdYCr6l/Q9iOkBxUge8YpYeqBO9GFcbMdhHnHv9djfPu1kYmNTH7iGZ6oRJAfONoT7GcKaVbykav6mnLn8J6pTAhXZ6kvj5dEo9WoooLAyKgsxRI69jyR9iU0G8p6kkLJ5UkTBXTJyQNZ2m4RXX//E8kDefNZ6ZX9vIIbesLJyDhv4v3MeWWHfnfDyTxgBSNIZgd1VeMdgHOA2ZO4LbcpZhvo74/86agisCQaysTJp5QJO5/9OGnOs=
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id y9-20020a62ce09000000b006db85b12036sm309673pfg.137.2024.02.01.15.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 15:30:48 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/2] riscv: Use CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 to set misaligned access speed
Date: Thu, 01 Feb 2024 15:30:44 -0800
Message-Id: <20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKQpvGUC/42NQQ6DIBBFr2JmXRoQSbWr3qMxBmHUSRQMNKSN4
 e6lnqCrn/cX7x0QMRBGuFcHBEwUybsC9aUCs2g3IyNbGGpeN1xIwSxFPa44bGVXmh3aYQ9+xMF
 4N9HMeCM1anlTUyehWPaAE73PwrMvvFB8+fA5g0n83v/dSTDOutYKpbAzVrePQMlHcuZq/AZ9z
 vkLJqLxkNEAAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706830247; l=1557;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=F3p4nG4PxoO2+hFv8J8UCk8zaUW8suFbDDH7G9TcVVo=;
 b=NARzrW04LTpqMAM3P7yfuTSxgMpTSoFMZWJ8kPCTrMySzqbFmMcS9qw8DYu0VEOKE4p/vOCgo
 ihPlQsTAUfOCbPMshYXmpQ4/82TNfXnzydOlyRMcIC6YluJ/z/xFTwB
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is enabled, no time needs to
be spent in the misaligned access speed probe. Disable the probe in this
case and set respective uses to "fast" misaligned accesses. On riscv,
this config is selected if RISCV_EFFICIENT_UNALIGNED_ACCESS is selected,
which is dependent on NONPORTABLE.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Move around definitions to reduce ifdefs (Clément)
- Make RISCV_MISALIGNED depend on !HAVE_EFFICIENT_UNALIGNED_ACCESS
  (Clément)
- Link to v1: https://lore.kernel.org/r/20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com

---
Charlie Jenkins (2):
      riscv: lib: Introduce has_fast_misaligned_access function
      riscv: Disable misaligned access probe when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS

 arch/riscv/Kconfig                               |   1 +
 arch/riscv/include/asm/cpufeature.h              |  22 +-
 arch/riscv/include/asm/misaligned_access_speed.h |  29 +++
 arch/riscv/kernel/Makefile                       |   3 +
 arch/riscv/kernel/cpufeature.c                   | 255 ----------------------
 arch/riscv/kernel/misaligned_access_speed.c      | 265 +++++++++++++++++++++++
 arch/riscv/kernel/sys_hwprobe.c                  |   4 +
 arch/riscv/lib/csum.c                            |   7 +-
 8 files changed, 321 insertions(+), 265 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240131-disable_misaligned_probe_config-043aea375f93
-- 
- Charlie


