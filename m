Return-Path: <linux-kernel+bounces-144932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CA88A4CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCE1B22354
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD145C8FF;
	Mon, 15 Apr 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgCYMAmR"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85D5C602
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178035; cv=none; b=OHANVa7eUmIAsloWQdph9M0U9VQo/XUqYRUgNVn3DRAqWhD5xOs/T4/edq7x925QeyLVWF9vms2a9d1Fmen6tzJWOGZj/V9Cykahj9UTuT+ihq0BWchZi0fX3oHpN5NrCNI0+OxAy0cRjqn1+useBqokvWohebsdMlmHIll0eX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178035; c=relaxed/simple;
	bh=W2Fbao+/FlwxfuGH1OFvZW2kvHWXUxBXy9sroyi2Gh0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Xui0O0wHb4NcFBnBXc75ikFYpAs9P4Yam3LfJHCnyYI0LIZlRhPZgcoUzovm8distMAJI+3X4zlaLWBz7R1eR0OpFfwLOF2imPfpkna2Ce/Sv466A7OsA7GQvP/DEfG4OyF5qkAdm8v4UP0foJZmeySSv6w2OUR/0FitjUANgGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GgCYMAmR; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7e3e0b2f653so867035241.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 03:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713178033; x=1713782833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5kbitX8QbhgxnsV5uCd0z4f/iShjUxkr6d7+ekg5tWU=;
        b=GgCYMAmRx3oR3IwqHhCAAzppu7jBJndHHIemaE/dDrZzLwIbVz2vSyEF1fwNwlKi3J
         unT4b+vNvAoA4N9fYO+ohqdbZdjzuRcpwdWr0e8BkJLMigBH+mj+W3OLCwPKuQKPs1MU
         mlFY98HFmeBDcjeq7tsb8QsSK3eVGT42mspwhODnm/o4Pd2eLBW53LKYTsC39ciJ83Xb
         lCDCSNqeulGVBve5ayyfZeE9nKJvjXCK2cfc54jZc6hmQz4EF77isuNHYelB6OrDy22G
         1/wQzu4cKh17DK13euQVm1e8bwCF1HZ/K6Eg98bibP4us6Tl0Y5ltPdapOEAqpKVom9u
         c5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713178033; x=1713782833;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kbitX8QbhgxnsV5uCd0z4f/iShjUxkr6d7+ekg5tWU=;
        b=Qh43rkDRGAjM68oTofJDxsuaWqsAwycTmNRXoWtAJA0wQB/DpGcVSnhPwzDnARu126
         40v9k8k1RNLZFmBApYcAtKKQvi89lbsTDunmgfM36de2ZngB6t1Fz77zTrqpow5RdI1z
         ymwEN3nqbt+LSe+SBD3jQJ3WZIS73+HPztEN3LB1WRRl3cMR2LGRvkjz9pz/Wuj+37cl
         DfSaaehdCoXcW1E7unAnjth9P/1V52JAdyq+P5sgqIw3fHGk1TlZuUKzr86fkkEoEXJK
         ogie5oKEWfu12h7J55v2y++zOp/ODKdEjT0MZp9afYQMtqlVDZr0xAy5m2KxpR0VpS9B
         hzsg==
X-Gm-Message-State: AOJu0YzTnlbb34MX1vDZqCHv8zDDxn4bdJV895DP77j47alDAnDo7jFc
	oRg2Sej61WNelU/ctpPPPp4SuZoPoCyvq2C4Nyg2tkrELT3WGblxBkaHNipEgMjmme4EAXqiCN9
	NPePYZc/YZ0uz7ZtPk2ZJOQq6rWfjTvHNdLG11BcTR8HKaMHNk5M=
X-Google-Smtp-Source: AGHT+IE4veDIOcK0vTkuxFAc8PebEblKLgDeLZg7etQEi0PYMGKyP1c0eS0dCvLk7/PMRnxeklqAIbshIYBCJ0ceNwA=
X-Received: by 2002:a05:6102:3590:b0:47b:8ef7:bc1e with SMTP id
 h16-20020a056102359000b0047b8ef7bc1emr175678vsu.15.1713178032756; Mon, 15 Apr
 2024 03:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 15 Apr 2024 16:17:01 +0530
Message-ID: <CA+G9fYvMdqT3BFNkspktVVtVqd=en8-x3Oz1Ekfia+cceV2LHQ@mail.gmail.com>
Subject: sh: arc: cmpxchg.h:50:12: error: implicit declaration of function
 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>, linux-snps-arc@lists.infradead.org, 
	Vineet Gupta <vgupta@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"

The arc and sh defconfig builds failed due to following build warnings / errors
on the Linux next-20240415 with gcc-9 and gcc-11.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Following builds failed.
sh:
arc:
 - defconfig
 - tinyconfig
 - allnoconfig
 - vdk_hs38_smp_defconfig

Build log:
--------
In file included from arch/arc/include/asm/atomic.h:13,
                 from include/linux/atomic.h:7,
                 from include/asm-generic/bitops/lock.h:5,
                 from arch/arc/include/asm/bitops.h:188,
                 from include/linux/bitops.h:70,
                 from include/linux/log2.h:12,
                 from kernel/bounds.c:13:
include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic_cmpxchg':
arch/arc/include/asm/cmpxchg.h:50:12: error: implicit declaration of
function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
   50 |   _prev_ = cmpxchg_emu_u8((volatile u8 *)_p_, _o_, _n_); \
      |            ^~~~~~~~~~~~~~

Steps to reproduce:
---
# tuxmake --runtime podman --target-arch arc --toolchain gcc-9
--kconfig defconfig
# tuxmake --runtime podman --target-arch sh --toolchain gcc-11
--kconfig defconfig


Links:
---
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240415/testrun/23463978/suite/build/test/gcc-9-defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2f7sIl2MlKB5Fgq7JtTpYQ9lnXw/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240415/testrun/23463981/suite/build/test/gcc-11-defconfig/details/


--
Linaro LKFT
https://lkft.linaro.org

