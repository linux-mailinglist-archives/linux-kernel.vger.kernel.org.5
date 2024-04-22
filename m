Return-Path: <linux-kernel+bounces-154211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D688AD959
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81B22879CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CABB46435;
	Mon, 22 Apr 2024 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LYMqN4nt"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11AE45BEF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829946; cv=none; b=odViuGHUB1g9ExpE53uys5rYOF3e42VQO+rgEG+ZyURx7E95M53+BE+HzjjFqPkH9MaIFSApBdoD+fzLbAMOUBN95SDmt5Bs7mje5ySQy1H0+Btw1GYCX8H44EVAtY2woBHHTo4wqUYYSKKrCrjYT5+e61rWNp+Kd9iA1z9meTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829946; c=relaxed/simple;
	bh=EHpp7S73gOdRUjxiqhvAAq6aSAY1pPeHrx6OMKnKkiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fj2lNyesKCXQM7LpxIpYeFqBMwhNYx0o2/cHLhJFep3q38kczc4hS9yCktYHZuEarJonKAiJx3xYWmEYee13WGdcM2exn+i/3tzLQw1M8Fh8OBseSZm1ZDV0YdJfAgX7VVgjpFUEP3z8AiE/iHC2hffKPE0vuUy38jh0B16P4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LYMqN4nt; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61587aa9f4cso55773967b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713829942; x=1714434742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DOqaxMdms/qXRzuhL549SToyGg4i6A1dwMfsfdbbL8=;
        b=LYMqN4nt3DdEqAJP0OrcH1KFiHaOJY8rWY2LLSd+Yd7H7KZWyJ+aY3IrVgTmoAGrV2
         3uaRFXm/b07uTINi5x1NzPDQN1swjKPL/CVCUl+AceB4x/8vKFgdLNmvQFoTUp3hE9Pt
         gndfyBftqxqUf/YvIImc5NLf9VIJGAdGleuCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829942; x=1714434742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DOqaxMdms/qXRzuhL549SToyGg4i6A1dwMfsfdbbL8=;
        b=GktTyriyTs5tlfAxz+5XWA2biVwjtGKhCJt8s8llL5VA5cqlgBdmlh4TKtapNxSm8o
         w+U16cG3P9lMfV0+FZCphBgiVmrzz2ek2H012wZq/N1qKbIwSIJfriCJdmeLv9vFU/cl
         sWAYbIVEGLQG4py/hl0mZDZg4Z5wC48GTKhHC5udHX29StPyu3i+80dkHPSSg/3k2LgR
         0xDnSEBt3gb8t3+JL0sq+UW5xcOyJGZNRR2DDJlAUpDe+P9FbEmCq3fLfw5Oi5rHFBRQ
         U7otQEXKF6R/3Tm7PT7EYJsva9EcDBHxwVflmdh/w0hg6w6y9z4ENFxRh7/oTO95hE3/
         fF+A==
X-Forwarded-Encrypted: i=1; AJvYcCVnlrQGuxfmBfjOV2Yy3VVYTBWZt34z+8Y2cmhhu97xms7aP8SfZhCz4dECrXrf0CcfRa83fNufcvasazGrmJTvCTmJX+FQ3v3ZR6rs
X-Gm-Message-State: AOJu0YyyBY/kOKdxD53ocKe5OvN8FDDCzJ2Uh0KP6I5R054PmqZC4jll
	eAWSrFDVnDztw6zKncX5O3t2tTKQzfgUOrWif9pXrUvTrBK/y0u7NbtUg8yYotXQ4N4UYDystm5
	wbtDY
X-Google-Smtp-Source: AGHT+IGuhqfGULtR0KQg+vxAr4PtZZkY2WKeQVtf1gXOGwgDXzkuWBwjrI1RRaaR3Bl1FkoNHZLRMw==
X-Received: by 2002:a05:690c:7209:b0:61b:33b6:41dd with SMTP id jl9-20020a05690c720900b0061b33b641ddmr12761514ywb.37.1713829942149;
        Mon, 22 Apr 2024 16:52:22 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id t13-20020a05620a004d00b0078efd956945sm4758489qkt.126.2024.04.22.16.52.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:52:21 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-439b1c72676so100991cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:52:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1A3Kc4z3sC2NPBgUGYJ52r8bmf30G7xhUqPdGi/OJtZJ0jSFUmlmjm00FYr6rhb8mfWASVPz7U2NxbT9cp0VPdmopNItJKG1n/NcW
X-Received: by 2002:ac8:6682:0:b0:439:891f:bbd2 with SMTP id
 d2-20020ac86682000000b00439891fbbd2mr122734qtp.28.1713829940394; Mon, 22 Apr
 2024 16:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org> <20240422-kgdb_read_refactor-v2-2-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-2-ed51f7d145fe@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 16:52:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VXFHqOatn3cvwvYCey53+zuzB7ie4gYdvDVbfGL=Qm1Q@mail.gmail.com>
Message-ID: <CAD=FV=VXFHqOatn3cvwvYCey53+zuzB7ie4gYdvDVbfGL=Qm1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] kdb: Use format-strings rather than '\0' injection
 in kdb_read()
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 9:37=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently when kdb_read() needs to reposition the cursor it uses copy and
> paste code that works by injecting an '\0' at the cursor position before
> delivering a carriage-return and reprinting the line (which stops at the
> '\0').
>
> Tidy up the code by hoisting the copy and paste code into an appropriatel=
y
> named function. Additionally let's replace the '\0' injection with a
> proper field width parameter so that the string will be abridged during
> formatting instead.
>
> Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug=
 fixes
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)

Looks like a nice fix, but I think this'll create a compile warning on
some compilers. The variable "tmp" is no longer used, I think.

Once the "tmp" variable is deleted, feel free to add my Reviewed-by.

NOTE: patch #7 in your series re-adds a user of "tmp", but since this
one is "Cc: stable" you will need to delete it here and then re-add it
in patch #7.


> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 06dfbccb10336..a42607e4d1aba 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -184,6 +184,13 @@ char kdb_getchar(void)
>         unreachable();
>  }
>
> +static void kdb_position_cursor(char *prompt, char *buffer, char *cp)
> +{
> +       kdb_printf("\r%s", kdb_prompt_str);
> +       if (cp > buffer)
> +               kdb_printf("%.*s", (int)(cp - buffer), buffer);

nit: personally, I'd take the "if" statement out. I'm nearly certain
that kdb_printf() can handle zero-length for the width argument and
"buffer" can never be _after_ cp (so you can't get negative).


-Doug

