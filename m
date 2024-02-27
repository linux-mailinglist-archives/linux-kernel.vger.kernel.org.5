Return-Path: <linux-kernel+bounces-84213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7B586A3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E351F24709
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7AC58AA5;
	Tue, 27 Feb 2024 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dee6SEu1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205D58200;
	Tue, 27 Feb 2024 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076363; cv=none; b=M+r5NZnDC304gH8yyuzwrfpJltmaDoAAS1nAEcG2Cvj1LwaNqUPFGvkNO+38FkWTMyrn9/baSr0ByPMCYWMZPU7nBy8Qkg/V1Z6mcRCsVf2M6rchffXVGNoWbsOf6InuOG7QvEVVqF3efiZNJvQteA8c+yOmumbE5rnkj584N5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076363; c=relaxed/simple;
	bh=Tp8rWEr1rnHxEgpzoTs6Z3OgfjHycVn0XPEyGG/4U+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKkHzeTJKiSyzX1aYpmAW5q8WTs0tZVjzdxvi93yYu3vRcai2vRgF82LuKmn5wvJdqdl1tkISK17qxm+Uinek5e6/+k+8V/6u4bPwXNEXm1owXRmk+QmFTOyEWNkqyNtwnZhORro/4P0X26fgwVScq71+qhPP6hFjMwYpZCdMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dee6SEu1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412a4055897so22415055e9.3;
        Tue, 27 Feb 2024 15:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709076360; x=1709681160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+U6e0phb4FgWhT3zKWvXHaHdGTpTD7AGlAcNzesxbio=;
        b=dee6SEu1Rj3tF9Xf3lHamRK/NuDWYgiQeU6B4JX4N6F0FCiKlbhiaR715LPdPStpOx
         tNXtj1wHCUNiNj9ffuxA4SieGMp9g68JBJ40Po4EAn0NVXPy7xLbsSfM0KSCBO+r+Vgu
         OIEbLab7PC7MDGe6QXsGkLravOb3vUycS6VsQu1LFg1nqfJsmYWOyKDKW/GQBTKvF0CE
         O1fy+CC1y8OE2ueNUh8dxI7t0jj/RBMUg3EteMTdXzlJ+KksjV6QZFke0fi9tVxuaRP6
         47+nw15ysQxqMn3ipjg9DvhB0YUScg883RIE3+CF732R1gHenXOpS7joCP8axJsiUicL
         3g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709076360; x=1709681160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+U6e0phb4FgWhT3zKWvXHaHdGTpTD7AGlAcNzesxbio=;
        b=e+5Smgi7aa6NQR66t7kkicOhSl8SnzI1hXJhDxxY+4XN42dFUb8w2X5iOJGf65LqJV
         8aESAVYVAvigoW2/m+9IAKt0CN/wYqBOgEWUEpASrFcaGg0VkJNMAV/NJnSwV88i+wai
         b0ZlzAdct6t/gk+i+DnAb2gMmZOxn3CoGtlslNNMfiITodRlfaijI0BdLNR0gwIAQ2uB
         0NLUPbsFhf7/tPcAAtSMwxh+STysujmYTOsoz8Ob9A/7kBB8m4PYkfdLJY+9tO9L9e6F
         Zj9WxtGM4Ix7AOsDMfWrBL5lCaCde8cM8UrNCFR3MOEfs4+JFoNcaGFnDcKUfoxoFMts
         owrg==
X-Forwarded-Encrypted: i=1; AJvYcCWEoflQPpWn3VKukmdF8/c5j1a+X+zT9BLXbEBusQ8cuf089Lqv/9TRVAgFOwQ9uZPkMjV6y4pMzeUJXfITPchG+1P5ZqS/aQgNDoV/AvFcBZ2ESDumW3HRc+tgiHemEQf5w1uK80gY+OFQXEpv8imxmr/QJxH3Bll4BkTbZFuV/C58rxFxVN07yBB5
X-Gm-Message-State: AOJu0YxGVxTXa3nO6TsAOcrucNvQcCu6Dkklnf6izkZITGxxMigYQCD8
	18W/R35V3HhrVaUEtzGMcxDBxoDwVyn7PWunAG3pHORR9uD48dmq
X-Google-Smtp-Source: AGHT+IEHa7nviaWP61Ygi9mGdFibcMp0zVb+oNZbOlKrT2Rpg7THVXPa8w9z5UssLoXFj6dnNJn1Rg==
X-Received: by 2002:a05:6000:4012:b0:33d:d82f:cc72 with SMTP id cp18-20020a056000401200b0033dd82fcc72mr5736069wrb.51.1709076359481;
        Tue, 27 Feb 2024 15:25:59 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e6a2:98b:e06b:631a])
        by smtp.gmail.com with ESMTPSA id co22-20020a0560000a1600b0033d96b4efbasm13014444wrb.21.2024.02.27.15.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:25:58 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/4] Add SoC identification for Renesas RZ/V2H SoC
Date: Tue, 27 Feb 2024 23:25:27 +0000
Message-Id: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This patch series aims to add SoC identification support for the Renesas
RZ/V2H SoC.

v1 - > v2
- Replaced RZ/V2H{P} -> RZ/V2H(P)
- Included Ack from Krzysztof for patch #1
- Included RB from Geert for patch #1 and #4
- Dropped extal_clk node from patch #2
- Used small case for hex value in patch #3

v1:
- https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

RZ/V2H boot logs:
------------------
~ # uname -raLinux rz/v2h 6.8.0-rc6-arm64-renesas+ #229 SMP PREEMPT Tue Feb 27 21:11:51 GMT 2024 aarch64 GNU/Linux
~ #
~ # for i in machine family soc_id revision; do echo -n "$i: ";cat /sys/devices/
soc0/$i; done
machine: Renesas EVK based on r9a09g057h44
family: RZ/V2H
soc_id: r9a09g057
revision: 0
~ #
~ # cat /proc/cpuinfo
processor       : 0
BogoMIPS        : 48.00
Features        : fp asimd evtstrm crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 1
BogoMIPS        : 48.00
Features        : fp asimd evtstrm crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 2
BogoMIPS        : 48.00
Features        : fp asimd evtstrm crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

processor       : 3
BogoMIPS        : 48.00
Features        : fp asimd evtstrm crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp
CPU implementer : 0x41
CPU architecture: 8
CPU variant     : 0x2
CPU part        : 0xd05
CPU revision    : 0

~ #
~ #
------------------

Cheers,
Prabhakar

Lad Prabhakar (4):
  dt-bindings: soc: renesas: Document Renesas RZ/V2H(P) SoC variants
  dt-bindings: arm: renesas: Document Renesas RZ/V2H(P) System
    Controller
  soc: renesas: Add identification support for RZ/V2H SoC
  arm64: defconfig: Enable R9A09G057 SoC

 .../soc/renesas/renesas,r9a09g057-sys.yaml    | 51 +++++++++++++++++++
 .../bindings/soc/renesas/renesas.yaml         |  8 +++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/soc/renesas/Kconfig                   |  5 ++
 drivers/soc/renesas/renesas-soc.c             | 20 +++++++-
 5 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-sys.yaml

-- 
2.34.1


