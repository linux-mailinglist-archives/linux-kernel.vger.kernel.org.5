Return-Path: <linux-kernel+bounces-45477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C3484313C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4F6282353
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA507D3FD;
	Tue, 30 Jan 2024 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ACEWrIRw"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349747995B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657247; cv=none; b=YIoy4M8NzoLrjiQhuZWmfqLfIi53TPF3Mz2kMmmDuK3mRb1WMsZdM1k6gxTfFy3BgmAX5dnpYI8plzppvFxYFQtNPcePKllO9+zL3LrQ054tBoPWaL5I2PhRM4+zhwkc+wxNn4EZn9aoAVrl4Xps0NIlW8LMPS5pGGTYrXiHc64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657247; c=relaxed/simple;
	bh=sOCwHJ8Q2pYqaViGMIp5ahANU0cmFlFhu0ydQtm2Glk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OR863OGSjaNezIKvXMSlVeOMJL4jgwe+xblj6Mvuz/aoZ4xIGHxfpj6WIkcBwWKDU8sxSwqjdhZPea1HOIpRl7a4DGyMqbbPfxLJMcLGaeboAz0atzyJJd2l53re1TcF19Ds+HbyllS32YtVgS8Z00P2dOwcvDlpYgGGcysn7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ACEWrIRw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso2594582a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706657245; x=1707262045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTXXsmwzTjPyQq0o9yr9KqNZv5QrGu6RUP3Khobjfp4=;
        b=ACEWrIRwGv6nXMKTzmkIjh31/SKyfkyTGjGBnuH3/lktt0Tl3GSBGpLDmoBWTpd/bN
         yK/Hb13sXMN/4c/GWpgQfbKGKGDa2iTSmYb62vS30LhnlyeQXLNpXCKhDyS9eJn8uoti
         TxIg+52E3x4SjcXv6q2L6KRQTfzZB/+XumgfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706657245; x=1707262045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTXXsmwzTjPyQq0o9yr9KqNZv5QrGu6RUP3Khobjfp4=;
        b=X14bhDZI/38gPDGMy0VhXJFqU5hN0YlmNGDiL/1YEhDjvAHxC/VREVG2JcRCy4j+Wo
         BD5fOrLf8YWGzg3i0EmvEtGKzHqfiKPSzelrbCs4+Jpqz3Zv16FqPMIinBbA3T52mgUV
         erODhhvYx4VJkARzS/dBpaL9WAoarU3QwD536cUDg/eDjm7UHXd8YBGhIkhOXx0QjOhD
         mEPAqLzFAeXcNkcdFYhrD0nMCwsJyRPk+5y80YAZpQhXAPvjyivSunuQ8+izUqC3UuNC
         wB3+CCTI1XN4EiV8Yw09nbTy11PTsgvg5e5F/qQuDoAB9oaukE5gXqqmkpNh9nrBMlu6
         LXIg==
X-Gm-Message-State: AOJu0YzhHFAE70evtQMRato84pcECFcMSovRnxdlwH2ASMF528Bvb99h
	WWGq6u3xnT5ntQL40YNXYDmrhj/LzQuAV6rkA0pir/B6KhR6bui/0pl1Sle/OQ==
X-Google-Smtp-Source: AGHT+IGCwsMMiN0BtC8YHTfKJ6KWrH0Lo33ohm42Z2CFNJgfmm1TAWJROBMu2J7IWq6ySVlvYEa6tw==
X-Received: by 2002:a05:6a20:4d93:b0:19a:508a:7f70 with SMTP id gj19-20020a056a204d9300b0019a508a7f70mr5160379pzb.30.1706657245557;
        Tue, 30 Jan 2024 15:27:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXXjT7jAns/aN2p87T+txOMPmldkeF5dTU38Qoz/OnAQZBVKzp+ZEKsoHBXtNdK8V91h3dl3e0v73W9fr4Iig+Ay1d/qEszLvBbBFPFaerwIgEqYYeZhGB76+WUcGf4jTC5SbQBG2cyIRYNoN64XJwHtqDWSO0x7ZDK3+bGOTfeOYsKKqeIyZPnQi7yIxO1IoerDlshlkFQNJkWVmu5QjLz1hl41VzqLRA3x9hnh/GzcNie2j5f+bs28Ei2Z1+ul9g8hpKywRWIEqBYsAp3SI74Q3h5jL9kXhUUIHpZdZ992XWmG6qqo/HrRkIhNw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902b60d00b001d75c26e857sm7646222pls.288.2024.01.30.15.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:27:25 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <n.schier@avm.de>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] sh: Fix build with CONFIG_UBSAN=y
Date: Tue, 30 Jan 2024 15:27:23 -0800
Message-Id: <20240130232717.work.088-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=keescook@chromium.org;
 h=from:subject:message-id; bh=sOCwHJ8Q2pYqaViGMIp5ahANU0cmFlFhu0ydQtm2Glk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBluYXbYzMwvQzdjb4LcQVxPeQiFyjaVT+WJc4sp
 l/6tgT3hKuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbmF2wAKCRCJcvTf3G3A
 JnubEAC1rdcv4mXd5Kmfw9RTR96KqhlOzXKsoSCQanjkimlERYXY9Zbr7+F0nO7Rcy+HL0sN42L
 HxNNvF1WpJM9Id4eCbxOBP6rPWCXAt+FsD47sETq/ckp9EnQESMOKNIamMkvOfh1gnNU7JMaEMF
 WJP0uxTKNN+FDY7QBq7khT1XfluHcDmSsBKn6XxS9sfkzb2JOkbGyYZ+eJx7+pP9THs04Pv8jLt
 GlLswu6HU6Je8vHJlkGH6oNFzjVLjOUVSspo7i0AwOt//pb13qzn3sb1G6TQMK96GJRZgbeEDQK
 +P9Cu47L3h2il/lpLq43gLCdV9HRCL8dROb8gTH84U+UXMM/7jvTsLrCbWJIC3UUeEAGP/WHHlu
 W8c8dYNIi8OX9D+63rGA6LHv287P1n3wOcMRxI3tAJIpTNd4THib8DIomIjO9esIEvBGaUnuEm/
 Iv6FV0LbnN8Cbhk7YcovFlcr3gg7uz+GX5J6UJUiaPcUj2/P7F4xvVgASCF1cgkCBHJLW4VNEAg
 R2w8HW7UYVD3JT5hvmVlpzAo13D5SC9Xyd3vFqex7KMcT5QP0Q2e2OL8rS4jrx2p2I/OEvtC6kU
 TCSal4XF0gQfvR5J+xOtJDdv9vuQUOmIBYFg4SlcZGqYI+bFAMcp8hKhTKVJ4l+naLk8sDL2IAA
 0JimCo7 8nxXvC9w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The early boot stub for sh had UBSan instrumentation present where it is
not supported. Disable it for this part of the build.

  sh4-linux-ld: arch/sh/boot/compressed/misc.o: in function `zlib_inflate_table':
  misc.c:(.text+0x670): undefined reference to `__ubsan_handle_shift_out_of_bounds'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401310416.s8HLiLnC-lkp@intel.com/
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <n.schier@avm.de>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sh/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index b5e29f99c02c..6c6c791a1d06 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -12,6 +12,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
            vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo $(OBJECTS)
 
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 #
 # IMAGE_OFFSET is the load offset of the compression loader
-- 
2.34.1


