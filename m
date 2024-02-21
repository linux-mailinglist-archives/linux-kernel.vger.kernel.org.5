Return-Path: <linux-kernel+bounces-75000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92085E13D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6F21F25355
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEBE8121A;
	Wed, 21 Feb 2024 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYCU9UO1"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209E180C14
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529567; cv=none; b=S9M1D5CnPNqo5hvYS/Jr7lMbuSOgl1aVC3TwNVHOniFjWVySGHU1f15HMpwwV8edaX+J3fuxQLX7hOGvTaJCxevF/klD/BskzDQn8dk2zj/JTqKYlYyGjHt6CVxaWQ5pZN9FpM8LUz3wtdHo7gZ+pr25r0407COVsxFn9jPpP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529567; c=relaxed/simple;
	bh=y8Dc5zRviYFJTbHOro273wuf8Sz1qdtMgs7N6xJCV7M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=THxqi/YVc7u/8MjUKzlu4cFIr+Jl8AlD0g2LbaQ5KW77Zn+FtEJFnb0m5MaiayzBh2tyZI4DL/Phrgzt/cCrXLe0uaXU8KCzbnbkkcNDVfPXcjLvOIHQ3bZ2gY5KCqchDa6Cg9nYX7kbhBySap9IKMS937j5DQ+jXerijBUhjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYCU9UO1; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c15dd2a1fdso2356554b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708529565; x=1709134365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xoYMhckH3/qYBJk6QPSBgn05rtVqWkGGpi9nCOG/QGM=;
        b=RYCU9UO1l0W55yZWWYjjejS+CZScbyEGLVbPMp+jlWMgpH5wXEHcqqintU/AbEFcRI
         cN9j+5Me/dkEovZJujUu29vawCVNlCJ3yAmmp/nC9LIxKPMx2bJKWVtO5WEydgYpP8TB
         VT/vO21fjMMw/cl82lexAavdpoiuYuwQLBqZERkN27+DL9oHX/oHjFy47TL8Rwuxm5ky
         0EEJyE3yHdvo1mFkTrNKeAIPIWkzsF6Y25ImZh9m3m54wr0Lpw3OsgJjRdTQiit61+Qs
         o8ThURaKTGzhl2p83JR+7V6mGaV4PPV/9SMwSSb7CUvE+0z0u2VkHSXRgQH70nT8c3Uv
         XTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529565; x=1709134365;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xoYMhckH3/qYBJk6QPSBgn05rtVqWkGGpi9nCOG/QGM=;
        b=uc2FbxpuwsljYp/IWXHnGAinpD6YvPiXtEMCO94HMtbdYFaAmUCeDMeghGpzpsSqKI
         VLXX6oPjqEzRvNkcpcTXcJacOaVUQb0opjcoIkY20q3YScWF2SMDeJW3KaFAcUenSLhj
         9SYmCZEOq9Y2p9wKTEUniDDnTZxfhHYN89GsKxNc00ZT0pdD0lCkL/BBk4e0TnhVo/bG
         3tX8ShD2em4zZWmLYi+J/fuYqEdl/rW0CkKjTJG2VCG/eEeu8wywCFyOYfvMX0aEjK7c
         wkEcna73XkgRSDL4Vm6mv5jKoOrL0GkronKeLFPKNyJvKSxit0riMjb5tvWJ6D9OZkTj
         gLug==
X-Gm-Message-State: AOJu0YzvP6ZC91nSPB4hpD5vc9BudmnwyUIFGGLjplhAE0oup/DuBL9Y
	FFVEOoAY2S9LAC05GbWgB+3giILNKQlbzRUC7tkaxadikEOH0atI5gfi6JauB2XqNAZD+Loxq7U
	StZfHJfl90pAxEkwxIm2LxrCLWwAJPOd4kDz5eq1ZXG0Ric63H7Q=
X-Google-Smtp-Source: AGHT+IGEd/3frv8oBIS2QpP2iJlzQrrW5W3omJJrefDfl8H0DyloByN19XPLH8ziQWRuDIW7m0trozsRiPjRQUQeW2A=
X-Received: by 2002:a05:6808:14cf:b0:3c1:4109:d147 with SMTP id
 f15-20020a05680814cf00b003c14109d147mr15706704oiw.9.1708529564791; Wed, 21
 Feb 2024 07:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 Feb 2024 21:02:33 +0530
Message-ID: <CA+G9fYtNbgy7C0bFhsptk9HfE-kxPf+gEpviL4=o1YePoY8xSw@mail.gmail.com>
Subject: x86: fortify-string.h:63:33: error: '__builtin_memcmp' specified
 bound exceeds maximum object size
To: open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	lkft-triage@lists.linaro.org
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Hao Luo <haoluo@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"

The x86 / i386 compilations encountered errors due to additional Kconfigs
incorporated from the selftests/net/*/config in the Linux next version.
The issue first appeared with the next-20240213 tag. This problem affects
the Linux next branch, but not the mainline Linus master branch.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The bisection points to the following commit id,
# first bad commit: [64259ce2a20ce2dcc585a2cb83d1366fb04a6008] ubsan:
reintroduce signed overflow sanitizer

Build errors:
-------------
In function 'memcmp',
    inlined from 'nft_pipapo_insert' at
/builds/linux/net/netfilter/nft_set_pipapo.c:1258:7:
/builds/linux/include/linux/fortify-string.h:63:33: error:
'__builtin_memcmp' specified bound 18446744071562067968 exceeds
maximum object size 9223372036854775807 [-Werror=stringop-overread]
   63 | #define __underlying_memcmp     __builtin_memcmp
      |                                 ^
/builds/linux/include/linux/fortify-string.h:655:16: note: in
expansion of macro '__underlying_memcmp'
  655 |         return __underlying_memcmp(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Steps to reproduce:
-----
tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-13 \
 --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2cfazKeUY5ZIZx7MgVwRAYSVe4w/config
\
 debugkernel cpupower headers kernel kselftest modules

config link:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cfazKeUY5ZIZx7MgVwRAYSVe4w/config
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cfazKeUY5ZIZx7MgVwRAYSVe4w/

--
Linaro LKFT
https://lkft.linaro.org

