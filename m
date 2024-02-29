Return-Path: <linux-kernel+bounces-87145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 060DE86D027
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46551F21C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97B84AEF9;
	Thu, 29 Feb 2024 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGT4IUcx"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C52383BB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226473; cv=none; b=XgHy8ERmEaHWR5dmKzsIe7k9qBLu9kEEjjUl4vnGMJsdjFXlrLImN/eYyucNrUfM3OB97xswdtIOxOTYj8sSGW08QelHQoat5KslWccD2eYq8le5hS8tUul128e9VHiLKejs9mPD3kVNFHhRWJZPkd+exFl147HGniwGW/JR7QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226473; c=relaxed/simple;
	bh=amo0eNZtd9oU8O56/+6pIemgnDn7UMyF4LASrdgemWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNZZVmkDbJvWnnyuKLbv51rNGnXtBxqKYCqU+qvAO3PWdqKJIg074LYYQITP5dNFXnSJQ6ksUWHyoOgn06KMWPbj3wfrQioniG5K1fsOqQs5eNTOmT7/rf9Pryevx5FuSJM4OX9m41z4GqpgsB7lvWqcyDgtSgljo9hkCsESjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGT4IUcx; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso15576a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709226470; x=1709831270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amo0eNZtd9oU8O56/+6pIemgnDn7UMyF4LASrdgemWY=;
        b=oGT4IUcxCY0Qbkn5onrXbU2sUUOaNSKb9T76wH1SVAQAIiAwAS5NCLpCsKNmHhoNng
         kVUsVHdUQ7iZDEj/JKarv/lsnPZdI3+9+99zC843Z2lrkbg/jr6AqzS11xDnGEBEPAPg
         /5WYJIgI9PDT0IAvalRMaAmv0ulcHjbWblY6XQ7nlvU4tovHBd2Qj3v8WrHMD6Yd03IC
         sb2UqGeUcW3dZO9kMkYedTygeenLBiWeIXMHgr1ZCvxD0hZusFIVkLm8lqoCMoLijc7E
         MLQl0xOyfY2pxs1FFEEuKqJdItlSS90PRZMKg9Z7j5Nt4vSotD9sS//qjowqPc+/y25M
         jzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226470; x=1709831270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amo0eNZtd9oU8O56/+6pIemgnDn7UMyF4LASrdgemWY=;
        b=WXdSFDreg2oqJiiH82Er3tPBZliJR1ZNqk0YC9OsHICVWDQfXkAXGMlTVsK7gKSIzn
         8LWy4dr6XQccezlurcnC9Yd4PIW59VJFOr9z86F0IVBI8tDGcAb1wEzVQUVv53kuzgln
         wPAh6kntkyHNqKOC/cjFT47/Prub4mCQJGeu3Fs0DrAzIYSNoGVJ5DIBQNwZ5MvJ9PXX
         4G9oAkiiGSURvmy1XgEGzMmf75nJm/+klvGd3assGhFl6fPM5GToyiTIKVewCr6zGD0g
         Xwkt30yOfV/iq1GK6weL4qfPtm5j2ahvrfWD1idZl0ehZz1EvrjELnSikyAmDnPb43MQ
         aKdA==
X-Forwarded-Encrypted: i=1; AJvYcCWZQGGw/39kuaptdfE9Je2OYYXu+BuLKWVdKcNhXT9huIGv78oA2JJswgU+LyUKEKrL6Pw0o8241NgUKo++OOv09r54nmXPrcNkcdCj
X-Gm-Message-State: AOJu0Yzz5Agrq8AdbP6p1rPjl+Tk3zWl4g763v1nyFvGObJbkwf5VK7P
	HmYu6RG5+UmWU83BvORpauEburFN9GC+hahkGBx7kpwpEQoR6cio5YYjzFI9jQqNmJmxBUrXUN2
	woFlhdGJ4Qa4VaimXEG29qFXMrI0ERT/LrZT+
X-Google-Smtp-Source: AGHT+IGjUaP2d8ryvQOL7I76Mhftue8l+Y6MKjxFwnbwPjrjVcWt+iNF8KdMk94wH9VJ9YPUvWsAk5cy4qw6oSF5Y4s=
X-Received: by 2002:a05:6402:2227:b0:561:a93:49af with SMTP id
 cr7-20020a056402222700b005610a9349afmr120493edb.7.1709226469560; Thu, 29 Feb
 2024 09:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
 <20240227062833.7404-1-shijie@os.amperecomputing.com> <CANn89iL2a2534d8QU9Xt6Gjm8M1+wWH03+YPdjSPQCq_Q4ZGxw@mail.gmail.com>
 <018b5652-8006-471d-94d0-d230e4aeef6d@amperemail.onmicrosoft.com> <b7825865-c368-1b72-3751-f1928443db32@linux.com>
In-Reply-To: <b7825865-c368-1b72-3751-f1928443db32@linux.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Feb 2024 18:07:36 +0100
Message-ID: <CANn89iJpZ6udACMC9EF=zgYJU5rqLFiTuYJRf1UNA3UKu7CxJg@mail.gmail.com>
Subject: Re: [PATCH v2] net: skbuff: set FLAG_SKB_NO_MERGE for skbuff_fclone_cache
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Shijie Huang <shijie@amperemail.onmicrosoft.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, kuba@kernel.org, 
	patches@amperecomputing.com, davem@davemloft.net, horms@kernel.org, 
	ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cl@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:01=E2=80=AFPM Christoph Lameter (Ampere) <cl@linu=
x.com> wrote:
>
> On Wed, 28 Feb 2024, Shijie Huang wrote:
>
> >>
> >> Using SLAB_NO_MERGE does not help, I am still seeing wrong allocations
> >> on a dual socket
> >> host with plenty of available memory.
> >> (either sk_buff or skb->head being allocated on the other node).
> >
> > Do you mean you still can see the wrong fclone after using SLAB_NO_MERG=
E?
> >
> > If so, I guess there is bug in the slub.
>
> Mergin has nothing to do with memory locality.
>
> >> fclones might be allocated from a cpu running on node A, and freed
> >> from a cpu running on node B.
> >> Maybe SLUB is not properly handling this case ?
> >
> > Maybe.
>
> Basic functionality is broken??? Really?

It seems so.

>
> >> I think we need help from mm/slub experts, instead of trying to 'fix'
> >> networking stacks.
> >
> > @Christopher
> >
> > Any idea about this?
>
>
> If you want to force a local allocation then use GFP_THISNODE as a flag.
>
> If you do not specify a node or GFP_THISNODE then the slub allocator will
> opportunistically allocate sporadically from other nodes to avoid
> fragmentation of slabs. The page allocator also will sporadically go off
> node in order to avoid reclaim. The page allocator may go off node
> extensively if there is a imbalance of allocation between node. The page
> allocator has knobs to tune off node vs reclaim options. Doing more
> reclaim will slow things down but give you local data.

Maybe, maybe not.

Going back to CONFIG_SLAB=3Dy removes all mismatches, without having to
use GFP_THISNODE at all,
on hosts with plenty of available memory on all nodes.

I think that is some kind of evidence that something is broken in SLUB land=
.

