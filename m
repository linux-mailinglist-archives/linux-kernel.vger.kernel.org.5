Return-Path: <linux-kernel+bounces-84182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C886A36A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F1D1F2E2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06935786E;
	Tue, 27 Feb 2024 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mzvh7WgO"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4D57863
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075685; cv=none; b=ZFXtozy9IFiLuwDDY9SAvn9WoKO528OIbW6NKHldZmJOXSY10bwkFezy5Bt2o/hWwWKiw7kOlNohRAJrlEcTsBesyIcGKibT8X35Vony0ryIOGh5m261ryk1QbNZ5hNqQBZFWAAjoLlbmgGjP6nzjGp3Gj3pYwcKwao3xtQQdwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075685; c=relaxed/simple;
	bh=V19HUq/JemRqcELPHFwcZliVz8Klrd9nqh2ouMM+iVQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TTiCqWxV+iCBr0V7/b2CjuOwx/a9O858yNPSujVDskrSexSxCBp9foR4zF4yLHp1bXN8RdG+8lwO1iE2/ZdVp/DH0+n1MgeJXseOBoekoFkUtbD7f9gP6bAUoisO7Q+HwtnU+Wap7vB3XXBCqq2SPtJ19GsV6MMywYcNf9MU5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mzvh7WgO; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so3899488a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709075683; x=1709680483; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOwhG/07dg+gcX9xrTrFROvlLzGJhL4J2NDKYOWOnRM=;
        b=mzvh7WgOci9K3fVMGmudX17syZPpkcgNcp4Vz073PnD/hY/UapmBLYthjIFzGtscWI
         mxpBT5S6V6pXJf/asXD8NcTbJix2rOJkS2wdAashFsH0YtwN2/gn+I6Ryrinue5npyFz
         eblalI5bABSblUmfh72kDv8wcRX5/ACYRjxEjE1yb2UheSqfmlgm0l0c4igJQh/CZlxF
         H9aVBe2PtLjSfy4n/wmx/z8amiQkZHipGIIjtS1ph/lWV3DXYmjK+iZC4Pxl8muZx7cU
         YLlZRQwWOX6yd0EEQLCrq24J7kyc2dh4+HJ3A6ifbwHLhlC+zye8P0MDuJ3bnbOZsdC6
         Jc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709075683; x=1709680483;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOwhG/07dg+gcX9xrTrFROvlLzGJhL4J2NDKYOWOnRM=;
        b=dsrxIaMKHDWP0hr6W2gl2YIn8yFKTN/9B40cY7q8WaB6552qQ1qe34tR9JkjUegHUJ
         ReA/7QiYGQdS1O1AmFhfyy0GyIC4+ZyWYfwe4tjG67Bq4VZhUPByklvsfgA8FTHnknmZ
         liRemMiBECBaaUfHn6mvQ15Zhe7zjkJorc9HXfoHNLskIAEO3tXbpNkVehUh9EnV6APK
         ayaTJ3aVdoFmUpSlI23Az2CcT4R3xuuhd+J4AfHXuxQntg2kYuJvYBqymA2m0cZfp+Uf
         gmref/vnjeaPA9Z27YxNS8kp8M8FwRt1/CLtbXL1U8sT/y0nGmurh7pIoaidZwadwWgq
         scaw==
X-Forwarded-Encrypted: i=1; AJvYcCWMQbhK6x7g4QC4C7lmy3im673nI73IkfKGVUG4Bj9WtcXYdjhZwnZUUshyQkgnIMRv/OaN7qqqXW0SWUGPZxajyEjQSc94KfsBZzSb
X-Gm-Message-State: AOJu0Yw2zNzFGvO19OCE8WgYkcEm1V/9tlTSv2Cp/rWXUfYunFDgDP6B
	dipmZ+skW8gdviS9abwidnT/RPDRugP5IeslTLUF9e3QL1XXvZFc+Rb46hLdGMU=
