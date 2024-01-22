Return-Path: <linux-kernel+bounces-33144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE70836531
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028AB1C21D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379223D38E;
	Mon, 22 Jan 2024 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqXgAAt2"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03E1DDC3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932865; cv=none; b=qGPVn7W47ol392tKd4xoeFFPxBJ2n4Ae+WwlTiz25cqRM9qjT8d47WJ4/0vtxxYexKQsTHPR5mjOgs7g8qUy5HtEbcPtxYLW+eUx1nWVPmJmMamSF845x8OzK3dBOey/rIMtD3YaiFAjUu9aBBqgtprF8QZkW4zPgGbXOchT3i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932865; c=relaxed/simple;
	bh=ErCyol5PZx6qXhJjCCnqoBN3KenhOYwcv+uuntVnlDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THioDOV5dNpbK07OZCSzAW3tfojC+dQbouijUgQMx9U4LjGCBtlt/hGUZ5X6pTWRY0+leUzJS/rXWehLTKjRvgZuGkUboRMyR5tD/6CyR2AlWkOve/9A9TgUBl8yvlslHDjtBDXygNjetF8T31myyCfHuH2v8FPJSf017PrDjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqXgAAt2; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dae7cc31151so2120018276.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 06:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932863; x=1706537663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErCyol5PZx6qXhJjCCnqoBN3KenhOYwcv+uuntVnlDk=;
        b=UqXgAAt29SN7FmUWvBGpDgfcfTQchOIDwzQEvjaADPFcICJNVpJkoEe0fcKgGYwqL8
         sI45YY81u9asw5XHKV1F2s7QHZHtCcCQPgF+pypspZLUvL13LjG4xTjy9r076FGEx0Fx
         Q+/LaviQbr0RYwt+LGWXwH0yV3PrrAHmAzr3YPftul2zO4+AwtGsdSjvZag/FQrJhCQN
         VO4Hc1haYQMjI9CIiZ6wDKXa6wdCPxcRXwdJyIfwlEu5vu3yRvVxxmgVP9mFJhOU8gX9
         RRWd/4SeMCbfh5F9XaBynZnoeVlV1YkuuItDyd7+wBUQDawbROv3snsKXhaFOgseysJq
         OL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932863; x=1706537663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErCyol5PZx6qXhJjCCnqoBN3KenhOYwcv+uuntVnlDk=;
        b=sYzNbvfZIbwXiIcwunBSIzDzHv19OF1MsWAZyXENuIUCsnSDh2wIUSwO3+1Om9wxcp
         v/exEbqGXcIa4YCY/UVN0j6Y6XtDGujqsSwl4pYU/pyPLLZxovH4WrPIRv6tZaDIbCtL
         FkCVeShAX2Zotfn9ggSU7a5GHvHL6azHTcAZLP/1v+c7cE0bHyXgks3fYMe92i+kJ4L+
         JYNbh8qNPqQqibkJ/RtfRgg7z+JDL0h2t/oYCpHa/CLycnRg90TSqza5kKKg0ejgmhLT
         magoNG4u1voKzp5K8uTh6Zzy3Jk7XueE/CYZsz3/ifZvBG5/MuF8TnLRD9961ZxEWC1Q
         mHGw==
X-Gm-Message-State: AOJu0Yxeb24YwC+h74sL4kgPcxEvAW+G7e2a0rMGqhWfjCnuwr92gGPE
	0c1tO2AA/qWbQk5Ex4iPkEZNCc+dlvOFjp+AMM4ILVHwirBaEaZ6IlKM7FeCc6Tl8pGZcqxyzl9
	345TU2Ja6hiOKNUsdfJnGCMPsKLg=
X-Google-Smtp-Source: AGHT+IGFEL9Ia3FpKndYQJjL+ePudTsCv9XRFC+t8B4dyNPevXxhMtw6VxkEKiXPKxsP1QtRS07YNey0Dodabekc8KU=
X-Received: by 2002:a25:a161:0:b0:dc2:5528:7494 with SMTP id
 z88-20020a25a161000000b00dc255287494mr1950832ybh.64.1705932862956; Mon, 22
 Jan 2024 06:14:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <ZakqQyL9t2ffNUIf@tiehlicka>
 <CAK1f24k+=Sskotbct+yGxpDKNv=qyXPkww5i2kaqfzwaUVO_GQ@mail.gmail.com>
 <ZapwWuVTIDeI3W8A@tiehlicka> <CAK1f24m9oxciHsAht4-cCWo_NT7x+bkoXUO2HOwgMCr0OnwpcA@mail.gmail.com>
 <Za5yvjZWVyYjgyfh@tiehlicka>
In-Reply-To: <Za5yvjZWVyYjgyfh@tiehlicka>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 22 Jan 2024 22:14:11 +0800
Message-ID: <CAK1f24n+pTw=7atKGAbgBh8qKOTBPq-BEV7ZkLcgN3P0n3h3ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, david@redhat.com, 
	songmuchun@bytedance.com, shy828301@gmail.com, peterx@redhat.com, 
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:50=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Sat 20-01-24 10:09:32, Lance Yang wrote:
> [...]
> > Hey Michal,
> >
> > Thanks for your suggestion!
> >
> > It seems that the implementation should try but not too hard aligns wel=
l
> > with my desired behavior.
>
> The problem I have with this semantic is that it is really hard to
> define and then stick with. Our implementation might change over time
> and what somebody considers good ATM might turn int "trying harder than
> I wanted" later on.
>
> > Non-blocking in general is also a great idea.
> > Perhaps in the future, we can add a MADV_F_COLLAPSE_NOBLOCK
> > flag for scenarios where latency is extremely critical.
>
> Non blocking semantic is much easier to define and maintain. The actual
> allocation/compaction implementation might change as well over time but
> the userspace at least knows that the request will not block waiting for
> any required resources.

I appreciate your insights!

It makes sense that a non-blocking semantic is easier to define and maintai=
n,
providing userspace with the certainty that requests won=E2=80=99t be block=
ed.

Thanks,
Lance

>
> --
> Michal Hocko
> SUSE Labs

