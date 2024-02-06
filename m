Return-Path: <linux-kernel+bounces-55167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F08084B8BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E7E282B04
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58025132C04;
	Tue,  6 Feb 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj2op3Q0"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287041C01;
	Tue,  6 Feb 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231776; cv=none; b=ey3wjaVg6v+KQJ+YpObYmhjplxHjPS4RB+w2nkf/7J9rynCwjLoVi7kY5vvLw1YXy+os5WC4SATzzCxhSMlq76DhlgHYUT3qxkc4+clJSnNDzgonrgHqF+212PcQuKWwhr2IY2YVwCLkbM+00/hs2DK47gKvlNlpg8c5rYTTEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231776; c=relaxed/simple;
	bh=bAVUStCpnTHy34IuoXOjMIRGDhuXtT/wZlAhqE0qX3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gq8l31ps4IARR/1Vvk/qAgB92ghrB4p9k8Ua3tVTsVVxbJMhavfj+VPg/9ZBh94yFmqOU3XskDg20Y9M9t8o9tvZSrtVT8zJgw+lkO6yliyfDxTLNRMwYqol9G5mqwy8HgumtQPZewvmn6OP6dnNJlzQr0BGQ6QNUUP3LSB1wjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj2op3Q0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3832a61a79so73454366b.1;
        Tue, 06 Feb 2024 07:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707231773; x=1707836573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SVGM65Du1cHuuQt3q8TxAhLq+zBG9N+zkQfXQrkH+g=;
        b=Cj2op3Q0tz2CIZQb6g3DXXnQmmJbWnx3l0ltCrswQgxjk6sgo817IIljWH4mgZVzmE
         rkGIRNgYxuwgAzRO+0eKLPXpKRtRZU+tsqX1e7UPLg9UbCLpjmTTYrwhzwjg/xTCcnrN
         6o9cCWn+Ip52MTaLtOAguL12IrRUxJYDcrG5IUX8DBmpkHBiUfef4c6iAC93B9a7PjYh
         FKqzZM+BKia/R+9k4N5vii1xOb4JPlxFfdA+e9xBMtV/yjLBJjsXx+TFls5EyoLwq8UA
         tTQZLxzm7oqQdyuB+73qNvh+Sw7XdIQ3Bhh1ipj/7bXFtC7X6+O4uaf43aQvQdbtFNm7
         enSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231773; x=1707836573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SVGM65Du1cHuuQt3q8TxAhLq+zBG9N+zkQfXQrkH+g=;
        b=dJ4o1su1MS5a881lr42A1EMfdbxghJdCO5ec6cCSsyKZzKA1kYBAZ9GGq2hsew4tf8
         I5vs3C9k+ywq3l6apQ+nvvYPfIILOcfOaFPleXTu6bmn9Qp6+0N9QsVEtO35mtxgqyIi
         qo/83EztCT3UySVDa7HstbTqbxkXwgHbiSqndCtJbp+wh6gMkx6ut5Sv6T4EREa2vEGj
         5LjODj4PUi3vSsGGi22LmNWEJYVqhfgxplnqQekVS3Ihykkfsse/QDP3EZdXVpTp2v6T
         oBPx5e8AS/CTeiJnula9JcymkrKy/sqH/0fK6Szl+TIzylNE5ABDauMhtMJEj1/Y8gII
         EiIA==
X-Gm-Message-State: AOJu0YxOeQAGsja/xmvVvpwjXLDC1EGUowVhafe6NEymkwFqFTDrNMwB
	xVagz1zSUrnf+ZcDRGT53X30A5zSkVQ0MvFFmyR5ulyupRURZeDcJ8d2FQrGa8+63ijG+UVLMHe
	N/eNmEEQAbOKd30WvAFveLJJYY7M=
X-Google-Smtp-Source: AGHT+IHU9T6LL01GUecm+IvzzB70+L0tc5CbaFWmtFcZruG258wvuzAvviNNQid60Zhs0yhkTvn78d8ZDVK1MeAd5HM=
X-Received: by 2002:a17:906:b28c:b0:a37:b1df:30ad with SMTP id
 q12-20020a170906b28c00b00a37b1df30admr2400439ejz.46.1707231773299; Tue, 06
 Feb 2024 07:02:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206142027.make.107-kees@kernel.org> <20240206142221.2208763-4-keescook@chromium.org>
In-Reply-To: <20240206142221.2208763-4-keescook@chromium.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Feb 2024 17:02:16 +0200
Message-ID: <CAHp75Vf3c0Q7tV8ih5fRL6Bsjr6dhspFe+mxV7xUN=vZ1JdTKQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] um: Convert strscpy() usage to 2-argument style
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, 
	Justin Stitt <justinstitt@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 4:22=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> The ARCH=3Dum build has its own idea about strscpy()'s definition. Adjust
> the callers to remove the redundant sizeof() arguments ahead of treewide
> changes, since it needs a manual adjustment for the newly named
> sized_strscpy() export.

..

> -               strscpy(dir, home, sizeof(dir));
> +               strscpy(dir, home);
>                 uml_dir++;
>         }
>         strlcat(dir, uml_dir, sizeof(dir));

An (unrelated) side note: are we going to get rid of strlcat() as well
(after strlcpy() is gone)?

..

>         if (*umid =3D=3D '\0') {
> -               strscpy(tmp, uml_dir, sizeof(tmp));
> +               strscpy(tmp, uml_dir);
>                 strlcat(tmp, "XXXXXX", sizeof(tmp));

This code is interesting... (Esp. taking into account making a
temporary folder out of this...)

--=20
With Best Regards,
Andy Shevchenko

