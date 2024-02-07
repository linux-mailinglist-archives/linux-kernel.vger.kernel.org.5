Return-Path: <linux-kernel+bounces-57292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8B184D67D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDD2289AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9C12030D;
	Wed,  7 Feb 2024 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOYJmMd5"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF67200BA;
	Wed,  7 Feb 2024 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707347221; cv=none; b=ONxaWIqSxNyf3XDiXbg3NGE4jE3XMm+oGkC1FJnq3f3iEGTU3zDWK6ulzAjS322i7b3DufkbDBRti213yP/Wkt7tfzJCsYSZVHfFiT4hl7zRZguST3nl36ZrgAlK8p+3QTlBVnU+aUF2riQd1xCDbwcc+kvucXWOSoFwxJHjj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707347221; c=relaxed/simple;
	bh=ULTvoBUFSGgsxHeRo0ZMsip78lrjmsRFup2qGNw9Uis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daR4SScmm3z/zrajRQdyqjw4erPW0hRZ88lI/BGo00TWYTF4hzOznscLNxrltyyrQdfQBP5ttd074oDHj7bTRh+1ytT1bBLyYyqJvDhOL+Our4XdEjsHB56Ps1Z++zlU0nayCqVasY2Ntp10QNnsONjRmChcxoLyx01JGD8I2aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOYJmMd5; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bf7e37dc60so64030739f.3;
        Wed, 07 Feb 2024 15:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707347218; x=1707952018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y461hO3ePCARg6hvMwpKBSrFexbMsmZV41JTYSiCLYY=;
        b=LOYJmMd51AoOZxZTVyZ3vHRtteWP+op9GDjRpWliFqIkXohVE9b9ZoF3EYjLl/Y03l
         0zuH+XpoL/wlCKRVnBucxOLy3a9scrN/WgB4TwZynNyv1qAlqTMko+Q3lTeL9FoldxTF
         ohq7ldBl06yssy/p+AkFcj0QhuivXvqy0BglqqZ2N7cd3G1U/Nc2KZbOyRlPaQeyVKiM
         yaa/DkYE/3xDsgzqcxj6P2wPUP+EeTDtI0d3FOUv9ioyz7NcP72XT+j1YJAn07EQpKct
         qxI+z6MkGlYmUgWKBASK5mhhhI8hOnIcmYeuNmT6OGo9sVSzK9QD3+9pGSlLAFt2EVUR
         mXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707347218; x=1707952018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y461hO3ePCARg6hvMwpKBSrFexbMsmZV41JTYSiCLYY=;
        b=tgkiIsYNMzFi8VahU64FYC3q0AQcQdjqzsmFNeE3PjDRy7ivWmBxLEku4FoksnNg6v
         UT0x2HesaamqPHmJtSeuNo96bnUZM0f3oFQsyjecaeauosxBOZxjPPPyUkmP0Gdluz3V
         CBvC7j7u1qQFcPy492c8o3yXOa19n4Z+S4SoJhZUX2XS6hgVdd+VqtxALofeaInF/ZmP
         5v8xTj8swW7uJwoEHgswPT98wiYXJXrA4iQRLJwMeTt1YBCIg/G7jG6DuGXEWDqkFU7K
         mXcjNdpENeylkiqr0vWBKBY31ZsmsODtK8DHOK6Hs6G8DI70ee/aI0IlWbLYBDXoMAbq
         F8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVzmpw57HOjlV3kFpBXQeT8rAOk2pZRvThY5MdgHkwM6JZhdRp92wsLw9/bmg/DRPz5JdI8BFiMnCJ+oohIfYshvE7l30LQEdr8qZx2ejhaQxcI576Qj+/UApYgcKcEgkkiFjzE
X-Gm-Message-State: AOJu0YyF2P+9cNyLDu/L9ZYOEdO8Fwrt5RoIauDRgt0MrCdIQfd/8q7I
	t+zemhbBActcjsEXFc9rmTbtmcxYDeDgd91u3Y5BpYjy0QFhMLU5gVjYjeIuAz/SeqEr33Wokii
	GKlnpUA3PjBi8SGRg1herSTQroMU=
X-Google-Smtp-Source: AGHT+IF3+2QfM9ocMWDhi4nlx3HhMqhvgL9NDyIR1zFC9vJRsfwANzxCykTvgtwJopWMe12Bo9BaLFMz9qY5/S9nM8E=
X-Received: by 2002:a05:6602:256f:b0:7c3:fbe2:7a65 with SMTP id
 dj15-20020a056602256f00b007c3fbe27a65mr3830502iob.11.1707347218340; Wed, 07
 Feb 2024 15:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207115406.3865746-1-chengming.zhou@linux.dev>
