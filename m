Return-Path: <linux-kernel+bounces-41534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB9B83F3F4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 06:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D00F9B226AB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16D5748D;
	Sun, 28 Jan 2024 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8VtzQrj"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9F63DF
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 05:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706418367; cv=none; b=IW5hngbw/+NNPUtDzA7SthUAswkx2Qu9V1kEPSNdMyJDiUXjO6PhRpxhMWLvpKLrtotUCAHB8FpVIWH9QfjEeQ5xcrnhOda9KCJV5zbwuTV63WiNtilEHMJ+0IPKR+04XnR6ORtZO9lkMVQdy5C15TyF9kS1wqSujAwWRLgOIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706418367; c=relaxed/simple;
	bh=woUTGpV2lL/Prio24DhLsAC1y4k4dXyC3Djn7wPcNNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwFMx8XqBUqWvWGRWJsjWDQidEG3fZ09eZr7sZHNfjhCL7yFZqdUg4uFIJrDfQk1y4x0h/803VCRSE9GYwZWwyQBb8aOYEvIMGNgyXsttZW70irWHFcem/ulaByuPymPOuHfoMBYnGDOnSa76dK4eimif7ZKXp+2/+q2VpjzOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8VtzQrj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6de0f53f8e8so505360b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 21:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706418364; x=1707023164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq/z7gzXK8vY4MJq5h6j8eIlm4yN+X+iR4tLkhOxEwY=;
        b=P8VtzQrj2aMFNhWpJXZZnaeXl2DaGVYDIwbyWC0AP/lmDRjhRZHqBACwNmunlRkSEF
         jHP3UOkPg/SLMhzeKQwrnqPtTFkI6QqkotjZPjIxx+wb1UM2cax6DwS6M17OWhxd5rPD
         HNfRnHylIfeV1RodC4B0YyrI3b92h4cZ4EZr2fvu+4SsEdOFjaywMqeuvEHnaPsuKn98
         8dIfnqQuIKB6w0KGwozgCDsv0ZvNYA5o7SHqCS23WRMLLyNGPlzJU2KWSvXNkXbskBAm
         ieFz1eJ+bWUI8Su3MBqXCsulY6/YqpG1wWi+l19WvbYkdalNUAsU7kI4ICMDbLPgKRiW
         bm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706418364; x=1707023164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cq/z7gzXK8vY4MJq5h6j8eIlm4yN+X+iR4tLkhOxEwY=;
        b=bDHhbylaLUFL/URtT+fsbqsZXAGDghnAzswDGX4QPKhZfM3dEhjZFOuoLqoV5gad+7
         nkabNiJLKUAxSjQqsSLxAwYuvLiYzvI5SC3t1n7gdIR8UMd+wbR1p5FoYTnIC3vq8hwU
         znHQ9Aw57KyhnfTb6eyPM7/TZhgQXAEHUvaaEuTlPCL0kJtqmFdSti21AjfZWrayZhOT
         6wof2UEiVxCwwZaQCLX7PDRfcZfqcEVQNIrt6p9zDWrIIC8QcViF7gqgeK0q916LBec+
         sAYqAnw5JO4GQI8wKHeyeAkIedo8vCgJbNGTJczkbGHUjYE5gQn8116C0Mnkd+xC1Hg+
         cpAw==
X-Gm-Message-State: AOJu0YzDvADM7YW8Od7Q/sxHAZOPWeutO30l7lFDW0VXrJSpwvBH7LKP
	cPWs6lJzb7H7Yr/iPoHqjbo0S1nTwL06OGtT5aV+BNtf+6sjTf50
X-Google-Smtp-Source: AGHT+IHlaF9aAss+wN3s/ZF+gmHMOoO6NWHBaUA46qNNRgoQwLErqdMCz/eggLIziRpdriVL6IV3Wg==
X-Received: by 2002:a05:6a20:4caa:b0:19c:678c:6d37 with SMTP id fq42-20020a056a204caa00b0019c678c6d37mr2616311pzb.37.1706418364398;
        Sat, 27 Jan 2024 21:06:04 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id lp17-20020a056a003d5100b006ddd182bf1csm3550372pfb.46.2024.01.27.21.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 21:06:03 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marco Elver <elver@google.com>,
	Brian Cain <bcain@quicinc.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	linux-m68k@lists.linux-m68k.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 0/5] bitops: optimize code and add tests
