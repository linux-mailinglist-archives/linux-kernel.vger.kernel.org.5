Return-Path: <linux-kernel+bounces-62911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4238527C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82153B243DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F5AA92A;
	Tue, 13 Feb 2024 03:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hTSKBPz5"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7A8F45
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707795468; cv=none; b=lXG0G/tJ0MNlQoETNfpKDuh8t1AUO0gnSQtXlCs4HvBTsx01ZfauoHIpnRUdobw0ymOUl8vjAaJOQZI/VhrU8BkKmW56pHV71T963cfkXox2L6TBV67w4pz7NAicd7SxKpA5GJ8bM1OdUusCut5tE0rKejeI8Q2KIvQjyDYeZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707795468; c=relaxed/simple;
	bh=jqhHJbkQXrDk+ACYp3qPgbhSRWDrDKA3bfUMXP5GpzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtNhv7EIzV1jNBLV6uwSCq9nOW3QExMhhqvA1q4vRxLJfedF3TYxRdWxu/NDGyZht8pKdQfo/khnc8BYSPiEJGH2HOKjWXWapkfLTL5EaP+3KfLcfDVGXLLd1S8fQdS+gbpiUN6Bn4u+t/cuVbzCVpuqc/wZVpVEWhK6q+F+K6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=hTSKBPz5; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so2833283b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707795466; x=1708400266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wd/JYFJKep1rAhC5j9BPNCBpr8gOscu2DNvYuPwSHJE=;
        b=hTSKBPz57g16MXsBCmlqHZaisz/tdTWMfIL/PesfD+e8ZXDzYF1NksJh8SMRSJF08i
         rLZ2fAHfMueslTZZ+rEzarC17+wVOcTas0AtAc6UA8xqPeH2ZZecWrs7JkyGlsTazHj7
         xJgZqpAXslNipi678les+fN3S88GCt/N+gW1sKNowV9ta1Skj6WMcqWP3QhvkWkqDkvT
         Bq0U5cUJoYTpr6JEKt9wmSqSC7P3Bc2JdrWwitF5ErDq8Me1LHCDKSytmRljMMVD356t
         +tnPiujsUzQY5nb4cLWy8J5Sr6qo27U6/ZFPF7vjFfmT8hTAZBuNqvsZQmT2D6WGSjpN
         fOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707795466; x=1708400266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wd/JYFJKep1rAhC5j9BPNCBpr8gOscu2DNvYuPwSHJE=;
        b=R32khs6nlPvfRgEQ3LFiKxNeMfCJ451yeWcTuMYHftEQlGKvyFseVqQZ+8NyS+rH/0
         c7omoWEcind1jb+tB27kK03+9SAiZuWHQI9e000uCbFVFXP1Srk4YAsFNPTpjJNiUNXI
         fmqKMqGjLr2ehU2rpID1LtGirti7LREUlFdwXdqXZgr8Vi8x80nrxh4KHPLxf1xMOGWn
         /SFp/2pzbVMOcqUowhdBlHlFRnX8ewYK80ZrgSBHJUpnaQETF4l0Y108nezGRCQgXhVm
         3y15RJ8b4C6CmtoUfsjpBs7skJBgLs8QMyYBJaULVcvk8Z+YKBc1IsiRAQqNIGcOGr+w
         7Z3A==
X-Forwarded-Encrypted: i=1; AJvYcCV2wlbfwVmA/T5cDqaP1mlD535zemWt3rQsAcQZ5YocdLg2KBwP7yR7UJmW8ut6jGIyoR5LQQZ4SXEHw3BRord6ZwOEsp0MgogvuVL6
X-Gm-Message-State: AOJu0YxpgvBdQ5/S8jLSehI8QvrLNTgBK7Q8hEfi1scWitswe2+TMLcg
	kPZoO2/y4IJS5FY2cxBoBo2VU0yYL5Xz10zZ9R5MwE8gv0QZofePVfUxC/swCqs=
X-Google-Smtp-Source: AGHT+IHU7T2Qcc7HVPlGS9K0ldctu9qV5MAsYITwNI996JmEkdMvEWmLy+Qiine2m4onhtLdTjFiug==
X-Received: by 2002:a05:6808:10d6:b0:3c0:3db0:55eb with SMTP id s22-20020a05680810d600b003c03db055ebmr3340578ois.49.1707795465913;
        Mon, 12 Feb 2024 19:37:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUy63kmiG126yff7qiLVwjqWHChxUM8jYm1eXwZgTtPIMijD8vVPWhxjemkWU2LKCT1hs9yCHNLAXefuYHAJ09+r/AYYl8O7SVrYV0zhVAKjdgb751QugTrjduf+N67rsT9zTuLnPz86NQyZtTj/Sg/OiRfB6kX1SnXoU3ejhcdyoO8Mat+GwwcC0gAKewup/ur2kHuCSZPa8TeSfrI
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id v11-20020a056a00148b00b006e0334e3dd9sm6188633pfu.76.2024.02.12.19.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 19:37:45 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH -fixes v2 0/4] riscv: cbo.zero fixes
Date: Mon, 12 Feb 2024 19:37:31 -0800
Message-ID: <20240213033744.4069020-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a couple issues related to using the cbo.zero
instruction in userspace. The first patches fixes a bug where the wrong
enable bit gets set if the kernel is running in M-mode. The remaining
patches fix a bug where the enable bit gets reset to its default value
after a nonretentive idle state. I have hardware which reproduces this:

Before this series (or without ss1p12 in the devicetree):
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

Changes in v2:
 - Add patches to allow parsing the privileged ISA version from the DT
 - Check for privileged ISA v1.12 instead of the specific CSR
 - Use riscv_has_extension_likely() instead of new ALTERNATIVE()s

Samuel Holland (4):
  riscv: Fix enabling cbo.zero when running in M-mode
  dt-bindings: riscv: Add ratified privileged ISA versions
  riscv: Add ISA extension parsing for Sm and Ss
  riscv: Save/restore envcfg CSR during CPU suspend

 .../devicetree/bindings/riscv/extensions.yaml | 20 +++++++++
 arch/riscv/include/asm/cpufeature.h           |  1 +
 arch/riscv/include/asm/csr.h                  |  2 +
 arch/riscv/include/asm/hwcap.h                |  8 ++++
 arch/riscv/include/asm/suspend.h              |  1 +
 arch/riscv/kernel/cpu.c                       |  5 +++
 arch/riscv/kernel/cpufeature.c                | 44 ++++++++++++++++---
 arch/riscv/kernel/suspend.c                   |  4 ++
 8 files changed, 79 insertions(+), 6 deletions(-)

-- 
2.43.0


