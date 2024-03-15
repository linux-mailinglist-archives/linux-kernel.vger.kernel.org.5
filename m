Return-Path: <linux-kernel+bounces-104395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BB487CD37
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E5E1F229FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC71C680;
	Fri, 15 Mar 2024 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=klervi.com header.i=@klervi.com header.b="dMDohCt6"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC6D1BF3C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505569; cv=none; b=OHnXJTU4KzWYW73O0/3o2ISYp2l++PNmKs3cinU4MAMSCRXqD9DWfvK3wGgkJIRsnWaQL3mgziwa+LePW9MhRGRkaPPCdbhfZu48ReloiXHNKEXASAoRATYssONli89u3n6u4AQeuntMbHrDs6w+Z2I8GsYWevRb+6h2GZ5hqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505569; c=relaxed/simple;
	bh=TD/KiH33sXM84mSoAKUU0jPwy3Um0JVk0ZAYWrgcUH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSeeQVCeTzn4BSVp+kxCl4gLHIzVErFwvhKZmLojmmvpfJMSNIYo9pR2py0u+LdG1+4GTfgA8bMsVfM382f9YYtgc/wwAbzwXYBipLKzJfmgzZEI1lG9PuQ4g4fxqMyQR/8h8ERvkYpCkH7jGjpaaWIGgGlHNQl3MgEKKse8x1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=klervi.com; spf=pass smtp.mailfrom=klervi.com; dkim=pass (1024-bit key) header.d=klervi.com header.i=@klervi.com header.b=dMDohCt6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=klervi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klervi.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513d4559fb4so1969021e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 05:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klervi.com; s=google; t=1710505564; x=1711110364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nga3nQAHAM0wWDICgNAH+2ZxnIgnE0zj9q8FIG7Fvl4=;
        b=dMDohCt6xspIbhELVuFpQ5KZnLDUzMnNftJw8p2wszUi/8CrgVKoaAqM9LFIPseGxx
         mXawGqD1ALC/3DdRMIauIeyN1d+TYvD5ZDXp7XQeZ+4pf6kX+/pU+8xSKx9gGr+pJD6W
         G/ABflnUyZbl0mQhFoSpDblqIQn9Xx9/6OTpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710505564; x=1711110364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nga3nQAHAM0wWDICgNAH+2ZxnIgnE0zj9q8FIG7Fvl4=;
        b=YGIeGwOrkXFSN6hFxBovA96SoWVVTTAEkVAKqlhzUJAYZKLeC4MqRyKgIWMXjwJXqE
         R+880VRSaD5HYhnemNGgwfHyT197cW1cG6GyKA5P1Lrs5z3A2+8Ds4H5AUzMGePkR1ja
         H6gbXiQibj0ctrSvKBnqKVlF3U3tD4WnoC0XpfRAY1QN+gqbG8Et8UVif6LIJQ+htfcX
         8Hr3+pu/9oQGwsOOAOJjvmWF1Vuda+jfQOlxhhQjno4YM4TUBEmMKDGLZAksZEvQQi0t
         Pe80hIYddJyn1xDmRdwxGnyujO66uUQeVyTkOmax+/WMQ1JB3A3+e7NZ/54vZixEuuqZ
         dNOw==
X-Forwarded-Encrypted: i=1; AJvYcCU/DHxlFzYAhjnTkpxwaEfsfbvI5T2wDideaKRwsN9LEnephy0t5ztYeHGKjq3LfcX13dlX6fEjOxYwkgItgCnF2nx0GS8w2uefqf2J
X-Gm-Message-State: AOJu0Ywljz1QFnfb2eFFANQU8IMcJw89fDemnwW95nAulg2nxkJh1+WO
	2ToP3/oafNVfZgSzFo20uDRkUIAF7zBShLuyhl2h3g5B3XoLeIk22NU7K0lwzR3HFjwLbsLB5ZN
	NUjByQ7CntuolUBq9mmCKS7PZU/uYZpbKgXSIvGL7+JuSYqUQJEVKSObBCv1t5ksrfPa8K0CPQm
	VLF9roi7uOTX3Xq4SzrmnEzVoAS2XbufhruxsZRH0leUTNBaQ+mUY1uXoOCEvH+P0+XBxcuESuZ
	hrqZ92SXxEW3UdwG5GrbMQ6bps=
