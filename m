Return-Path: <linux-kernel+bounces-126871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F89189423D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C53A1F22948
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54604D59F;
	Mon,  1 Apr 2024 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzv6H8Li"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD7E4D11D;
	Mon,  1 Apr 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990241; cv=none; b=lIhhobkng31Q4pHRzCTsjyo1WFwkMqxfprdhVztXi0IyXsMKu2mStz6BuLv5rYVep2jP4qMMYjSp+nU4mfNcwiH+snDcV+lIqjRXcwJPwTFwzRatxBILvRkgKVSdOGL4QkQl231vXdROjW2qsJinEp4ddzLcVQNVWnr5D3PXqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990241; c=relaxed/simple;
	bh=5awwDDBktLQM4l0OZm+d+L47DmrR33aIVMdFPJxYh24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRAxQfQchZXGYU26irbmcJOs5hhvBaz3epgknYGlC5ZELVvkSHUCMGQWiyObZQ0Ac8kS96yP2cPhijqUY+qPM4pA8/NcVHFI9zOHVOUyKK339ZRywtwxeaHO5U41fdiYg563iqNaVNEw+Si/pmcrvfUfimnic6UDHTZzYzmtKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zzv6H8Li; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6990efb56fcso1535376d6.0;
        Mon, 01 Apr 2024 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711990238; x=1712595038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFdTtQEhrlvUy6ZociJ27yi27v8XQ4Lcvn+acNNZdYo=;
        b=Zzv6H8LiDhEbkXP6/sfM66zlNGMnBKMvbXIrMkPGT0tB2Pp9zZ5s3DPeU1I50ocSvo
         S8Wwri7QvKgDl1uz5O6KEL4+/TEG6CX6hp7EJQSM5ZdBkDeuPBZ9UzW1bAzHFjVTh2NY
         etbSvxVkt37Ulg5nRCG9d4lq73i5xbRgasDx/ED/xZCbe2pLXzjP4+5QCSYbaxKwBBJW
         22wQuJf+5HnM9bTF/Ql4AjVc8d8y1Yd4BV8rC8w/OSUfa31dUX/xtJhvCs2QbQAgBch4
         1I2RHDsowjNyR3l6H5/Su4JgxUGrABONGPxTXJ4KX6sAINkv7BOBjt4yHUNyUmNJPnoL
         AoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711990238; x=1712595038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFdTtQEhrlvUy6ZociJ27yi27v8XQ4Lcvn+acNNZdYo=;
        b=aP/c88W5m8+tSV9ijBhKzLaJkcFWDJzFTyq4jF2jG25MrLxs/csp9SmwQWjaRSe8bU
         BJl9TmJo6saKY320g/mbV7ZVLp++l+TFI37do7wJJ+2C0FWJffqfhgLOA9cvkI2OneRP
         hEXxMnySj3Zu7kYE01kE0NEfUgDshNK6wy4QiS0bouPVHnWTRffU0o1w2GrWdpEg7/B1
         OknLT7oqajomkNCTlByPciRI7XAa7At8nOjw9dDuzBCyzZb9ubXQPiwzNlGBBHTYceTE
         wbG4ajPVE2y5yEpz/XAz+iVg2pf8VW9Pb9lxODdb3LMPcvDlERpGZDm/nU5vOr9slpoB
         lRnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj9aHr1HU+vDKJ3LJ1tPw/Dw659LuLHqKp+fC83an9JH8xGSc0BJ5ZnApO4kjE3ErW9E6NMMpQWzoD93DRdAl7BCVh3AAdANubdLU=
X-Gm-Message-State: AOJu0Yy7oKq0HffBBqao+vEo1K69Sh6SyghNiQKdbQZc/g2nadK4O/qL
	uEAwz3qpG4dqQg3jK/LfqLjeLg3/xzrQa6ZVoFmhjLCT3aAeeLY5XO0KOCWIPr03j8u9zjA/tG0
	Hd8w1D6FqVpVqz3MyQ5+0ObUXeyFvwJVTJAXMx4qvEbM=
X-Google-Smtp-Source: AGHT+IEJ8mUuXDzKZTVFgaRP6kPL5i+QnDb0aexndug9J4eMjlhKS4LGUyNBk+jzI9pa2CeDDyTQE1Gj1gFUc9emBIE=
X-Received: by 2002:a0c:c792:0:b0:699:dfe:6015 with SMTP id
 k18-20020a0cc792000000b006990dfe6015mr1890172qvj.5.1711990237905; Mon, 01 Apr
 2024 09:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNmEtrN9DK-XmESaPm_1xpXm8A+juE+44Jf6AK5JE0+TQ@mail.gmail.com>
 <874jcl7e83.wl-tiwai@suse.de> <CABXGCsMmRFW3EYJ3UvNd-LO7ZTOyoNqjc_3OAmaCDSL=LuxJqg@mail.gmail.com>
 <87v851e2di.wl-tiwai@suse.de> <CABXGCsNMBRUaY-V8mhUQKdq+CQW5+eGUWL_YCJWXo0cgh9bGJQ@mail.gmail.com>
 <87h6glt9zc.wl-tiwai@suse.de>