In-Reply-To: <20240207115406.3865746-1-chengming.zhou@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 7 Feb 2024 15:06:47 -0800
Message-ID: <CAKEwX=NR+QN1P960_Qz_sHACoD8FK=Kb=LQw==JGR+9h73SENg@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: invalidate old entry when store fail or !zswap_enabled
To: chengming.zhou@linux.dev
Cc: hannes@cmpxchg.org, yosryahmed@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chengming Zhou <zhouchengming@bytedance.com>, stable@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:54=E2=80=AFAM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> We may encounter duplicate entry in the zswap_store():
>
> 1. swap slot that freed to per-cpu swap cache, doesn't invalidate
>    the zswap entry, then got reused. This has been fixed.
>
> 2. !exclusive load mode, swapin folio will leave its zswap entry
>    on the tree, then swapout again. This has been removed.
>
> 3. one folio can be dirtied again after zswap_store(), so need to
>    zswap_store() again. This should be handled correctly.
>
> So we must invalidate the old duplicate entry before insert the
> new one, which actually doesn't have to be done at the beginning
> of zswap_store(). And this is a normal situation, we shouldn't
> WARN_ON(1) in this case, so delete it. (The WARN_ON(1) seems want
> to detect swap entry UAF problem? But not very necessary here.)
>
> The good point is that we don't need to lock tree twice in the
> store success path.
>
> Note we still need to invalidate the old duplicate entry in the
> store failure path, otherwise the new data in swapfile could be
> overwrite by the old data in zswap pool when lru writeback.
>
> We have to do this even when !zswap_enabled since zswap can be
> disabled anytime. If the folio store success before, then got
> dirtied again but zswap disabled, we won't invalidate the old
> duplicate entry in the zswap_store(). So later lru writeback
> may overwrite the new data in swapfile.
>
> Fixes: 42c06a0e8ebe ("mm: kill frontswap")
> Cc: <stable@vger.kernel.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Nhat Pham <nphamcs@gmail.com>

Sorry for being late to the party, and thanks for fixing this, Chengming!

> ---
> v4:
>  - VM_WARN_ON generate no code when !CONFIG_DEBUG_VM, change
>    to use WARN_ON.
>
> v3:
>  - Fix a few grammatical problems in comments, per Yosry.
>
> v2:
>  - Change the duplicate entry invalidation loop to if, since we hold
>    the lock, we won't find it once we invalidate it, per Yosry.
>  - Add Fixes tag.
> ---
>  mm/zswap.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index cd67f7f6b302..62fe307521c9 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1518,18 +1518,8 @@ bool zswap_store(struct folio *folio)
>                 return false;
>
>         if (!zswap_enabled)
> -               return false;
> +               goto check_old;
>
> -       /*
> -        * If this is a duplicate, it must be removed before attempting t=
o store
> -        * it, otherwise, if the store fails the old page won't be remove=
d from
> -        * the tree, and it might be written back overriding the new data=
.
> -        */
> -       spin_lock(&tree->lock);
> -       entry =3D zswap_rb_search(&tree->rbroot, offset);
> -       if (entry)
> -               zswap_invalidate_entry(tree, entry);
> -       spin_unlock(&tree->lock);
>         objcg =3D get_obj_cgroup_from_folio(folio);
>         if (objcg && !obj_cgroup_may_zswap(objcg)) {
>                 memcg =3D get_mem_cgroup_from_objcg(objcg);
> @@ -1608,14 +1598,12 @@ bool zswap_store(struct folio *folio)
>         /* map */
>         spin_lock(&tree->lock);
>         /*
> -        * A duplicate entry should have been removed at the beginning of=
 this
> -        * function. Since the swap entry should be pinned, if a duplicat=
e is
> -        * found again here it means that something went wrong in the swa=
p
> -        * cache.
> +        * The folio may have been dirtied again, invalidate the
> +        * possibly stale entry before inserting the new entry.
>          */
> -       while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -E=
EXIST) {
> -               WARN_ON(1);
> +       if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -EEXI=
ST) {
>                 zswap_invalidate_entry(tree, dupentry);
> +               WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry))=
;
>         }
>         if (entry->length) {
>                 INIT_LIST_HEAD(&entry->lru);
> @@ -1638,6 +1626,17 @@ bool zswap_store(struct folio *folio)
>  reject:
>         if (objcg)
>                 obj_cgroup_put(objcg);
> +check_old:
> +       /*
> +        * If the zswap store fails or zswap is disabled, we must invalid=
ate the
> +        * possibly stale entry which was previously stored at this offse=
t.
> +        * Otherwise, writeback could overwrite the new data in the swapf=
ile.
> +        */
> +       spin_lock(&tree->lock);
> +       entry =3D zswap_rb_search(&tree->rbroot, offset);
> +       if (entry)
> +               zswap_invalidate_entry(tree, entry);
> +       spin_unlock(&tree->lock);
>         return false;
>
>  shrink:
> --
> 2.40.1
>