X-Google-Smtp-Source: AGHT+IHQ0ULPpRLOVvOoucXnx201JA8MEIAwBwVU86lPavzN57TwmGGyrkIP36R3zVv3bYFuQ7/1Nw==
X-Received: by 2002:a05:6512:3447:b0:513:ca65:8c58 with SMTP id j7-20020a056512344700b00513ca658c58mr2993160lfr.43.1710505563415;
        Fri, 15 Mar 2024 05:26:03 -0700 (PDT)
Received: from cadmium.klervi.com (fourier.klervi.com. [91.90.98.42])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c350a00b00412ee8e2f2asm8897028wmq.9.2024.03.15.05.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 05:26:03 -0700 (PDT)
From: Pierre-Louis Dourneau <pl.dourneau@klervi.com>
To: Ludovic.Desroches@microchip.com
Cc: Pierre-Louis Dourneau <pl.dourneau@klervi.com>,
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
	Manikandan.M@microchip.com,
	b.alcaina@klervi.com,
	a.lahache@klervi.com,
	n.georges@klervi.com
Subject: Re: [PATCH] drm/atmel-hlcdc: Release CRTC commit when destroying plane state
Date: Fri, 15 Mar 2024 13:25:27 +0100
Message-Id: <20240315122527.344534-1-pl.dourneau@klervi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312084016.36136-1-pl.dourneau@klervi.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/12/24, Pierre-Louis Dourneau <pl.dourneau@klervi.com> wrote:
> On 3/8/24, Ludovic.Desroches@microchip.com <Ludovic.Desroches@microchip.com> wrote:
> > This patch fixes the memory leak but introduces a crash on my side when
> > exiting a graphics app using the Microchip graphics library.
> 
> We've tried to reproduce your crash with 6.1.22-linux4microchip-2023.04,
> to no avail. We'll try to upgrade to 6.1.55-linux4microchip-2023.10 (your
> version) and test again.

I was able to test a few more recent kernel versions[0] with the patch
applied. None yielded any crash, be it running Microchip's EGT samples[1]
or libdrm's modetest. Although, what I did manage to reproduce was a
refcount underflow similar to the one you had:

  # modetest -M atmel-hlcdc -s 32:#0 -P 33@47:800x400@XR24 -a
  setting mode 1024x600-65.48Hz on connectors 32, crtc 47
  testing 800x400@XR24 on plane 33, crtc 47
  [   75.736699] ------------[ cut here ]------------
  [   75.741353] WARNING: CPU: 0 PID: 200 at lib/refcount.c:28 refcount_warn_saturate+0xf0/0x15c
  [   75.749731] refcount_t: underflow; use-after-free.
  [   75.754574] CPU: 0 PID: 200 Comm: modetest Not tainted 6.1.55-linux4microchip-2023.10 #4
  [   75.762915] Hardware name: Microchip SAM9X60
  [   75.767198]  unwind_backtrace from show_stack+0x10/0x18
  [   75.772423]  show_stack from dump_stack_lvl+0x28/0x34
  [   75.777479]  dump_stack_lvl from __warn+0x8c/0xc0
  [   75.782187]  __warn from warn_slowpath_fmt+0x74/0xa8
  [   75.787158]  warn_slowpath_fmt from refcount_warn_saturate+0xf0/0x15c
  [   75.793611]  refcount_warn_saturate from __drm_atomic_helper_plane_destroy_state+0xd0/0xd4
  [   75.801894]  __drm_atomic_helper_plane_destroy_state from atmel_hlcdc_plane_atomic_destroy_state+0x38/0x48
  [   75.811573]  atmel_hlcdc_plane_atomic_destroy_state from drm_atomic_state_default_clear+0x1c4/0x2fc
  [   75.820642]  drm_atomic_state_default_clear from __drm_atomic_state_free+0x7c/0xb0
  [   75.828228]  __drm_atomic_state_free from drm_mode_atomic_ioctl+0x868/0xb88
  [   75.835204]  drm_mode_atomic_ioctl from drm_ioctl+0x200/0x3c4
  [   75.840960]  drm_ioctl from sys_ioctl+0x240/0xb48
  [   75.845669]  sys_ioctl from ret_fast_syscall+0x0/0x44
  [   75.850725] Exception stack(0xc8c91fa8 to 0xc8c91ff0)
  [   75.855794] 1fa0:                   004b0ec0 00000003 00000003 c03864bc becd7bc8 becd7b98
  [   75.863992] 1fc0: 004b0ec0 00000003 becd7bc8 00000036 00000003 00000003 b6f22f80 00000400
  [   75.872183] 1fe0: b6f21e74 becd7a68 b6f07494 b6f61cc8
  [   75.877289] ---[ end trace 0000000000000000 ]---
  Atomic Commit failed [1]

