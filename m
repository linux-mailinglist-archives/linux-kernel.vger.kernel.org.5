Return-Path: <linux-kernel+bounces-40439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F0583E024
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D728B216C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051EE200D8;
	Fri, 26 Jan 2024 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+BL9r2p"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1F1D6A6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290299; cv=none; b=k/PlhX5+RCJtMmoJKMUqcmjnDINEXvHfIjerFW72BbqZWJBdPuovcgNmrPh5UfdvDlSvqBiWvLqGFA69lTanloLN0Iuq0XXltigk64EcXzlfHqidjmyY7uxOrwFto48LGRvXVtQ5/k6H1Vk2tDeaquv6B25MJRb3i/TL1D/Pfn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290299; c=relaxed/simple;
	bh=802X38QQjF+xW1fF28bSOTaC5TTqcgGoMPJtqfAsHSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQ7PnAf3IRguSMch+le5eXUWUkvnDM+CUTOzep9XQk8WBIZvLLYkbBXeO5KxgHPAiB+lPITzg/VmrIB++LB5WH/Q4THENsD21glgOuineq9hLR873ZJlnasegv+9G0a2tG2YHxwCmV2gDxN2D1+2SiQwhvyWjJANJKfuy5zN1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+BL9r2p; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d7881b1843so6003425ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706290297; x=1706895097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnmh6Oth+tI6D8+irCPnK2QidXXehtdK72TQeIMhu+0=;
        b=c+BL9r2paXsa2THngRs3GX0eoS9UdpEdq2vGAHujOZ2CsAUtvfBc/0NAHZJRrNMyo+
         GfQ5KQ9tLQkJVAJpFbZFjh126F7YxGJSwpoIUYH/a/bcaGxkXTp42KQ9QFOlN7qFxL4g
         mOued7siryWpwTwhiZdD6MsSH5Snj91b2GKiAHrqNm3BVCXKobJYi4Kdpm5yAy8ToiWG
         ZMTB5GGp3eCmk4JNxoT/VM6vMyUOk6thTtfQ0jXSmdRuQICJ/g5XDQCIPQmh8GxI9TH8
         76o6bAXGaO2/1xTfzQSJKcVWp26GwQIsOnWtlNm/JevVmvdhiXkf4pTRX+uifAlt2k/T
         0UqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706290297; x=1706895097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnmh6Oth+tI6D8+irCPnK2QidXXehtdK72TQeIMhu+0=;
        b=jYKoGHBTAO8wydA+xXSWBHd6Q1dMde9gLEezX1usnHav7yVpuV0hV7XVyBqgcamOUL
         2vOOe5ADn8yhSBlEDE7byotkYepfKwraV4C/epNN6cUr8OVpA8MhCAKTv0Im2Jh+NY+O
         ixZMcGlht1pcauzBZVH/3nr8GX1k3Tio7IF4SdBDsgRCzfCuaWUFg6yWjtgf+i3tKEHb
         FvyezxndsemwMJLkueecDh6al4pDTv31fAjXn1gXuDNFaguFsRTJMKDiSBbkWtD44atv
         1KdgqVU/3ZMtAkEfiRdy7yP5BTpFdngylzYWzqdOJM1VYHGqwhYOm18mRdprIQ6IIPoS
         FlWQ==
X-Gm-Message-State: AOJu0Yw2TzDLl4rNng7q82IsKBcE+dPoX/2R277p57yF8JD7wKlMi48B
	G+G2VrKB8teiESrSGkzHPcN93n28QUmXDVonMWUMDmspzw+jZFdDDKfyi6dBWgT5/3V2H17gLPq
	Qju/WBh13G/GgEHPb8LKFjhU5rg==
X-Google-Smtp-Source: AGHT+IHsBpA9CDP0HYeCGAZe7XwXu5b2iCw50Q/j+SN1PPeLO5GQntCdeKQEHQBxyKY2bYVXS/AyphIF0GtDsYwCJhg=
X-Received: by 2002:a17:90a:5d07:b0:28f:fc51:ad43 with SMTP id
 s7-20020a17090a5d0700b0028ffc51ad43mr201501pji.49.1706290297217; Fri, 26 Jan
 2024 09:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALGdzuqqU1PJ3BZ2PRtCHXyrsZ2xtzk38abB0=K7V-kOCYgHfA@mail.gmail.com>
 <ZbPnsnwnVKvI1rQ4@casper.infradead.org>
In-Reply-To: <ZbPnsnwnVKvI1rQ4@casper.infradead.org>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Fri, 26 Jan 2024 11:31:26 -0600
Message-ID: <CALGdzuo7V-3-US9U+rjyBfmZD=d-gUfAxJejsTUsmnSZNDnh5A@mail.gmail.com>
Subject: Re: [Linux Kernel Bug][mm/gup] 3 Warning Crashes: kmalloc bug in
 gup_test_ioctl, is_valid_gup_args, pin_user_pages_fast
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	Zijie Zhao <zzjas98@gmail.com>, John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Matthew,

Thanks very much for your prompt response!

For `gup_test_ioctl`, we generate the descriptions for it for
interaction and testing:
```
openat$gup_test(fd const[AT_FDCWD], file ptr[in,
string["/sys/kernel/debug/gup_test"]], flags const[O_RDWR], mode
const[0]) fd_gup_test
ioctl$PIN_FAST_BENCHMARK(fd fd_gup_test, cmd
const[PIN_FAST_BENCHMARK], arg ptr[inout, gup_test])
..
gup_test {
    ...
    gup_flags int32
    ...
}
```

In this context, I would like to seek your valued opinion. Do you
believe it would be more prudent to avoid fuzz testing the
`gup_test_ioctl`, or are the warnings in `gup_test_ioctl` an
anticipated outcome?
It seems that `gup_test_ioctl` can indeed be exposed in the kernel by
accessing /sys/kernel/debug/gup_test.

Thank you once again for your time and expertise.

Best,
Chenyuan

On Fri, Jan 26, 2024 at 11:11=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Jan 26, 2024 at 11:04:53AM -0600, Chenyuan Yang wrote:
> > Dear Developers for Linux Memory Management,
> >
> > We encountered 3 warning crashes when testing the memory management
> > with Syzkaller and our generated specifications:
>
> These all come in through gup_test_ioctl().  It's my impression
> that this is something you can enable to wreak havoc on your kernel
> and it's not something which should ever be exposed to fuzzers.
>
>
>
>
>

