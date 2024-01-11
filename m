Return-Path: <linux-kernel+bounces-23754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1615282B13F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2CE28837E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C3C4B5B4;
	Thu, 11 Jan 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R59vs6wi"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270204A987
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e490c2115so25755675e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704985309; x=1705590109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlU9CairkGmPdE7mvp0HFWtFNt4+Gjb65TjgR3sW9KI=;
        b=R59vs6wiJTXfvvomLRhincMVDBh0lW6PTQHf8ixR8g2Q0UkP1pe4WvBJSpZZukhEvQ
         jNTBq9/inZVXEUX8Cz0MGxV2xW8McwePopshij/chtmfT4/uYeNnNuBX47Rd9J1DaGgi
         1fhjcYmm1TbXo9FdZ4trV6ymWB5XfPnD3u5cWJwaIQ3ZszdMwM9Ndt8KYSlNovnKFL/h
         W3GZGcIsFXbEtoqkLG5bSAFvQ/9MSBrTh2EhGAyoFoF4tysaBaYStrTube+wHIOyJKKk
         vy2c++AIOU9x34KA0NoAjWTex6ahTrvC+Nqp8u6NcFs/na8m9UFR/UrmpC6dQlwQc5vO
         OGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704985309; x=1705590109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlU9CairkGmPdE7mvp0HFWtFNt4+Gjb65TjgR3sW9KI=;
        b=g58Gg0uIF/NEqdCRELLih4brjjAQ2fbXPwDVqt/1QX8yj2Ms/Y29Eg7SRJLxI2B7Ny
         saa7nBvUja80TeETT5Q6WsOJ9MikPppxSFh/xhgwlV1YUKvIfufi3YQbT9WgS/fRv0o9
         Atzk7ArpFqiT1C1TR9Bb9KHzv/QNPdFKhyGbaIhxg/HDzLphyvBTqIbfryT5/eLrRaJl
         XDeDZ7Bcv4+t+hvjRcsLmX9Oz+E0HEVigzHr0jUpP6nXIfUKbY970XTjATkeKf636C4V
         deJTyk/XXfGDINP5VLNqu5JV//oB9em6aGDXXQFmq9SgUZvQ6XxDFqn37GKEteuZvGYI
         M8CA==
X-Gm-Message-State: AOJu0YygcHLQDFRm2nsvFKXYm3hMMzRWABwXUFsMC5FHg9UUMQ9ras5R
	RlEp62vcal/oUJEgrge+Q9a0w7/OVHTbsBdeJFxeDnu8jl8=
X-Google-Smtp-Source: AGHT+IFc4QeDxDjZCAJ8PR28lluBukrSonJR5i+S0lw+3pGNGMdoJW4cFhXbrsFr6EuJWcoLvPnx8u/nBozbG7hTYDs=
X-Received: by 2002:a05:600c:46d5:b0:40e:56ea:d9c3 with SMTP id
 q21-20020a05600c46d500b0040e56ead9c3mr551988wmo.47.1704985308895; Thu, 11 Jan
 2024 07:01:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401111558.1374ae6f-oliver.sang@intel.com> <b1adbb1c-62b7-459f-a1bb-63774895fbb3@I-love.SAKURA.ne.jp>
In-Reply-To: <b1adbb1c-62b7-459f-a1bb-63774895fbb3@I-love.SAKURA.ne.jp>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 11 Jan 2024 16:01:37 +0100
Message-ID: <CA+fCnZcmxQn+hSsJf=WOsYX4HY4u4s=cRKje65pEcAQ5gpqANw@mail.gmail.com>
Subject: Re: [linus:master] [kasan] a414d4286f: INFO:trying_to_register_non-static_key
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	kernel test robot <oliver.sang@intel.com>
Cc: Andrey Konovalov <andreyknvl@google.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Evgenii Stepanov <eugenis@google.com>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:00=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Commit a414d4286f34 ("kasan: handle concurrent kasan_record_aux_stack cal=
ls")
> calls raw_spin_lock_init(&alloc_meta->aux_lock) after __memset() in
> kasan_init_object_meta(), but does not call raw_spin_lock_init() after __=
memset()
> in release_alloc_meta(), resulting in lock map information being zeroed o=
ut?
>
> We should not zero out the whole sizeof(struct kasan_alloc_meta) bytes fr=
om
> release_alloc_meta() in order not to undo raw_spin_lock_init() from
> kasan_init_object_meta() ?

Yes, already sent a fix:

https://lore.kernel.org/linux-mm/20240109221234.90929-1-andrey.konovalov@li=
nux.dev/

Thank you!

