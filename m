Return-Path: <linux-kernel+bounces-82468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DF4868505
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D1DBB233B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F2115D0;
	Tue, 27 Feb 2024 00:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cYyVNXD1"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B2437E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994195; cv=none; b=IzjJnubh0JBNjCyvf0JEyUpYfa9ztvVidgUDibaVNZH5RIdknKCwKDzlQSK8+TN6KydHhIm72S0UvQPy8dgzjlfKgIR5D/pIxX47kjJcj3LtolmKTGjKFR1s4sOcA86Db1ooeUe4/PwuFDii0UEOjr3roH1FQqRf/YDl8ZnPOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994195; c=relaxed/simple;
	bh=IXjp9ffzWGMlN6IdNxjC/u0dQ4UDT6IPvs9OH9Mcs5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s7YLG6cWfuDiqTE8cPQmk+kF9ZqeKWouY/8gwHeZtgBxjVSgbdlU8yuhIbgnC/ckCLC44K9XHsd0cpUcrIPzYOWf3AOY4NwE+0W1J+m2etW0Y6NkQ6SNrjU7pnLIAQx9xr/KFDZ4N8f/HXOb2EdqViWkOWvXnTrE/tYw1r9Gnuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cYyVNXD1; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22007fe465bso968178fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708994192; x=1709598992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gKpylQvY7fWF0HEhcpoV/u+3QY3QSMz3zE4Q+faMtfw=;
        b=cYyVNXD1F1RwCDYf8ksuvfh22H6rMhwcFSt6siQlvCq8KDnoZMFXuCtvVE7WJGBxuP
         ycW1F0vtLleZt4kJj3sdc3XbXht1yAqwXnQ0lZxYt9PDic0vKK/1kjMMiy9Klv9XzSx4
         4S1EpgfyE5o09SEVrYaSWbAJt0kag9Ww31zs6zvjgBGaTCuAdwEdY4q1Fu78qvc27H2q
         Q6gYko3Z9YjtR2S0hLx+ophZkQNx8pwGveJ+cO8/A4Fae5JX18vx61d5Urd/zBBKrKkf
         xyq/7ztNUFln7j/9Tm4rTqkoOYRG5ebt95zMIaybN/cc+0MkgqsQrTqrotr53kWBqnIH
         wx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708994192; x=1709598992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKpylQvY7fWF0HEhcpoV/u+3QY3QSMz3zE4Q+faMtfw=;
        b=LJdCUjb4FjgGgttkn65xTkGDwMbQq3LQB37kLsMKSizfsxGipPKhEnPiCBLcKw760p
         SSY2lJZdmfGJ7D20VAXaOUVFV3FnYxjTrHTsRykDnpIeVnHDLoxFX1/WX69uskpuKwp+
         1sLN0m0MBmmx2xbaBu5RNAKC54GgwAgfV0Q9VgqY/vs+fHbmlg2wzTXE2MxVBpQPK8r/
         qRAAv3wNbz4oYVJ1NJFflbOZCZ+gGis30BJxNu1OgIvhlFmzg81GSQ50uUE6b8yupePP
         iQPBq5avDpSs+3+oqU5OcGvA2SdlO3iF5MuQ6dPrPAHzcDfrWJ8pOgj30mlySuBybTn3
         Cs3Q==
X-Gm-Message-State: AOJu0Yw8YJKIZ3ZjLgKYG+Y58UizCqDOFR6Vgl8phdwlzc9TEwLvRs3e
	9AqIwTonxrWJ9oDByqhjEsq68iv9HKuIxCkcGMFqe4a0ZIJtGzk6vDmGS13DmuE=
X-Google-Smtp-Source: AGHT+IF8tWJd2eygIWIDlgPAqpdoF+Qi7wuIkaoa0or5Hh5ol/qnDbAz3ov/zNu7c3Mnn8M8tQ1D2Q==
X-Received: by 2002:a05:6870:d154:b0:21e:8424:8325 with SMTP id f20-20020a056870d15400b0021e84248325mr9458650oac.18.1708994192531;
        Mon, 26 Feb 2024 16:36:32 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id z25-20020a631919000000b005dc85821c80sm4504117pgl.12.2024.02.26.16.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:36:31 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 0/4] riscv: 64-bit NOMMU fixes and enhancements
Date: Mon, 26 Feb 2024 16:34:45 -0800
Message-ID: <20240227003630.3634533-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to improve support for NOMMU, specifically by making it
easier to test NOMMU kernels in QEMU and on various widely-available
hardware (errata permitting). After all, everything supports Svbare...

After applying this series, a NOMMU kernel based on defconfig (changing
only the three options below*) boots to userspace on QEMU when passed as
-kernel.

  # CONFIG_RISCV_M_MODE is not set
  # CONFIG_MMU is not set
  CONFIG_NONPORTABLE=y

*if you are using LLD, you must also disable BPF_SYSCALL and KALLSYMS,
because LLD bails on out-of-range references to undefined weak symbols.


Samuel Holland (4):
  riscv: Fix TASK_SIZE on 64-bit NOMMU
  riscv: Fix loading 64-bit NOMMU kernels past the start of RAM
  riscv: Remove MMU dependency from Zbb and Zicboz
  riscv: Allow NOMMU kernels to run in S-mode

 arch/riscv/Kconfig               | 17 ++++++++++-------
 arch/riscv/include/asm/page.h    |  2 +-
 arch/riscv/include/asm/pgtable.h |  2 +-
 arch/riscv/mm/init.c             |  2 +-
 4 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.43.0


