Return-Path: <linux-kernel+bounces-84578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7455786A893
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A8E2859CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB5022F03;
	Wed, 28 Feb 2024 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Sxrtg5r1"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4B36B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709103364; cv=none; b=QlbkSYq6f37XetADGRcfgk2ubYeNyOn9J8H3Fg9rykU4IrXLkh0UL3370TUwqAJ6tTMvCgz8GklMF7PuQA6WC4FCTHd7i+TcV3K9KECycA1qZO6TpyAdI2xUq06nTMbzSpw7gASnFGPi9po8p81oJrjQe9SzMarh9jF+HacpznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709103364; c=relaxed/simple;
	bh=CTkHAULfhu6eRBwbZstmEQ1EMRW79tI7xXnddcLfbMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AH2k92KXyC5kYhngQzKIG1xfDo4ASqD/mlfLDciuDHcTfOMV+wGPORtm+UC+jcO7ep73FnxnKZgt1nkygWHy5nbsCjaEvgBRuOL+QHtYdgEw4BE/yDA5xDephNhpG3GsgS2XZHPmgGa6sYRoSAz0JCNLBW+Cd0akjH322SpB0l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Sxrtg5r1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e4ca46ab04so3253903b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709103361; x=1709708161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JxG7vP1SFrBhJ98k0I3xsm/G/tk3/29eGsIPZ1DJHx8=;
        b=Sxrtg5r1yo9WBebGnC0Ub15BqPOSCafnrC9telgva3s2vrch/EBOKaj8JB+v6bzYbr
         XSo9+Js/dyBXfzHe6CJrQupyE1sTzDUATArloAkoMijI/jIOg4czHgdiQN4ygLsScq22
         o6rgaBRvI0R2zQR5mA6BcCgJSMeGOkTq9D6FpsrrgjRhgkHClprmLCQ8UZO9563h5FQt
         Rav59nVT4fVa65GNF9hbA+I097gjs8WPa3AHy9/Rwi7GhufN1hme7ZF9Lq6HJLO6HEkp
         oPfp8agQiXmc7etEwuV95Y8m1ZvgQOddgL2On91MGqDZPBZfMnfxZ++QKOtRUvRHRUcb
         P+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709103361; x=1709708161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxG7vP1SFrBhJ98k0I3xsm/G/tk3/29eGsIPZ1DJHx8=;
        b=fAQ5wblIt41VmXrR7ZAPql0oxhfDCl+zisITuPlhOuUtNKKlXDm44OLG2tZmtAtqH2
         CGCoWJMMoTWFV6wiWrg/5hIkY7SyilJftBdIuGxe5dGJmqxTMYw8XZFokY/Pk1q8eEpK
         x3zR5kqkrWZQpl+Qi2R/lZrCDXg9nQVQg1Sse2gCUCnykrE0x1VQYQcv6rSoRjOtjQBo
         6AaiqyjbycTBRJ0SdldJS8RRWVfycIfc4stUxcOvgq7Bmr/9L2nKpoHmTrqSz7Hi5jws
         jXbxdawQnAwdmqWOVI6BJny99ZG5xYp1Aj3CIumKnpw2zNPMcHzzpZOyWZdVH7DTWWY2
         3+Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVf8VLiltM/G+vXgCs1wQuuVtEfcGsT9dbyDmNDs1c/qd4ZvP56xmqtCuzDBirNrFBdYtDhWbhpwkaeb197mV1zrukaUDeK6bhYWUUV
X-Gm-Message-State: AOJu0YyYiTRDCo4VuFfEqYYbAA6T3wuhA1pnG781u3QLzplNRrR0bJnx
	hkRg0m4VtX6+4qy7Cz4zV5jWc93V+mGmxZdz4tG6k1dPIZnvx7RzZytR5vmn73k=
X-Google-Smtp-Source: AGHT+IHHOue4TrxJ31AUpskbU0nr+ZxbtS6GU64fgSQ6x04HFCZfxdsGdPGmSmGJvkrgw2d5djzHTA==
X-Received: by 2002:a05:6a00:2:b0:6e4:e611:8f65 with SMTP id h2-20020a056a00000200b006e4e6118f65mr12013448pfk.21.1709103361509;
        Tue, 27 Feb 2024 22:56:01 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e12-20020a62aa0c000000b006e5590729aasm1010112pff.89.2024.02.27.22.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 22:56:01 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH -fixes v4 0/3] riscv: cbo.zero fixes
Date: Tue, 27 Feb 2024 22:55:32 -0800
Message-ID: <20240228065559.3434837-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a couple of issues related to using the cbo.zero
instruction in userspace. The first patch fixes a bug where the wrong
enable bit gets set if the kernel is running in M-mode. The remaining
patches fix a bug where the enable bit gets reset to its default value
after a nonretentive idle state. I have hardware which reproduces this:

Before this series:
  $ tools/testing/selftests/riscv/hwprobe/cbo
  TAP version 13
  1..3
  ok 1 Zicboz block size
  # Zicboz block size: 64
  Illegal instruction

After applying this series:
  $ tools/testing/selftests/riscv/hwprobe/cbo
  TAP version 13
  1..3
  ok 1 Zicboz block size
  # Zicboz block size: 64
  ok 2 cbo.zero
  ok 3 cbo.zero check
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Changes in v4:
 - Add a patch defining and setting the Xlinuxenvcfg ISA extension bit
 - Check for Xlinuxenvcfg instead of Zicboz

Changes in v3:
 - Drop patches added in v2
 - Check for Zicboz instead of the privileged ISA version

Changes in v2:
 - Add patches to allow parsing the privileged ISA version from the DT
 - Check for privileged ISA v1.12 instead of the specific CSR
 - Use riscv_has_extension_likely() instead of new ALTERNATIVE()s

Samuel Holland (3):
  riscv: Fix enabling cbo.zero when running in M-mode
  riscv: Add a custom ISA extension for the [ms]envcfg CSR
  riscv: Save/restore envcfg CSR during CPU suspend

 arch/riscv/include/asm/csr.h     |  2 ++
 arch/riscv/include/asm/hwcap.h   |  2 ++
 arch/riscv/include/asm/suspend.h |  1 +
 arch/riscv/kernel/cpufeature.c   | 16 +++++++++++++---
 arch/riscv/kernel/suspend.c      |  4 ++++
 5 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.43.1


