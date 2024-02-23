Return-Path: <linux-kernel+bounces-78047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77398860E60
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1889CB26582
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DB25C91E;
	Fri, 23 Feb 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="H1KgZBBc"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE422EF5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681374; cv=none; b=IvYczLuHRM+VTFAEzhU2Qzhe31CppyboIV0/YKWD7new7imhf7X1ZxH9VftcEXsEFDxQfBngw0W01u8NyuDLzhLom9hH+t+GWZjWNqM1w1/lahvTa8EXzrvobDL4Uh77DEe/kc+vd5V3Qh7THca5lJdZypRZJlkF+G4Hq8++oYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681374; c=relaxed/simple;
	bh=LfBvV5ftt5p5wwwqFBLDPSUdEXzAXS6aKdqDAKHrVSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEfz8jBACRwbirDTH8BpLSrEwgNFcbng/eVvOJoFtH7+bHczBGIbmvPd3XxR/kcB0K1P2ESMRn6xghvWO8icfWclhLeo3xHf0OigN2IA+QRLVTSQXRSTfvfsn/u0+rlfN0oneC65RL3czft+ehRxaXal653ot9Vn+fhO9KcCl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=H1KgZBBc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e4765c86eso26111466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708681370; x=1709286170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JeGMCdaCDD7BHdfywFTOPLnwnnbru3LEGQbmIcb6KjM=;
        b=H1KgZBBc00OGeN9yXQ4/8mZ9jDPny/9wT7OZnL1jZcBdhoD6DkuTSy6OBLxn48HYCU
         2XpuJyOTb2An1ISi6Si2EUnW4D+j7m28Pp0cF0ftXDCXoAiwDgmJ+dG+sTgEa9v4lMIC
         hxRB0mWU6lsDk0WupJr08y6JJUcnYwDtLY+es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708681370; x=1709286170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeGMCdaCDD7BHdfywFTOPLnwnnbru3LEGQbmIcb6KjM=;
        b=nIHG0AXBkf8WH6AqC1fukb3oSwI/darhtSczOsPEj/Ygj0zqDKxa/de9WHe0D7G6mJ
         9ipOmLGI0YvDdYnQkx6dzd7y/nnHpDKEhtzvpFz7RNYiyhdgEVFc8yBQmOrn3O0wMxDW
         SlEdaSSiPKgMuM3jHnYO/Nd5AzYJmoT+ByRN/BKzNqDdinhq4tlnSl09B+ksUMw/L9Ql
         7MjJn0VRtrLQ7C3V1xopT4l18Sev/vUz/opcanNCKOoCKosLX5uSQrX0O8lGOYWjdHO6
         2oCQVfgI+ghnNkUcuImoAC3UsiQRmX74Qu8o7W8xn7CjJSv58fFDf09guXKHIZaK9Ubd
         wbyw==
X-Forwarded-Encrypted: i=1; AJvYcCUytVk4t+y/3XPfTxZcR+dMaU3hPwYIs7ZCw1E4R73VcEj1z8OVrD2s2K8TI9LeSjjaY+wkU7vx3WoYotSYwT12MZgIkVFMY0ZftO0i
X-Gm-Message-State: AOJu0Yx3yR1ZGXhv2a1QTGRbQ+FqH23bC6RvraFNZMV60yAlG5D0Un3M
	BimMsbG6mhXK+w7Qv8x8r6tDk35YbwGKAKgV135cUFi4PXkzr1wxJHgvjKCOHDHgJ4qPip7U8Zl
	/ANS4jpHsGZq9NJInfOTLrrjWu37BC+evG8II9g==
X-Google-Smtp-Source: AGHT+IG7sHUBZkp5FIyZ3wKIve695rZrZC0DwB1Cw2bOizO+7Yv+Nfpx1UfnCXqAJF48GUxGUtu/0dlNY6sUXDf7XwM=
X-Received: by 2002:a17:906:cb94:b0:a3e:c818:b7f with SMTP id
 mf20-20020a170906cb9400b00a3ec8180b7fmr815276ejb.29.1708681369617; Fri, 23
 Feb 2024 01:42:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103105929.1902658-1-houtao@huaweicloud.com>
In-Reply-To: <20240103105929.1902658-1-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 23 Feb 2024 10:42:37 +0100
Message-ID: <CAJfpegsM2ViQb1A2HNMJLsgVDs1UScd7p04MOLSkSMRNeshm0A@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: limit the length of ITER_KVEC dio by max_nopage_rw
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 11:58, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> When trying to insert a 10MB kernel module kept in a virtiofs with cache
> disabled, the following warning was reported:
>
>   ------------[ cut here ]------------
>   WARNING: CPU: 2 PID: 439 at mm/page_alloc.c:4544 ......
>   Modules linked in:
>   CPU: 2 PID: 439 Comm: insmod Not tainted 6.7.0-rc7+ #33
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ......
>   RIP: 0010:__alloc_pages+0x2c4/0x360
>   ......
>   Call Trace:
>    <TASK>
>    ? __warn+0x8f/0x150
>    ? __alloc_pages+0x2c4/0x360
>    __kmalloc_large_node+0x86/0x160
>    __kmalloc+0xcd/0x140
>    virtio_fs_enqueue_req+0x240/0x6d0
>    virtio_fs_wake_pending_and_unlock+0x7f/0x190
>    queue_request_and_unlock+0x58/0x70
>    fuse_simple_request+0x18b/0x2e0
>    fuse_direct_io+0x58a/0x850
>    fuse_file_read_iter+0xdb/0x130
>    __kernel_read+0xf3/0x260
>    kernel_read+0x45/0x60
>    kernel_read_file+0x1ad/0x2b0
>    init_module_from_file+0x6a/0xe0
>    idempotent_init_module+0x179/0x230
>    __x64_sys_finit_module+0x5d/0xb0
>    do_syscall_64+0x36/0xb0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
>    ......
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
>
> The warning happened as follow. In copy_args_to_argbuf(), virtiofs uses
> kmalloc-ed memory as bound buffer for fuse args, but

So this seems to be the special case in fuse_get_user_pages() when the
read/write requests get a piece of kernel memory.

I don't really understand the comment in virtio_fs_enqueue_req():  /*
Use a bounce buffer since stack args cannot be mapped */

Stefan, can you explain?  What's special about the arg being on the stack?

What if the arg is not on the stack (as is probably the case for big
args like this)?   Do we need the bounce buffer in that case?

Thanks,
Miklos

