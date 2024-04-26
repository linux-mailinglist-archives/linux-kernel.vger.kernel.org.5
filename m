Return-Path: <linux-kernel+bounces-160133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF6C8B3991
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA4EB2395F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5405A1487F8;
	Fri, 26 Apr 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/I+SoeZ"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC4113BC3B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140903; cv=none; b=sSeaxu0cTgZs+4FpATDu6voLTulZSANjFd2aWNCxCpFFkuAsDox8HBeD6BXsbcMaFvh/kwy+RoN4LeHLj4zO0DTQ2K6+WEpSI4btH5VDz223G3DWnMul+5fS+nXhYZDJ9HVFgcRudJZwRZ1koYlJXjaNmW4HqqHFPocx81ejZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140903; c=relaxed/simple;
	bh=Loex3vC/81CujVkcjEfMBQVJO7OtnGtz/DgRQyTpCQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irGvlrswDPOhkRRaVJrUEAcM+q4kFtgP99rc+nTOdvD8oS9hwcHrOfzEOlcdpzSVd7RlFCHcHIKlww1jXcKcCEeuxhDgs1PteLk5CGnf/ccFmM8YxN0jblcvihC+P/X7PYf+KTxFGTEd5n7s9gTGeoW1vUN078oFoiVqwJ4ewKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/I+SoeZ; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5aa2551d33dso1435236eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714140901; x=1714745701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPlmlFgQLT0cE7r2xhzAyFZFOTgssBOxfGKG5d5+F7c=;
        b=Y/I+SoeZi8coELcBDcp3vrae6Yg30aaA3fVpD8qESnbG2O24wBhXGY4gFM9Z2SwnnP
         5tWhqEYes0aaZbmAYPa4BNBElVyRQtvFMD5pAEexw5PeJrQa7CuVUendy72k8YtF57fc
         5z70jgAiulo6ODL9qTZ6Ol252TqCCrVfd7eUpNVeKUnMym/yTKR3qkq3EZCKM7RxpEjz
         y3K9elOg6bveA3/r9kmVvr3qOdYuLtZAZZP0lpJn+/YpFe4bF3HjpwqITKszCqJCMSuS
         3AJ0w9O9MScfDh+kKjL1+7bgE4epv0ldPWdnBq6QDSW0hLgEifs4Y58BWZd5MvzSU1A2
         1bPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714140901; x=1714745701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPlmlFgQLT0cE7r2xhzAyFZFOTgssBOxfGKG5d5+F7c=;
        b=T7JMQpHWm9aSkA/wfKiELZ7e2+HLfiDGaBWr9Cid70AJ+TKer3fRE9cZ/L4MiEIwSO
         k29QA4W6boRHQFHeJxR6FHcSgOXJALl/SwH+wkN3rCwpOBxDgY5pZPVfLeW/dOBu1xX5
         fvx5N0hAoGGKwS8ZxiFrE3J9gI6p/uZ1exno4jFqPDfLCLYcHMLOepoOxxpPanEH9lgx
         gSKRBeuPh9G1hwaxtVFclKe3W8PtBnN85Od9GfY7tknZ9JKfo+escfO7DdH6VdN3pEKP
         0BlIx0lMYjyrMoZlZxF94vFm5B/4BgbWvc0LEaUufd/9j10aPYE2URzAgrYuOp8kdUnb
         gvJA==
X-Forwarded-Encrypted: i=1; AJvYcCU62Br0tKpPuLj2FU2T/or/lmcGs1s9wuaLiXdNIge3TteP1qU4wqrMQNhHuxxgIyKZxJKn81pDPcB9/i0IUpB/bw0OgwlJ70fwU4S+
X-Gm-Message-State: AOJu0YxaMD+UVrUou4EAhRQ+DsoY+tahzgCYX0xA+GU/8WoREnj9IDhb
	Ii3aZBf8knMH5YkLokO+YZOtxUb8VWmGd93rnpbOjYjEOikuQwJnksT62kXohjjs5rrKhzv+ddl
	gx+3OgGWnlpzD0mPq1JwIYAUolm4=
X-Google-Smtp-Source: AGHT+IEU/fzFbjm4XcHlxqFxpzS5ez+DsOKQ2iJOG0Ge0GQMeA3KxS1g4yOdaPsS0RENAoimAZNgPDWoRALfaLJXeJU=
X-Received: by 2002:a05:6358:838e:b0:186:2720:2122 with SMTP id
 c14-20020a056358838e00b0018627202122mr2879599rwk.2.1714140901218; Fri, 26 Apr
 2024 07:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426103528.406063-1-chao@kernel.org>
In-Reply-To: <20240426103528.406063-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 26 Apr 2024 07:14:50 -0700
Message-ID: <CACOAw_xiC08JTanBSLaBED8_zveCEhoaDWeJ3YVU0h9+dNkQUg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: zone: fix to don't trigger OPU on pinfile for
 direct IO
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 3:35=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> Otherwise, it breaks pinfile's sematics.
>
> Cc: Daeho Jeong <daeho43@gmail.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index bee1e45f76b8..e29000d83d52 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1596,7 +1596,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2f=
s_map_blocks *map, int flag)
>
>         /* use out-place-update for direct IO under LFS mode */
>         if (map->m_may_create &&
> -           (is_hole || (f2fs_lfs_mode(sbi) && flag =3D=3D F2FS_GET_BLOCK=
_DIO))) {
> +           (is_hole || (flag =3D=3D F2FS_GET_BLOCK_DIO && (f2fs_lfs_mode=
(sbi) &&
> +           (!f2fs_sb_has_blkzoned(sbi) || !f2fs_is_pinned_file(inode))))=
)) {
>                 if (unlikely(f2fs_cp_error(sbi))) {
>                         err =3D -EIO;
>                         goto sync_out;
> --
> 2.40.1

So, we block overwrite io for the pinfile here.

static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *fr=
om)

{
..
        if (f2fs_is_pinned_file(inode) &&
            !f2fs_overwrite_io(inode, pos, count)) {
                ret =3D -EIO;
                goto out_unlock;
        }


>

