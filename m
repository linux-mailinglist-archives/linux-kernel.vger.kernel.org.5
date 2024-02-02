Return-Path: <linux-kernel+bounces-50146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8F98474E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942B1B21133
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A01487DF;
	Fri,  2 Feb 2024 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="szB/kNWD"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF461487C3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891688; cv=none; b=ecCz4ZrqN/1FgXqmn6xFeMqfZgmxuqA0C+S2pJRK+uLoiHuGoMVasF8bZTfIsSytltmv+Zfppzzsu6JqHg98xFpE+8O5a3lawsh5p6ZdlM1faW3b0r2SA0JK00RJ9ukR/GIke2p2w67AXcP88OSkJK/LwP6CQE5VNwpB3HxcWuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891688; c=relaxed/simple;
	bh=+v1TZF2URicEdYFQLC2qCb57HIjFgUlWEfgDgy3fcIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tnRlFQKEQmXcQgZ4u2LZPLpeCySEBxtEZBoSUJp3FIWd9xkecF1g/24wMFKwrY0E7RJ/3weo1t5RsnYSRoac5UNVCJkqKaLebuROHLlUvkL5c2ZlDlEAr3R0wdyZn/aPj4WRVXDgO9S48oxn6tFOV06cm9miJ46nIvFbSZT/IWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=szB/kNWD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d8ef977f1eso18314475ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706891685; x=1707496485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zdXQdXt7uLhKSI5m7G79mULu/VguSqRuThE3UzF0G/M=;
        b=szB/kNWDzAQIVgS3oUNOCGjtj3CEu7vg1kpIviotUksxSakMzSRWEzahbTPGuZeDzG
         oLniVkn9YHe4g1KAerTVesWb+g/We8k3isiu0qRUzs2RaCTxL2CybD9uTeb+a1hYDfkr
         9PJAl6tNtn7zR/IAjeX2V90bESl4cKZvkr2YqMi5H+JRM0ncu2bZApLTWca0DCbV+q/7
         /T0twG0I5dBTcE4iLnetY5s3PKecL/CyhWv3CCdUheFennhehwyGA93TXTi87g6I3NpG
         bzsEeZP2TfvMTurrWv7yH6uIL5npAXeKDIMLBVSsfXcUE5jnGgt+fvqYsoiULq+WmaaD
         NA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891685; x=1707496485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdXQdXt7uLhKSI5m7G79mULu/VguSqRuThE3UzF0G/M=;
        b=rAOXF16Lp/FPC8M6ufPWdvugLzBk5+DfheoRBLyFPKNlNFZxUAW9cyiF+1UrkVVg0t
         BKWGq9up1zBzWfzhbI7kavG2mZ1d/raFeKJ/BzuZmf8I1su0xCMAkcv4YHa2pU05Qbpv
         22lQ5WB9irwd26F28D7G95gATiQRFex6edOX2s5WriHdpOnuiOd82jv2rM8GO/k/J48r
         6K/mST6ez6fwBphSiQ61Xbo2FaLtU1s6KvJtSxoWHq4Pf9nCVBOvMG1VREXN1gGs9Bxp
         NPEu912XvigsLqqpmDsUfP/6mBeNoSfuF49TglG/LoVvLloJkJWNreXvnL4Jg9d7crkD
         DXcw==
X-Gm-Message-State: AOJu0YycectRiX4V2t0Vw323j5fks/vRftWGMPRPkdrZFXJO3mpXm1+F
	9yuCPweOkIgqZWdb2lydilV5SFSr6DyiNWP5WACTqFjU/3RS7jg/onWQWPDKZSU=
X-Google-Smtp-Source: AGHT+IGeSXexknJyqCvxmwiH4L2JVOdEJAH5LevXg0Rh8dfbIrxux5chSbtz0h0DsQdD5qCN3QQDlA==
X-Received: by 2002:a17:903:32cb:b0:1d9:6091:6f3b with SMTP id i11-20020a17090332cb00b001d960916f3bmr4721097plr.47.1706891684987;
        Fri, 02 Feb 2024 08:34:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVqKdY77sH4w/gkgczn3OarUbhZoeewIrRVoedcjoAmpjy2EH+uuY1EUYIhfWI+JJqio+FklxQl1cB3xtxG4uHlt7uG5w2uVyoK08N64wTmY9ggGPUC4khyuhLoXSSaR3gl8O4yqPnNHGFN2yb1OgBwCPFDfETYS3r+yVfJV3L5S/2Hv8vXEiAY0AJncaVFLy0F6jA6ymeNnJQJePdLRpir1N3kZ5q37J7r1diC2vku+m06f8Uq1NHv9cmGmScGAx+ePj6Q4VKXQBjr
Received: from abrestic.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ju15-20020a170903428f00b001d75c26e857sm1784870plb.288.2024.02.02.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:44 -0800 (PST)
From: Andrew Bresticker <abrestic@rivosinc.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH 0/2] efi: Fixes for EFI_MEMORY_SP memory on RISC-V and ARM64
Date: Fri,  2 Feb 2024 08:34:31 -0800
Message-Id: <20240202163433.786581-1-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small fixes to enable the use soft-reserved/special-purpose memory
(EFI_MEMORY_SP) with dax_kmem on RISC-V (and ARM64, I think, though I
don't have a platform to test it on).

Patch 1 fixes a trivial integer narrowing bug. Patch 2 prevents adding
memblocks for unusable memory (including soft-resreved memory) so that it
can later be hotplugged by dax_kmem.

Tested on a RISC-V platform that presents a range of EFI_MEMORY_SP with
Bjorn's MEMORY_HOTPLUG series[0] applied.

[0]: https://lore.kernel.org/lkml/20230512145737.985671-1-bjorn@kernel.org/

Andrew Bresticker (2):
  efi: runtime: Fix potential overflow of soft-reserved region size
  efi: Don't add memblocks for unusable memory

 drivers/firmware/efi/arm-runtime.c   |  2 +-
 drivers/firmware/efi/efi-init.c      | 12 +-----------
 drivers/firmware/efi/riscv-runtime.c |  2 +-
 3 files changed, 3 insertions(+), 13 deletions(-)

-- 
2.34.1


