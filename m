Return-Path: <linux-kernel+bounces-63140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4089852B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A12A28136C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39571B5B1;
	Tue, 13 Feb 2024 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eTANGQE2"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B691B592
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813969; cv=none; b=mC35a7apiQxzk6Hu+MDD/t1BYfWqGn+9pnqrFk50gput/6eyjtWMLJYkOwPnN/PgmVL1BjrMslI7kX6ICfpo/pax3QpEBcqMCtNIQUV2MIpQK20OPoWztlGGAEofODasr2DphgPSaIzHp5VjOzHMeHOLYmnlGlzotGsAlokSbgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813969; c=relaxed/simple;
	bh=SFj1O+gIc6/mjCX6EwhFyiNF8sE1xceTeC5fREpN68M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIMlt6aNVZ4toUagtokaOLUuwdoU43pKJu3BxY9Rcg8YqDrpuqV9CJMLt3SYBvqgKCm59J+sNbzxaD0LN0mHjnlPt93nnB71fahwFcN7ehSKaZEn3viSXyexQqbb6PQdbNNBogm+L/uASfnG3FS4YYu7dQIN6smfK4xAZ5sia7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eTANGQE2; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-46d5f87548fso2258257137.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707813967; x=1708418767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fzcuV2n4iA/l5qKMVwHfprJqu/PSyuIZf0nPPISMLpI=;
        b=eTANGQE2vWF+DzuhgAdt8a7rN/oP0oIeXUYQx6E3pZdFW4jHt1dEeXvRY9TbRtKuxx
         Efj4UAUQgvj/1pkcIy+LahX6cif2yRD0o+8kDNGKLHjSDc/xiOeE32eCJs2kfa1vNPSC
         xDAwmQYVuxr1fhO1/xvVVvqmyTKYixQldnVWbVrRjNI3SvBoIaRhNL8RrFifQc+J0aQY
         rLFdZQT6TiR4iI8m6vt3jTY73JeKlTeL+jDbyi+35RP2s+D7JmGo0yMqP0asorqfneZK
         wMCWvnk3feqPYxQeVIFCLW78H7HTnffkg+L2f3dTed4/jwsZAcNP/NtWmmNJgxCh9eOL
         ttFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813967; x=1708418767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzcuV2n4iA/l5qKMVwHfprJqu/PSyuIZf0nPPISMLpI=;
        b=Kw/5Pc9Dl44BTRT9oT6E1FBBd3UAFi3ponbj2RKKWZgc5SQGZZOIB9Dbl7WG6qBAu4
         S+6Q3VUQbBJ8SmnX7Z/FxXAtVuNeIKkrgJhBO8+cIMrpT/RnNHAgaLecYMf5H6L63Eud
         +7D+xZht/kBfnjOeATMX8yuHNlWoqcQULVUBdzJsffbJMw70eEi2iWEtzuApH097VpPl
         F8zu/8vcp3b83r4+AZac6mjDw1lLbL74EX3X45PnQJfKusxBpFiKFWzPpABXAVEvalro
         faEYj2iQbP7nyXA6ki/Sxb+ePT14CDlvHkmxaoJ0DcgscXVRj/zl/rqhPZ+TiKrCrF/j
         lgBQ==
X-Gm-Message-State: AOJu0Yz1vSqrC4sXnUfMZKuOBZEtgZXeVIehPhdWs+ME53/n0ytVZpkV
	yKBC+8AaPD9aj8VrBUGwrMnUd9q3M5ENDnNPF2sV4W2TglN6+Kbu976eVILhknqHQJiO1Q0DkY/
	1yqLidWC1yaDHriIynpOWpQisVnfYFfihQm9B
X-Google-Smtp-Source: AGHT+IGET/tysWO1JG0UEp1toY1w2DREDm4WQBRq/SnNElHOPrJ87+Rie6YKbFWNpo6ahQ+5Rtjv8x9B+YM05gjb0YA=
X-Received: by 2002:a67:f649:0:b0:46e:c5df:2b15 with SMTP id
 u9-20020a67f649000000b0046ec5df2b15mr1375250vso.15.1707813966660; Tue, 13 Feb
 2024 00:46:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212223029.30769-1-osalvador@suse.de> <20240212223029.30769-6-osalvador@suse.de>
In-Reply-To: <20240212223029.30769-6-osalvador@suse.de>
From: Marco Elver <elver@google.com>
Date: Tue, 13 Feb 2024 09:45:28 +0100
Message-ID: <CANpmjNMaUHMNmA7CxZkGUsJ7LCmz+PGqYAzTKxq=u_Osu8Y4sA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] mm,page_owner: Update Documentation regarding page_owner_stacks
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 23:29, Oscar Salvador <osalvador@suse.de> wrote:
>
> Update page_owner documentation including the new page_owner_stacks
> feature to show how it can be used.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  Documentation/mm/page_owner.rst | 44 +++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
> index 62e3f7ab23cc..bcde81bf0902 100644
> --- a/Documentation/mm/page_owner.rst
> +++ b/Documentation/mm/page_owner.rst
> @@ -24,6 +24,11 @@ fragmentation statistics can be obtained through gfp flag information of
>  each page. It is already implemented and activated if page owner is
>  enabled. Other usages are more than welcome.
>
> +It can also be used to show all the stacks and their outstanding
> +allocations, which gives us a quick overview of where the memory is going
> +without the need to screen through all the pages and match the allocation
> +and free operation.
> +
>  page owner is disabled by default. So, if you'd like to use it, you need
>  to add "page_owner=on" to your boot cmdline. If the kernel is built
>  with page owner and page owner is disabled in runtime due to not enabling
> @@ -68,6 +73,45 @@ Usage
>
>  4) Analyze information from page owner::
>
> +       cat /sys/kernel/debug/page_owner_stacks/show_stacks > stacks.txt
> +       cat stacks.txt
> +        prep_new_page+0xa9/0x120
> +        get_page_from_freelist+0x7e6/0x2140
> +        __alloc_pages+0x18a/0x370
> +        new_slab+0xc8/0x580
> +        ___slab_alloc+0x1f2/0xaf0
> +        __slab_alloc.isra.86+0x22/0x40
> +        kmem_cache_alloc+0x31b/0x350
> +        __khugepaged_enter+0x39/0x100
> +        dup_mmap+0x1c7/0x5ce
> +        copy_process+0x1afe/0x1c90
> +        kernel_clone+0x9a/0x3c0
> +        __do_sys_clone+0x66/0x90
> +        do_syscall_64+0x7f/0x160
> +        entry_SYSCALL_64_after_hwframe+0x6c/0x74
> +       stack_count: 234
> +       ...
> +       ...
> +       echo 7000 > /sys/kernel/debug/page_owner_stacks/set_threshold > stacks_7000.txt

I think this example command is wrong.

