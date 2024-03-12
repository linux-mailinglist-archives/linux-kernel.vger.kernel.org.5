Return-Path: <linux-kernel+bounces-99965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F98878FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C912D1F21E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F677F2A;
	Tue, 12 Mar 2024 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=klervi.com header.i=@klervi.com header.b="Squ+obn2"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703E77F03
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233260; cv=none; b=H51RIaK2ObSFt04cfy99opbPLvh7drXl+5i0ixgKSTCNR6WE1X2hcqOAI1St9jn9+mbOXfUWXREfZu/TuCCTwqYmMHKlYXcsQWactuPF39NwLs7vPwJOVh0AEHbZBdBM51d2UlvPgRUxpxkc8uDyZ4js5Wv3zYenpQ/M1qVvJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233260; c=relaxed/simple;
	bh=tHBrJcuGqaRHB4why9jHhPpAc6snleR5cX9tHGUmAtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNQMODKIrQT4tjWTpwU4Pimh3aeJDdEFMlf3s7br75OCghCQK8tZLVDtkmCsHFnEzhVTZUnCVaHVSr5O2g0rhKGM5Yn+a79QPmjHXdWDznWxW49iVVfafWO9TuTNPljXqiFZqVy+SbScwK8QnmXfzCnAt4RjBvSCQhgZhVq6JfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=klervi.com; spf=pass smtp.mailfrom=klervi.com; dkim=pass (1024-bit key) header.d=klervi.com header.i=@klervi.com header.b=Squ+obn2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=klervi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klervi.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33e6aca1ca9so5105928f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klervi.com; s=google; t=1710233256; x=1710838056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNwAuf3xKbCs7LgkxRoAfBG44V8t0JvPJ1MnxJHQkm4=;
        b=Squ+obn2nIa6GnowyxbG8+JATDG0XRXqzySl/u0adsgj+zgWVdOpdQuTpQ6luWE/Md
         6kcyTsF/mh7RVI8N0mGLR9P6wC+BWdfQ/iww0W3Qhqo6S4obpiDLYRkgRsh81oDB+vnT
         nJl/CcR5sKXpT9w9BVUYZ/9amhzjCSAoX7MBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710233256; x=1710838056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNwAuf3xKbCs7LgkxRoAfBG44V8t0JvPJ1MnxJHQkm4=;
        b=vVticHz0CrNNdv0fh6XDpxsYZ1LUm+4DN74IgquS/bnep6HFElJYoVE4/0e04JedNL
         vTX9Ub/gwu92Ts/4+7VInQiQArqZoCPFKdVza5PwNEECESMwHwwwUFtpSw0vm8DqYnDD
         moiWj5LB/yOtOgrxMbipdaYv+7YZa3WSuLyPP3YYh+DfQYl8/3BaeiHQz9TWF2ZVQsCC
         5QKdNILEAUdb6CF6e4leE11bbu3TQ3eemZf4NvJ3Ks0cOQ0qk2C2lVEdBH5TktpamwPK
         ZrfSz6+i7qCbKa7kYMDxplH4NiLMz2q7m9ZuPVigyMQL91uT7+TzRDXfxjeDQRT3Hscu
         7n4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVjBkTCQACzhi6TT46Me7Tx3cSdkfiUJ5r7Pbo/GiGQARNY9bnSioLa4n3XJCwOKzYbV24wF7wnSR0bqSxQs6Z+zD8D2NG0O5/ZuZ+
X-Gm-Message-State: AOJu0YxdpvTuXlb3w5bqBmg/8LZLH+5Y3mSKR3z9m2Mt+bYoUadUIUld
	m1rfzH1g94rpUc+dZ4xTvRtz1zoXbGQlk7jhZi2M5ZzfklFe6kL0yT94CoXl0NTb0J7ajJKyVkP
	wKfafxBFiHkPjg2r7JvyL4VYqX2T+d6KihfGKD8xmTE5row7nRFUuvjw8o6ltExGULQvDtgSbkJ
	k7q1DLM+c7Hlpe6CeDvggdSlDC88hLbFEaG0+xzl+oTRcMhXo3JPraWUQG53xssxJLfJoTgHrI6
	iJu77yNOHWHzCw7M3U9RCdgik7jKIlsnGhouEhrY3hR3w==
