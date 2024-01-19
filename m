Return-Path: <linux-kernel+bounces-31604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492718330AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B852838D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1E458ABE;
	Fri, 19 Jan 2024 22:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xPZgwrvU"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C354BDA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 22:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705702126; cv=none; b=g9dATKjO05zyMMaPS5bqr0JhQZevZ8lJFuOCjMx8QFZ+lseyNlX5q6Zt0ex4VwJ9EPUZAO0twsWoTjvFMy5a2v64c1Hxh0+xlEgX8g9d/00Vnpxxg0zY4nHMVWRz5vvO0DCf25i64lPFjaB/KZUDPq88lvN2bOG4hkFzZgNqa4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705702126; c=relaxed/simple;
	bh=I+h5o8ZkdqHgAOD1hCY6AzkDWjWnjqpzJUeO4riFkuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEpQlPD5qXXBNrxPPwdUAurtKRGaj9CCMMooONKv4IAtUk9GPOOZV1kmybaJDVpSv9p4l/kHvAuUUpY/xh8DFVvUvz3rW8hDVi2xnKASIfelqgEarvlb4w5dZhT4zwgFIaTkyuZr8akLwv9F/3JgHbjSY8UoFMaZ7DMCg0oQS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xPZgwrvU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-559edcee495so1424053a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705702123; x=1706306923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbi1G6F8BUFvl4DD/h7+WYMvisIsLuju9f0daY5rOe4=;
        b=xPZgwrvU22DYbkuTzU+V7/8K9FVdiPFOMUfjfx+gZB4+z+T2tqwEftKBwfy04ps5QN
         OV8NYMoHwoKIhb0BhKRU6PWA5JHgTm/YtNxvQB5NimrZuSvvi3sIli3kUOUsjQIzD9BT
         rN2PEYq6JMx7OHC4gzAfUjBxRCXmeb0Y3mtX4FbKv9dMve2EtF/rGRlCHf4W2j+Yj1DI
         p+4AQqmR5drG3/RqUg5vOhgg/GaXIenONJMYRCYsFR5maanvAn9DnsC/LsTsGsb9Hbqp
         CGbIsJ1CYhtpu7lKo4TFHMSZ2qxzaRdwUnzySNyTQGEbUay84DiOmk9R/xiKgAEtCZQi
         9Tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705702123; x=1706306923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qbi1G6F8BUFvl4DD/h7+WYMvisIsLuju9f0daY5rOe4=;
        b=aH6wJgif8ZWPOMbcJPH/7U45AVqTCDL9g6NAItGuVdFODzxQIFWYGJ0fWLGVnZm95F
         C90uEAACOFJlUeTsqy+wpjNCl5UvpnbEsjVEkbsKTcwggB/yE3IjEl3KVvr1yEDKZQ99
         WbsG99mygfJ8JXXRoOt7tSpZvadaej1h7nCyF2FpWt+bEVM4+wcDm5S6gdaUY51zooQV
         BwvhlRVSD+B3AUNo7RCuz3z5Mp6WVvXUkZBZrs4VcbDI+9gd8N9Jo9Cxj9g2/Z6GB8Bo
         6FHYXfnKLBebOLyjbJlWIyghQzhHBc81053My4P+diezZdh/vqGuaQW5hrTnaBnfJNOk
         iZDw==
X-Gm-Message-State: AOJu0YwHgmnV0PYCrMR0FFBe/7iE4La0RTQLccDhgjA6KDJL55tCtkoc
	dl5OIwXZ/FfoTymEW37pehK/ez4kDAZIDQyoHA2Yn84Nzjou+6QQMeusfZWt3IVdpQCb9kgPFN7
	GRFtDqmo8/RD3utjSc75b4UqD9/fmUySvY2AV
X-Google-Smtp-Source: AGHT+IGONCOvMnuFAD7rG72w0oyYlQhTNSLHYjcvFhVaVyuiDcnkqYf6cR+YO+/Ym4kJDQfLohY/N9ODdz3qcYsUS0g=
X-Received: by 2002:a17:907:2812:b0:a27:f465:298c with SMTP id
 eb18-20020a170907281200b00a27f465298cmr227334ejc.124.1705702122995; Fri, 19
 Jan 2024 14:08:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org> <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
 <CAF8kJuO5tAqwyKQK7AasWgs3Ohfc2osD9oX0m8YAkfsAZsjjyQ@mail.gmail.com>
 <CAJD7tkY6K8q1t-nzZ7oJu-f3OgS654PiOcQgU=E6f+0joYSzPA@mail.gmail.com>
 <ZarV0Iyq7Wor_Dvc@casper.infradead.org> <CAJD7tkYTU10W4WX3HXzs3t4hKRLZ0saX0Nd8RDcaoYj58bzbsw@mail.gmail.com>
 <CAF8kJuOvOmn7wmKxoqpqSEk4gk63NtQG1Wc+Q0e9FZ9OFiUG6g@mail.gmail.com>
In-Reply-To: <CAF8kJuOvOmn7wmKxoqpqSEk4gk63NtQG1Wc+Q0e9FZ9OFiUG6g@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Jan 2024 14:08:04 -0800
Message-ID: <CAJD7tkbKZqOwkDgNUQ7+XCHs_Uqb=gbCk7L=Es4sR1T3wWG+gA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap.c: add xarray tree to zswap
To: Chris Li <chriscli@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 2:05=E2=80=AFPM Chris Li <chriscli@google.com> wrot=
e:
>
> Hi Yosry,
>
> On Fri, Jan 19, 2024 at 1:41=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> > > if your code is naturally structured so that you delete the entries
> > > after freeing them, you have no reason to call xa_destroy().
> >
> > Thanks for elaborating. Based on this, I believe doing xas_for_each()
> > { zswap_free_entry(); }; xa_destroy(); is both closer to the current
> > code structure and more efficient.
> >
> Can't do that in this case though.  Because you get the RCU read lock
> on the tree.
> Other threads can still lookup the xarray (also RCU read lock) and get
> a pointer to the already freed memory.

During swapoff no one should be trying to swapin or swapout, where
would the lookups come from?

