Return-Path: <linux-kernel+bounces-32180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1878357BB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC3BB2164E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19F3381DF;
	Sun, 21 Jan 2024 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAXNAELt"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65271111E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705869026; cv=none; b=SKXvEdP1pY581IUj8Z6VT0BLKi/Ykq7ods8lKBQYW6nq294A35W8C/rlaWIhwR5aE669pZUpcWDSrypOl60AEIsbTFu7Vm4AGsIzmRpXOpZmajy9+GAI98MXivjf/PvJDcj7RBxWlXHkkFu7qbJnTGj6moGsw+hQjBTjt6ZHEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705869026; c=relaxed/simple;
	bh=2/1fsYmKDZN1wvsh6DuQbpj2D7/RgQxj/Mhh3EyrEQQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HXqzJdYmwsww8TQ/s1xtDCWr7rYJUsnVLBG6oVucy+ZwUw8Jj5ZQLpLtBBSINr7hyWfoCv94NQgmuedLVtlG2dzHhaXAwuMcI2mvCpBX/Pkxj/R0jgozOMp57GHHKGNe09wHNs/dJCwSJk2lPILZ1exfANhznBLTGLsNFiO6wo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAXNAELt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so28919335e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 12:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705869023; x=1706473823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kWLX6UP/f8j7PC87iA+ocN+7ezu0AHr8NQjFXggguQ=;
        b=IAXNAELtmIyIig/TtYDftZgN3brWTtUt3P7JD+RDkOgf8pApgrYbxC0cABQsYYkTFo
         DOY/Kohe//abeGFAfe/m74x08xh2RLlruWVq4kkyfRgvcP9JT1EokW0/pV+Tev0fTLLH
         9377i9h4nrzv1GVzZXlU6sgPqj0FIjHeWIwwaSo2brttteV5MWKMQcVo/27r3+pEhh9q
         2RWM3lMS5welNdwGdOaUN4hhiBYCQph6059jEpTktbVLqzWGxGSrVwyA9NS1pEH2T+Q5
         bIcEJ3KX1D8squYVathnj1wqdGPJERqDuvX5zKLNjDj2nTY6Fj6dB/xRScRUpK7vHecn
         mM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705869023; x=1706473823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kWLX6UP/f8j7PC87iA+ocN+7ezu0AHr8NQjFXggguQ=;
        b=FJO9tRnsUObjeOCc2N7NwVhKRy9xhpKVK9L5Y5EE77D3jNuG6ki9lartni6UQm/vU8
         VnyMDn2JE1aJePUFBb2x89UfsSP1Sm90HflDDoJHwLJXLohRfXryOdxm/iBYSK/fnkPJ
         zkcU4hNjgkoL1raa0dR6wFJk/TjWl/muDYdj0UhVslsRyedxOUxzmw+oYCN1dzO7fgaA
         k62I/swlHkjyxeUokp1KGaRam8YazDRoFoI+hdCH8scpwpFiKGV/tHm9FDPeLAJKOi8O
         SSbime6maFKRDN10HHNTAgMIJxKd4MmNyGwxF8S2eAcjA09e8F8qXNHXSYmwhZDxJWWK
         2c5g==
X-Gm-Message-State: AOJu0YxOA6bRRwFzFCJEwWxh2aZN9yLa3Ywysf5ODDUbAmvvHuC0BZRE
	p5K12tQYhaYep5Jbc4YRN9JgHCmE6vNvOOOCiV8LMktAKfHl/Pve
X-Google-Smtp-Source: AGHT+IEfYnzr4yVRgG6iZg16P/KMLlpVOmCErhK0dUK6S5bUecgiMXK+wucZ4OO1xL/VHTPmYNPPkA==
X-Received: by 2002:a05:600c:2d11:b0:40e:6247:5f7 with SMTP id x17-20020a05600c2d1100b0040e624705f7mr1681171wmf.45.1705869023163;
        Sun, 21 Jan 2024 12:30:23 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j5-20020a05600c1c0500b0040e9f7dadc6sm9021967wms.25.2024.01.21.12.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 12:30:22 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	John Crispin <john@phrozen.org>
Subject: [PATCH v2 0/2] ARM: decompressor: support AUTO_ZRELADDR and appended DTB
Date: Sun, 21 Jan 2024 21:29:32 +0100
Message-ID: <20240121203009.9257-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series try to address a long lasting problem with legacy device
that require an appended DTB and the use of AUTO_ZRELADDR.

With these device AUTO_ZRELADDR is not possible if for some reason at
the start of the RAM it's needed to reserve some space. (example qcom SoC
that allocate reserved space for SMEM)

In the current implementation with appended DTB and AUTO_ZRELADDR,
the memory start is only derived from the PC register and it can't be
changed by declaring additional info in the DTS.

In a normal setup, we have an intentional undocumented chosen property
to handle this and the memory node to declare the start of the memory.

With this applied and ARM_ATAG_DTB_COMPAT_IGNORE_MEM enabled (more 
info in the related patch) ipq806x can boot right away with AUTO_ZRELADDR
enabled and a correct memory node defined in DTS.

It's needed to ignore MEM ATAGs as most of the time the values from the
bootloader are hardcoded and OEM didn't care to actually provide them
resulting in funny situation where a Netgear R7800 with 512Mb of RAM
have Uboot passing 1.7GB of RAM with ATAGS.

While MEM ATAG may be broken, other ATAG like serial number or bootargs
might still be useful for partition declaration (cmdlinepart) or other
info hence DTB_COMPAT is still needed in these case and can't be
disabled.

I'm open to any suggestion on how this can be improved and I would love
some additional testing on other legacy platform but I assume this will
permit many legacy device to be correctly supported without having to
hardcode address.

Changes v2:
- Add Review and Ack Tags
- Use IS_ENABLED instead of global variable

Christian Marangi (2):
  ARM: decompressor: support memory start validation for appended DTB
  ARM: decompressor: add option to ignore MEM ATAGs

 arch/arm/Kconfig                        | 12 ++++++++++++
 arch/arm/boot/compressed/atags_to_fdt.c |  4 ++++
 arch/arm/boot/compressed/head.S         | 22 ++++++++++++++++++++++
 3 files changed, 38 insertions(+)

-- 
2.43.0


