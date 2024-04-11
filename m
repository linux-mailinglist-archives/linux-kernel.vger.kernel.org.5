Return-Path: <linux-kernel+bounces-141461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293928A1E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8DD1F29DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8F013AD0A;
	Thu, 11 Apr 2024 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X6SPhAzK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3DA13A88D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859272; cv=none; b=fzF8hjXDa4K9OYn2zuMwfwSX//lq0X7nR0nbPsr9BrmHzuHMun79YMvoLOn4OS8qO4gEYpfDq71Lt42UXePAxnxK/9473317uWCRskEjB22wTMoOo2jfHd0CYIp4f4ctUyvwuSkIg4/b+rBHoI6WpeyDmSqRkNzKmZIOl7DFS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859272; c=relaxed/simple;
	bh=DybY5geq/NnjXSSLgHJhlnzwn1nIcKVs1t5wzdMrvQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etKg9dT+8wkIC6ae8QqbwD6crQIBifTofxLYFEcZdxxwIWMFQaGrXvqn6GnI3BdBzIbA6QDK+4I27mrMZOlKdjMiMZTS5qxScPYrrRgjYWU0+3qFdLf5m2J74hp0Iwm2at/VrQf4C5TGgjlHcMixc1f/pLjUKbLFR1Dr0Fb3pbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X6SPhAzK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5224dfa9adso21986366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712859269; x=1713464069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHBaBIUoFklBaMtTfic4+fLd2+2/fo4UaDmh0hhFoUI=;
        b=X6SPhAzKn5otULOlWhcCPrOp1t7ioc+elZJIRY+DlTa6eieWZAD6qM22+u0uv4rBQ8
         M3YCkYEuQ+oPWjlrQH7VvMPbPfuP0FvDT/4/8v6Y0DGOSJ/HRfJtkriA0D8LRIyY1ISp
         5u5ANv6MeZvdQTQbzVbsws6hPsVLkFbVXUlns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859269; x=1713464069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHBaBIUoFklBaMtTfic4+fLd2+2/fo4UaDmh0hhFoUI=;
        b=gTbDyU+QCWNmRRZPvAvxp/BRltoyXq7T0ESz6goB2AbDgzSzX1Nnpnf8+nyYXWhygm
         xkuK9EL5QsHLkCVknM6cyVcczG5Mn70G8I3rQltfge7pjZ/DoJKx028JVkgQAs2AmMMy
         O3bVrO39LeHrpaAXB8pXgUfoRxCG/wphcAVyhLicwQ8HIJoOZWhs1ZLCVUobZKXpp4s0
         4tv7OheklYS0DGlOAP+9Kp+p3s5dVyBVA7s8h0FlL+xBqrE0iaqNTDIMXq3XwF5VCf2K
         SP2Lj77F7fKEMCikw5CkxBz3t73CDqh8js8wVwAYLHU3ENn9DwbqJqKNOkuTqyxIYaO0
         ya5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlt2vPRaiyVQcSMagCRM7TIgHUxEXY2h4qAZ0g3AsHIXb+HQ+XWlJaegrh7Abng2XaOkC0RZ2BEcQj4dWCNlBp/mt8L6JESU9/HbX2
X-Gm-Message-State: AOJu0YyqN8uwSu70XFfpEa8lvHGabrohkfXS4O1yywHtcx13zd+XTGoE
	V/8J6a+byocpt1huOZH7+nsiNjSMfZFQgSePrQjR9yt/Io2cgNKX/EWV43ecnyrk/lB8AR6K5n7
	S/IndEg==
X-Google-Smtp-Source: AGHT+IGLk7zSxboT92DAg9wuGbVtmG2/phTjh2hGXmckKUqMGHYmB5pa6UUIxbXEhQRvehcBKEcguQ==
X-Received: by 2002:a17:906:c79a:b0:a51:e188:bced with SMTP id cw26-20020a170906c79a00b00a51e188bcedmr2206786ejb.37.1712859264083;
        Thu, 11 Apr 2024 11:14:24 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a10-20020a170906468a00b00a522d350674sm291951ejr.184.2024.04.11.11.14.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 11:14:23 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5224dfa9adso21972566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:14:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWU61ELjxQk3mczlbo/iXQBBOuRRcRILMWvy3Yfnrr+dIvK1cWjcCAXFIWiErYuVGRln6vXPxnKVRGKkQWIyCLyrU8ltEcZ0AAWAn3O
X-Received: by 2002:a17:907:9450:b0:a52:1fe5:d1bb with SMTP id
 dl16-20020a170907945000b00a521fe5d1bbmr2535657ejc.11.1712859249933; Thu, 11
 Apr 2024 11:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner> <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
 <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
 <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com> <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com>
In-Reply-To: <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 11:13:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
Message-ID: <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 10:35, Charles Mirabile <cmirabil@redhat.com> wrote:
>
> And a slightly dubious addition to bypass these checks for tmpfiles
> across the board.

Does this make sense?

I 100% agree that one of the primary reasons why people want flink()
is that "open tmpfile, finalize contents and permissions, then link
the final result into the filesystem".

But I would expect that the "same credentials as open" check is the
one that really matters.

And __O_TMPFILE is just a special case that might not even be used -
it's entirely possible to just do the same with a real file (ie
non-O_TMPFILE) and link it in place and remove the original.

Not to mention that ->tmpfile() isn't necessarily even available, so
the whole concept of "use O_TMPFILE and then linkat" is actually
broken. It *has* to be able to fall back to a regular file to work at
all on NFS.

So while I understand your motivation, I actually think it's actively
wrong to special-case __O_TMPFILE, because it encourages a pattern
that is bad.

                    Linus

