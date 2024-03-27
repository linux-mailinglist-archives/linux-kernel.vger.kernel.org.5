Return-Path: <linux-kernel+bounces-120668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6139388DB45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B971F2A110
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2E91A702;
	Wed, 27 Mar 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="rX574iRW"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0CB3DABF0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535497; cv=none; b=YB/9tteI/womq0Te3/mQFYdQvZITAxCzuxNuX+SiT5oCTedSVYf0sin9LaN9Sq6rZk0qzPWiUBlnu8Eg+NSzaoKKNTdojJ3AEB7znkSDyLhs25wrFqTG7TVQIl0U4txFDzuIckwtCdKsjoQHjk9/Ks4ucKFNF5pvh7WetfDA19s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535497; c=relaxed/simple;
	bh=xtpVMt94GrSHCZiPADIb9HDF3vKnlwc2ZyBzsAFK3ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Njic9C8Iv9m6HWkojgBHjR1oyw8FzoTkHtM3rZHvm0awjbMkJEBtCex7as8boX9yNXaDdaR2qnEKaDDXoKLjZEa83ijje8fH+5dx66s8nNrEd297Kl0uoUiK3Y8D8k8ukAivyjvdonjonspLTmqHsr7Z1dFKyAKzH32zqKG4pgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=rX574iRW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4a393b699fso115762566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1711535493; x=1712140293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KabXKG7QzV07xEnqAZlFM9GzBMwE9AX8NiZo1iI6OCQ=;
        b=rX574iRWsEV6iwDYtDnLgHge+4BJYVnKv0f5NxGQka7ULtYboOvdpM1UhYvsVPrcHj
         sPRbkrjA6zcomUTkEsn1hnW4HobcV/FULzhezxzvfy5bmp5DgMvquKz7f7a2qW50hs9j
         oPmxCK0GNPi1rY0DsRD8Q0jsUxfDdlHn4zAKl6fS+/DKBrAkMKWTNGScXa2yXkS6mFWk
         cC9tT/xaRdaMrEPLO12HvA6LW6nK2idOprp/2nxBHgIqwVOb5EAHFjij/C7TOqwyUlCQ
         Cey5f6LjHu3Hvz8bveUgCMwjlWKJoOZqTxXf6FvVBrrfQCFFHNwlu+x2IxSwcXwonozN
         ozBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711535493; x=1712140293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KabXKG7QzV07xEnqAZlFM9GzBMwE9AX8NiZo1iI6OCQ=;
        b=Ds2qF0R6S3AQZD5mCiOBv1m0x/yxbbhO8cV59KdsnQRFI+yuSYj8tjuIA8QY/cT5gb
         gdi149nC8PKm1TIuMMdmljqb/TP/XfXUgsplqCVsgLaygVq/l5Co+fWjF/7ZwsDjbx8N
         KTDnEEMXljLBBRXhw6+csGoO8GHh2soN9nXDY8tqVsjqhy/NKMCqsEPZQs6H9ECq8qp/
         MyEwtjTUYTXujqL2WZieT7YCEWdX+JVjlpTzMVUUPr9YXGemAzG5/ru8pN/Ge30VqApV
         C2gPL8sxFCZRs9mdz2mOdH+OVBrsIVmFPD/zV3EnTPpMttED5rKjqely+QX/EUet0eE6
         hq/w==
X-Forwarded-Encrypted: i=1; AJvYcCXKJ5CpzoUmC+1myVo8euVmLwnZ+Cd96XktWpRZp+Mz8Y7VuNl6g4Z2lLK3tGR4MTtEeoYUF9bY91ouZDnuth1zvEyctwF5e0JBUfiC
X-Gm-Message-State: AOJu0Yw/jXCNXaCV/KKTSlClKLZbvv8U9PuG6Boekk3M3jC8GYZUkH7F
	wTsDRi4lXfwZuSp5wcQRg9QFlJXbX8/fzJzhsfFnOD8CGjsTBBBreDx8em9hrgQ=
X-Google-Smtp-Source: AGHT+IF70lDcd+7mVT/V5sDOo51cv+JWRqcD4/cE8DYPzR0glhB/3uBYMYV3tk23Xj1H5yHPw4Xtaw==
X-Received: by 2002:a17:907:31cd:b0:a45:f9c5:3024 with SMTP id xf13-20020a17090731cd00b00a45f9c53024mr4156607ejb.11.1711535493584;
        Wed, 27 Mar 2024 03:31:33 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906270f00b00a46b8cd9b51sm5294078ejc.185.2024.03.27.03.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 03:31:32 -0700 (PDT)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Cooper Qu <cooper.qu@linux.alibaba.com>,
	Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
	Huang Tao <eric.huang@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH 0/2] RISC-V: Test th.mxstatus.MAEE bit before enabling MAEE
Date: Wed, 27 Mar 2024 11:31:28 +0100
Message-ID: <20240327103130.3651950-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, the Linux kernel suffers from a boot regression when running
on the c906 QEMU emulation. Details have been reported here by Björn Töpel:
  https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg04766.html

The main issue is, that Linux enables MAEE for CPUs that have a T-Head
mvendorid but QEMU maintainers don't want to emulate a CPU that uses
reserved bits in PTEs. See also the following discussion for more
context:
  https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00775.html

This series renames "T-Head PBMT" to "MAEE" and only enables it if
the th.mxstatus.MAEE bit is set.

Since th.mxstatus is only accessible in M-mode, this patch depends on
the following OpenSBI series:
  http://lists.infradead.org/pipermail/opensbi/2024-March/006718.html

The th.mxstatus CSR is documented here:
  https://github.com/T-head-Semi/thead-extension-spec/pull/45

The QEMU patch to emulate th.mxstatus with MAEE not set is here:
  https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg06368.html

After applying all referenced patchsets, this patchset allows to
successfully boot a C906 QEMU system emulation ("-cpu thead-c906").

Christoph Müllner (2):
  riscv: thead: Rename T-Head PBMT to MAEE
  riscv: T-Head: Test availability bit before enabling MAEE errata

 arch/riscv/Kconfig.errata            |  8 ++++----
 arch/riscv/errata/thead/errata.c     | 22 ++++++++++++++--------
 arch/riscv/include/asm/errata_list.h | 20 ++++++++++----------
 3 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.44.0


