Return-Path: <linux-kernel+bounces-39126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E03983CB28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF45296908
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117C1134732;
	Thu, 25 Jan 2024 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoD8mSgn"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058AE1339B7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207456; cv=none; b=SWkGDKeMnkM13BCGTyXXqJ58Jo7AXgjNgD8ZmXFotcKk2C5hMZzGuK1CNPFWad7H+RVgPLfYtpWhxXr6Rg8zRibuj+R4V4Y+2SY56V9QoCXtdox+dC0vKOJouGoF105E54B+4cGyJ+QWJq70AqYmWJ1WBBEOEiYwucg9XBmgszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207456; c=relaxed/simple;
	bh=CRB2jwMQ75eHS9B0tPOMRs3gBXANjoRAR19AibG3qK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQBL/sjpu5IHuqgRiWccc3wY6d0cnN8h4sUN6B+uc3OOmNfhqrIpUDn2rgJ9vxSry6T8PqiSU7mdz8gyvvUCfL5LxLUJiHT3u0GE8F9goUF+2y02yGFgGRKnjfQld275SQq7veRG6Rn1jmfYu93CY3vl+60/GGB1td6Eco/1f2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoD8mSgn; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7beda2e6794so28616539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706207454; x=1706812254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr8WYXXTG85MkSzKhBhuNtLC6TKS9e57DsvrjGC7Wys=;
        b=MoD8mSgnwJSFPdsOePJjRbND/dfBFvFL4zmr4zmiv5Ca0lcnkXV7m3j/zwCW3J/kF7
         EMzH1twgpy2sqRjC7ETQhjKpyuWkApC6xmt1DZzEDmmK3sA7JOnySMn4RrfeYKPqY3k/
         XdAzs+ua79lqOfAKZ++pTymIL8R25OUBG/IFQx4iGjXjfUHqKajY3PFN4UIrlvgmFWnr
         d9whnq6ZsvAOTrcjBkeh1y0QMQF3qA4OMH7HZlU/Rqyojkxjjj3UbIXN/3JF4r/CYBDL
         fWIFIy7GeKeJP4XT+XezqCtJh1VlKOr5B3LU6QjoiImO+9tBzfvnKVjYH/uIdT3bmTuH
         qbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207454; x=1706812254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr8WYXXTG85MkSzKhBhuNtLC6TKS9e57DsvrjGC7Wys=;
        b=J3cAMN1SRRR8q34FBuEKTMtYsr1YKBvzYVFVn3wIBLhTQsDk0FyTER0ulU6gqYFk3V
         u/Z7zoNT15TG0fcrUA7Tf1UWqQeOPrcHdmdSpQ+42rFVKuy3nV8+rm7pYDr64E3gEwib
         esNlWSUQLrdapVinrmk5Y0L54O0fzCZF4HRdy8owPdWN6/I0K8/b0zsiAxBXzR3mwbFz
         4ybfsmz9Ci1+WnJihMRfOelwD+B6mgQqrp8uoaInVqCuD4z9vtViyONnrAVEzoodMeSP
         5qYBFWyfIdog4FYhjz3oCtAwcIrSW0qSVhHmQGTzcpqA6V2dL4FnOS9DfiGMlqtugSoB
         XFwg==
X-Gm-Message-State: AOJu0YxSLp5McSAteJEX+ZUnmOgkcAQoYiVpP0o82ZSypK/QTyxbn8Iq
	JWcUms3F7tVjVuLxdtTZC+C7qpESxvwO2qE3SusbCFp37230drU7DDDannfETjKXD2qtOfqkXNt
	nni1MNlLFaO3SRUi0Agn3RFtLLN0=
X-Google-Smtp-Source: AGHT+IHDIPGdFzFzcMUyPs2hYtZ/8rT+6D3F2kndwqn+nggGohLGRnocHZkOcGHZnBEpE7KVzeCooOzSaqrpsu6huMg=
X-Received: by 2002:a6b:e210:0:b0:7be:f42c:2b62 with SMTP id
 z16-20020a6be210000000b007bef42c2b62mr197688ioc.14.1706207454016; Thu, 25 Jan
 2024 10:30:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125081423.1200336-1-yosryahmed@google.com>
In-Reply-To: <20240125081423.1200336-1-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 25 Jan 2024 10:30:43 -0800
Message-ID: <CAKEwX=OROzSF6QUjm14kn036Amvumv9tGjWc8xorDtazDOkBPg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: remove unused tree argument in zswap_entry_put()
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:14=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> Commit 7310895779624 ("mm: zswap: tighten up entry invalidation")
> removed the usage of tree argument, delete it.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zswap.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 78df16d307aa8..8f4a7efc2bdae 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -569,8 +569,7 @@ static void zswap_entry_get(struct zswap_entry *entry=
)
>  /* caller must hold the tree lock
>  * remove from the tree and free it, if nobody reference the entry
>  */
> -static void zswap_entry_put(struct zswap_tree *tree,
> -                       struct zswap_entry *entry)
> +static void zswap_entry_put(struct zswap_entry *entry)
>  {
>         int refcount =3D --entry->refcount;
>
> @@ -853,7 +852,7 @@ static void zswap_invalidate_entry(struct zswap_tree =
*tree,
>                                    struct zswap_entry *entry)
>  {
>         if (zswap_rb_erase(&tree->rbroot, entry))
> -               zswap_entry_put(tree, entry);
> +               zswap_entry_put(entry);
>  }
>
>  static enum lru_status shrink_memcg_cb(struct list_head *item, struct li=
st_lru_one *l,
> @@ -924,7 +923,7 @@ static enum lru_status shrink_memcg_cb(struct list_he=
ad *item, struct list_lru_o
>
>  put_unlock:
>         /* Drop local reference */
> -       zswap_entry_put(tree, entry);
> +       zswap_entry_put(entry);
>  unlock:
>         spin_unlock(&tree->lock);
>         spin_lock(lock);
> @@ -1754,7 +1753,7 @@ bool zswap_load(struct folio *folio)
>                 zswap_lru_del(&entry->pool->list_lru, entry);
>                 zswap_lru_add(&entry->pool->list_lru, entry);
>         }
> -       zswap_entry_put(tree, entry);
> +       zswap_entry_put(entry);
>         spin_unlock(&tree->lock);
>
>         return true;
> --
> 2.43.0.429.g432eaa2c6b-goog
>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

