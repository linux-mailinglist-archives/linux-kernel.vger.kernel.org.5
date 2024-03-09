Return-Path: <linux-kernel+bounces-97700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA40876E09
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 01:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69BA1C21EAC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A8F15C3;
	Sat,  9 Mar 2024 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KO7ECHUh"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138FD620
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709942671; cv=none; b=EiMuMlXaBDXdK907ff5HqLFarQeQ9EkLl8Pt1PlfoepQa02UOtz2osK6m/S8NEnAUW3lPwyx1350rWRU5rAs1LdwFVctsxdnoqSw+rbjqUpGyR6FVOFc+4KsG6WChXH2UHpaKh4fdac68NK9kjVexU14N/nekbH6kbdr1yl+aqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709942671; c=relaxed/simple;
	bh=vxsATqgNsPjCEnUG9U3rsV4Pk5K0jSUVYO72o5X1hR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bw3OKOV6ylgnFah+tAFbMXDhn9x5Fs8Su8sPh7cu44Cf1kf1jZp7OXTc67KAV73s/I+L6j+IMjW2rSP63BWcp90bbw+6RDPBYqOqHf8tb74b3JKON3rAI3rLo7TnZtiadskxvXQ99jhjYspW8CFo0ioTK7NutLzJq4SvNiu+Yyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KO7ECHUh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a45606c8444so333606866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 16:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709942668; x=1710547468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ShLjDVt5TyNUjC5WP0bvmBKt0Z3sW/nw5eC5/Dqk7k=;
        b=KO7ECHUhfUqCYSwFVKfZtIP6UNKf0a1LJaJDi78f5ohgFd9h9HcFUBfvAP/ww33e60
         HU0ev6JJBmtV0d2muXR315uwwb+ZJ21nM6ZDHnt1lqH7pZjXYN3XEXeX5bzO7fTW66v8
         CiiTHAC2Gi6FqG58JlGH9aMghNxMJ8tJjXI8RZiAxqIlrtW6IeH6LhaCS9KZAl3DHQmA
         ngtEnNF92TseMMLumcfFJQkkPflgR5YBEHQm74yaUYrZ3pX6/Vl56U2EkPrLRj8Bl4iD
         bE+6QxbjM6TjzbXjYIGBkFP7M7esAgXxMSEpzyuTDgrAyLnQSMo+HJk/ehHcXhAmTMPd
         36Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709942668; x=1710547468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ShLjDVt5TyNUjC5WP0bvmBKt0Z3sW/nw5eC5/Dqk7k=;
        b=XLMYCGzH7Oox5Q9SzpioOnDDQJK5yhBqmTUlBRI1AoeTgwvSUMe/EhjzpUY8gfuacd
         5s3GoID8kE5Bynf6iZ1O6ZKOxDml13Os4UA/ZR8cJd01nvaE55zPBNTfmUVJREl4VTtL
         V38f2EzXIhKQHVHzVwPP4StO7cYRk7RE55B8YOuD6tQxc17YqEgdoS3uA6DNo7xY+XcJ
         pRklFoh4ryxZefSA373LZx2rC8H75CQGnMd3kDAwHPVvaGMgfnyoY/kxJoMGm1Hm3AJw
         psvIu2DWh2GXoKRA3QaFNE5vVqeKW2ymmmv1nlN3UVe6hx7N4Fb1LcRnmvH1r6djtLrk
         1ioA==
X-Forwarded-Encrypted: i=1; AJvYcCUBd4ceVp+S2QcihwrIpvwZ0x6UD1eYljkPRO2wlBpAQIfBL5hEliNuioHfGgPsfwFkHbs/k1AToFpMSnKwzB4UIvIIDHn7Acn44XPy
X-Gm-Message-State: AOJu0YzHunlx2dizCM13sPOpKvwVwf5nOyfZVHV/A7IRdYfY9p4cmgVo
	q55d6uN1z9TtdBOCEZpk1iSlIczZFGrTWSQnh9LlpgY36EOYXXmcTDWLRm22FCfsElDedOBNsTa
	r36cFg24lqo1U0+8RhregpI7mgNyoGpGNiWmK
X-Google-Smtp-Source: AGHT+IG5/WtGgOurdPyTTfUyg5tMClwiuIy0cwYe/KflW92nffNonl5K+8vLpJQoMoKsScc0PQSkwR4ssZrwckgzolI=
X-Received: by 2002:a17:906:5cd:b0:a45:2b2c:8968 with SMTP id
 t13-20020a17090605cd00b00a452b2c8968mr114204ejt.20.1709942668151; Fri, 08 Mar
 2024 16:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308204500.1112858-1-almasrymina@google.com> <8adb69f3-b0c0-42bf-b386-51b2be76cbb4@davidwei.uk>
In-Reply-To: <8adb69f3-b0c0-42bf-b386-51b2be76cbb4@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 8 Mar 2024 16:04:14 -0800
Message-ID: <CAHS8izOm18Rv7QJfpKmquEgf74PvqZeY4zBnyG73BVFDbCvWmw@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: page_pool: factor out page_pool recycle check
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 3:50=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-03-08 12:44, Mina Almasry wrote:
> > The check is duplicated in 2 places, factor it out into a common helper=
.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> > ---
> >  net/core/page_pool.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index d706fe5548df..dd364d738c00 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -657,6 +657,11 @@ static bool page_pool_recycle_in_cache(struct page=
 *page,
> >       return true;
> >  }
> >
> > +static bool __page_pool_page_can_be_recycled(const struct page *page)
>
> Could this be made inline?
>

Looking at the rest of the static functions in this file, they don't
specify inline, just static. I guess the compiler is smart enough to
inline static functions in .c files when it makes sense (and does not
when it doesn't)?

But this doesn't seem to be a kernel wide thing. net/core/dev.c does
have static inline functions in it, only page_pool.c doesn't do it. I
guess if there are no objections I can make it static inline to ask
the compiler to inline it. Likely after the merge window reopens if it
closes today.

