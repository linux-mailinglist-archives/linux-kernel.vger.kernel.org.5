Return-Path: <linux-kernel+bounces-130780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6F7897D03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B391C27549
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAC1184D;
	Thu,  4 Apr 2024 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMaPozWs"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF4ED9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 00:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190282; cv=none; b=TZCgCKCMa0H7p0biX+pJvVZGQy2dlhMSVD4fTH1sTZ1UwtNI8azUcXzM5qiPDs8ITl3Pj1ujo+t8K4ruiQ6AK0loCizUfkPY8KXxMx/0HaQ02BH6xjBng8btOKqGKIT/bMxQ9zq+K+03F7BSrz+Q/vDYrUyJ/Cn9gR9SQbhD35o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190282; c=relaxed/simple;
	bh=3JPZfsSQGYLv4i4aZfgMUDZ5L89pgYI3CBEmLS7s63U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXenh5XBSqg2l2QsXBtnuNQhjBXYjcCHevxd1jXlS7bwP4pmiBLW/n7enagkOW/76g4jqwH5AVxpkhdyoscQFWALNcjaju74jYGkw5dawsZIsasNUjQAoQX2aeDZvqoD7QZ9Uf3lWCRJ7rKbMQB3bho/fml7nyS51abwuSnjsKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMaPozWs; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a465ddc2c09so26135466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 17:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712190279; x=1712795079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzWz7IdJMj61AY2xXdjLGAh4Sy+JwYaABh1sOf/dM44=;
        b=KMaPozWsVN5P9vWH6ET4TjKwL50yqmPH+Ji9xlZHQm3+VEx/X/u3KY8Nf1ayZHvDb2
         VKJ3fZy2jzBVvn0i3XB5YzXkDJeLwbH6EMzCYMkTaO7Xn1yany02QbwH9i9hYZtgr+gQ
         Sg41kNyYisI1cNDwqrNpTpXE4ryRlFPA9lfkDKhZoEZL15UKq4Z97weJfl67Lqg+zID0
         j231PvUszmcsJksZAyyuVjVNSnPVS56PXhh/KCfPaIYpI9KZAS5HWvmrYgqkRip4facw
         LRcoVEJaxP4TPN7YTtUA59J+sm+K+HV0Ci3dWdh+3PCO/Rr9S9wQtaL2qvWEUrzmN7Ps
         Jjmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712190279; x=1712795079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzWz7IdJMj61AY2xXdjLGAh4Sy+JwYaABh1sOf/dM44=;
        b=NBzo3setLu8iD7eXzlZvA6cBd/7N0AKFgPXvluJy5UzhQfbUfRL+yh4QLMY0KcK7F6
         x13LbKRblEtFFwHe0eOJ4OuCSklHqbEtdUADXo2Iv4rmlHeha1M9GTw3C0ytJVFXSP73
         QBSJdQM+hL6yYaqfu3IPa+Tg0UOBxDuTolOb35JWvuuGW/sBA1UiJ0YTmgURbkRwlEhK
         8MgwfJ48wwpAf/98m4CVIApCtP0spVbczAVmEW+njuI9NvdPZJJPc4p545implWImjKn
         CMYeHr2Q6bE+cftvLDQQryS58LEVZIoi6mNEZE6rkED12knUwMPe8zphH3aZ8fMalDpD
         Tb0A==
X-Forwarded-Encrypted: i=1; AJvYcCX2pQ9jYroJ+SpD+nqCaXj+xRlN/K+X7qtmVFRoaD/nw0fNbtrCvRLxDXf0kFGjbqqGTrmu3eJdxr9dyKuOmA0Nj00CtjDZ9HAckRPZ
X-Gm-Message-State: AOJu0Yx92KZtUkqW6v2sh+5JFNf9oXOJ7zabyF8rLE+4hIqKquMZF6aL
	cOUOMVn1agWynbl7z7neou71vyzRQj8p7fD8PjPdhYYpC84zOLUeonFOL9RWM+P5De4oL/pHcXj
	05Cfo73m2l3g4OHOo6OYMmRL75lIAvjr1MCEWqSmgE6wmUuun0tx7
