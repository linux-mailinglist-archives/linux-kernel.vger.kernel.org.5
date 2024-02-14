Return-Path: <linux-kernel+bounces-64904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55EF85447F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627CD1F2954F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE09B64A;
	Wed, 14 Feb 2024 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kOKK98GW"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BBD79DC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901330; cv=none; b=AWx+TIRJU6EJ/biJzsWCgCLouRsNXOHY22MxCvf9ycpP+YYKZFTOe35kWfkgKJf3ghDvGN+1GiHvH1OM8GTnkPWKxDLoUsPGsmbW+ovhovJF7M+0tbLsLglE2vq5WiqisQNUtqdtcn17qxVPzOVBJLxwUMaBIyG7/cmlaqsWGFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901330; c=relaxed/simple;
	bh=/fE39pKrfDRibqn1WWdykU0qcTy9Pk5txFzrjNPfvdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUDx4J0VlEHwvucnVRpnh5QOxvjPOchZyrJajUui/r+Tfu2Zbl4Y7CAY5DYteH78C01mZGEckztOsPDLenrXpJTy7OG8rn+eaYj+84GX1x7nfa+MQNF9OwLrfwhVfGWyHAoadTxJTJOxHYGaz/bP2ZQaA4X1WdhOrsdJNzef2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kOKK98GW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso431515b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707901328; x=1708506128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PG0IiU/s69rauKmwQQKq0QDss70qdtIt7mVzhoYNTgg=;
        b=kOKK98GW5TnwXNE5+DFy6CR92iUrJtEYnVQg6P/w2mb6IqcF3RFjTBl2lEVhdjvlz/
         w85VwGsPVxIiOgOPYgxIG0jUxfXGUVgRo1jlVYllSJTKcOdBDRzieCpxvcx7TSdxez7H
         dDtxkiV2LXpXlhv3WBkldZTCEcDb6jHCqMxfHI6kP/SxuFZTx8Z5FoHCC6+Hey/B82Th
         e6UYwVxqnQj2d2v/5/A7WfWZSYpjtR5XohB6u7XBTcjI+f2bA2OUbw2ZompoLUqr6Q1K
         OdQpNTRKdb6TEuoDmpcvwL4rQxHuRhH+n7pbgoHLWWmMoIYbbC8OCEC8mdPqjy0oDVpo
         dCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707901328; x=1708506128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PG0IiU/s69rauKmwQQKq0QDss70qdtIt7mVzhoYNTgg=;
        b=laIfF0lqD5vVs3CcSIFFxQBrKLirJE4S1nT2QLsSePqmfMEq8zfXbgb/C+WQ/bHUG8
         KV5j36DlSvWQ3Egrd7hIUdMq12vkgmRocIQneQpab+AakOc61a6mDkJBjLYVkm3trl8g
         OAjLzHO7kMX7CaR0sacWXHerMzhzc4nC7aTEaGWglzKQGRXbdVrem0Gv+FaTE43WWyiJ
         KVhazqtTc6aGpVtuUfd7wjChWL6BaEqTMDfA+hublnesLJCXdnYeM583RNJj+hz7TqmY
         jf+vzPtrT3kxO3zs/MG2psfLxRS6vApruEaTJrdTzFOpSyQtSz13ZFyoeLDlEVzkGE0R
         zIJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiO05iGoeBWLS6STOEN1ifUGBFn/HxynlmuXgN/+ZNua7yaQ8Ao8r71zfQue62RJF1S9IG6ye6VaV4qqmBRWvCjsiFLS3CrrK0q4ag
X-Gm-Message-State: AOJu0Yw2SWbXe3JN6KfLEru6evD8kirJzMHvWVt98iprL9ujPoghjBr6
	Q17+xw6ESXdtdiWNEZv4W/11FhCkByrf6kUllt02A2ABA9BUY4NjLNTl69DjYK4=
X-Google-Smtp-Source: AGHT+IFZDfQZGItnAQkonqR/Yikgb4B5zLgUFibXDBjJa1njdREAj5ps9BVVaW/vzNwOz21QNCGcMw==
X-Received: by 2002:a05:6a21:3997:b0:1a0:587d:5664 with SMTP id ad23-20020a056a21399700b001a0587d5664mr2415076pzc.15.1707901327898;
        Wed, 14 Feb 2024 01:02:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwx8T69DaHtqPp+CeSq/WLrl/IdHgV6ExI7p/7RvPuv2E7ZTW1x36XoZ7PISg15xVLh/f2Yoh66AZ0ddPdxoWYRc/Ddqchz4mt4vauHE5KkKyhxzoxytAfLtOxiQlLneN61j5HrOVOZ0OqZU830b3Z59XwhPJl6OxtE2a46ojK0hFnlLheuEcNfvhL/FFGX6NIxwyvJm+QIPMCzVbJM2jJtUIygOpb/QKOxPPwS6OA
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id m25-20020a638c19000000b005d7994a08dcsm2476681pgd.36.2024.02.14.01.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:02:07 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org,
	Stefan O'Rear <sorear@fastmail.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH -fixes v3 0/2] riscv: cbo.zero fixes
Date: Wed, 14 Feb 2024 01:01:55 -0800
Message-ID: <20240214090206.195754-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a couple of issues related to using the cbo.zero
instruction in userspace. The first patch fixes a bug where the wrong
enable bit gets set if the kernel is running in M-mode. The second
patch fixes a bug where the enable bit gets reset to its default value
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

Changes in v3:
 - Drop patches added in v2
 - Check for Zicboz instead of the privileged ISA version

Changes in v2:
 - Add patches to allow parsing the privileged ISA version from the DT
 - Check for privileged ISA v1.12 instead of the specific CSR
 - Use riscv_has_extension_likely() instead of new ALTERNATIVE()s

Samuel Holland (2):
  riscv: Fix enabling cbo.zero when running in M-mode
  riscv: Save/restore envcfg CSR during CPU suspend

 arch/riscv/include/asm/csr.h     | 2 ++
 arch/riscv/include/asm/suspend.h | 1 +
 arch/riscv/kernel/cpufeature.c   | 2 +-
 arch/riscv/kernel/suspend.c      | 4 ++++
 4 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.43.0


