Return-Path: <linux-kernel+bounces-159938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCAA8B3684
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E6BB21DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75114532A;
	Fri, 26 Apr 2024 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqVHpssC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A513C9A7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714131036; cv=none; b=QfVnyBFPd/KzBLtksNiTPkAnWTWUyMHZqGwZCNx3XAD7czgjDcIY2ueUSOYsLMFoClsQworYlQc6PoRwidIjJ5IPLop0WRhOFJHuzUQhY/ydU9joauaAHAVbxu9bBzDDLsSD2g5OklBUtwzVykM9dnhxgZQ6dQoop6xRuu599Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714131036; c=relaxed/simple;
	bh=KYncooLgA9+otlBO7iJSk7L0IerRU1VzhvGkNgX7uz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOwbyRZ3x9GrhqU0GFVfMqjxvmWZBOh9aUfLXrMIJzssekZqHV9b4mV+w2P4dZkXST/FqZv4XlRoSnW8pnKYaz+Cg1xLbuIzXfo42cX6bljM2RQt2fOLYyJE1r9nJnYKspYw26+FN+au4Gsm3QYHcjweHK+uw2fQZdNbrqZzZ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqVHpssC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e8so2160925e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714131033; x=1714735833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB1mt9sNpnIuQMWViJTKaJZ/u7Ekmxb+gEhtincBweM=;
        b=AqVHpssCmF34UeLG+vymalEADmIY8moIrvD3dyj/OGmXh/rje+yhUWf9SKVcZN4DO2
         RZJE4e1XrY+nsR+o4ggxVnHWqfdTP5TmP6YjYX7jrwCOx/KxqUd1AufYmkOnjUTMmD4b
         FKp8bTl5r40M7Fy5FuCLd6I94HHTyfSrJCQZZAbjUw9G9DYOusVOzXX7/QHDZeO9GmDT
         6md35j/8cliTxZu3FT0M3UiMmVt7Mnog4Yvq8DsaOxWOPvpHlj4vYPSUopDvymCZO+J2
         M000u6IjRPXcF+8SEhgInqrxZV8PGxKJ8MfBRFlQgYt5wuRZaxLMt96wMwd/3v2ftmWJ
         gSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714131033; x=1714735833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB1mt9sNpnIuQMWViJTKaJZ/u7Ekmxb+gEhtincBweM=;
        b=qEJxDNTBjsUTNXfhv68HRae8mio7IFQqubtE4TI3K9Y8lal3qPrTQs4pejzVC0cK5e
         RdW4OIJn7mf0CEm7DWhRFeLM6H2pzPFghM2nQWcpmWWCUSgwHFSuQ1azDWRmXoaio/L2
         dfxjDpYR2mCJPnpiUhX2jDX7UZxaiC15nrX7wj8GDwwWQO/xVM5aWDw0KNlEAFMU2wMI
         GMYzvhHkZil9G81fFTgWcZQ4KZ6vZ8LhCuXlVVc22CyRrHCjmXAXKusrQ3Q2FalBZls9
         WcnASGA5jxXhxYgP5acwAKYRz0/Jd8v7dyyfNNInXrsoun1ail1P09czjL90HDUKtx4f
         nB4A==
X-Forwarded-Encrypted: i=1; AJvYcCVIUU1YFKAyExp2b5T2KH67N4ChMPqfcvMiyHQMJuVMhth8zgJgLreiTt6PDiy2YOXgezKpKHA7iizej0Ig/iinGg+8dq3ro6+FNpov
X-Gm-Message-State: AOJu0YwNxeNm9XWEbnYQ+w/TSo9xwH5zYKo5ubNsTvAVI/c+9c1Qevjy
	48GTK38xoS+VeDsDguUShuKH8P+LpVEdkpXPE/cFnQinkY5vKgdCeB6Q9JnG3je/qYmzs+ky/8j
	ozost9CGtTS4MkCC4StCLvROukYRzSW94
X-Google-Smtp-Source: AGHT+IEq+t0JzlAiE/ntLmzUm/wFvcl8gxKMAtzFSJL9GKIdrXhyeetBuXyDVLTjqKbTRJLxJU081NBHzaGvyWpCCbQ=
X-Received: by 2002:a5d:6e64:0:b0:343:e45c:c91d with SMTP id
 j36-20020a5d6e64000000b00343e45cc91dmr1644235wrz.41.1714131032606; Fri, 26
 Apr 2024 04:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426103528.406063-1-chao@kernel.org>
In-Reply-To: <20240426103528.406063-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 26 Apr 2024 19:30:21 +0800
Message-ID: <CAHJ8P3+G8ooBt7Atw62wkSWBS0Xzx7J5eE4tPOKWd8_rjp=KNg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: zone: fix to don't trigger OPU on
 pinfile for direct IO
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Chao,

On Fri, Apr 26, 2024 at 6:37=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
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
Excuse me I a little question=EF=BC=8C should pin files not be written in O=
PU
mode regardless of device type(conventional or  zone)?
thanks!
>                 if (unlikely(f2fs_cp_error(sbi))) {
>                         err =3D -EIO;
>                         goto sync_out;
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

