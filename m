Return-Path: <linux-kernel+bounces-121601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FDF88EABC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BE51C31A92
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96662130497;
	Wed, 27 Mar 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kj55+KDY"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C912EBC6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555523; cv=none; b=MqZNS/lfe6VNAmP4Fjb+cC5soKerxs/29dDBd4eyr/JhIUH7zXyk8pLim3dyGyLfIvY6738AbVvbuKlGqMZBuNv2LTb0Md1UVEdefGf0f/RU+f3Xcgu7jd8+mgA+rbBxyWjyRtw8OSLAeL82JdymZbf1q27sYqR3nv5K2LJZc0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555523; c=relaxed/simple;
	bh=EXr7t5ZyXFX9wXSbTzc9vLveFmblL3BI0CqEVyK8kVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I6xaMJlwFcvrRC4SXznkAD4hbK8l424bRRxIGRyozoUSXHAH3KbZSSZxR4zUPmgaxhMbAmnggm9fJjraVBd4lzpBn2JnlyfD67F7CYylkvWSt86iWUHO5SsTlJt9QEbMtzxzFdhykBdyvnrG9kVSxI9ysDK82cwkMJYydYQtixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kj55+KDY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e04ac4209eso61626955ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711555522; x=1712160322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kwbw8Bfq5TVdPAVwgD2UahVCoOXtlyfhsdDWXgrrMaI=;
        b=kj55+KDYAdr/AEgfzPfnFh6UmQT/rKlyrwHbKWZ4X6VwcJIRS+hJV5AXAhl4N0mCne
         VpZveojmj0F1gKUuaVIAwjWXOeMeWLcU/7Uw3glu4EaUluKq0wskuKFZWQpuvsVRxwft
         2AltJBTF7rj2Fr8EG4f8xuwyNmhMvpTYB4Ey6Lge6Z7NpNi1/7IR632D36BiALXER0ku
         Cn2YZKqHdx/iAWjHvdEraAdAsDwVBRcCuaNMilVWCD/ftA1+/jzYmoiusSLuTStULuAu
         GqriH9sBOPgucTtm/kBs6ehYNfXLpUCn8e4/1WnqaGswaTGutMZ6KYlxlHdo+fme7CQ4
         xB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555522; x=1712160322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kwbw8Bfq5TVdPAVwgD2UahVCoOXtlyfhsdDWXgrrMaI=;
        b=Fh4QTPL/s9R5XoN0ztKttqaSk754XT2GbJ+e943t0t6z8YTAGntWaCc2YB9DAC6MVn
         BfcI8xwNH02VdJn+pYv91z7wWIKmS3L9sN3w1O5xRDK0Dnmaf/CHnXhTn0OGVrs5zkhT
         o+XdcLiRYJ9VGdgn3oF/cxsgQu3ajr0PFfA34j49gPRezOdmuh7TJNetlWU2iYTaMIY1
         MJQtn4nvdamWL+OdaQu2MmQpY+TQ9He7HVwKoe37dOh+qX+tVPfq9NCLcNlE5bIdhS8Z
         ezuHfQ8xZz0behenM3YU4hvaOLvtywvF7GAtNKpXMaMn1mYT2C3h5il0AhfrJH2QEuhM
         8wsg==
X-Forwarded-Encrypted: i=1; AJvYcCVhojIaeONP40Nkl5NaCC6MPZ5zvxS2J7PtrHS6t1PUH5p1j/SHs+1pWNidf94OQuVOA53I0qPGq+giATkyNJxbsXkxnx/EIRfDkOhp
X-Gm-Message-State: AOJu0YxTV9zGZ0X1j05HZjClQkf/lIZi0ZfKg4IdwhggaDQzY/2oOoEy
	nyhaSH5EYsPOc43c+faist0uPWF73EXoVNGJqf8TaCDBkoKY0N9p3N16zlfX280=
X-Google-Smtp-Source: AGHT+IHrHUQx8CTOsGUx7d9I0wuSaSBLdTL7D/z7DZEE6/9Njp7t/Ngzy8GHegWFTHCH7uUVnbidfQ==
X-Received: by 2002:a17:903:11c4:b0:1de:ff9f:aee9 with SMTP id q4-20020a17090311c400b001deff9faee9mr138103plh.11.1711555521786;
        Wed, 27 Mar 2024 09:05:21 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bf4-20020a170902b90400b001e14807f9cesm1718226plb.125.2024.03.27.09.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:05:21 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/7] riscv: Various text patching improvements
Date: Wed, 27 Mar 2024 09:04:39 -0700
Message-ID: <20240327160520.791322-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Here are a few changes to minimize calls to stop_machine() and
flush_icache_*() in the various text patching functions, as well as
to simplify the code.

This series is based on "[PATCH v3 0/2] riscv: fix patching with IPI"[1].

[1]: https://lore.kernel.org/linux-riscv/20240229121056.203419-1-alexghiti@rivosinc.com/

Changes in v2:
 - Remove unnecessary line wrapping
 - Further simplify patch_insn_set()/patch_insn_write() loop conditions
 - Use min() instead of min_t() since both sides are unsigned long

Samuel Holland (7):
  riscv: jump_label: Batch icache maintenance
  riscv: jump_label: Simplify assembly syntax
  riscv: kprobes: Use patch_text_nosync() for insn slots
  riscv: Simplify text patching loops
  riscv: Pass patch_text() the length in bytes
  riscv: Use offset_in_page() in text patching functions
  riscv: Remove extra variable in patch_text_nosync()

 arch/riscv/include/asm/jump_label.h |  4 +-
 arch/riscv/include/asm/patch.h      |  2 +-
 arch/riscv/kernel/jump_label.c      | 16 +++++--
 arch/riscv/kernel/patch.c           | 69 ++++++++++++++---------------
 arch/riscv/kernel/probes/kprobes.c  | 19 ++++----
 arch/riscv/net/bpf_jit_comp64.c     |  7 +--
 6 files changed, 63 insertions(+), 54 deletions(-)

-- 
2.43.1


