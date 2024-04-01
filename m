Return-Path: <linux-kernel+bounces-126974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D392E89452E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BFC1C2187F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0BA51C33;
	Mon,  1 Apr 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASFESFrV"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0951C46
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998279; cv=none; b=Ae/L+WXu9a7gEbN1e44uojz92FjCiYqG8T6Y/kbZiTcoQoaX1l2hfJ4CBJhdHFSUNYdF361r14h+12H8GxHTjHoUJYtmBLuCSJEw82WDtnwqrlPeOPNmpmk7zPHilzf+7dixB5QKdpi6cjKz1ZyfjsesXDCvldpkr7gABAzVPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998279; c=relaxed/simple;
	bh=j7VLIK/u4oATc/29XeVXWWlasJDfPqEJ9jTWxs2dNWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6Hma/QTRv9hQpwjiJfaD643SCp2bN+l4nJHLCyh1LR+1fR968qLFCm1TCD0Vji8BYmZyL26ZzQ9HUh0e5MkZlrop4UtClDGZaLY+4vJvSne50TiPOOqSlf4vAs4pykz5X1SGfFxNsO/w9V7SB/j6t0RqmT77O+2+DgqxxtJsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ASFESFrV; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56c2b4850d2so5061085a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711998275; x=1712603075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u6uaUI+tf8SHKzsQC+xZokqIl8VwjiOYFPlSJheN0WY=;
        b=ASFESFrVjrCH6gC5TV1XvEQd/5rhkwLOB6094MP1neqOfhQyNzbqIkhEYBVr6oHsRg
         DCuDtl7NCkUR08zheHfnF+k/jrFdZA0TgGwo7CnfjkgIJbha2HAdW7OX4CxJG1Oajb84
         6CHYs2zZ7fEFiULgeRQEVk7ogT0aBvsrZ6s0SMNkdtBthcj0X6rixZnAvEabrARrx5Qo
         77ZSTjLdJ7xLWWZqtwrMANk8G/0aGje9jCGKY9YGWwGzc7vWS6u+rq1+S/49fX6ID1zr
         N4Cp8noLOdsV3CL9nG+bUFZKlBC4pNzRFh5Ul0rsgm3gS9rwzuhjBetO4+KZa6uxmW1S
         co6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711998275; x=1712603075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6uaUI+tf8SHKzsQC+xZokqIl8VwjiOYFPlSJheN0WY=;
        b=gxa353tYyCsjbAWBxM0XqGJauwbhz76QYxW+xDU2vLR6FSR78AJxSVlrmW6bUYVSKK
         FtAc65bqlDbCrlxAeqgMZumUrVxfvh1txjSPRZVRvc+HjhHeupNZSvTT+bWTj0emZ5je
         BbPG89XOSyJ78gGAzk0OSOqECAX9f9A9DFm0k7aVuJUDDMjQl53yKYg42qYFXYYaedui
         9G7s9vJf4rzQIw5vWs7gxCZSmWHJ12jzNwQCp+skg8LJN54tSgTvv82sv/U4itPNp3gr
         VEVcYqvWZNzVsLQi6oruSKlyj/7n0WQH1T/H4xEidoH1Likh1TIrOlzgzLctlT6HOFmU
         D0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCW6vyC19HsIq/Wd77mcbbTxuT3JrhnN5zzcsefud3su0Ag5Q0GLIyHlU94tXXXGJm0eaAh5xCKSRWYJyBuZYo4fh7QkhpupQZSOKboU
X-Gm-Message-State: AOJu0YyoXr01laTGL8T5CcbCfhYN99jlhvuPli2KGm05n/4mwVN6JvoQ
	DdrqzqNmDxkdWeKirjCbftJJY1ioNn5S8gpS5f1IjMFqssqV2T27DjPzZhMoQBkNGVw/t1uK9k8
	RjQIE9WKaz7ak9Qj+OAXPi3hUad3bzyFQtv1oIA==
X-Google-Smtp-Source: AGHT+IEGBhywqC+1C7o8zzn+AZ5cc0LrVNMqLDt3eM22SEsVPi/zqIlKIAhUFw1kqaGpME2GmtIWwF1NpF/DV8RSiUo=
X-Received: by 2002:a05:6402:518f:b0:566:ca0:4a91 with SMTP id
 q15-20020a056402518f00b005660ca04a91mr8331898edd.2.1711998274794; Mon, 01 Apr
 2024 12:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152553.125349965@linuxfoundation.org>
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Apr 2024 00:34:22 +0530
Message-ID: <CA+G9fYuY6jrEroCeeioC389E6G56wjSGQpFxQS5MQtTFz-aZtQ@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Apr 2024 at 21:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Note, this will be the LAST 6.7.y kernel release.  After this one it
> will be end-of-life.  Please move to 6.8.y now.
>
> ------------------------------------------
>
> This is the start of the stable review cycle for the 6.7.12 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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