X-Google-Smtp-Source: AGHT+IHFRYoj1ujPIjrnnD2FdqnX3CgjhCyRszbS+OoWbBKnqV0VQDAPUhZMkwUH8x2LE/bRi3VOog==
X-Received: by 2002:a05:600c:314d:b0:413:1f57:a312 with SMTP id h13-20020a05600c314d00b004131f57a312mr864272wmo.11.1710232889062;
        Tue, 12 Mar 2024 01:41:29 -0700 (PDT)
Received: from cadmium.klervi.com (fourier.klervi.com. [91.90.98.42])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0a4600b00412f2136793sm18557523wmq.44.2024.03.12.01.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 01:41:28 -0700 (PDT)
From: Pierre-Louis Dourneau <pl.dourneau@klervi.com>
To: Ludovic.Desroches@microchip.com,
	sam@ravnborg.org,
	bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manikandan.M@microchip.com
Cc: Pierre-Louis Dourneau <pl.dourneau@klervi.com>,
	b.alcaina@klervi.com,
	a.lahache@klervi.com,
	n.georges@klervi.com
Subject: Re: [PATCH] drm/atmel-hlcdc: Release CRTC commit when destroying plane state
Date: Tue, 12 Mar 2024 09:40:15 +0100
Message-Id: <20240312084016.36136-1-pl.dourneau@klervi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5856fbbb-2b51-4609-ae7a-d920648567b1@microchip.com>
References: <20240306194935.11871-1-pl.dourneau@klervi.com>, <5856fbbb-2b51-4609-ae7a-d920648567b1@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Ludovic,

