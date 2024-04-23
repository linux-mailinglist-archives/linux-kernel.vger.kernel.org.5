Return-Path: <linux-kernel+bounces-154677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5506E8ADFA3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FDC1F21ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B326851C59;
	Tue, 23 Apr 2024 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X08769yh"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677232B9CA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860624; cv=none; b=B4I6eS5jwa7JZh48/OE8+Vb1DxSBtm/llKP4E1Y1SVzsTWnWPYcHckjsCaUHfptdpytCwIYL9JUHro9qkRq5al3+++8ob0RljkVX85pnEtI1nMZLrx5A1k1V13M/g05GqtSYbKXZb3C4eAqJd2oIiECTSsapkaCI8gt75CHWJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860624; c=relaxed/simple;
	bh=Rww7TxuzQROoyZ+YFLTo/PMMJ6PyQ1PTF3vLyCFRV18=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XmnZ7zKdlQt4a3OzUUO+8gFG9pdHikTOaQSdJLR4azNGRW+Yi9mE1spr7mOF486iJaKWU6Bi8R7t1dkATC4F+MbDycgfEmQlf2yAvb32Wnu7fdsaLFfHSjOALhcaXiQOQZO365CEjbq5m95jKdWIqPLBr3hExyysNOt4nhKqVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X08769yh; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-479ef9db155so1654776137.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713860622; x=1714465422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hvJAvOkdB3nYgeq28VFan9zcQ7TGjXgnfVwBWPnAFoU=;
        b=X08769yhmUijkihDFEUaufF6DQiWlJhzFzKo20S7e6YoGeFUJwvdLfHl/53VV7Px9J
         LS5sQsFhcBtOcu4c0paC2YV6qDQEP/Fp5IeNMynyuZZ8IVq9F2wqTRuivWGBuXn3Mi0L
         l/JrUaaAn3dDhe6iKipAfNw7tKkJvTppfo5MHYqIF6RA6xYioxHQ0tqnjBdTfz3tlcmm
         6/souTIbVAx1L15vtUHFQSgj9+1eCWTgSLcrJGnri2wvd2C4wp0kUdIxacjDGcJ7TmcU
         LVbvgWgIOhYJ/5p/oWVMTc5l88h8AMmcWw8hSowOEyQ9usI/UmuoBtrIh6sqzw7Koo4O
         EadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713860622; x=1714465422;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvJAvOkdB3nYgeq28VFan9zcQ7TGjXgnfVwBWPnAFoU=;
        b=pib7qqpMEw33YdySjFdU9zEh8EtAS7zBhA06iNTUSX6wJ92mhEL0W/U+POjgrQHSMs
         pBBQRPknxRcNPSND8+OHTl+Vhu3tfIfSMihsZiypIOli8/lMb1VgJUvBM5quCQpLK8UX
         sGgqyGFp5WicGXTjhRTf2spKEFILKFkGb6jXodWyVnI4Zmj2NsD865Uuli9JXdUbvNlD
         653Ni1Ebx4QtyskXYPFndzCpLmVIGT8h4jypNVSW5rj0J6ptc8nyZoCvrWiVBa44+hwt
         1o7Uuun69HRapjUKxGBKpOnt4N4GKYX/+SsvKmoYLG6sasUgyHyc2yF1PtG7lFVhwwUE
         oMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyveHZi3M5g0mORqbvXm+x0qD2CY9q7BYyoaGl+kFD7MdWFSw1soDltToJ2oskGejPjVJTJViA3icpaKK1fr9MHrTGDH4jVwkZnElQ
X-Gm-Message-State: AOJu0YwHIXc50YGUT7EuTrAejRbfKhIWV5L2Ou635yWOqCLydw8zhZ2d
	YAce+M96+MUpk7FBNAG2Eu082ba+unxpRy8HpDz5YD087WcXdQhsu9NkIsK8PE0HXicEliD9Dae
	WRAk7XsU42XdAlReQ9TeyQ6uWJAMRAntDgicsQg==
