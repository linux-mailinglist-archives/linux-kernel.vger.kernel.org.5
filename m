Return-Path: <linux-kernel+bounces-64070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F190D8539C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A569B1F2485C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD19B605CE;
	Tue, 13 Feb 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwzA4Nsu"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69439605BE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848497; cv=none; b=mvjyPb/PZv2AgGWTHVc9lUQw2QHQ9HL3TFTnoTFUBjwn0Yt6+jPGy9Q7mbRjGxnY08m8gsEvK8WlcBUNoI69ZC7WDagfv8ViVqhj8/UZnMyVSQdlq77AXPH627Kvnvxd1+SZlcegour7wjWJTpFNKLtxW69Quc1Cknu6bDufw14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848497; c=relaxed/simple;
	bh=hwajgSbZypT3uCqwUd9BeVCG81p8AYheELlUfLV4ojA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=atmROc6PZmESeEc6nMWTAzu3BFd78HnA86o/m5MQ1ei7Rj1C9Q7dJkD+8NH15QjutCbf8ztEK3++TTNOlMEtLS7G5WAWFoK+QjT1cdAM0VBs0oG9BcHtlzd0yAw1il9foxh/mHc/LTvjoWP8yZzkvmUk+TJ/xz1v9GCyAi7Y5eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nwzA4Nsu; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d5c890c67fso2224954241.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707848494; x=1708453294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p0gWEJ+hXgQI6y33M/nb2B6h4Ud8BJXSfxP0ajpNo3E=;
        b=nwzA4NsufnstvK6vhduQh3vqBPxMWePqMQ+zsED6m1QgNz1YqeiFnQxTvD87r9+0db
         wRw9Fhs1NAPpOOnB1XIknucZDGuhhvxeDClj8OZMGSUy6kzjKxikogX12r4dRlC5Bnfr
         U1iz2jGQ5boW7B3DmK2FxADC5ciunSQcRWgVgKoIDyqCJ22HYiKCAWFbdfBvRXcKNuK+
         6DXJ82vJGwDgFLXw9UsCjlAai//ZdglzMOoNgOsCzRTCtuMBc66Vg1B7YYvfBMH2jqDq
         p4eHiwUqbZwuBBC6Xrl8zxVdvS/ZH6MYjFVUAfFgc93LmgoJoooTV/3nMatsCCuLdZbi
         LneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848494; x=1708453294;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0gWEJ+hXgQI6y33M/nb2B6h4Ud8BJXSfxP0ajpNo3E=;
        b=rDySO2IwC2hIa0hNEzlIpTzcWyPhNV/kUQwvZexYNAW8evYP3CuemYnjLDhSOoAScI
         HaW1jqDT1FvigNOSdj+vZho9redHT5t4BHh5cze3wJO4lZ5c7BVfHFR6vj9iLxJNT/Wr
         aNqP0Y/ybVhTkBnFDgORZQrphlpehG57tOwjKEMLNY6lGd7jZ8S4aCfNwhi9mu71Fxrj
         cHMXyd0VIxVxP2ehfpE153Ot9ooHR+b0F1UNzKvykJbhIS/N7XDkJO4mJ4bFq8/hM4+A
         /X63rwnBuqi5EaJkyvz9Ypz9QZWQ9IjtI4k7AWKgJaXqHhligTOPdNUtVWbnVMjkoBrR
         MMmg==
X-Forwarded-Encrypted: i=1; AJvYcCXyfQbkweZsiLco4sGRKx62Bcwa7Q6Am5cuZcP9jqjd74mIPMzbPk4PV/I7AR2KcwFaipYvfZLt9KC+1z3RSCtA0Qs/kZ0jYJip/Yao
X-Gm-Message-State: AOJu0YzMzqm4l/+GdcHxkU9EHhc6faUjnKcbzhUKDtWqB091HCPgRMoo
	g0ZtkIpONJFNg43O1yMbGa7XVHLg0fELaT58FnLvKmAyw67ssHhigZVDEvIfdbteG3+IZf5PZ0y
	+NKaM09+qs8se5b2R4FNbspeiRTVkZ03wEb4Vsw==
X-Google-Smtp-Source: AGHT+IGmhU25oRCBMvi87vQXz5j+wxayC1GfXzxhpbI42FH/k5Xpj0vwSotgSlTsoBlE3Xvyg5Zd6UYFCnMRjdGj1Fs=
X-Received: by 2002:a1f:df03:0:b0:4c0:34e8:d55d with SMTP id
 w3-20020a1fdf03000000b004c034e8d55dmr356808vkg.11.1707848494292; Tue, 13 Feb
 2024 10:21:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 Feb 2024 23:51:23 +0530
Message-ID: <CA+G9fYuVJ3DfmOR2GxbVmLqh_d=3y_wTXX-vQOUgp86uX-3oGg@mail.gmail.com>
Subject: WARNING: arch/arm64/kernel/cpufeature.c:3369 this_cpu_has_cap
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Regressions <regressions@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

Following kernel warning notices on all arm64 devices on today's Linux
next-20240213 tag.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[    0.038524] SMP: Total of 6 processors activated.
[    0.038539] CPU: All CPU(s) started at EL2
[    0.038588] CPU features: detected: 32-bit EL0 Support
[    0.038602] CPU features: detected: 32-bit EL1 Support
[    0.038620] CPU features: detected: CRC32 instructions
[    0.038650] ------------[ cut here ]------------
[    0.038656] WARNING: CPU: 0 PID: 1 at
arch/arm64/kernel/cpufeature.c:3369 this_cpu_has_cap+0x1c/0x70
[    0.038691] Modules linked in:
[    0.038707] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
6.8.0-rc4-next-20240213 #1
[    0.038721] Hardware name: Radxa ROCK Pi 4B (DT)
[    0.038729] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.038744] pc : this_cpu_has_cap+0x1c/0x70
[    0.038761] lr : has_nv1+0x28/0xe8
.
[    0.039008] Call trace:
[    0.039014]  this_cpu_has_cap+0x1c/0x70
[    0.039031]  update_cpu_capabilities+0xd4/0x138
[    0.039048]  setup_system_features+0x38/0x130
[    0.039075]  smp_cpus_done+0x50/0xc8
[    0.039094]  smp_init+0x84/0xa0
[    0.039109]  kernel_init_freeable+0x11c/0x400
[    0.039126]  kernel_init+0x28/0x1f0
[    0.039148]  ret_from_fork+0x10/0x20
[    0.039167] ---[ end trace 0000000000000000 ]---


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240213/testrun/22596318/suite/log-parser-boot/test/check-kernel-exception/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240213/testrun/22596318/suite/log-parser-boot/tests/

This issue has been addressed in the relevant email thread,
https://lore.kernel.org/all/0593516b-2419-49b7-83aa-fe189ffad0c2@arm.com/

I will test the corresponding fix patch and get back to you.

--
Linaro LKFT
https://lkft.linaro.org