On 3/8/24, Ludovic.Desroches@microchip.com <Ludovic.Desroches@microchip.com> wrote:
> On 3/6/24 20:49, Pierre-Louis Dourneau wrote:
> >
> > From: Arnaud Lahache <a.lahache@klervi.com>
> >
> > Fixes a memory leak occurring on each modeset update.
> >
> > Running a program such as libdrm's modetest[0] with this driver exhausts
> > all available memory after a few minutes. Enabling kmemleak yields a series
> > of such leak reports:
> >
> > unreferenced object 0xc21acf40 (size 64):
> >    comm "modetest", pid 210, jiffies 4294942460 (age 331.240s)
> >    hex dump (first 32 bytes):
> >      00 a0 a1 c1 01 00 00 00 ff ff ff ff 4c cf 1a c2  ............L...
> >      4c cf 1a c2 ff ff ff ff 58 cf 1a c2 58 cf 1a c2  L.......X...X...
> >    backtrace:
> >      [<d68b3e09>] kmalloc_trace+0x18/0x24
> >      [<f858a020>] drm_atomic_helper_setup_commit+0x1e0/0x7e0
> >      [<26e8ab04>] drm_atomic_helper_commit+0x40/0x160
> >      [<49708b0c>] drm_atomic_commit+0xa8/0xf0
> >      [<e58c2942>] drm_mode_obj_set_property_ioctl+0x154/0x3d8
> >      [<5e97e57d>] drm_ioctl+0x200/0x3c4
> >      [<ed514ba1>] sys_ioctl+0x240/0xb48
> >      [<26aab344>] ret_fast_syscall+0x0/0x44
> >
> > drm_atomic_helper_setup_commit() acquires a reference to a drm_crtc_commit
> > for each CRTC and associated connectors and planes involved in a modeset.
> > 64-byte leaks map well to the size of a drm_crtc_commit on 32-bit
> > architectures, and the second 4-byte chunk in the hex dump above awfully
> > looks like a reference count.
> >
> > We tracked this missing reference decrement down to the driver's
> > atmel_hlcdc_plane_atomic_destroy_state() callback. Its CRTC counterpart,
> > atmel_hlcdc_crtc_destroy_state(), calls into the drm_atomic helpers and
> > properly releases its references to the commit. Planes didn't. Using the
> > default helper for that purpose, __drm_atomic_helper_plane_destroy_state(),
> > fixes the leak and avoids reimplementing the same logic in the driver.
> >
> > [0]: https://gitlab.freedesktop.org/mesa/drm/-/tree/main/tests/modetest
> >       Invoke with `modetest -M atmel-hlcdc -s 32:#0 -v`, assuming 32 is the
> >       ID of a connector.
> >
> > Signed-off-by: Arnaud Lahache <a.lahache@klervi.com>
> > Co-developed-by: Pierre-Louis Dourneau <pl.dourneau@klervi.com>
> > Signed-off-by: Pierre-Louis Dourneau <pl.dourneau@klervi.com>
> > Co-developed-by: Benoît Alcaina <b.alcaina@klervi.com>
> > Signed-off-by: Benoît Alcaina <b.alcaina@klervi.com>
> > ---
> > As far as our testing goes, we've been running 6 of our production units
> > with this patch for more than 2 weeks as per the date this patch is sent
> > out. We can report stable memory usage.
> 
> Hello Arnaud,
> 
> This patch fixes the memory leak but introduces a crash on my side when
> exiting a graphics app using the Microchip graphics library.
> 
> 
> ------------[ cut here ]------------
> 
> 
> 
> WARNING: CPU: 0 PID: 201 at lib/refcount.c:28
> refcount_warn_saturate+0x58/0x130
> 
> 
> 
> refcount_t: underflow; use-after-free.
> 
> 
> 
> Modules linked in:
> 
> 
> 
> CPU: 0 PID: 201 Comm: basic Not tainted 6.1.55-linux4microchip-2023.10+
> #65
> 
> 
> Hardware name: Microchip SAM9X60
> 
> 
> 
>   unwind_backtrace from show_stack+0x10/0x18
> 
> 
> 
>   show_stack from dump_stack_lvl+0x28/0x34
> 
> 
> 
>   dump_stack_lvl from __warn+0x70/0xb8
> 
> 
> 
>   __warn from warn_slowpath_fmt+0x78/0xac
> 
> 
> 
>   warn_slowpath_fmt from refcount_warn_saturate+0x58/0x130
> 
> 
> 
>   refcount_warn_saturate from kref_put+0x54/0x5c
> 
> 
> 
>   kref_put from drm_fb_release+0x100/0x11c
> 
> 
> 
>   drm_fb_release from drm_file_free+0xcc/0x1bc
> 
> 
> 
>   drm_file_free from drm_release+0x44/0x94
> 
> 
> 
>   drm_release from __fput+0xf0/0x20c
> 
> 
> 
>   __fput from task_work_run+0x8c/0xb0
> 
> 
> 
>   task_work_run from do_exit+0x310/0x760
> 
> 
> 
>   do_exit from sys_exit_group+0x0/0x14
> 
> 
> 
>   sys_exit_group from get_signal+0x524/0x64c
> 
> 
> 
>   get_signal from do_work_pending+0xf4/0x398
> 
> 
> 
>   do_work_pending from slow_work_pending+0xc/0x24
> 
> 
> 
> Exception stack(0xc9991fb0 to 0xc9991ff8)
> 
> 
> 
> 1fa0:                                     0054dd48 00000000 005331f8
> 00000001
> 
> 
> 1fc0: 00533270 00000002 00000000 404c8000 beb54170 0051b448 43ab8000
> 0051b424
> 
> 
> 1fe0: b6cc1d98 beb54040 b6c224fc b68357dc 20000010 ffffffff
> 
> 
> 
> ---[ end trace 0000000000000000 ]---
> 
> 
> 
> 8<--- cut here ---
> 
> 
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000004
> 
> 
> [00000004] *pgd=00000000
> 
> 
> 
> Internal error: Oops: 805 [#1] ARM
> 
> 
> 
> Modules linked in:
> 
> 
> 
> CPU: 0 PID: 201 Comm: basic Tainted: G        W
> 6.1.55-linux4microchip-2023.10+ #65
> 
> 
> Hardware name: Microchip SAM9X60
> 
> 
> 
> PC is at drm_fb_release+0xc0/0x11c
> 
> 
> 
> LR is at drm_fb_release+0x100/0x11c
> 
> 
> 
> pc : [<c0329b10>]    lr : [<c0329b50>]    psr: 80000013
> 
> 
> 
> sp : c9991e48  ip : 00000000  fp : 0051b424
> 
> 
> 
> r10: c174a5f0  r9 : 00000000  r8 : c2188074
> 
> 
> 
> r7 : 60000013  r6 : c9991e5c  r5 : ffffff8c  r4 : c2188048
> 
> 
> 
> r3 : c1590994  r2 : c2188048  r1 : 00000000  r0 : c1590920
> 
> 
> 
> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> 
> 
> 
> Control: 0005317f  Table: 2384c000  DAC: 00000051
> 
> 
> 
> Register r0 information: slab kmalloc-192 start c1590920 pointer offset
> 0 size 192
> 
> 
> Register r1 information: NULL pointer
> 
> 
> 
> Register r2 information: slab kmalloc-192 start c2188000 pointer offset
> 72 size 192
> 
> 
> Register r3 information: slab kmalloc-192 start c1590920 pointer offset
> 116 size 192
> 
> 
> Register r4 information: slab kmalloc-192 start c2188000 pointer offset
> 72 size 192
> 
> 
> Register r5 information: non-paged memory
> 
> 
> 
> Register r6 information: 2-page vmalloc region starting at 0xc9990000
> allocated at kernel_clone+0xb4/0x204
> 
> 
> Register r7 information: non-paged memory
> 
> 
> 
> Register r8 information: slab kmalloc-192 start c2188000 pointer offset
> 116 size 192
> 
> 
> Register r9 information: NULL pointer
> 
> 
> 
> Register r10 information: slab task_struct start c174a140 pointer offset
> 1200
> 
> 
> Register r11 information: non-paged memory
> 
> 
> 
> Register r12 information: NULL pointer
> 
> 
> 
> Process basic (pid: 201, stack limit = 0x41541c7b)
> 
> 
> 
> Stack: (0xc9991e48 to 0xc9992000)
> 1e40:                   00000001 00000000 00000000 00000000 00000000
> c9991e5c
> 
> 
> 1e60: c9991e5c 5c44a9dd c2188000 c1621800 c2188060 c03146e4 000000c9
> 0000e200
> 
> 
> 1e80: 00000001 00000000 00000000 c1621800 c38f2cc0 c0fb63e0 c0c1ce70
> c0f99560
> 
> 
> 1ea0: 00000000 c0314a5c c38f2cc0 c10ee6e8 000a201f c00c66a0 c38f2cc0
> 00000001
> 
> 
> 1ec0: c09f1a4c c00c67fc c38f2e00 c174a140 c0a20b1c c2232a50 c9991ef4
> c002f000
> 
> 
> 1ee0: c174a140 c2232a20 c174a140 c001a094 00000002 00000008 c383c880
> 5c44a9dd
> 
> 
> 1f00: 00000002 c383c880 0051b424 c001a6a8 00000009 c0024af0 beb53c50
> 00000000
> 
> 
> 1f20: 00000000 5c44a9dd 00000000 00000000 c9991fb0 c174a140 00000000
> 00000000
> 
> 
> 1f40: 00000000 00000000 0051b424 c000c244 00000000 00000000 00000000
> 00000000
> 
> 
> 1f60: 00000000 00000000 00000009 00000000 00000000 00000000 00000000
> 00000000
> 
> 
> 1f80: 00000000 00000000 00000000 5c44a9dd b68357dc 20000010 ffffffff
> 0005317f
> 
> 
> 1fa0: 00000000 c174a140 43ab8000 c00084dc 0054dd48 00000000 005331f8
> 00000001
> 
> 
> 1fc0: 00533270 00000002 00000000 404c8000 beb54170 0051b448 43ab8000
> 0051b424
> 
> 
> 1fe0: b6cc1d98 beb54040 b6c224fc b68357dc 20000010 ffffffff 00000000
> 00000000
> 
> 
>   drm_fb_release from drm_file_free+0xcc/0x1bc
> 
> 
> 
>   drm_file_free from drm_release+0x44/0x94
> 
> 
> 
>   drm_release from __fput+0xf0/0x20c
> 
> 
> 
>   __fput from task_work_run+0x8c/0xb0
> 
> 
> 
>   task_work_run from do_exit+0x310/0x760
> 
> 
> 
>   do_exit from sys_exit_group+0x0/0x14
> 
> 
> 
>   sys_exit_group from get_signal+0x524/0x64c
> 
> 
> 
>   get_signal from do_work_pending+0xf4/0x398
> 
> 
> 
>   do_work_pending from slow_work_pending+0xc/0x24
> 
> 
> 
> Exception stack(0xc9991fb0 to 0xc9991ff8)
> 
> 
> 
> 1fa0:                                     0054dd48 00000000 005331f8
> 00000001
> 
> 
> 1fc0: 00533270 00000002 00000000 404c8000 beb54170 0051b448 43ab8000
> 0051b424
> 
> 
> 1fe0: b6cc1d98 beb54040 b6c224fc b68357dc 20000010 ffffffff
> 
> 
> 
> Code: e590c018 e5902078 e5901074 e35c0001 (e5812004)
> 
> 
> 
> ---[ end trace 00000000c0a20288 ]---
> 
> 
> 
> Fixing recursive fault but reboot is needed!

We've tried to reproduce your crash with 6.1.22-linux4microchip-2023.04,
to no avail. We'll try to upgrade to 6.1.55-linux4microchip-2023.10 (your
version) and test again.

