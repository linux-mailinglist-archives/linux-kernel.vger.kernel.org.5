Return-Path: <linux-kernel+bounces-164521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3888B7EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1141C225CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9711F1802BE;
	Tue, 30 Apr 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYGlOYW9"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75512176FD8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498340; cv=none; b=TiN9avxDi4hbUfcVMZ3GfpWNXh57I/Du27TgfSd0Z6KxVnEFj61gvCM4rQ1wW8bxi5/1T/Xp9Hqu82npYkCNy+ax0SL84+Me/XV26yrE6ujLByRmOFp5uDFrAudzubAW8kTYAoA25SBO6KcOHs19/UCOqNEf0MzN2esXZua8+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498340; c=relaxed/simple;
	bh=/N1TeT8Lt6jMTRUZgsuQRBjbnAA5fXJw6oTciw8CL8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRVMut6nKtgbDa0DilspEw45dpIiXhWLOi475Crvhez4pOwxMP6Fmd1idxSu3u1IcG6BXPUcGbpGGi522gEyUwl7VTNJHPvaHZdVAILv+XaXoI8l411nc9k02sqMoLdoLBDFlkAYSs20VSHNiwbupIQoDZi8HlXbMat3dDAUPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYGlOYW9; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de610800da0so1446254276.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714498338; x=1715103138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yW/DKRBIS4ATn0WcLDg63sbAJpcKsatVFeaBysHTbx4=;
        b=WYGlOYW9lrXLp0kV70aMtjPQqlzewAn9fM5oFblDVN8hIcDjkp0kwcX/IKuOw2iaRV
         IotSXy7s6Q/HZJR9DXW6tpy3s//fUWHTiihoTW9+9p987qd3adoWTWC/5KhEGDxy3euD
         S5idBJOU1pYIino8LZJXTteG5hkemFcRzGC/rtK66LWsCFAeWXlf/IkO/MHX87AgBDAc
         9d1xWgYmcisWg1McydaqOlm7D4/YHUXOkyc2n/aE5VIyxtgK+hw1PXGDKF1gXYp9p8US
         aPicNMOsRlNyZST8M3zOCy4AEM+1zh5fvixWMVN4eYfsrcGzRqjarPUFfBfIfBdWC5vv
         EuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498338; x=1715103138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yW/DKRBIS4ATn0WcLDg63sbAJpcKsatVFeaBysHTbx4=;
        b=gK3obvG72TFQaqlOEVlRw2MdaxoadNekF8vtRu4wJxyv9XZJNgSgXWI3yV4dYrtljj
         KOSU464aCuWkKq9xpyTFemIB81hyLp2HSdYvqFa/OCE527LXaDYI0ejg64DlGw1aRc9w
         KeVjP82/goppfiEt4+jcc5ybW2rT5ZpJ3bH5g0JefJ4vWKmWLxlzWL9y4X66jj+p7dV2
         oSL7DGBB+C2L6Q7bby5ytq2pGvSoZ25Ka8rinPOVxJ8tZwvCUoMjR4YM/7OzrTX+knU3
         O0Fc6o+YsClw411ZD2uTjTB+uAy6Gk2tuv8sbr7OyeI76ghDyShfmhrGntm558vko+E4
         Pdhg==
X-Forwarded-Encrypted: i=1; AJvYcCW+mnLdBwKlHUCSezvpSG4Rge4DhhvCXg+n4FrmHRC8sX9H3AW8QEMsqYVGxRsvzKRQZdptjWrVXYnhvBdFE6FYjpWlXFTdXH1RNkev
X-Gm-Message-State: AOJu0YxlAcHiZkbZYjA9S+lXxQBCabpUwixZhNQhXeqivl+rpDz1w18N
	/TWgL0WbsNCb2pNPAzJNowPSoUxj7nkauocm70IjPIaXkYkbR0pPJEQAMaDQ21Ov3HY6SAw0wwj
	yeTliCj+SGNYw34ZxUW04oc0z0PTs/WhXKd4f
X-Google-Smtp-Source: AGHT+IGGj2j629aGObH5Im8Bk3IRYjZLXCZc3eAvdRTbmkI73mygaiDZqMZuoLjAKsy7A7OQwr72htT4re5sSltDfIc=
X-Received: by 2002:a5b:609:0:b0:de5:5a39:2cb0 with SMTP id
 d9-20020a5b0609000000b00de55a392cb0mr184524ybq.31.1714498338252; Tue, 30 Apr
 2024 10:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430060612.2171650-1-shakeel.butt@linux.dev> <20240430060612.2171650-7-shakeel.butt@linux.dev>
In-Reply-To: <20240430060612.2171650-7-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 30 Apr 2024 10:32:05 -0700
Message-ID: <CABdmKX2-5k7o9P0LDkghr5EFLwe=42aBU9kVfd05+4-Uf41WiA@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] mm: cleanup WORKINGSET_NODES in workingset
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> WORKINGSET_NODES is not exposed in the memcg stats and thus there is no
> need to use the memcg specific stat update functions for it. In future
> if we decide to expose WORKINGSET_NODES in the memcg stats, we can
> revert this patch.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

> ---
>
> Changes since v2:
> - N/A
>
>  mm/workingset.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/workingset.c b/mm/workingset.c
> index f2a0ecaf708d..c22adb93622a 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -618,6 +618,7 @@ struct list_lru shadow_nodes;
>  void workingset_update_node(struct xa_node *node)
>  {
>         struct address_space *mapping;
> +       struct page *page =3D virt_to_page(node);
>
>         /*
>          * Track non-empty nodes that contain only shadow entries;
> @@ -633,12 +634,12 @@ void workingset_update_node(struct xa_node *node)
>         if (node->count && node->count =3D=3D node->nr_values) {
>                 if (list_empty(&node->private_list)) {
>                         list_lru_add_obj(&shadow_nodes, &node->private_li=
st);
> -                       __inc_lruvec_kmem_state(node, WORKINGSET_NODES);
> +                       __inc_node_page_state(page, WORKINGSET_NODES);
>                 }
>         } else {
>                 if (!list_empty(&node->private_list)) {
>                         list_lru_del_obj(&shadow_nodes, &node->private_li=
st);
> -                       __dec_lruvec_kmem_state(node, WORKINGSET_NODES);
> +                       __dec_node_page_state(page, WORKINGSET_NODES);
>                 }
>         }
>  }
> @@ -742,7 +743,7 @@ static enum lru_status shadow_lru_isolate(struct list=
_head *item,
>         }
>
>         list_lru_isolate(lru, item);
> -       __dec_lruvec_kmem_state(node, WORKINGSET_NODES);
> +       __dec_node_page_state(virt_to_page(node), WORKINGSET_NODES);
>
>         spin_unlock(lru_lock);
>
> --
> 2.43.0
>

