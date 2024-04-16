Return-Path: <linux-kernel+bounces-146557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C238A672C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67B51C21479
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914C585948;
	Tue, 16 Apr 2024 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zi0gv0rF"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D28085291
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259986; cv=none; b=fxbf3R+aftgHgxewXykoBZbXn9KDVbCxzLquFhcm6J79VigqiS9nEZ05uCmvdvE5mL0r29RWOT3IT6z9iIhljWcX9vDugDWEduLzEt7RhNt7RP8Hx98/U9onqyjlyBQbSBKv2tYhkmWGEUd7iP8isfWzTxvUs+T5tEifu33oodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259986; c=relaxed/simple;
	bh=0Gl50EmCLVOMt6kqv6vYCIWrekR2zOz/+FuL5NWpOck=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RBcFZ232fLyKIAOCPAGKZPBPznKEOIBLeCBAHDzV3UFcjUsK93gCul/yNXJ0pzM8yCUbFaTZUVclGG1yn60WRf3yUlf686emEtzxA7SgCMqa/OTej3JUFApfNIpKAx1881EUDNCgp/VUdvbP/DbZP1VQyJ/HT1fGK/LvYVh6N9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zi0gv0rF; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4daa8e14afbso1378460e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713259984; x=1713864784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ndrnd625fhH+o+1Q6bsYpoaFuC2gIYmA4glyfnWSIIc=;
        b=zi0gv0rFcFHpeVzSvAnEkOZYSw3kWnzKjhntH1ZEt7gib2GxVunWldFFwt7dQBB84T
         BCz72A8o4V2bk5Bu//f9nz0KPl4XxpTYd88CsodYsGwwBXqjnwgEcpf7qhPYsegD4mZY
         PWA1OYMXoWGxJ/Xa1dh7Xq+ti/vhss3X2BB31vrPzKanr+HyIPGIUDJsJmoizhL+8Gtp
         YcBUQsPZYNw91iD+2I6zVicIKd1xEZ9ki4U3yCiZMCNLP2wCivqHU6b3RcI3KoDQ2D2L
         83qqHOUxN259pa3fhJulaN/zTU8q7XTGfpSumtkn49iiMeLk/4f4XQx7Cb991S8iLJe2
         6w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713259984; x=1713864784;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ndrnd625fhH+o+1Q6bsYpoaFuC2gIYmA4glyfnWSIIc=;
        b=Lg8QsdvzpynXs0fvrAHxbqiTqiW8N/F9zE7yp0aMn5h7Z+WlOwZUS/iI8HHUXZOZdp
         dYHlPlGzzHNt3HGAf3Sh9jRURLuEQErwbjEJhZfj1w2hTtj1Vcn/f5a53MEZVIh63F+s
         ldhze1Wi1rgS+pgnfaJVMf9hmipVdYCP2NxwNuW4aAhUfqD8I2SIB/AZm0+sMmh0WC/z
         wWFHNhaww+GZpc1/Niy3/71cS2xE21xlVXzj+Ko4tGQlS83XgrQj132/9XXMDipTsVu1
         vgfjDneh17GeRvmPjRbbZoXnMpCwA6KDRRUQbOZ4tvokmEKzWT7h7IwJ1n/dpUb0TCXl
         ugKw==
X-Gm-Message-State: AOJu0Yyrphm7BtAIvVSJOM8Qp7kshGAJZEqHVeKd+aze+rQjLZ66zDIM
	W3FpEbahFuNc22eEqP/sJxVPWj+7OQbpROu9czZaiuzbGJmBx6n1S64jfLR1Bk8+V4s9TsCU4gx
	qqEpVTEiyHtSXd0zH+vZVyzG1GVG65rfMaYujWO2ono6U/UGcrVY=
X-Google-Smtp-Source: AGHT+IG8D9vuAHmYC+KaM43JW5eMv7zVIbneQHVp8QBSV8dIrkMNPPOSsaQF76mhGJzEt5W5Jxc6s2f74IzVPZ0IMx8=
X-Received: by 2002:a05:6122:31a9:b0:4da:aabe:6f6c with SMTP id
 ch41-20020a05612231a900b004daaabe6f6cmr10367344vkb.7.1713259983821; Tue, 16
 Apr 2024 02:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Apr 2024 15:02:52 +0530
Message-ID: <CA+G9fYtEh8zmq8k8wE-8RZwW-Qr927RLTn+KqGnq1F=ptaaNsA@mail.gmail.com>
Subject: powerpc: io-defs.h:43:1: error: performing pointer arithmetic on a
 null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, clang-built-linux <llvm@lists.linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Jeff Xu <jeffxu@chromium.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

The Powerpc clang builds failed due to following warnings / errors on the
Linux next-20240416 tag.

Powerpc:
 - tqm8xx_defconfig + clang-17 - Failed
 - allnoconfig + clang-17 - Failed
 - tinyconfig + clang-17 - Failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
--------
In file included from arch/powerpc/kernel/ptrace/ptrace.c:19:
In file included from include/linux/syscalls.h:93:
In file included from include/trace/syscall.h:7:
In file included from include/linux/trace_events.h:9:
In file included from include/linux/hardirq.h:11:
In file included from arch/powerpc/include/asm/hardirq.h:6:
In file included from include/linux/irq.h:20:
In file included from include/linux/io.h:14:
In file included from arch/powerpc/include/asm/io.h:672:
arch/powerpc/include/asm/io-defs.h:43:1: error: performing pointer
arithmetic on a null pointer has undefined behavior
[-Werror,-Wnull-pointer-arithmetic]
   43 | DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   44 |                  (p, b, c), pio, p)
      |                  ~~~~~~~~~~~~~~~~~~

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240416/testrun/23495171/suite/build/test/clang-17-tqm8xx_defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fAvI3mKJ0dTHcazPrLl2zNF9JO/

--
Linaro LKFT
https://lkft.linaro.org