Same but without using the atomic uAPI (`-a` option removed):

  # modetest -M atmel-hlcdc -s 32:#0 -P 33@47:800x400@XR24
  setting mode 1024x600-65.48Hz on connectors 32, crtc 47
  testing 800x400@XR24 overlay plane 33
  failed to enable plane: Invalid argument

  [   98.542958] ------------[ cut here ]------------
  [   98.547547] WARNING: CPU: 0 PID: 28 at lib/refcount.c:28 refcount_warn_saturate+0xf0/0x15c
  [   98.555902] refcount_t: underflow; use-after-free.
  [   98.560698] CPU: 0 PID: 28 Comm: kworker/0:7 Tainted: G        W          6.1.55-linux4microchip-2023.10 #6
  [   98.570695] Hardware name: Microchip SAM9X60
  [   98.574972] Workqueue: events drm_mode_rmfb_work_fn
  [   98.579859] unwind_backtrace from show_stack+0x10/0x18
  [   98.587615] show_stack from dump_stack_lvl+0x28/0x34
  [   98.595201] dump_stack_lvl from __warn+0x8c/0xc0
  [   98.602438] __warn from warn_slowpath_fmt+0x74/0xa8
  [   98.609937] warn_slowpath_fmt from refcount_warn_saturate+0xf0/0x15c
  [   98.618919] refcount_warn_saturate from __drm_atomic_helper_plane_destroy_state+0xd0/0xd4
  [   98.629740] __drm_atomic_helper_plane_destroy_state from atmel_hlcdc_plane_atomic_destroy_state+0x38/0x48
  [   98.641947] atmel_hlcdc_plane_atomic_destroy_state from drm_atomic_state_default_clear+0x1c4/0x2fc
  [   98.653545] drm_atomic_state_default_clear from __drm_atomic_state_free+0x7c/0xb0
  [   98.663660] __drm_atomic_state_free from drm_framebuffer_remove+0x48c/0x540
  [   98.673252] drm_framebuffer_remove from drm_mode_rmfb_work_fn+0x68/0x84
  [   98.682495] drm_mode_rmfb_work_fn from process_one_work+0x1b4/0x3f4
  [   98.691390] process_one_work from worker_thread+0x214/0x4e8
  [   98.699587] worker_thread from kthread+0xb4/0xd8
  [   98.706824] kthread from ret_from_fork+0x14/0x28
  [   98.714060] Exception stack(0xc88adfb0 to 0xc88adff8)
  [   98.719125] dfa0:                                     00000000 00000000 00000000 00000000
  [   98.727327] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  [   98.735520] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
  [   98.742219] ---[ end trace 0000000000000000 ]---

The first one is not deterministic, you have to try a few times to trigger
it. The second one is a hit every time.

Same commands on a kernel without the patch don't report any underflow.
Note the commit in the first command also fails on a kernel without the
patch, which I guess is expected as plane 33 is the primary plane and I'm
trying set dimensions that do not match the size of the display. The commit
succeeds when invoking with the correct dimensions, but then I can't make
it produce an underflow. Same with the second command.

It seems to only trigger once per boot. Running the commands again does not
yield another underflow.

Looking at the disassembly, this is an underflow of the drm_crtc_commit's
refcount this time. In the warning you had, it was on a framebuffer object.

Anyway, I'll go back to the drawing board, study more closely the resource
release part of the driver. Thanks for having brought up the issues with
the patch.

[0]: Namely, linux4microchip-2023.10 (6.1.55), v6.8, and drm-next-2023-03-13
[1]: https://github.com/linux4sam/egt/tree/master/examples

Pierre-Louis

