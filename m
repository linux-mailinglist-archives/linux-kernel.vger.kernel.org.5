Return-Path: <linux-kernel+bounces-126969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AB989451C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819E51C216BF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5351C2A;
	Mon,  1 Apr 2024 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kV2DsGXl"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585FE20DE7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998103; cv=none; b=LQqMgGxB6m54+P/pg9VmMkEnbWNCwp6idtknbJrVVh+GAWB2bQ4Uopeuphx5p5fETTeOAyQP1Zt6QI9olDhq2O8woal8XsBRk72x+09NjAXrqRokgDqeycmhZgabS3cmukgLjXuVfV6wHKHYB1bwI7UE5Bg0Vr94KLmsnem68Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998103; c=relaxed/simple;
	bh=OpL35PcgIK4wmZiMDnenaRELysGw5y7Sx+jwFbuYnC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+KHBoPHXliEy3pJ3v+4XeXEq8Yl/r8LtIhQdR6i+3vJoNce0i6SJw3vfvFoZbwaxS5Y+480JYsVBcbeFHx+baAPNE+iZAwFaALdtuJJXGBzISl9EUFPp+8zvMoBrPgKBoE+QsyvoO5dGosk4xQ5Q8fcK7u02X7TBzyXR+jmw4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kV2DsGXl; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4d435a036so1708179eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711998100; x=1712602900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8VfZljfocSfpqKfZ24APD96ZY0uNFOza/nVTuCvA10s=;
        b=kV2DsGXl3YCXM56t5xV4bC9jgT0P4BSlV1y52ZYuJvI/EAWueCT75kCRGYFSjnitGW
         +2ppHk3Bx4fsOiQXT3EDjtSAVhwQ55K2CD1+WiZ7tMaERJNAOdKHoUOT2epl7/EOcBC3
         qgXxjngv+nLDGFCOstWhX3cOU5mZmVv6K4HErfv9bP7AwRSv2KoCBWxEjq+HpZkh7ePY
         RN4IkQFFD0MwJHhyew3PNGf2nVrE0ToHDOH8Wp8K6tiixSp7kOE9sfLqERDiZ1LwtsAH
         f9OFNBIEVGisx8wsIOejaGPdiXs2xv4L46MxIiYfVCfsAHEZTZDKd67ksQ9MhBkVApzS
         +9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711998100; x=1712602900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VfZljfocSfpqKfZ24APD96ZY0uNFOza/nVTuCvA10s=;
        b=GX1xW9Vbjr5gU7dGopJ6uOv0k+1u7/czzxmcXtf33FeALRsHdTrahd0RvZvcV3PhM9
         yWwFkUsocf89q8FoHjeY/SJQcWc7y8DVVzGVokYnYYv0SDMcD6aPaP3138AmjvJxYa+K
         Dme7BkkfcuKAO/Xmpx352ANdF2cS+Ctqkve0EY42uECtpmL7uEc0Prk/6K3iy00ioxET
         A1N8GrIRY3tZnMwmqHT8u+nb6Zg32OZQIqOQXBHvNNSHsJKvQDYdffZl8BDS7AV/PegC
         pHKE2hIweahakAKp97R4e9vsRTi7CycfalzcLwHI6r/LoMgCxjizY5pelviGTyh2kBVd
         7xNw==
X-Forwarded-Encrypted: i=1; AJvYcCUTkP5z2zD0+cS36s/zKNbEWtqiIYJe7CEVy6ROu6YpbwjDr0Hhof676EidIbvKeI0KgjYBLOBHlSbO3cTXMaibjy8q9MA8k2kgM0Vh
X-Gm-Message-State: AOJu0YyKZzXbuMgGJ81FHg55qbzFVAUbOEzl7pEnTDKdlJ+i9Gpnv9Ux
	XlNqzW1TlKO+42RMkP9/PCPDd0EWoW61GyY4PM67DFvo0G7s0tztGup9lYKmyYjDHJeqcOdhuIM
	QKxRMjCRu3p/1FhyBJ9vvMqMpsegaK9asiC26pQ==
X-Google-Smtp-Source: AGHT+IFWsTgohUEdMBkXC10fXfKP3iS0KDnJgXeRSHA+MEC5uuUmhMYLgrrl4ce7h5CXapU9nMnWcn+nFmlIVMpAOM8=
X-Received: by 2002:a05:6808:190d:b0:3c3:d37d:594d with SMTP id
 bf13-20020a056808190d00b003c3d37d594dmr12830121oib.0.1711998100384; Mon, 01
 Apr 2024 12:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152547.867452742@linuxfoundation.org>
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Apr 2024 00:31:28 +0530
Message-ID: <CA+G9fYvewkbwR_i07HHTM=8E2yS-0wRhOT-C45LP3SNtzgd+4Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Alexander Wetzel <Alexander@wetzel-home.de>, 
	Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Apr 2024 at 22:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.24-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Following kernel warnings have been noticed on qemu-x86_64 while running LTP
cve ioctl_sg01 tests the kernel with stable-rc 6.6.24-rc1, 6.7.12-rc1 and
6.8.3-rc1.

We have started bi-secting this issue.
Always reproduced.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg0
------------[ cut here ]------------
[   36.606841] WARNING: CPU: 0 PID: 8 at drivers/scsi/sg.c:2237
sg_remove_sfp_usercontext+0x145/0x150
[   36.609445] Modules linked in:
[   36.610793] CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.24-rc1 #1
[   36.611568] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   36.612872] Workqueue: events sg_remove_sfp_usercontext
[   36.613691] RIP: 0010:sg_remove_sfp_usercontext+0x145/0x150

<trim>

[   36.621539] Call Trace:
[   36.621953]  <TASK>
[   36.622444]  ? show_regs+0x69/0x80
[   36.622819]  ? __warn+0x8d/0x150
[   36.623078]  ? sg_remove_sfp_usercontext+0x145/0x150
[   36.623558]  ? report_bug+0x171/0x1a0
[   36.623881]  ? handle_bug+0x42/0x80
[   36.624070]  ? exc_invalid_op+0x1c/0x70
[   36.624491]  ? asm_exc_invalid_op+0x1f/0x30
[   36.624897]  ? sg_remove_sfp_usercontext+0x145/0x150
[   36.625408]  process_one_work+0x141/0x300
[   36.625769]  worker_thread+0x2f6/0x430
[   36.626073]  ? __pfx_worker_thread+0x10/0x10
[   36.626529]  kthread+0x105/0x140
[   36.626778]  ? __pfx_kthread+0x10/0x10
[   36.627059]  ret_from_fork+0x41/0x60
[   36.627441]  ? __pfx_kthread+0x10/0x10
[   36.627735]  ret_from_fork_asm+0x1b/0x30
[   36.628293]  </TASK>
[   36.628604] ---[ end trace 0000000000000000 ]---
ioctl_sg01.c:122: TPASS: Output buffer is empty, no data leaked

Suspecting commit:
-----
scsi: sg: Avoid sg device teardown race
commit 27f58c04a8f438078583041468ec60597841284d upstream.

 + WARN_ON_ONCE(kref_read(&sdp->d_ref) != 1);

Steps to reproduce:
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2eVWFlAeOUepfeFVkrOXFYNNAqI/reproducer

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.23-397-g75a2533b74d0/testrun/23255318/suite/log-parser-test/tests/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2eVTitwVMagaiWhs5T2iKH390D5


--
Linaro LKFT
https://lkft.linaro.org

