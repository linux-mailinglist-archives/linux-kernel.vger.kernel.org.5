Return-Path: <linux-kernel+bounces-75702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C908385EDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB84D1C222D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D27B661;
	Thu, 22 Feb 2024 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="V4v3q5zW"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1064685
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560550; cv=none; b=Cdh+vZYUYNeHdWrIe4JDACC+FyZrHSJgdOlHfHWcyiuWG01HDV+Xw6KKunK2hxcme71gSkOhOS/Du+U1OHNp9WfMllhgCz1v8ty54EIARLjVNj6V3wxYVAWh0jDUvAOuyJIeTK5GJsB6lBB8Qwv/FIO+Gc902hI1C+K0tJ82W9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560550; c=relaxed/simple;
	bh=aiZ2wjkXdUeF2DZJw2oBIl8u+9EyfQfZ9ycNkF8fAgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEx7aiD864CqywevAYXtKgTc2jr/XXZ42P1XYqpiF1jiSLr67GDHsS2fvQTTintSmoDuUK2ZpWNj6V8vWVgqa59mqkhHHfKV+JD9Z8+X7GCMpRaIRWFWTLpz8GqElo3NWY/aUZDPd8l57fmg1E2L5wDSO4v1uEWgSp/olMNuwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=V4v3q5zW; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so4629626241.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708560547; x=1709165347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiZ2wjkXdUeF2DZJw2oBIl8u+9EyfQfZ9ycNkF8fAgk=;
        b=V4v3q5zWy6TRguaajZ4nQ7fJK1qziegRcyc2f4uuaXkZgb4nKEsRZW5usZn2/WC6UG
         2HWxXkyggg+HnHBE4LSYDAV3qlSVSEAJ7vgj3MpYcNlVANNi82gJyKs3TGO95H7vQQs3
         P+mjK3bnK/Tsa/y3lgPnoCSvSJbs2j87+GMbVDg3j9OYX0gZdOAxTTKJHTxjoXOw0Gwx
         0DKKNqPgam6bcmtKcoMyNXiATqMuN8yiT32970gwjqs7o9zipOX4DhXrYhTml3lKxizt
         +ishB81w04QpeSmjviwcPT5P0aChisMAKE13nexWROtuY9dinTAdSxKj6PHKgtTQO6OK
         fdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560547; x=1709165347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiZ2wjkXdUeF2DZJw2oBIl8u+9EyfQfZ9ycNkF8fAgk=;
        b=rLvXxCws7bsT5OCJzvlGxw7RqUkACUgohFX6LZXcyrT5wNgA7lV1BVHxNH7dG4M8d3
         6wOpkkEmnM/4VRp3hwO8Fy7ItN1dLx2BlQigXSYT3i+oZI/RgMmSejJf216Gul9ouISo
         RQlnnpHIjORvcd2O0N8wZyzesGTBicCsHP3xI04MKgT/BlbC831NTkR+dAy2dJyb1yjv
         ViFwSGu0dnKAq6Yd6WI4s8MkqcNtiKj0B4iiP+qO2T6cuAIXBNsoZ5WUEGhZrOFzV3oV
         /hVmIyDCB+m27WfnhDh4Ca76cq3mW9ghXHwtc9dNHIS18jj/9+NOBdIjO3sK3f5MAfL6
         Ja2A==
X-Forwarded-Encrypted: i=1; AJvYcCXJ0YwRUoJ4SJHGmEHgYhOrOakkyOXBlQ3EYX9V/S2Nh8YGYREZbFSmPS3o/A8obxpruai86IvAT8UKfGSByr7UuTlS7MLrsshrhBNa
X-Gm-Message-State: AOJu0YwRZuZEp7q6iE1bE5vq0Hs3/DfyKtwji9bzBZHfvGIcrOTbh6bJ
	4oDjYTTmmdmFuUTjzXE+vrZNLrQw7IdIJBC5c3wVgUeQml6UDiiyJslDmBRvTxGUUm7b3Hzbx0r
	YhYIRE8j1e2Rlpj/9X3tV1gJ6K+1n55nVPkxoeA==
X-Google-Smtp-Source: AGHT+IE8YdNcoy9yHPyWH3FSVi3grCuLLJ8fT8RNUBKoMQxE9UzcTUruywG2qiU3pKHX1/up6wOF6uOUyIuOPTAbvgM=
X-Received: by 2002:a05:6102:953:b0:470:605a:6a4 with SMTP id
 a19-20020a056102095300b00470605a06a4mr10156813vsi.21.1708560547208; Wed, 21
 Feb 2024 16:09:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-9-surenb@google.com>
In-Reply-To: <20240221194052.927623-9-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 19:08:30 -0500
Message-ID: <CA+CK2bD-AvHR45zWrLOGA7Y=HQeFf=Ty4vCB5bWxbX7XyMsYRw@mail.gmail.com>
Subject: Re: [PATCH v4 08/36] mm: introduce __GFP_NO_OBJ_EXT flag to
 selectively prevent slabobj_ext creation
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
> when allocating slabobj_ext on a slab.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

