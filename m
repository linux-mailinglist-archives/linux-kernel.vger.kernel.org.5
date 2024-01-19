Return-Path: <linux-kernel+bounces-31445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A07832E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85E6289D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E219056456;
	Fri, 19 Jan 2024 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnqP8eXb"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB34856B71
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686870; cv=none; b=GW1RwOPHMFj3+CIW+1lquMzWRepCxHMUYeXLOZMuRyHta3ovWzh4rH++I6Q3drHf36hx0OVPodEg/xm9Jnr/d/L7Whb+zlxv9bRca6zNVIiJQBDFmHO0+clzFAsdMjPl4XHD9pdcArhBTYOGt8ipubCofBajpXN1xx5TdZ5HYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686870; c=relaxed/simple;
	bh=Y0JcJnqy3Dn6RKvJZKzPnPupBP3P2qu/sXGf3igKL0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxoOF19+z1blpqSMdUwcHpudu8ew9zbuw5Voy4P9+1/E5btuk6T3qeBQkK2jLBsDsmvX9yfk5ZVGL/ff1ypDqvlydXwvaGVWdDzu7gkTIG5hVQz5mwS3BhMASFP2z1OfetUZD7uo+eNMxsg1aBghUgW1VS80EMsrUwPGwCkmH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnqP8eXb; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ddec302e68so139068a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705686868; x=1706291668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mhh2ZhRu9KiZWKHPzosUKChvpXSmXetshKuywKmfueM=;
        b=NnqP8eXbEnUh6I653KweAGDYCZ5QEeFjxO0y2Y3Y+l/+H5N/coaquKiTINlEydXfV/
         CIB6nNhORwp7TbKmIsJsA7oKtFe2BPcQZBC/0Z+4EtH/wIjPLsxPA8d/mARnSejx5uxu
         p5UhoR1e3Ss1FmB5MtV7IS+o3vUVdr2yIhFxt+u53EBtkUpL3hhoMjqSaQDMQp/1RPJh
         bHg7f3tnlDelWB/b60KaGZe1z5nT3Chp3ELsvqHl1HJEI83OAk/px3e303o02ms9KPFG
         vbg3uJJ3xlxVSS1aA/7EoFiLtwybXfSU6LlAPkzKkAIdeVDc6IwrvcG4jHTgkcNXU5Dv
         7u1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705686868; x=1706291668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mhh2ZhRu9KiZWKHPzosUKChvpXSmXetshKuywKmfueM=;
        b=WVsmJ3f49s3oH/ZL5QyRkPpDJK3Zw3OFz+5tVUXxSEAchHgRkS8GywMln9wUaBVP8a
         aPy/t7y4EPrlT6SWHjHvEf+zDGw2z0BTqGC4/RLEsquSYGRtvUtraozgHmaygN1Mg0vd
         /ABNtVTHt5rjMZxpnz5DInI879N2fMeWmzvyyISD44BYjHNsQgTLnjrSlOcWXSR3/ed5
         dJkmyCOAu3NnXJMvQPRYIjknVTYStY9cUFRffa6K0TJG4vh12t316oyadTZ1eX077ruh
         bLYJzPsMsJTt0CjhxIPvJe8R4OAWO8jtffAZbbEnBq5hSWbkKaVH+OuxtlHrAxzWOeZs
         u3yA==
X-Gm-Message-State: AOJu0YyMTv+o1SZtJfCW6RFFJ86nG2EPGGa/XsVG/FF+4Xgcu9IizCKv
	mGYeQze7iXGwH9yVwhnB9dWGIE7wfsql4Ss7MQqTj+qa1vARDqVPBxWHrqVfJ78XNHHBR9WoczL
	XwNeIYfG+BM62RpOZuPAC/GYij5s=
X-Google-Smtp-Source: AGHT+IER7y62btloXzSo/unkZ+dMzfanmnio0IddGIAnWSKjaIHg8zw04Zop+g9zr766X9wugaW17z8srndYEEdlUEg=
X-Received: by 2002:a05:6358:591c:b0:175:fe85:62f1 with SMTP id
 g28-20020a056358591c00b00175fe8562f1mr173044rwf.3.1705686867552; Fri, 19 Jan
 2024 09:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CANpmjNN-5PpSQ1A_9aM3u4ei74HuvCoThiLAHi=reXXQwer67A@mail.gmail.com> <CANpmjNM=92PcmODNPB4DrAhfLY=0mePCbyG9=8BGrQ4MC0xZ6w@mail.gmail.com>