X-Google-Smtp-Source: AGHT+IHssyVg1DjomAETOfWcmMnS8hOYo64YOhc2SMJJP7+Aa1K8+N+lOeeJNPKYw2+Y917lPIUQGw==
X-Received: by 2002:a05:6a20:c68e:b0:1a0:df5f:99cb with SMTP id gq14-20020a056a20c68e00b001a0df5f99cbmr3609699pzb.27.1709075682714;
        Tue, 27 Feb 2024 15:14:42 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id l9-20020a635709000000b005ce998b9391sm5455645pgb.67.2024.02.27.15.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:14:41 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v5 0/2] riscv: Use Kconfig to set unaligned access speed
Date: Tue, 27 Feb 2024 15:13:12 -0800
Message-Id: <20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIhs3mUC/43NzWpDIRCG4VsJrmvx9/x01fso5aDjeDKQaNAiL
 eHce002DSWQrIZ3Fs93ZhULYWVvuzMr2KhSTj3sy47B3qUVOYXeTAllhNSSB6rOH3A59nugNWF
 YTiV7XCCnSCsXRjt0erRx1qwrp4KRvq8LH5+991S/cvm5DjZ5+T5vN8kFn6cgrcUZgpveC7VcK
 cEr5CO78E39kUo8QapOjiPoYfIYRq/ukPqWVI9J3UkwJs4yCu39cIc0N6QcHpOmkwGERDtJEA7
 +kdu2/QJF4sz9ygEAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709075681; l=2131;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=V19HUq/JemRqcELPHFwcZliVz8Klrd9nqh2ouMM+iVQ=;
 b=voRMT+T4E4Amqngh/Ts1I/w5hpMDAjgLL2GVHpkeTAn1nZRTQZ+YySoYOa3gUGKJ8BeDXxAAc
 c8IpIXzHWJ3CglX0o3xFRdHHGMAZrzC5AKHY2vPZBx7ByVdiyiiAyqa
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

If the hardware unaligned access speed is known at compile time, it is
possible to avoid running the unaligned access speed probe to speedup
boot-time.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v5:
- Clarify Kconfig options from Conor's feedback
- Use "unaligned" instead of "misaligned" in introduced file/function.
  This is a bit hard to standardize because the riscv manual says
  "misaligned" but the existing Linux configs say "unaligned".
- Link to v4: https://lore.kernel.org/r/20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com

Changes in v4:
- Add additional Kconfig options for the other unaligned access speeds
- Link to v3: https://lore.kernel.org/r/20240202-disable_misaligned_probe_config-v3-0-c44f91f03bb6@rivosinc.com

Changes in v3:
- Revert change to csum (Eric)
- Change ifndefs for ifdefs (Eric)
- Change config in Makefile (Elliot/Eric)
- Link to v2: https://lore.kernel.org/r/20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com

Changes in v2:
- Move around definitions to reduce ifdefs (Clément)
- Make RISCV_MISALIGNED depend on !HAVE_EFFICIENT_UNALIGNED_ACCESS
  (Clément)
- Link to v1: https://lore.kernel.org/r/20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com

---
Charlie Jenkins (2):
      riscv: lib: Introduce has_fast_unaligned_access function
      riscv: Set unaligned access speed at compile time

 arch/riscv/Kconfig                        |  47 +++++-
 arch/riscv/include/asm/cpufeature.h       |  43 ++++-
 arch/riscv/kernel/Makefile                |   6 +-
 arch/riscv/kernel/cpufeature.c            | 255 ------------------------------
 arch/riscv/kernel/probe_emulated_access.c |  64 ++++++++
 arch/riscv/kernel/sys_hwprobe.c           |  23 +++
 arch/riscv/kernel/traps_misaligned.c      |  54 +------
 arch/riscv/lib/csum.c                     |   7 +-
 8 files changed, 173 insertions(+), 326 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240131-disable_misaligned_probe_config-043aea375f93
-- 
- Charlie


