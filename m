Return-Path: <linux-kernel+bounces-43066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB943840B28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F053B23696
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E621156973;
	Mon, 29 Jan 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E783/9qA"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D66154439
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545181; cv=none; b=ofM/rWyInxx1Bo1V/I+IYeSbhezCTUTPscTKu/0Wgnk9bwy6AhLleVQeZmKGSFPU4a2iRfJza9mBFfmXDtyg/EZKGsi5E51SpdyuBi8eqZcGAxsX9iGMePw7LLvDI/1nk/8NlXM5gV16EFrVhaAH/PHoB5MIpnSsPeChZD2k1lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545181; c=relaxed/simple;
	bh=IogNNPkNljcPj0S3glEeF2R9tLr657QwgfZwPmokQ6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/AQ0kKf2c1U1w2OK4I210fq5HbgBep+cZ1V+Jhu5ZBWU+9BtIg42sMlcl9xn/v4+9Peglgf1YMYmYO9vES3IgXBkYhrChMoZ7YfV19Or4RkwblYwWHWA74PMbbD488lkka4C8jTqzcaCm9bTQvAaJ3BNwfw2pIsKt/gIX+/MjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E783/9qA; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d2ded146cbso698971241.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706545178; x=1707149978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxIMPwXxO56Te04nQLiHnEy/gVhT8AAzuKsrBhH07uY=;
        b=E783/9qAlspzU01h7gzlCHyw10au9OCEBw2Otf/2A0ZvhwsLo6VQhOX1YouigdD7YC
         sAD4UispSVLyYawMgFl0KqS6tODNxixeS+owUwFlRaNUkh9SdTg3iGM43gQ9lGpQD+tG
         /BC+eB10CO47uqj7tzLu3nXgOuf6D5jc1Fn0S0Og3NaYA4rSHnq52CnhdVbRFMwXhXPW
         lTRXywMmSL7hx4R7h3ozJ1hUUDHqwzcdDNSlNTPjuuHFmkm71MCSCLLV0DDvar6eqy+G
         AIbFPY3TKI2B+LEOUeV/FvKyiHC579M+98/TVGvBtJsf6UCuMbDalqPQtADuBFcd3W8i
         FEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706545178; x=1707149978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxIMPwXxO56Te04nQLiHnEy/gVhT8AAzuKsrBhH07uY=;
        b=oxjlhCTvQcXe4z39lIpIHezk/FxtgzFxOdlZwedKd+wOr8rTqDnfT2E3v0QFet3GRw
         xvQR1VpMWmYECf7J7Pj5o1pONRciz8h7yNzsi/adPypZV3oXySIKFQxqljPe0ySL/IQ1
         82wSAQJ2m9g0rzXdA/Z0GPdZoqC99qgk0xYv63LBytNf7vQy560kTnVfFy92VIMtUvkG
         LsDsvFbjtl7n5Fy0GRv2imPfNTceWBXUiU/n4/zy8jtcP/1xqFRDLkZtZLUg81Miq76g
         QLZ5/ti9B3oMOnduZGn4iO0Lu9flBT9Rvg/Rlzxi1RsM40IPLJYXQ57ncp3ca1vNQbBr
         ZFmQ==
X-Gm-Message-State: AOJu0Yz+YP4T6RoPjh5EgGnbQ9mHPVRZhuWKVW5HUTtyImimzSrVCS4i
	F97Nv7NxgbdFKfETOOkWhUNukZro0Zdk9fokxT8amScDTmo8je8DTiO5Gzu1W2UwhyC2cXG52ei
	GqviRRupuk0EFMGATvVsYQ+WyUt4=
X-Google-Smtp-Source: AGHT+IEqDtuEvINWYbcnE6QTCFFMC/ThpAq5Z34OgSGGbN/aqboub29Gbf+ovelQfmc0eCJ+Gb7SsYN5uHCFvArPFJU=
X-Received: by 2002:a05:6122:1793:b0:4bd:8b9c:d551 with SMTP id
 o19-20020a056122179300b004bd8b9cd551mr2471464vkf.18.1706545178178; Mon, 29
 Jan 2024 08:19:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129112740.1908649-1-chao@kernel.org>
In-Reply-To: <20240129112740.1908649-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 29 Jan 2024 08:19:27 -0800
Message-ID: <CACOAw_w=GsdGyLZN8ZWZ=G7ogo_oRqLXaBCqzVwHkqXT=pxNnA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: zone: fix to wait completion of last bio
 in zone correctly
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,

On Mon, Jan 29, 2024 at 3:29=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> It needs to check last zone_pending_bio and wait IO completion before
> traverse next fio in io->io_list, otherwise, bio in next zone may be
> submitted before all IO completion in current zone.
>
> Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f45ecb810ae6..8cdbc5ae44db 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1006,7 +1006,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fi=
o)
>         f2fs_bug_on(sbi, is_read_io(fio->op));
>
>         f2fs_down_write(&io->io_rwsem);
> -
> +next:
>  #ifdef CONFIG_BLK_DEV_ZONED
>         if (f2fs_sb_has_blkzoned(sbi) && btype < META && io->zone_pending=
_bio) {
>                 wait_for_completion_io(&io->zone_wait);
> @@ -1016,7 +1016,6 @@ void f2fs_submit_page_write(struct f2fs_io_info *fi=
o)
>         }
>  #endif
>
> -next:
>         if (fio->in_list) {
>                 spin_lock(&io->io_lock);
>                 if (list_empty(&io->io_list)) {
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

