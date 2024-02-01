Return-Path: <linux-kernel+bounces-48017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC60A845648
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFF91C22B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134BB15CD6A;
	Thu,  1 Feb 2024 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9nADXxR"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1146F51A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787143; cv=none; b=WLo44bqo/jLrqDdvMDRHx1Yvf6ePeaqWvtkSJbRzmA9ZmBSNEIK/OmgqQJrdFis6kFLoq4FzbFMleGg+CuiYjCVHFjVvwkb0ZnEotBvQlzVPWZBOE1YIzYz23VeTrw5IxUwPniTNHgeyI7hqLiG2ak54TWYlfy8YW00rizkhSjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787143; c=relaxed/simple;
	bh=+JCXQ/F5lEphfjTu5WTd25Ol8SqJqt0VAt5iHLuRepY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XxNHgS57SRQoKAd4loBToG8WoPEnZVBiSvyQyc55az3fko1BErMBgdhOZI0creMNxv+R4dZ+PHRanGSj3ZJEoOHulbSTSSQr12dquzmoTh3G2Q9SWXvjV34Cq1iK4lk5LS0gfYXTe8cCwq+SsIuofjvkYvHD6bTxpm3SOGVau8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g9nADXxR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68c794970d5so4512916d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 03:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706787140; x=1707391940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uOIkFgtn+5CGBhF6IYD+AtjX4nq3rhY5L7Cp0vY+fM0=;
        b=g9nADXxRvuEMqGrDd8HUsGNP3chp37TPsqPtW7Nhjk85+XYBTamsPmidSqxN3ut84H
         4IPUGEWUkrvygLwZwfxoTBfcEAa+0dJ+AqEtB8uyGAgGFxqUeg1utm8ghT3Fh05i6SCD
         5TTIX7dMMsEbzCsVfeb6KHaui7Pje/UU1XukLOAXO4f7q1FCxZtsxWrOSN0JMxOtGfRY
         gbRpvsdsgTyyWxBi2CGc8WzUnmczM3+bRGGz+LdKVOMKHWMh1m581H7hu9GlHE9gahQV
         lteyQk8ydeR981PTbOIOSKmkVCM/apRMXHwb7qULC3FnE3wxvX6keRdcDpI5RpTmmPcI
         U6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706787140; x=1707391940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOIkFgtn+5CGBhF6IYD+AtjX4nq3rhY5L7Cp0vY+fM0=;
        b=Q07/fc4R/6XzqT30hm0vvfcQTnl680v5dg3x1DlNZRaswOwnaTfFZUi5qoEpwN/wAT
         8ZSSZXJxaB+Cebgs2SP/iGaJ4oNu1xELFKVZcrGDwZUuBY8auyQodWgo8tiP8RKvc9hD
         Fu7mMQ9m7bse7TE1zoo9/n3tyZVv0fvtOk5930uiRD1L8cbqT6oXv5d91pWZMrwKDemD
         GAX8zWkNRuysJrgddzkvJhPfLfyekQRr5pTehWUkbpBXYXWAZn02t3kNUsEKHHcEo8q2
         LfEyWfeGCxNJcMJ4rUhOx6FJOUWlNUhYvWZZwBK/uC/u/niC/nqzF68UFwtbSyoktbM/
         Rq9w==
X-Gm-Message-State: AOJu0Yyv7yhsJCJZXHEzVpmvaKFjyiAkJI9c3zjIkpcDqGKoBcPnz9Ka
	YXKGiWHHtnjx+IhEr6FKXmfHECnADn53XvZF9Ddf6YFoYEjNNZ5IBLXdtbQAuMIwZJy/vqVwFFA
	VUyNoQ/2ZMCQaGICMiqVGXrm1q29/RmCBW8m0cQ==
X-Google-Smtp-Source: AGHT+IEn/DdYnb4HbGcodvZpVi0fy3Ok/BebPtt2rZ4aQx47747TBTjBGaYePw+Arowpy/mNwi8CPKs2RWowIN2yRxU=
X-Received: by 2002:a0c:b456:0:b0:68c:5149:7619 with SMTP id
 e22-20020a0cb456000000b0068c51497619mr7887302qvf.24.1706787140649; Thu, 01
 Feb 2024 03:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 1 Feb 2024 12:32:09 +0100
Message-ID: <CADYN=9+DUzu6xEThaWQKp0udCsPs7h3XijyE5zmn-UYG8oM+AA@mail.gmail.com>
Subject: Perf not able to cross compile
To: linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, james.clark@arm.com, Arnd Bergmann <arnd@arndb.de>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

I'm trying to cross compile perf ARCH=3Darm64 on my x86_64 host from
linus tree [1], branch master.


This is the failue I see, full log [2]:

..
  CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/staticobjs/el=
f.o
  CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/staticobjs/fe=
atures.o
cc1: error: =E2=80=98-fcf-protection=3Dfull=E2=80=99 is not supported for t=
his target
error: command '/usr/local/bin/sccache' failed with exit code 1
cp: cannot stat
'/home/tuxbuild/.cache/tuxmake/builds/1/build/python_ext_build/lib/perf*.so=
':
No such file or directory
make[2]: *** [Makefile.perf:678:
/home/tuxbuild/.cache/tuxmake/builds/1/build/python/perf.cpython-311-x86_64=
-linux-gnu.so]
Error 1
make[2]: *** Waiting for unfinished jobs....
  LD      /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/staticobjs/li=
bbpf-in.o
  LINK    /home/tuxbuild/.cache/tuxmake/builds/1/build/libbpf/libbpf.a
make[1]: *** [Makefile.perf:261: sub-make] Error 2
make: *** [Makefile:70: all] Error 2

Running 'x86_64-linux-gnu-python3-config --cflags' I see
'-fcf-protection' in the output and this happens when I'm building
cross compile arm64 on my x86_64 host machine. Building on an arm64
host works. cross compile x86_64 on my x86_64 host works too.

I have 'aarch64-linux-gnu-python3-config' installed but that isn't used.

$ x86_64-linux-gnu-python3-config --cflags
-I/usr/include/python3.11 -I/usr/include/python3.11  -Wsign-compare -g
  -fstack-protector-strong -fstack-clash-protection -Wformat
-Werror=3Dformat-security -fcf-protection  -DNDEBUG -g -fwrapv -O2 -Wall
$ aarch64-linux-gnu-python3-config --cflags
-I/usr/include/python3.11 -I/usr/include/python3.11  -Wsign-compare -g
  -fstack-protector-strong -fstack-clash-protection -Wformat
-Werror=3Dformat-security -mbranch-protection=3Dstandard  -DNDEBUG -g
-fwrapv -O2 -Wall

I tried to set PYTHON and PYTHON_CONFIG too, but didn't work.

It doesn't try to use $(CROSS_COMPILE)python3-config, any idea how to
use the correct config?

Cheers,
Anders
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
[2]  https://storage.tuxsuite.com/public/linaro/lkft/builds/2bc6x6cISHzG9Jg=
o0oAVv2OgLOG/build.log