Date: Sun, 28 Jan 2024 14:00:06 +0900
Message-ID: <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a compile test to make sure that all the bitops
operations (namely __ffs(), ffs(), ffz(), __fls(), fls(), fls64())
correctly fold constant expressions given that their argument is also
a constant expression. The other functions from bitops.h are out of
scope.

So far, only the n68k and the hexagon architectures lack such
optimization. To this extend, the first two patches optimize m68k
architecture, the third and fourth optimize the hexagon architecture
bitops function.

The fifth and final patch adds the compile time tests to assert that
the constant folding occurs and that the result is accurate.

This is tested on arm, arm64, hexagon, m68k, x86 and x86_64. For other
architectures, I am putting my trust into the kernel test robot to
send a report if ever one of these still lacks bitops
optimizations. The kernel test robot did not complain on v3, giving me
confidence that all architectures are now properly optimized.
---

** Changelog **

v3 -> v4:

  - Only apply the __always_inline to the bit-find functions, do not
    touch other functions from bitops.h. I discovered that the
    benchmark done in the v3 was incorrect (refer to the thread for
    details). The scope was thus narrowed down to the bit-find
    functions for which I could demonstrate the gain in the benchmark.

  - Add benchmark for hexagon (patch 3/5 and 4/5). Contrarily to the
    m68k benchmark which is with an allyesconfig, the hexagon
    benchmark uses a defconfig. The reason is just that the
    allyesconfig did not work on first try on my environment (even
    before applying this series), and I did not spent efforts to
    troubleshoot.

  - Add Geert review tag in patch 2/5. Despite also receiving the tag
    for patch 1/5, I did not apply due to new changes in that patch.

  - Do not split the lines containing tags.

  Link: https://lore.kernel.org/all/20231217071250.892867-1-mailhol.vincent@wanadoo.fr/

v2 -> v3:

  - Add patches 1/5 and 2/5 to optimize m68k architecture bitops.
    Thanks to the kernel test robot for reporting!

  - Add patches 3/5 and 4/5 to optimize hexagon architecture bitops.
    Thanks to the kernel test robot for reporting!

  - Patch 5/5: mark test_bitops_const_eval() as __always_inline, this
    done, pass n (the test number) as a parameter. Previously, only
    BITS(10) was tested. Add tests for BITS(0) and BITS(31).

  Link: https://lore.kernel.org/all/20231130102717.1297492-1-mailhol.vincent@wanadoo.fr/

v1 -> v2:

  - Drop the RFC patch. v1 was not ready to be applied on x86 because
    of pending changes in arch/x86/include/asm/bitops.h. This was
    finally fixed by Nick in commit 3dae5c43badf ("x86/asm/bitops: Use
    __builtin_clz{l|ll} to evaluate constant expressions").
    Thanks Nick!

  - Update the commit description.

  - Introduce the test_const_eval() macro to factorize code.

  - No functional change.

  Link: https://lore.kernel.org/all/20221111081316.30373-1-mailhol.vincent@wanadoo.fr/

Vincent Mailhol (5):
  m68k/bitops: force inlining of all bit-find functions
  m68k/bitops: use __builtin_{clz,ctzl,ffs} to evaluate constant
    expressions
  hexagon/bitops: force inlining of all bit-find functions
  hexagon/bitops: use __builtin_{clz,ctzl,ffs} to evaluate constant
    expressions
  lib: test_bitops: add compile-time optimization/evaluations assertions

 arch/hexagon/include/asm/bitops.h | 25 +++++++++++++++++++-----
 arch/m68k/include/asm/bitops.h    | 26 ++++++++++++++++++-------
 lib/Kconfig.debug                 |  4 ++++
 lib/test_bitops.c                 | 32 +++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 12 deletions(-)

-- 
2.43.0


