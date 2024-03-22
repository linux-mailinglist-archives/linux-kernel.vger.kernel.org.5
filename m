Return-Path: <linux-kernel+bounces-111259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE658869D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D084E1F228D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052A638DDD;
	Fri, 22 Mar 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKBmpTld"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727020DDB;
	Fri, 22 Mar 2024 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101500; cv=none; b=cZQtnYYhvk4kMsuAyIBWt4luvboZDi34DwM8dbb6cesiB0xKZs3YL68Mez5yiRrTsxEinLEFqAk/aPn/9Cd+BUGQkgvlAJeHUa7453jmGGRkQWIwZ7ZlFJ7ob3CKfJvCgFRyjL07DvZALOfzV1ZDEeO8skzzVQHVo+3FiF45guQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101500; c=relaxed/simple;
	bh=/30BwBXERLGIM0q6thI+873JARw67ueqrIsiqLnetpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmG64AWyAdeKS9ZuEnQ7KVBhdGs2NcINU26V2bOkNoZNr00XeGYjCtS6Tbqh7hKjbD5s8Bvg6Kbu2VEZV+84C9qDDfC5uMk2cpy7y+TrA7jl/jIYRm5UGZh/0d4uSREGGm/m4agk81XY+1P+su4jsnhd6xZV14w7y0SZ4pmu18o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKBmpTld; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513e4dd6ca4so2691110e87.0;
        Fri, 22 Mar 2024 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711101497; x=1711706297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLzE8tALpeCrWW/quPBxEN3bxd3tzH7hzk8V7xM0O5E=;
        b=MKBmpTldH3Kots6AVnX3diz5znFaGYWFQ+X/4otvKqkGdrl4wItfebktffJlZMXdja
         wHnioA3DvpeipxQBscKbqhJbi7xjJJo3r3bBbugdpYBIYtCI4dX7BmIXho80TnAQxvVk
         ufSzwIRARjoY7iRnVXWTqtsLH3j9c6BFpkXiC1WgifBSVpnovGxLQ7LrlF/o0QOMpbvJ
         Y+dm1K2STqbFUqZT+oBsNRJX/od6m3wH/ElwHRsP4ZGiHf4jdeQ8S+MZmENlyiWC2wrY
         f7V4nT7LIU0CRnhuk7jlh84LFV+GHY/eoKOdPxDsKqPCBYQgpq7zhVznRb1omWgQOCmO
         zFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711101497; x=1711706297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLzE8tALpeCrWW/quPBxEN3bxd3tzH7hzk8V7xM0O5E=;
        b=wCubQRuUfqnKxcQBYLudi4LdUGcAFgMOkae6F0Wa0UKmXBZHlwah8qcyR9iEOi+6iP
         jjOMxrB5RKxWRRHIJjlodFl3BMx6JMJQWWgmPN9bxadTfsyxf4+K2t0j8HJly0FBbWzp
         tRrGZx7bbQNXE5DvLJKLFeTiHWDqyQfSwHSLjftYWCgs1JRIjfr4jEjYVskarGxXrlMA
         1EL1v8HjrcPXPUsdHN8qXHWN5Z0gyqqngwB6rskx23hCMMMJEYJULO2wrQQCILhFOSuN
         VqzqvbynS+JKJ6XUQkpGNwAIrBY0dL7c65bWsrhF9mxPf2laSp4ivwKzHwAPf+VanLRc
         kQbg==
X-Forwarded-Encrypted: i=1; AJvYcCXqyqVizRyJForL9yzhZQ0A9uQzx2BabYABXDTjA/k40foXg+OAi4n/lJ/0n6zDxJ7Zvoopp59yrtE14CK+Klt19k/jqIMUOSFgrtDr
X-Gm-Message-State: AOJu0YzRhhybR5PYkcaF+OSq0FZjeKYZZuos5St+v8tH+EL+rmeTcaMY
	FYZy0XxLlwBW6xxZ3fQ3PnhkQ38CS9BQzhtjyOh9MytrqjRcB3hBDXEfrI48QXjlC0F0wjd9ykd
	mZbD/kHwmdcTWkgL+Qy0XCDsDbezwTMXQyz0=
X-Google-Smtp-Source: AGHT+IEJM70W/0XiCmq4w9Dz9xgCijW80RjvzOaO4tlBA7LSpPvU4fdW7yC40Q3vV0aWt/A2/SiR5Cs5o/sQ5ZzoOh8=
X-Received: by 2002:ac2:498c:0:b0:513:d4fb:fa76 with SMTP id
 f12-20020ac2498c000000b00513d4fbfa76mr647885lfl.3.1711101496658; Fri, 22 Mar
 2024 02:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322073240.91639-1-yang.lee@linux.alibaba.com> <20240322073240.91639-2-yang.lee@linux.alibaba.com>
In-Reply-To: <20240322073240.91639-2-yang.lee@linux.alibaba.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 22 Mar 2024 18:57:59 +0900
Message-ID: <CAKFNMon20yyJ2Daf3nkG1A4hP=ENEnO_em4qrGm50e=A9c1++A@mail.gmail.com>
Subject: Re: [PATCH -next 2/3] fs: Add kernel-doc comments to nilfs_btree_convert_and_insert()
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 4:32=E2=80=AFPM Yang Li wrote:
>
> This commit adds kernel-doc style comments with complete parameter
> descriptions for the function nilfs_btree_convert_and_insert.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/nilfs2/btree.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
> index 65659fa0372e..de38012fd87c 100644
> --- a/fs/nilfs2/btree.c
> +++ b/fs/nilfs2/btree.c
> @@ -1857,13 +1857,21 @@ nilfs_btree_commit_convert_and_insert(struct nilf=
s_bmap *btree,
>  }
>
>  /**
> - * nilfs_btree_convert_and_insert -
> - * @bmap:
> - * @key:
> - * @ptr:
> - * @keys:
> - * @ptrs:
> - * @n:
> + * nilfs_btree_convert_and_insert - Convert and insert entries into a B-=
tree
> + * @btree: NILFS B-tree structure
> + * @key: Key of the new entry to be inserted
> + * @ptr: Pointer (block number) associated with the key to be inserted
> + * @keys: Array of keys to be inserted in addition to @key
> + * @ptrs: Array of pointers associated with @keys
> + * @n: Number of keys and pointers in @keys and @ptrs
> + *
> + * This function is used to insert a new entry specified by @key and @pt=
r, along
> + * with additional entries specified by @keys and @ptrs arrays, into a N=
ILFS B-tree.
> + * It prepares the necessary changes by allocating the required blocks a=
nd any
> + * necessary intermediate nodes. This function handles the conversion of=
 a B-tree
> + * node when it is necessary to split it due to the size constraint.
> + *
> + * Return: 0 on success or a negative error code on failure.
>   */
>  int nilfs_btree_convert_and_insert(struct nilfs_bmap *btree,
>                                    __u64 key, __u64 ptr,
> --
> 2.20.1.7.g153144c
>

Hi,

First of all, thank you for posting these patches.
These three kernel-doc comment completions are necessary.

One thing I would like to point out is that the last part of the
descriptive comment for this patch is not accurate.
nilfs_btree_convert_and_insert() is used to convert configurations
from other forms of block mapping (the one that currently exists is
direct mapping) to a B-tree, and is not intended to split a B-tree
node block on excess of the number of entries.

So, I'd like to slightly adjust the description for this patch and
send all three to upstream.
Or, if you want to fix it yourself, please send me the revised version.

Thanks,
Ryusuke Konishi

