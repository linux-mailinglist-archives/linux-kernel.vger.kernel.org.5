Return-Path: <linux-kernel+bounces-31537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8270832FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860F11F21657
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C483657884;
	Fri, 19 Jan 2024 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj39tQy5"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F05788C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695253; cv=none; b=Nmc4R3c7eF2XuQI5EzLgU8ZhibBAS+3vgxgMLdTUvsOR/R+Pcs/K6pr478+VmiRAyL14LrOARVXmp1OJNcwLZOevS2vCT33kuo+FuoeY7hCDUYWhI0aB//fz1HPl5aCAD5QXwhU047arkA5sj4EJu3o0mu0MwcM7ChqNIxvLNIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695253; c=relaxed/simple;
	bh=3PSSN9zmx3qHvcJQwCDz4Bljr7sTESkoDwkyeh8+6NU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rh1snVfaGkYQWkkdXTtw1c+Ke5yX0U2IA4uND1gXCTh5AAL1z4LHw/s/Lw7zzORUzDUoiE0q5s8UABGmMwgxxC+z7508lpiuexCHoC1yQrH9pvQBoirIQpHyWgPIW5fw8SxLboFECRCjXOqa3QnkyuISublzfr5pVC76xpX4IYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj39tQy5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so1058770f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 12:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695248; x=1706300048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMGLhwG85B2w0NThmk2zDLj49Bo1ipFv4zuCwGP7AlE=;
        b=Cj39tQy5yMnyAbCiNO1Yp9mYGKqFK42t1z90cmheCcZr7iOfUPuQzpD5vCIAk4rYvJ
         XSC0l+51dbsyV7nth3i6PI/BtMyfub+sRudeTmp555iSFsT8P9szat8I0VaVOi2Qm5eH
         sXzUOpSf4oWsPfW+7X+WLF0mTb3Qvvz4k2/6Lg+BD0nj09gzn2i1WE/YiO5UCoIII9d4
         0X92vpT/DTfYLNoYrcS5+UH5Y0rr8qhHaeNhbtADJxuM4c9VaUwKsaTaI7l/cfAIvYXA
         7ZQrfVgstd+v6RwtFBenKk/eMwftq7qCj6W6CJhRS1SjE0iC7c6TLTTXZncmpejAT58I
         1feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695248; x=1706300048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMGLhwG85B2w0NThmk2zDLj49Bo1ipFv4zuCwGP7AlE=;
        b=EEQjTHzC1cRn4s8R+sHXF6fW+//dv5cvEaZao/v3bZlztD2SkhG+elwDJaPDPhz169
         pJLq8WzI4egMGhPyW3CiFQxj8gQNr7oavUT3eD1ZqTMfdBXekxD8bpTKANb+bPgm4EZp
         L/FkVvg3An7rU6fevgjDfx4ZNVXPYZAtJ7cBx5hYe0xkZ020BIGZp/qO/Od5Yd+ZzzHU
         AchKVpdQTlb5JowwyFPCQ5qerM2VK2SWUVtfgXX6LdH4EJr4gi3ElDCLzBVflhFTh8MU
         mavbfSvpQXpI3aJaVUEB52dHc7ZhA+rSQTZrGXgdiJhVa4uWSsRBioTT77+pM4wvvBcX
         +z6w==
X-Gm-Message-State: AOJu0YwDnA1rG+ZzEL+BQN3jCdPH2Rjxy3wUufr9AmRO+fZV9MKNbdbZ
	DWmyDOJ3NsIXsqc1vMnMBvdsBinYLZ2YWxk4ZVzMQ+vUURsNvntO
X-Google-Smtp-Source: AGHT+IGKrhhaNGUIfdV8IaXzr4TapkJavnd/VbMPYmXsGgBSUz+zxWC9LbIaz64fEZkqwJmRKMggPQ==
X-Received: by 2002:a5d:4903:0:b0:337:bc26:5d43 with SMTP id x3-20020a5d4903000000b00337bc265d43mr152768wrq.4.1705695248319;
        Fri, 19 Jan 2024 12:14:08 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff505000000b00339214d70b5sm2084788wro.85.2024.01.19.12.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:14:07 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	John Crispin <john@phrozen.org>
Subject: [PATCH 0/2] ARM: decompressor: support AUTO_ZRELADDR and appended DTB
Date: Fri, 19 Jan 2024 21:12:43 +0100
Message-ID: <20240119201356.7903-1-ansuelsmth@gmail.com>
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

I'm open to any suggestion on how this can be improved and I would love
some additional testing on other legacy platform but I assume this will
permit many legacy device to be correctly supported without having to
hardcode address.

Christian Marangi (2):
  ARM: decompressor: support memory start validation for appended DTB
  ARM: decompressor: add option to ignore MEM ATAGs

 arch/arm/Kconfig                        | 12 ++++++++++++
 arch/arm/boot/compressed/atags_to_fdt.c | 10 ++++++++++
 arch/arm/boot/compressed/head.S         | 22 ++++++++++++++++++++++
 3 files changed, 44 insertions(+)

-- 
2.43.0