In-Reply-To: <87h6glt9zc.wl-tiwai@suse.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 1 Apr 2024 21:50:27 +0500
Message-ID: <CABXGCsMcazRvmiN4XtiHQCE9=dB=M=VsRqB=v+RPmtuhBL29DA@mail.gmail.com>
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592
 decrease 30% of gaming performance
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 7:48=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
>
> Then it shouldn't be dmix/dsnoop.  You'd better try profiling what's
> going on there.  e.g. try to get perf results with and without the
> commit.

perf diff perf-with-revert-587d67fd929a.data
perf-with-revert-587d67fd929a-beb45974dd49.data
No kallsyms or vmlinux with build-id
81ed128ee346c4f6a2595295d5b0f85ba85f770c was found
No kallsyms or vmlinux with build-id
5b7d215e519bfbc813e04bbb3850a08b8a8274c5 was found
# Event 'cycles:P'
#
# Baseline  Delta Abs  Shared Object
Symbol

                        >
# ........  .........  ..............................................
..........................................................................=
..........................................................................=
...............>
#
    44.80%    +14.98%  [kernel.kallsyms]
[k] 0xffffffff9f006bc0
    43.34%    -11.87%  ShadowOfTheTombRaider
[.] 0x00000000001d9da1
     1.67%     -0.70%  libc.so.6
[.] syscall
     0.75%     -0.21%  libvulkan_radeon.so
[.] radv_UpdateDescriptorSetWithTemplate
     0.42%     -0.12%  libvulkan_radeon.so
[.] radv_CmdBindPipeline
     0.35%     -0.12%  libm.so.6
[.] __powf_fma
     0.44%     -0.11%  libvulkan_radeon.so
[.] radv_bind_descriptor_sets
     0.51%     -0.11%  libc.so.6
[.] __memmove_avx512_unaligned_erms
     0.36%     -0.11%  libc.so.6
[.] __memset_avx512_unaligned_erms
     0.35%     -0.10%  libvulkan_radeon.so
[.] radv_amdgpu_add_cs_to_bo_list
     0.28%     -0.07%  libvulkan_radeon.so
[.] radv_emit_all_graphics_states
     0.21%     -0.07%  libc.so.6
[.] sem_post@GLIBC_2.2.5
     0.31%     -0.07%  libvulkan_radeon.so
[.] radv_AllocateDescriptorSets
     0.20%     -0.06%  libvulkan_radeon.so
[.] radv_CmdDrawIndexed
     0.21%     -0.06%  [vdso]
[.] 0x00000000000005a0
     0.23%     -0.06%  [amdgpu]
[k] amdgpu_bo_placement_from_domain
     0.19%     -0.05%  libvulkan_radeon.so
[.] radv_flush_constants
     0.23%     -0.05%  [amdgpu]
[k] amdgpu_vram_mgr_compatible
     0.18%     -0.05%  [amdgpu]
[k] amdgpu_vm_bo_update
     0.12%     -0.05%  libc.so.6
[.] __futex_abstimed_wait_common
     0.14%     -0.04%  libvulkan_radeon.so
[.] radv_emit_graphics_pipeline
     0.16%     -0.04%  libvulkan_radeon.so
[.] radv_amdgpu_cs_find_buffer
     0.14%     -0.04%  libm.so.6
[.] powf@GLIBC_2.2.5
     0.18%     -0.04%  libvulkan_radeon.so
[.] radv_amdgpu_cs_add_buffer
     0.14%     -0.04%  [amdgpu]
[k] amdgpu_bo_list_entry_cmp
     0.15%     -0.04%  libvulkan_radeon.so
[.] radv_emit_all_inline_push_consts
     0.08%     -0.03%  libc.so.6
[.] __new_sem_wait_slow64.constprop.0
     0.10%     -0.03%  libvulkan_radeon.so
[.] radv_ResetDescriptorPool
     0.11%     -0.03%  libvulkan_radeon.so
[.] radv_upload_graphics_shader_descriptors
               +0.02%  [JIT] tid 6669
[.] 0x000034d982fb9005
     0.04%     -0.02%  [amdgpu]
[k] amdgpu_cs_ioctl
     0.10%     -0.02%  libvulkan_radeon.so
[.] radv_bind_shader
     0.00%     +0.02%  [crc32c_intel]
[k] crc_pcl
     0.09%     -0.02%  libvulkan_radeon.so
[.] radv_emit_descriptor_pointers.isra.0
     0.05%     -0.02%  libc.so.6
[.] sem_wait@@GLIBC_2.34
     0.06%     -0.02%  libvulkan_radeon.so
[.] vk_common_CmdBindDescriptorSets
     0.08%     +0.02%  libcef.so
[.] 0x0000000002470460
     0.05%     -0.02%  libm.so.6
[.] __logf_fma

Here is original perf files:
[1] perf-with-revert-587d67fd929a.data -
https://mega.nz/file/EpZmXbgL#vEnxuODoB__jM6TwV6XbwC_TWMMqvT7qaWkJU22JY48
[2] perf-with-revert-587d67fd929a-beb45974dd49.data -
https://mega.nz/file/0lI31CDA#hKsv6vX7t5u-Sx1_p2E7-Y32-z5VFPlW2Y793oM-JRU

--=20
Best Regards,
Mike Gavrilov.