X-Google-Smtp-Source: AGHT+IETsHlsYMSQzlW7E1YI7QU+5izexDZQYyZejyzwsbgVBBsE69lGVvchijeB+ICSBsYB3Y17A9M/NOChyEX3VXA=
X-Received: by 2002:a67:eed3:0:b0:47b:ebf3:7c6d with SMTP id
 o19-20020a67eed3000000b0047bebf37c6dmr8185544vsp.27.1713860622320; Tue, 23
 Apr 2024 01:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 23 Apr 2024 13:53:30 +0530
Message-ID: <CA+G9fYuu0SApq057AMQmOiUC1upt_akKYfhu4BR+2BDkMoqs=w@mail.gmail.com>
Subject: mm/slub.c:3330:28: error: implicit declaration of function
 'node_nr_objs'; did you mean 'node_nr_slabs'?
To: Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Ard Biesheuvel <ardb@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm and mips builds failed due to following warnings / errors with
gcc-13 / gcc-12 and clang-17 on the Linux next-20240423 tag.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

arm:
 - imx_v6_v7_defconfig
 - orion5x_defconfig

mips:
 - defconfig
 - ath79_defconfig
 - bcm63xx_defconfig

In file included from include/linux/export.h:5,
                 from include/linux/linkage.h:7,
                 from arch/arm/include/asm/bug.h:5,
                 from include/linux/bug.h:5,
                 from include/linux/mmdebug.h:5,
                 from include/linux/mm.h:6,
                 from mm/slub.c:13:
mm/slub.c: In function 'count_partial_free_approx':
mm/slub.c:3330:28: error: implicit declaration of function
'node_nr_objs'; did you mean 'node_nr_slabs'?
[-Werror=implicit-function-declaration]
 3330 |                 x = min(x, node_nr_objs(n));
      |                            ^~~~~~~~~~~~
include/linux/compiler.h:286:55: note: in definition of macro '__is_constexpr'
  286 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) *
0l)) : (int *)8)))
      |                                                       ^
include/linux/minmax.h:85:25: note: in expansion of macro '__careful_cmp'
   85 | #define min(x, y)       __careful_cmp(min, x, y)
      |                         ^~~~~~~~~~~~~
mm/slub.c:3330:21: note: in expansion of macro 'min'
 3330 |                 x = min(x, node_nr_objs(n));
      |                     ^~~
In file included from include/linux/init.h:5,
                 from include/linux/printk.h:6,
                 from include/asm-generic/bug.h:22,
                 from arch/arm/include/asm/bug.h:60:
include/linux/build_bug.h:78:41: error: static assertion failed:
"min(x, node_nr_objs(n)) signedness error, fix types or consider
umin() before min_t()"
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~
include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
   77 | #define static_assert(expr, ...) __static_assert(expr,
##__VA_ARGS__, #expr)
      |                                  ^~~~~~~~~~~~~~~
include/linux/minmax.h:51:9: note: in expansion of macro 'static_assert'
   51 |         static_assert(__types_ok(x, y),                 \
      |         ^~~~~~~~~~~~~
include/linux/minmax.h:58:17: note: in expansion of macro '__cmp_once'
   58 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x),
__UNIQUE_ID(__y)))
      |                 ^~~~~~~~~~
include/linux/minmax.h:85:25: note: in expansion of macro '__careful_cmp'
   85 | #define min(x, y)       __careful_cmp(min, x, y)
      |                         ^~~~~~~~~~~~~
mm/slub.c:3330:21: note: in expansion of macro 'min'
 3330 |                 x = min(x, node_nr_objs(n));
      |                     ^~~
mm/slub.c: At top level:
mm/slub.c:3301:22: warning: 'count_partial_free_approx' defined but
not used [-Wunused-function]
 3301 | static unsigned long count_partial_free_approx(struct
kmem_cache_node *n)
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Steps to reproduce:
---
# tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig orion5x_defconfig


Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fUaQMPe7cZ5qJJOt50avspw7bH/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240423/testrun/23561861/suite/build/test/gcc-13-orion5x_defconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