X-Google-Smtp-Source: AGHT+IGkG1/yck/uSuam66eaa3CVQfyxf0M3DbmMTdOOe8Ii4uS2BxtQhgGXsXQVO5+1oO4H0dKDrcENMRpbVWqdT0o=
X-Received: by 2002:a50:aa95:0:b0:565:f7c7:f23c with SMTP id
 q21-20020a50aa95000000b00565f7c7f23cmr709860edc.3.1712190278846; Wed, 03 Apr
 2024 17:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403183352.391308-1-phillip@squashfs.org.uk>
In-Reply-To: <20240403183352.391308-1-phillip@squashfs.org.uk>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 3 Apr 2024 17:24:25 -0700
Message-ID: <CAFhGd8rMS2L7chM+h=UoDAfBMUdPsZxfrqfKWP-MWQfJO0h94g@mail.gmail.com>
Subject: Re: [PATCH] Squashfs: remove deprecated strncpy by not copying the string
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:34=E2=80=AFAM Phillip Lougher <phillip@squashfs.o=
rg.uk> wrote:
>
> Squashfs copied the passed string (name) into a temporary buffer
> to ensure it was NUL-terminated.  This however is completely
> unnecessary as the string is already NUL-terminated.  So remove
> the deprecated strncpy() by completely removing the string copy.
>
> The background behind this unnecessary string copy is that it
> dates back to the days when Squashfs was an out of kernel patch.
> The code deliberately did not assume the string was NUL-terminated
> in case in future this changed (due to kernel changes).  This
> would mean the out of tree patches would be broken but still
> compile OK.
>
> Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  fs/squashfs/namei.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
> index 11e4539b9eae..65aae7e2a859 100644
> --- a/fs/squashfs/namei.c
> +++ b/fs/squashfs/namei.c
> @@ -62,27 +62,21 @@
>   */
>  static int get_dir_index_using_name(struct super_block *sb,
>                         u64 *next_block, int *next_offset, u64 index_star=
t,
> -                       int index_offset, int i_count, const char *name,
> -                       int len)
> +                       int index_offset, int i_count, const char *name)
>  {
>         struct squashfs_sb_info *msblk =3D sb->s_fs_info;
>         int i, length =3D 0, err;
>         unsigned int size;
>         struct squashfs_dir_index *index;
> -       char *str;
>
>         TRACE("Entered get_dir_index_using_name, i_count %d\n", i_count);
>
> -       index =3D kmalloc(sizeof(*index) + SQUASHFS_NAME_LEN * 2 + 2, GFP=
_KERNEL);
> +       index =3D kmalloc(sizeof(*index) + SQUASHFS_NAME_LEN + 1, GFP_KER=
NEL);
>         if (index =3D=3D NULL) {
>                 ERROR("Failed to allocate squashfs_dir_index\n");
>                 goto out;
>         }
>
> -       str =3D &index->name[SQUASHFS_NAME_LEN + 1];
> -       strncpy(str, name, len);
> -       str[len] =3D '\0';
> -
>         for (i =3D 0; i < i_count; i++) {
>                 err =3D squashfs_read_metadata(sb, index, &index_start,
>                                         &index_offset, sizeof(*index));
> @@ -101,7 +95,7 @@ static int get_dir_index_using_name(struct super_block=
 *sb,
>
>                 index->name[size] =3D '\0';
>
> -               if (strcmp(index->name, str) > 0)
> +               if (strcmp(index->name, name) > 0)
>                         break;
>
>                 length =3D le32_to_cpu(index->index);
> @@ -153,7 +147,7 @@ static struct dentry *squashfs_lookup(struct inode *d=
ir, struct dentry *dentry,
>         length =3D get_dir_index_using_name(dir->i_sb, &block, &offset,
>                                 squashfs_i(dir)->dir_idx_start,
>                                 squashfs_i(dir)->dir_idx_offset,
> -                               squashfs_i(dir)->dir_idx_cnt, name, len);
> +                               squashfs_i(dir)->dir_idx_cnt, name);
>
>         while (length < i_size_read(dir)) {
>                 /*
> --
> 2.39.2
>

