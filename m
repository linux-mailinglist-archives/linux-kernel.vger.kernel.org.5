Return-Path: <linux-kernel+bounces-29740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6568312C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AB21C213A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E49444;
	Thu, 18 Jan 2024 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J9ObBuiU"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9F45CB0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559755; cv=none; b=IWwcaMF56ruzIqUFrw0J7raUAoioxi1YJKNjKyzhu2C0IihVaj0vBVqg9oxT67ZMReo6qFJXp8OUX5JDAcwqU3TBNfH6G/gYO/RiychCQnCluk+bvamHKnej+y7rezMOHpaP+d1vQ+HCplOGA1RukV7Oq9ABky70vZ0UExkWDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559755; c=relaxed/simple;
	bh=eTHiBnyqir1sEFqwoXdsbYZ1XGTsUucLPBVw+yxu1PI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=ZdeOZh2OiG/iSlah+yfQwNu8gkExfO+e4FG+XDyKven6DhVIZ4A7USZ+KpaVX9AiPvu3mC6XUHLrmANnaK8JCjabVyTfwAnFCKn/80c0+oM/fECyGi00MkKZ1dNBqOJ6rcR7z/X/Kw30yX9bhDbY8HoczAPZY3tqe0bzJCdlsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J9ObBuiU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2cea0563cbso884754866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705559752; x=1706164552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F6Z6wuTdIE3oI+ENMJR97SNTKTQo97xJmtmIXWm79Rs=;
        b=J9ObBuiUD/YGf3i65QumcD/nlhg1QTBRggxkZC1a8b/VcwF8Gqef32FwhnnpmQ4zcX
         YHTkPQ5JFABIkWCcqHfJ31ouMZhNr0ElHpgLC7NOPMvmxd/jm0k1fTVZlSAaHiXqfCJC
         9BYPovdvQW5X7/PnEuBHe4I0pNhg583y3Jn4rvvcpvS1hqBtrRpsUTi6G6uwcGF0iF4p
         3hD1wAZ232lMdmoBmGxtvzTUy1qyolxqgCp310vNPXbOhKmvrL+VQl3R4aNJg84ONywn
         HIW0nyxM72ZanV5s4CEaJ8/Op9cjRjmUhOWxW7mxOIjXyqm+/tFe0d3eF0rd6doQd3xp
         /xYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705559752; x=1706164552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6Z6wuTdIE3oI+ENMJR97SNTKTQo97xJmtmIXWm79Rs=;
        b=GxO31UaqhTnSdQjKVVNXTdx9CtEwpb7wHu9qwb+A0AKaLMDb3k21R3uzxxY3Qqxkca
         09u81WIBlnd8VXzcmea3lGiYiD86frJfyf7ombPd+Paozgq/9W9zWHw+1oBVH3ZMWC2a
         m15chsXlWR0iwDWmWPyE4hIRDDE8hROIWRsdzjeVOzAJMMzQkdgM0ok/bZ1VFDffg7Gl
         MPu8ima1NLn5aVNMH0tTsRhCsDJn+ed4fuV36jq2n8qNC4uMHNo5KrNr70oPsEs838bV
         P1TA/ZJjT2vyT770i3rAprlKPIQ1pxdzpST6yUQGIF7sXoB813tlnWoEIe7+088tDt4i
         jFvw==
X-Gm-Message-State: AOJu0YwkyPaXrppQkrc/t1Dgfr1BCf9njHx5uKpplQruZhX5V8nb9Ypr
	lqw2tCUBB+mOZuSJ4WeLXws21jxHmBeN1yUw3hRJfyuFwvKbq9leyPp1d2guj5O+AtFPKbfwjh3
	NuSlsB6m3Sef74Rnctz9Q5hBD3Iirox0lZt9Q
X-Google-Smtp-Source: AGHT+IF9WPH8KBIEm47kPYtcEi3P9fns4xjGcZxGxJfXJ7F/utnKCwSy+gT6g5altMwCfW0Gh/a6MGT+qR+StuUuPZQ=
X-Received: by 2002:a17:906:35d8:b0:a2d:a5b5:70ab with SMTP id
 p24-20020a17090635d800b00a2da5b570abmr195429ejb.100.1705559751871; Wed, 17
 Jan 2024 22:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org> <20240117-zswap-xarray-v1-2-6daa86c08fae@kernel.org>
In-Reply-To: <20240117-zswap-xarray-v1-2-6daa86c08fae@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jan 2024 22:35:15 -0800
Message-ID: <CAJD7tkZF102x_8LKAX+sxAttgYD_LNT3cRqeOr7_euwPfNdCFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap.c: remove RB tree
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, =?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
	Chun-Tse Shao <ctshao@google.com>, =?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

