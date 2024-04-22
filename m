Return-Path: <linux-kernel+bounces-154216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7358AD964
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F461F21B00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728CF4778B;
	Mon, 22 Apr 2024 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vexbhy1t"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3B646433
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829988; cv=none; b=uG0F/2v2OnNGSHBtkHOYvDczePqYkt7Cxrn+FCcazUUVe+lqagXyxMaO5kiuAau7YBsV/68g+K/wMWNQr+TKev79gNk6vWWc20l3Kd/9/gvYRQX8+e22YAWGOFl3CkT8O/Jbw7NNaPhY2DWUp2fTdJvgCSfibLfwtmAX7FaBOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829988; c=relaxed/simple;
	bh=iXV0L1N+Lrq9i/jVw377JzbRRAKm374wRqrzKNfzVV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCHPb4XQ6L5S8GLjP/s+gxI10530+Zxje2arQiG+Q515j/AaV0Ua3eE6rPM9zSpQvVTuKw3Th/chNfUhDuMOxCswMPH2bsMUmZS5YfRBpFkqjVYFHrN3IlsKE8d1vkzWiBPaSZGobpVfrR7IXWjO2OMAqwlCyzzT2FCmO5fRt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vexbhy1t; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f03917484so355912985a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713829985; x=1714434785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvKHZ9JjRUWbi49dOaz2jnKn8wC1TnFH6x1+VhyrjCQ=;
        b=Vexbhy1thr3evOmNrdpJ7X1qnDGrrRZ+Vic6Va81NvCXZ1CsYcM2IAZUFUCUqngfWJ
         IneLkj4SOFHVJga2RHHP1/i0C8a6cgWLLAoUie/VNLl/LXWUQhXtR7zxsh4E3TK03D1Q
         qov9T02g5/46sSKplU1GWa76YE8mKIKZGmlxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829985; x=1714434785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvKHZ9JjRUWbi49dOaz2jnKn8wC1TnFH6x1+VhyrjCQ=;
        b=A/k5TJEzxC8HmNWAhtzACNpDmLp332Bcs7QSN4DiW+ZlLfVn+LClokJLr+0YGLAr8l
         UaYeeba+hqkt4sAKsg3mYK1RdlOqr0k6R2It8iYPcE9DGviiehjGIfeCBmHW3U8lG42K
         2Fq95BFFQFDLLSQZn7QVuXlMxvS0H1cgXQ5HCPVdmRLLhn/tR4g7f72FQfoBI4JP5IVh
         exagChLNjRS1WUjroSLpl7n99rM+/pdtnmL6WjUum/Xt2HLiEnKgb3IAiydrcceMyB9R
         cAbvRR386W3jnEnKGD8szkNggyP6++QzFZmdB+W8umBg5DHfTpathqYIE15X666tDlCk
         197w==
X-Forwarded-Encrypted: i=1; AJvYcCWOFzP86jokuaPSQ5lrUlEYG6OxstENatNKTWBc8lpEIa/tIf4cev5iV94d74id6A0IvQRDpXgwTpRXUZ2FhTU6g0CGlSUMvqM06D8y
X-Gm-Message-State: AOJu0YxEmSXK95HSs9RVnFX3htqKYImspeAiZBw/8DCE18LP3ntCe1iP
	usdv/m8CB1LhdQuSHUAboY+P53lgYx3sjcRSOVTlw9UEq4qyxxzCQBz16OATuVFtOMtNZpypdbu
	ez0TV
X-Google-Smtp-Source: AGHT+IEinM01N5U+ifXog96XFOca7OTLByJm/2xhnifBQzlGS5u5b0y10hw6rhkr+ahA47OBdqykyw==
X-Received: by 2002:a05:620a:8221:b0:78e:f092:88d4 with SMTP id ow33-20020a05620a822100b0078ef09288d4mr12156775qkn.70.1713829985547;
        Mon, 22 Apr 2024 16:53:05 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id du30-20020a05620a47de00b0078d65fbde2bsm4758217qkb.86.2024.04.22.16.53.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:53:04 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-436ed871225so71831cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:53:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVI8UCW3oPQo4Z2hSvJFsrOjmuRDbyznXAVKMjZ3Q9aNS5zowIdQ4fz3r87dOqNso0dVjpQuZe0aMy//jxRSZtnR9I+hwjr0WhFWd2+
X-Received: by 2002:ac8:7c6:0:b0:439:b85a:3fa with SMTP id m6-20020ac807c6000000b00439b85a03famr67307qth.11.1713829984304;
 Mon, 22 Apr 2024 16:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org> <20240422-kgdb_read_refactor-v2-7-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-7-ed51f7d145fe@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 16:52:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XqSmD4WGyBp7Cv1i8X9yjk2gH1y2j_5qzkxtDL+GKv3g@mail.gmail.com>
Message-ID: <CAD=FV=XqSmD4WGyBp7Cv1i8X9yjk2gH1y2j_5qzkxtDL+GKv3g@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] kdb: Simplify management of tmpbuffer in kdb_read()
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 9:38=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> The current approach to filling tmpbuffer with completion candidates is
> confusing, with the buffer management being especially hard to reason
> about. That's because it doesn't copy the completion canidate into
> tmpbuffer, instead of copies a whole bunch of other nonsense and then
> runs the completion stearch from the middle of tmpbuffer!
>
> Change this to copy nothing but the completion candidate into tmpbuffer.
>
> Pretty much everything else in this patch is renaming to reflect the
> above change:
>
>     s/p_tmp/tmpbuffer/
>     s/buf_size/sizeof(tmpbuffer)/
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)

Definitely an improvement.

Reviewed-by: Douglas Anderson <dianders@chromium.org>


> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 94a638a9d52fa..640208675c9a8 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -227,8 +227,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
>         int count;
>         int i;
>         int diag, dtab_count;
> -       int key, buf_size, ret;
> -
> +       int key, ret;
>
>         diag =3D kdbgetintenv("DTABCOUNT", &dtab_count);
>         if (diag)
> @@ -310,21 +309,16 @@ static char *kdb_read(char *buffer, size_t bufsize)
>         case 9: /* Tab */
>                 if (tab < 2)
>                         ++tab;
> -               p_tmp =3D buffer;
> -               while (*p_tmp =3D=3D ' ')
> -                       p_tmp++;
> -               if (p_tmp > cp)
> -                       break;
> -               memcpy(tmpbuffer, p_tmp, cp-p_tmp);
> -               *(tmpbuffer + (cp-p_tmp)) =3D '\0';
> -               p_tmp =3D strrchr(tmpbuffer, ' ');
> -               if (p_tmp)
> -                       ++p_tmp;
> -               else
> -                       p_tmp =3D tmpbuffer;
> -               len =3D strlen(p_tmp);
> -               buf_size =3D sizeof(tmpbuffer) - (p_tmp - tmpbuffer);
> -               count =3D kallsyms_symbol_complete(p_tmp, buf_size);
> +
> +               tmp =3D *cp;
> +               *cp =3D '\0';
> +               p_tmp =3D strrchr(buffer, ' ');
> +               p_tmp =3D (p_tmp ? p_tmp + 1 : buffer);
> +               strscpy(tmpbuffer, p_tmp, sizeof(tmpbuffer));

You're now using strscpy() here. Is that actually important, or are
you just following good practices and being extra paranoid? If it's
actually important, this probably also needs to be CCed to stable,
right? The old code just assumed that it  could copy the whole buffer
into tmpbuffer. I assume that was OK, but it wasn't documented in the
function comments that there was a maximum size that buffer could
be...


-Doug

