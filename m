Return-Path: <linux-kernel+bounces-87197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450B786D0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F7628CF95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA97D70AF4;
	Thu, 29 Feb 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca2YkROa"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42470ACB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228515; cv=none; b=FSVdgGVUk5La7temQyNqZJxGugKNgEJR8rZH8GgAeWxy7mo3w6p3n9Kd6AUI1eYtKIYY6+M68bjgFa+yGug0yR6VaKdcJym57L1NLKptvr6lc0yhWSZJkTwUUrlxB/pZdGC8fcrW1z9NXx9+Qu7MtIOiHNHyjowZk0pgREMhzew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228515; c=relaxed/simple;
	bh=L7t+cjgaOEUV4vmAQb5nSr8DaJ/BoAacydvcd8CjuB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kc3VMkFx/R99OC2UtOq9Q3B1OT2dXPtElA4BvHec4GRl/dtvecE0moQlrUYv1MgTf1u+QRUm6n8Ga+ggAtSMjfIfk7w+tIN3CNjxtgAq9wLsA85lkYCcPITxXyEjg9YIm610gERFLz9qs5+9opo7LR2CnftkknqD9//TODOBa5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca2YkROa; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e4c1d243b4so350511a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709228513; x=1709833313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQH2kEF1fd/n2WQZsc7xucdtJjSFJpVP+ITv1bMt0zY=;
        b=Ca2YkROaST2YkWM3QDNYsCHJBZOaB40vpzb18ElMqSsmLA3A/F5yZeuZOATjzAh0eK
         nzJeeovUW7iBBq/vt8ZspfOTMTWoSJ2loeHrWfRAlYu9MSzZMboZasiPBf19BmEpsaug
         JRB4NfA2x3k3Q7eDoNQy8eft1d33i52Hsw2QDBHeMk55LJgajENt6vdPK8vIyhugNAtK
         weOJmEVQXXYk4pwwLMTpQWUlJmMbqZLx2Al9R1PISnIcWy+D58xOALQCtB7p6pAr9sTe
         zVaYsDwhpNGcAF7PwilMyYkafh0ZVNy8zf7tYgerZHadVZTKBWxExygNxXMei2BKQUY1
         HZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228513; x=1709833313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQH2kEF1fd/n2WQZsc7xucdtJjSFJpVP+ITv1bMt0zY=;
        b=POhYin6QiUZ/hJx5U4t51VYPMuxahZEf1sw/2R36DgHNH2bLo/56e0J3/gQXZXluE7
         Qhy6og2OHmaBM0cBaok3vljBGx5lrczydsi6olKFL1KNS/PGaosjiTqhsN3+7pY8wK/l
         LY4lBdm5/kmI5SWG03+NJLgohdD1xiyptWIajki2UjUJdLqAJ0BefxRU0cUVWer7bAxI
         t4bgIW5eKoadLG5um7TQDSDyUzafRJ85gujewZk652FPyblLs6tWkYtyyVy13ALa1VN1
         LI797d05FbH7MWM72Fv/1HNihB3b8jeYde67+EA8p3p6/3X33DjKFDMjvgJ2BjJNzNml
         JTTA==
X-Forwarded-Encrypted: i=1; AJvYcCWCL80lssW25zoT4DtrjnyGqx9coPqVNkO9M4c8QlQ6yt1KRTOmi6sGB7B+Pg78TXAIInYmWmv9bMZhIQsrGrVMJFZoG/ZaGe3LGab5
X-Gm-Message-State: AOJu0YzdPj19CnMMOfw5LsBDWW/VnZbWE+srhCTLLHE7ofQToXwCSjOD
	D6EnRTpTSdSEMa3hIWNPM7MntxKdnak1Oq/O+cH4zVLQszF0AR/Iu6/iPHXUApHuCJE9otjFPeF
	JUjm/SdL/1D4pfvCbcEVoLsBr6rbMzl2Q+fE=
X-Google-Smtp-Source: AGHT+IFqu3534frvCxwANMLH7IOv+D5fvIdsTNlvhalr8QBR3MD69zJBV+Fbonk83QZmTRsBpZiAfnt1zxREbQMfbk8=
X-Received: by 2002:a9d:7a48:0:b0:6e4:7271:2bdf with SMTP id
 z8-20020a9d7a48000000b006e472712bdfmr2557571otm.32.1709228512955; Thu, 29 Feb
 2024 09:41:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226013208.2389246-1-chao@kernel.org> <20240226013208.2389246-2-chao@kernel.org>
In-Reply-To: <20240226013208.2389246-2-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 29 Feb 2024 09:41:42 -0800
Message-ID: <CACOAw_wG_6OVMFC1OKEvc_Y0YanZTcVgum6VL=bh-nqJgg=uZg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: relocate f2fs_precache_extents() in f2fs_swap_activate()
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,

On Sun, Feb 25, 2024 at 5:33=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> This patch exchangs position of f2fs_precache_extents() and
> filemap_fdatawrite(), so that f2fs_precache_extents() can load
> extent info after physical addresses of all data are fixed.
>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 0c728e82d936..bd8674bf1d84 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4045,12 +4045,12 @@ static int f2fs_swap_activate(struct swap_info_st=
ruct *sis, struct file *file,
>         if (!f2fs_disable_compressed_file(inode))
>                 return -EINVAL;
>
> -       f2fs_precache_extents(inode);
> -
>         ret =3D filemap_fdatawrite(inode->i_mapping);
>         if (ret < 0)
>                 return ret;
>
> +       f2fs_precache_extents(inode);
> +
>         ret =3D check_swap_activate(sis, file, span);
>         if (ret < 0)
>                 return ret;
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