> @@ -493,45 +471,47 @@ static struct zswap_entry *zswap_search(struct zswap_tree *tree, pgoff_t offset)
>  static int zswap_insert(struct zswap_tree *tree, struct zswap_entry *entry,
>                         struct zswap_entry **dupentry)
>  {
> -       struct rb_root *root = &tree->rbroot;
> -       struct rb_node **link = &root->rb_node, *parent = NULL;
> -       struct zswap_entry *myentry, *old;
> -       pgoff_t myentry_offset, entry_offset = swp_offset(entry->swpentry);
> -
> -
> -       while (*link) {
> -               parent = *link;
> -               myentry = rb_entry(parent, struct zswap_entry, rbnode);
> -               myentry_offset = swp_offset(myentry->swpentry);
> -               if (myentry_offset > entry_offset)
> -                       link = &(*link)->rb_left;
> -               else if (myentry_offset < entry_offset)
> -                       link = &(*link)->rb_right;
> -               else {
> -                       old = xa_load(&tree->xarray, entry_offset);
> -                       BUG_ON(old != myentry);
> -                       *dupentry = myentry;
> +       struct zswap_entry *e;
> +       pgoff_t offset = swp_offset(entry->swpentry);
> +       XA_STATE(xas, &tree->xarray, offset);
> +
> +       do {
> +               xas_lock_irq(&xas);
> +               do {
> +                       e = xas_load(&xas);
> +                       if (xa_is_zero(e))
> +                               e = NULL;
> +               } while (xas_retry(&xas, e));
> +               if (xas_valid(&xas) && e) {
> +                       xas_unlock_irq(&xas);
> +                       *dupentry = e;
>                         return -EEXIST;
>                 }
> -       }
> -       rb_link_node(&entry->rbnode, parent, link);
> -       rb_insert_color(&entry->rbnode, root);
> -       old = xa_store(&tree->xarray, entry_offset, entry, GFP_KERNEL);
> -       return 0;
> +               xas_store(&xas, entry);
> +               xas_unlock_irq(&xas);
> +       } while (xas_nomem(&xas, GFP_KERNEL));
> +       return xas_error(&xas);

I think using the xas_* APIs can be avoided here. The only reason we
need it is that we want to check if there's an existing entry first,
and return -EEXIST. However, in that case, the caller will replace it
anyway (and do some operations on the dupentry):

while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
        WARN_ON(1);
        zswap_duplicate_entry++;
        zswap_invalidate_entry(tree, dupentry);
}

So I think we can do something like this in zswap_insert() instead:

dupentry = xa_store(..);
if (WARN_ON(dupentry)) {
        zswap_duplicate_entry++;
        zswap_invalidate_entry(tree, dupentry);
}

WDYT?

>  }
>
>  static bool zswap_erase(struct zswap_tree *tree, struct zswap_entry *entry)
>  {
> +       struct zswap_entry *e;
>         pgoff_t offset = swp_offset(entry->swpentry);
> -       if (!RB_EMPTY_NODE(&entry->rbnode)) {
> -               struct zswap_entry *old;
> -               old = xa_erase(&tree->xarray, offset);
> -               BUG_ON(old != entry);
> -               rb_erase(&entry->rbnode, &tree->rbroot);
> -               RB_CLEAR_NODE(&entry->rbnode);
> -               return true;
> -       }
> -       return false;
> +       XA_STATE(xas, &tree->xarray, offset);
> +
> +       do {
> +               xas_lock_irq(&xas);
> +               do {
> +                       e = xas_load(&xas);
> +               } while (xas_retry(&xas, e));
> +               if (xas_valid(&xas) && e != entry) {
> +                       xas_unlock_irq(&xas);
> +                       return false;
> +               }
> +               xas_store(&xas, NULL);
> +               xas_unlock_irq(&xas);
> +       } while (xas_nomem(&xas, GFP_KERNEL));
> +       return !xas_error(&xas);
>  }

Same here, I think we just want:

return !!xa_erase(..);

>
>  static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
> @@ -583,7 +563,6 @@ static void zswap_entry_put(struct zswap_tree *tree,
>
>         WARN_ON_ONCE(refcount < 0);
>         if (refcount == 0) {
> -               WARN_ON_ONCE(!RB_EMPTY_NODE(&entry->rbnode));
>                 zswap_free_entry(entry);
>         }

nit: the braces are no longer needed here