Is there a particular EGT program you recommend to trigger the crash? Or
any should do? We've limited ourselves to a few of the samples provided
with the library, namely egt_basic, egt_water, egt_charts, and egt_i18n.

> The memory leak had been introduced with this commit:
> 
> 
> commit eec44d44a3d2d00c8f663f13555d3dd280b1ea3f
> Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> Date:   Thu Jan 21 16:29:54 2021 +0100
> 
> 
> 
>      drm/atmel: Use drm_atomic_helper_commit
> 
>      One of these drivers that predates the nonblocking support in helpers,
>      and hand-rolled its own thing. Entirely not anything specific here, we
>      can just delete it all and replace it with the helper version.
> 
>      Could also perhaps use the drm_mode_config_helper_suspend/resume
>      stuff, for another few lines deleted. But I'm not looking at that
>      stuff, I'm just going through all the atomic commit functions and make
>      sure they have properly annotated dma-fence critical sections
>      everywhere.
> 
> 
> I think this move to the drm atomic helper should have gone with an
> update on the release side as well. There is probably something wrong
> with the atomic_destroy_state callbacks provided by the atmel-hlcdc driver.
> 
> Regards,
> Ludovic
> 
> >
> > Admittedly, our usage of the DRM uAPI is rather simple: create 2 dumb
> > buffers, do an initial MODE_SETCRTC, and then MODE_PAGE_FLIP between the
> > two dumb buffers at the rate of once per second on average. We haven't
> > evaluated more complex workloads.
> >
> >   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > index daa508504f47..390c4fc62af7 100644
> > --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> > @@ -934,8 +934,7 @@ static void atmel_hlcdc_plane_atomic_destroy_state(struct drm_plane *p,
> >                                state->dscrs[i]->self);
> >          }
> >
> > -       if (s->fb)
> > -               drm_framebuffer_put(s->fb);
> > +       __drm_atomic_helper_plane_destroy_state(s);
> >
> >          kfree(state);
> >   }
> >
> > base-commit: 9dfc46c87cdc8f5a42a71de247a744a6b8188980
> > --
> > 2.34.1
> >

Pierre-Louis

