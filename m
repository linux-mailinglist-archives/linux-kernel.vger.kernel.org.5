Return-Path: <linux-kernel+bounces-116428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E7B889CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF7F1F364C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BBA16ABCE;
	Mon, 25 Mar 2024 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QJ8oSI9d"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365837D66D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335729; cv=none; b=XOHwtxHCo85wbJ7CmC/QHkHheSShXAqgydj54IO4C2mSVkFnt4QXt+lSar9tXdp4BDHgiyvk7IDIc/Z5lLqaAG01oz46F8ULBCHLtcg1cm8Wlu4shnii+gwjTZErU9l8HKpbTBOqIvSSeJRAtS3IclDw2tgSJ/KZZsCdeML4BHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335729; c=relaxed/simple;
	bh=TwSsbGoAzrMlvSmqLjXTibrvNixlaFbTE5ouixSO704=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQkTJT8AWt4HbO6aWOv6J7y0cbYwjBapYTRIEm7gyOA8ludVsL4C9XQFEvaW4vclJu2RYGHbRr9jpc6QqM7wuODZU7KDDeQnHYJR4SVm1puAty8BVGIODkkC6mreX3lE+xeoKA3wJmCO5uflp8cMptCQ6y8y6VspYAiHQxEpsdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QJ8oSI9d; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so47646991fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711335724; x=1711940524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGZHB2WZTfvTK8AUGI8LedlLw/3bzf9ZOZw9kvDSlsM=;
        b=QJ8oSI9dFk5VyP06hyuzq+6oQV3JDucC0yuoAs9DY8KEVdUbCRMGpBTRCBkqELc/Gj
         dAuAvwEkYkblXqZcx8G8G1RzBq1iyL/mKNe9pI86nRFiOxcOTDCsBzuZMmiYlBfHmIzP
         pOFCGGnqkQy7KZPMFGcdRYNg2UWf4/VFUa0k1TltWw+Z/rVTNFvx9Ra4tgrX+fSo+9uE
         2iVFlrWFc3rITUWyrz694ZsO0+rdGyJ6C765eW9rlk8uXxGaRxY7RpcqGd0KQlJ7oPis
         XJjhdleA3MdYS9GPDAjU05wN6Bmxg9oIgWYrzgywV5A0iUty6rG2NIsmUl1MxTFn9ZCe
         Uiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711335724; x=1711940524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGZHB2WZTfvTK8AUGI8LedlLw/3bzf9ZOZw9kvDSlsM=;
        b=BrfPNpYCOuZ6gPYS10n5AyTKmBcBcalyXMWf0iqxtZNTLLS40dJvSAUEE1V/1B47S8
         AMF8ixRf4whvQODa3ml+h1AGAufHt9w0DFwIP4QrTjFczRDMjPQwXUOecdWHxe89Amih
         p3KBVrEgHMVe17CdPv2+wTzGXbq5UDpqllzD+SfoYXAl3vT9KYNTV2HPQOJS1FiCYj8k
         tBH66f+w9VnwXmZUzw+IO2g5+xJkkSuW4Nfpth+P7fgYMoRhuauITlHe2pRrnoFBiswC
         gFuCp7cAjZVp1wohoehsPajTRwmwA/Koem9ROSqrZdj9TBm/FXzQCp0/qExNfTdc1bDa
         BtXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm2//uMVxRlFEyT0AiAa/SJncXFkzyeEZx85e4p1XtV4cSKwMp5p4oRfek3PR2vyBZAntO+1OtB1WqMBs19RL6GnBuOh+tmr5Q1KBd
X-Gm-Message-State: AOJu0Yz/FQt4zeuuyVnY+rabY1/OKZJzOLi8AktfkFvc8F3ZxSaBNWrb
	vZmjQsqKaEHpzi7F9aFAq2t/4LxNSdJGJBLM5OOOLWNF8U54jdQSPyiBmgztpBJK0+ZAv5C4cC4
	SBQRVZQofPGtg4CCKMBTDz3YYCaORrIhbSWwDhw==
X-Google-Smtp-Source: AGHT+IHSwGHPA3VAXSaD502fc6IbNOyaE83xzpb1sU/fP30IgGWmj7pWuPu1y6z0fWpl0amuLlGajV0ai0CcIJ/zlkA=
X-Received: by 2002:a2e:88d0:0:b0:2d2:206a:2f2a with SMTP id
 a16-20020a2e88d0000000b002d2206a2f2amr4041890ljk.17.1711335724075; Sun, 24
 Mar 2024 20:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324210447.956973-1-hannes@cmpxchg.org>
In-Reply-To: <20240324210447.956973-1-hannes@cmpxchg.org>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Mon, 25 Mar 2024 11:01:52 +0800
Message-ID: <CACSyD1OdHqcqsFQNyi52WkBpSec=mhg3UnZqdMcX0t+KJmMXgg@mail.gmail.com>
Subject: Re: [External] [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:05=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Zhongkun He reports data corruption when combining zswap with zram.
>
> The issue is the exclusive loads we're doing in zswap. They assume
> that all reads are going into the swapcache, which can assume
> authoritative ownership of the data and so the zswap copy can go.
>
> However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will try
> to bypass the swapcache. This results in an optimistic read of the
> swap data into a page that will be dismissed if the fault fails due to
> races. In this case, zswap mustn't drop its authoritative copy.
>
> Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=3DzV9P691B9bVq33erwOXNT=
mEaUbi9DrDeJzw@mail.gmail.com/
> Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> Cc: stable@vger.kernel.org      [6.5+]
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> ---
>  mm/zswap.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 535c907345e0..41a1170f7cfe 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1622,6 +1622,7 @@ bool zswap_load(struct folio *folio)
>         swp_entry_t swp =3D folio->swap;
>         pgoff_t offset =3D swp_offset(swp);
>         struct page *page =3D &folio->page;
> +       bool swapcache =3D folio_test_swapcache(folio);
>         struct zswap_tree *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry;
>         u8 *dst;
> @@ -1634,7 +1635,20 @@ bool zswap_load(struct folio *folio)
>                 spin_unlock(&tree->lock);
>                 return false;
>         }
> -       zswap_rb_erase(&tree->rbroot, entry);
> +       /*
> +        * When reading into the swapcache, invalidate our entry. The
> +        * swapcache can be the authoritative owner of the page and
> +        * its mappings, and the pressure that results from having two
> +        * in-memory copies outweighs any benefits of caching the
> +        * compression work.
> +        *
> +        * (Most swapins go through the swapcache. The notable
> +        * exception is the singleton fault on SWP_SYNCHRONOUS_IO
> +        * files, which reads into a private page and may free it if
> +        * the fault fails. We remain the primary owner of the entry.)
> +        */
> +       if (swapcache)
> +               zswap_rb_erase(&tree->rbroot, entry);
>         spin_unlock(&tree->lock);
>
>         if (entry->length)
> @@ -1649,9 +1663,10 @@ bool zswap_load(struct folio *folio)
>         if (entry->objcg)
>                 count_objcg_event(entry->objcg, ZSWPIN);
>
> -       zswap_entry_free(entry);
> -
> -       folio_mark_dirty(folio);
> +       if (swapcache) {
> +               zswap_entry_free(entry);
> +               folio_mark_dirty(folio);
> +       }
>
>         return true;
>  }
> --
> 2.44.0
>

Good solution and makes great sense to me.

Thanks.

