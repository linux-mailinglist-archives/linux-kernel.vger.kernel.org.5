Return-Path: <linux-kernel+bounces-141540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709438A1F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B8B28638C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1657317582;
	Thu, 11 Apr 2024 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WTzaXJlO"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CA313AE2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864114; cv=none; b=KFD+SrW9iueLBXv2KOdpDa9GYebtM3ihdDVI4AvrmzMj0MH4UxGMweRY9tyxAXfBWx0LgfvfVGjXS2bAPkNMcLcyO+buwGu0v7XaXRvBKI50NTRPTugxbG4t1128sPSs1KgPlWGmIeFHDRVinVCfil03/KZFn0xS/Iui4zXYviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864114; c=relaxed/simple;
	bh=5KVFeFerRH8GLwfSRDO//pTmkAv+uv/gwR3NCKN8Cdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyutQgUxwfsXhpSzP8RUZdr2iw1qDYQMB+OCDvT765lkOtRTvREkM3HUg5Hdf+QQsoajJY1UBnyDQgZSjNOIP9V4ukH3aE0vc0gdnpevy2EAH2qR0JQ43dACvCW0Q+plDNxw8IFH12vK+5KC9sXCSLTeEJi35Mis7STcxTMHIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WTzaXJlO; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d8129797fcso1409181fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712864110; x=1713468910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qhujaawioP0edqzESewC5qrutyIfvYKamEof/gouabc=;
        b=WTzaXJlOO/kVxxr1UkWojPQ/xwlyFTzOJSP5b0jR/awylRo5f1TXq5e9VoMDDY3kO2
         FFLH/bUak6hUenp9hECToGe5ICfRIfzKfk90FANs+DTVMzj3e0K5xRZ7x080OufLuOAP
         z6rlyTv541da48Ok+wcK3uaiY64r9X/GDlcuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712864110; x=1713468910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhujaawioP0edqzESewC5qrutyIfvYKamEof/gouabc=;
        b=HS2SoQFUyUh1r03He6h8svjUmrHD2gjl3YbVDCcPAxrXsf0PjvCWoscnuHBxKiFUm8
         yCIbqTf8Ni5fAMTdULxy2ncM5e3MF6pZCiUNgnFiToBMCS0Y6VgNs/oPpLAnLLQEyWjx
         276pZfHKvtUUdNZulEvOlrr2B2AtjR3stg2xOpUOUtKccEwq14MlMqm5sWoUVKf5S85g
         o4CkHpZncczorkF2FQemQOPOymO92yGji2+WwtaNmGBdOri0z32DyzGhOvN8S3RRlBxP
         qwZdCzxs5sPBOqVKOAH/UfS+9iu1+P5boMTCJU3sU39C+l4V6Nc1uQaKC7Xdd+GbMbM7
         UhVg==
X-Forwarded-Encrypted: i=1; AJvYcCWf+Jjeqvg+ryC9y061oCeUFmg0F0cgCC3pCMS+Zd9PTicPz8/saM6+ayJijrkdkHU29jiXiXQSrbxy/wRGEued0HELQwNOgyEo9iRz
X-Gm-Message-State: AOJu0YxTeXrhPDMqmqSLeLXRRuxtSroekFiTCUoZWDzWseYXR6cgw193
	G3enFnHNQmJchuqDFnQ6VXZ3gdPBiN6nWv+1n6bpySrLtGGjlebq9hvmBy9zbJ7MkhhHoW9BvUV
	6FufrtA==
X-Google-Smtp-Source: AGHT+IFw2+Lh2FafyqDQylF2+vel37vCZLYMzft8itWuJW5AD2fZCz6DcWMfMjdi9ali/AYwCB6lwg==
X-Received: by 2002:a2e:be86:0:b0:2d8:d472:581e with SMTP id a6-20020a2ebe86000000b002d8d472581emr528389ljr.37.1712864110364;
        Thu, 11 Apr 2024 12:35:10 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f15-20020a2e6a0f000000b002d868f2939bsm276785ljc.103.2024.04.11.12.35.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 12:35:09 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d2600569so275958e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:35:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPwyMcBgDMERRSML1YVdLwHvKFfMwV0Vas0boYuD90S3dq+RdYUj9p4RtXpoWpksJ9Y74NTqGoIYJ15h2nu7TwJAvcI8DVWOxLw5KT
X-Received: by 2002:a19:3855:0:b0:516:d11b:5532 with SMTP id
 d21-20020a193855000000b00516d11b5532mr402271lfj.23.1712864109199; Thu, 11 Apr
 2024 12:35:09 -0700 (PDT)
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
 <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com>
 <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com> <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
In-Reply-To: <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 12:34:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEdyUeiu=94iuJsf2vEfeyjqTXa+dSpUD6F4jvJ=87cw@mail.gmail.com>
Message-ID: <CAHk-=wgEdyUeiu=94iuJsf2vEfeyjqTXa+dSpUD6F4jvJ=87cw@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 11:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So while I understand your motivation, I actually think it's actively
> wrong to special-case __O_TMPFILE, because it encourages a pattern
> that is bad.

Just to clarify: I think the ns_capable() change is a good idea and
makes sense. The whole "limited to global root" makes no sense if the
file was opened within a namespace, and I think it always just came
from the better check not being obvious at the point where
AT_EMPTY_PATH was checked for.

Similarly, while the FMODE_PATH test _looks_ very similar to an
O_TMPFILE check, I think it's fundamentally different in a conceptual
sense: not only is FMODE_PATH filesystem-agnostic, a FMODE_PATH file
is *only* useful as a pathname (ie no read/write semantics).

And so if a FMODE_PATH file descriptor is passed in from the outside,
I feel like the "you cannot use this to create a path" is kind of a
fundamentally nonsensical rule.

IOW, whoever is passing that FMODE_PATH file descriptor around must
have actually thought about it, and must have opened it with O_PATH,
and it isn't useful for anything else than as a starting point for a
path lookup.

So while I don't think the __O_TMPFILE exception would necessarily be
wrong per se, I am afraid that it would result in people writing
convenient code that "appears to work" in testing, but then fails when
run in an environment where the directory is mounted over NFS (or any
other filesystem that doesn't do ->tmpfile()).

I am certainly open to be convinced otherwise, but I really think that
the real pattern to aim for should just be "look, I opened the file
myself, then filled in the detail, and now I'm doing a linkat() to
expose it" and that the real protection issue should be that "my
credentials are the same for open and linkat".

The other rules (ie the capability check or the FMODE_PATH case) would
be literally about situations where you *want* to pass things around
between protection domains.

In that context, the ns_capable() and the FMODE_PATH check make sense to me.

In contrast, the __O_TMPFILE check just feels like a random detail.

Hmm?

Anyway, end result of that is that this is what that part of the patch
looks like for me right now:

+               if (flags & LOOKUP_DFD_MATCH_CREDS) {
+                       const struct cred *cred = f.file->f_cred;
+                       if (!(f.file->f_mode & FMODE_PATH) &&
+                           cred != current_cred() &&
+                           !ns_capable(cred->user_ns, CAP_DAC_READ_SEARCH)) {
+                               fdput(f);
+                               return ERR_PTR(-ENOENT);
+                       }
+               }

and that _seems_ sensible to me.

But yes, this all has been something that we have failed to do right
for at least a quarter of a century so far, so this needs a *lot* of
thought, even if the patch itself is rather small and looks relatively
obvious.

                 Linus

