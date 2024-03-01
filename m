Return-Path: <linux-kernel+bounces-88148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F85D86DDE3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE83D1F25B60
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882436A33F;
	Fri,  1 Mar 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dV58ST0I"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0A6A322
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284203; cv=none; b=VczFoW2Wt7v9lADV3zUceTw8MKve2DBc/w7L1AzDH8CzgHzmEI28bzv+Uz3J5W5Jm1TYTtbCEx7HT8zkbUYtQSDvPk/Xtuttz6+OCzg/V7/zyJD2uWQVuHzLxHj4tJGmCdeLdszzSz1qlfH1lqMUAZnxsA2qp7KolkqcO67wdKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284203; c=relaxed/simple;
	bh=mDeYp+/K2UzyizRtuI3W4E0SyYsHEQtnhLJ81m99uoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdPNf4o5gv/vZTdDZrO43+NK0wiaAgQbOXk2LN81RQ7wm3inI6175tGuH7QB8I9FXAMZ+1YqBgI8lVpgtom2NywQ3pWQvRv+UDjhrnp1cqk38jb5l2kGtCRASDoYK1MqtH6WqcgIeBxlXFzD6nM/nPHywif5ky+WR9YI35fYH/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dV58ST0I; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so33665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709284200; x=1709889000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/ANMr+3cEZ0ZNfgil/L+4To+nT1xIFH5lCy/naCOjA=;
        b=dV58ST0Icdi5amXIv94VWU5NSj+zzkGmaNd8ZUfVVws+y0iS4RP7nFbKN9HB3iWVam
         EX1vYP16Zb42DS5CWZTsx7xZ4eHOQtIDZmLwRIUCusHb5Jg14AxSJy1gI4xZVq4ZSq31
         zLSjy/sIeEsKP0rNpXmHxyIOGLUy5OOJAEBiBfWPNYBdlhIYG+I6hP6IlvSx8C49nyOs
         HjBlP8nE7MW+ptwShVPK8wuhjpWjeMBj0g0Vwg03hfkI5gHkPlTb2EgJmW2cD9uKZR5K
         zSj8wf0YzUuorJDjVAnJEYgzeqq/p6A1q5L8kQ2VBP18WCuxdxjD1+hHYmbuJQn1POYM
         CVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709284200; x=1709889000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/ANMr+3cEZ0ZNfgil/L+4To+nT1xIFH5lCy/naCOjA=;
        b=PRbhec0OimPGfmfxDQ9TUhvICJnwPwy1lmH7oAJcqc9DaOK2YAA2gvuZJPNhb/6LFE
         wqceLvRwkcheOz7B5WzfYi7QWZSVa3f7zczsaM4t1lsEUgos7aB8sfvZlACtWomgMS4S
         CzMNg0kRirIpt+BToIDjZQUC3HSxurBLSz86quKv/Ufb1HXI/sI4yKVp0L0IqVGz5dEn
         L2ssuFpbSuttiZURwByg9SAHQweAf/70QsgqwAa7/aNfZTtlf5YdAZYIZ2EVxpDhhSHw
         EvMcnsOyYcHn+l/nyIaVUQzXv4KQYr76j5FVBCNVpK68+Q8s+Px3kwIIUbidUVyZFQSz
         UuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7DuciCBwj3NpkDYSp/iVaPd062ptZimeWzepAwx8EMTzMpTNhFgyKpLQzgSIKnRPFvUiIMN4v83fco/VUGa51tPscnPPu6okVbnyd
X-Gm-Message-State: AOJu0YxUBGSAstuRTqHe7KKCPcGOQ9JjOubdahwRQ/+S/YLRDMEnRtFs
	MEaeKWRnaaMax4wFYef4b7fQQ1rC56ZX4KFgRe22I5TySPZLg6FtpQlM/+rCJoFTnq4Wl8Gzjot
	rTGHtVaMGa9blg2ZI3guPwRIDJyTWh+pQmGUv
X-Google-Smtp-Source: AGHT+IG0r3zRJ6YjzCctr3gWX3Rox3vswBptriUgnXzxYzsyJh67YHrS1JihMP5dxjTnoPKebA9b7afZP3LHMY2ozrU=
X-Received: by 2002:a05:600c:3b20:b0:412:c810:ff9c with SMTP id
 m32-20020a05600c3b2000b00412c810ff9cmr48399wms.1.1709284200186; Fri, 01 Mar
 2024 01:10:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301121108.5d39e4f9@canb.auug.org.au>
In-Reply-To: <20240301121108.5d39e4f9@canb.auug.org.au>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 10:09:45 +0100
Message-ID: <CANn89iKpsHTQ9Zqz4cbCGOuj8sp5CCYGHe3Wvk2cyQL4HPADkw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the net-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:11=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> After merging the net-next tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> In file included from <command-line>:
> In function 'tcp_struct_check',
>     inlined from 'tcp_init' at net/ipv4/tcp.c:4700:2:
> include/linux/compiler_types.h:442:45: error: call to '__compiletime_asse=
rt_940' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct=
 tcp_sock, __cacheline_group_end__tcp_sock_write_rx) - offsetofend(struct t=
cp_sock, __cacheline_group_begin__tcp_sock_write_rx) > 99
>   442 |         _compiletime_assert(condition, msg, __compiletime_assert_=
, __COUNTER__)
>       |                                             ^
> include/linux/compiler_types.h:423:25: note: in definition of macro '__co=
mpiletime_assert'
>   423 |                         prefix ## suffix();                      =
       \
>       |                         ^~~~~~
> include/linux/compiler_types.h:442:9: note: in expansion of macro '_compi=
letime_assert'
>   442 |         _compiletime_assert(condition, msg, __compiletime_assert_=
, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime=
_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), m=
sg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON=
_MSG'
>    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #cond=
ition)
>       |         ^~~~~~~~~~~~~~~~
> include/linux/cache.h:108:9: note: in expansion of macro 'BUILD_BUG_ON'
>   108 |         BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##GROU=
P) - \
>       |         ^~~~~~~~~~~~
> net/ipv4/tcp.c:4687:9: note: in expansion of macro 'CACHELINE_ASSERT_GROU=
P_SIZE'
>  4687 |         CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_wri=
te_rx, 99);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   99123622050f ("tcp: remove some holes in struct tcp_sock")
>
> I have reverted that commit for today.
>

I have no idea. Maybe this arch has some unusual alignments on
u64/u32/u16 fields ?

The patch should not have changed tcp_sock_write_rx group...

My patch reduced tcp_sock_write_tx on x86_64 from 113 to 105 bytes but
I did not bother changing the assert,
because the assertion triggers if the size of the group is bigger than
the numerical value.

So I could have added the following, but really did not bother.

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c82dc42f57c65df112f79080ff407cd98d11ce68..7e1b848398d04f2da2a91c3af97=
b1e2e3895b8ee
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4651,7 +4651,7 @@ static void __init tcp_struct_check(void)
        CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock,
tcp_sock_write_tx, tsorted_sent_queue);
        CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock,
tcp_sock_write_tx, highest_sack);
        CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock,
tcp_sock_write_tx, ecn_flags);
-       CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 113=
);
+       CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 105=
);

        /* TXRX read-write hotpath cache lines */
        CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock,
tcp_sock_write_txrx, pred_flags);