In-Reply-To: <CANpmjNM=92PcmODNPB4DrAhfLY=0mePCbyG9=8BGrQ4MC0xZ6w@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 19 Jan 2024 22:54:16 +0500
Message-ID: <CABXGCsM+9TxxY-bOUw6MyRV7CSZsyQpfDgvwgaBBKk9UONJkBw@mail.gmail.com>
Subject: Re: regression/bisected commit 773688a6cb24b0b3c2ba40354d883348a2befa38
 make my system completely unusable under high load
To: Marco Elver <elver@google.com>
Cc: glider@google.com, dvyukov@google.com, eugenis@google.com, 
	Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 4:00=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
> I was afraid this would happen - could you try this patch series:
> https://lore.kernel.org/all/20240118110216.2539519-2-elver@google.com/ [1=
]

Thanks, this patch series definitely helped.
I can again work at the computer when something is compiling in the backgro=
und.
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

> In addition, could you give some additional details about the number
> of CPUs in your system?

Hardware probe: https://linux-hardware.org/?probe=3Dba941d7a4e
CPU: AMD Ryzen 7950x

> And if possible, do you have a way to measure performance besides the
> obvious lagging of the system? It would be interesting to know if the
> fix in [1] regains performance fully.

perf-2d5524635b00.data -
https://mega.nz/file/Q0ACSI4a#QQ8Ntbw5zvP_YZMsXPzSr-PxLVCw8fwg2RJaVOghoOQ
perf-773688a6cb24.data -
https://mega.nz/file/F8wAgBZI#OQ75qLFyf2diFXrDs9bP6_5xDevVrs1KlNdeupWSJSQ
perf-with-patchset.data -
https://mega.nz/file/l8ZXnI6Y#SmrZpH2Em6xzlIZgJe50PwSw-zLK_4whRjx3t_058kE

> perf diff perf-2d5524635b00.data perf-773688a6cb24.data
No kallsyms or vmlinux with build-id
c64a03a51e9503a251dbec8e5267fb3ae51914f2 was found
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
    59.91%    +23.05%  [kernel.vmlinux]
[k] 0xffffffff940065c0
    17.88%     -7.89%  cc1
[.] 0x0000000000207020
     9.39%     -6.30%  cc1plus
[.] 0x0000000000225110
     1.37%     -1.29%  libpython3.12.so.1.0
[.] 0x00000000000647e0
     1.16%     -0.84%  libcef.so
[.] 0x00000000021720e0
     1.27%     -0.67%  as
[.] 0x0000000000002090
     0.78%     -0.54%  steamclient.so
[.] 0x00000000001ed915
     0.77%     -0.33%  chrome
[.] 0x0000000002892080
     0.54%     -0.32%  libc.so.6
[.] _int_malloc
     0.30%     -0.23%  libpixman-1.so.0.43.0
[.] 0x00000000000078a7
     0.31%     -0.19%  libc.so.6
[.] _int_free


> perf diff perf-2d5524635b00.data perf-with-patchset.data
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
    17.88%    +12.61%  cc1
[.] 0x0000000000207020
               +3.89%  [kernel.vmlinux]
[k] unwind_next_frame
               +3.53%  [kernel.vmlinux]
[k] kasan_check_range
               +2.54%  [kernel.vmlinux]
[k] debug_check_no_obj_freed
     9.39%     +2.10%  cc1plus
[.] 0x0000000000225110
               +1.87%  [kernel.vmlinux]
[k] rcu_is_watching
               +1.41%  [kernel.vmlinux]
[k] lock_release
               +1.24%  [kernel.vmlinux]
[k] __orc_find
               +1.21%  [kernel.vmlinux]
[k] lock_acquire
               +1.08%  [kernel.vmlinux]
[k] stack_trace_consume_entry
               +1.08%  [kernel.vmlinux]
[k] check_preemption_disabled
     1.37%     +1.01%  libpython3.12.so.1.0
[.] 0x00000000000647e0
               +0.96%  [kernel.vmlinux]
[k] stack_access_ok
     1.27%     +0.79%  as
[.] 0x0000000000002090


Thanks!

--=20
Best Regards,
Mike Gavrilov.

