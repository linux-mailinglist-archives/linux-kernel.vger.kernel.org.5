Return-Path: <linux-kernel+bounces-128707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5D7895E76
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42111F23CAB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A415E5A2;
	Tue,  2 Apr 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j5gzK1aB"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C8979DD4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092188; cv=none; b=N7RgcXHLxVkghvfpXQUHMJEdBOJOovN42UEXOazyUlkI4uerdgHTLqs8COD1LZgpv9goXRglZhLNdFIrMHEbagDRemVMBjZpJc49Tu1geO2wNEVywU5foe/4YbrJv8Bwa+XVxYcjslKJRNF/ejz80BUsNOOrwOfcoLHS10I/KGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092188; c=relaxed/simple;
	bh=T71MZZYbHh/QHnIoLQj8nkValmMmnPqckXdi1WN9EEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qS0vBVQuNRbr1USzAD2u9+hS8L5p5FT2l+/ndtYuwc9yag/7CyUBIEFZ6Hes+KWR720lazasmfN67U2mnu+FZDyQVPN4NVmSzs/SWgUQL7FUOElqn62cZYEkDl4jIt9zUL6WNLlBEVWhycD62h8TIjOL5Itk96QsTbi2NjoPUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j5gzK1aB; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-432b5b3dad7so31680931cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 14:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712092185; x=1712696985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T71MZZYbHh/QHnIoLQj8nkValmMmnPqckXdi1WN9EEI=;
        b=j5gzK1aBAkzzfg6oQwkHrJmUYYFHQWxOdxkKBUx82p1X3ad3TD1519OqOsn5RERxoU
         4VjhgQj3FJpiiJT+qJPQWPXKLGkX+ja8jPNjwt/Bey/TlH31Le4Y6ccnoHyax9NAzp1L
         YtXLnn0Dg+dmhfNqFmd7qygkLkpUl8wzeEpzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712092185; x=1712696985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T71MZZYbHh/QHnIoLQj8nkValmMmnPqckXdi1WN9EEI=;
        b=fcB3z7c7DrQKz1R/Lt6tX59ZFwdGAORIPq0jmk+1wJqrP/Vl5p/+IUzUvCXkXWa9OF
         pBaoDiztdvauvtebW/+L6CRBwfHNuCNAx5k2yvT88JqYPffZxgvK7x4h0Wap2mpmcHvQ
         zD8V/no/rziU98PQZ+PPoUubW3HBSQprNuTUDxQgf06EuVXpgozVolUFWCN1hA/oP1CD
         In3G+muEnOP07tsqOEyJ1fpaH1R2K7D0oYopLHGyIxRb0h2boC+N66Vj7VSBScA+75cN
         P3syaWTg/63LpJoG8sE4ap7kEYFASXY8sr/4jxnI4D33O4OHriVis4V2fLGs0ZZ19I+q
         f9OA==
X-Forwarded-Encrypted: i=1; AJvYcCWX9ZkE6t00/8Mxj3v1mwByUCv9G6Pnm/Ja2zZzdolIkNjoMAc7YXNgMuPkEmcvb706lZR7J/uJQL+IIwagu+yiV8FnNyyTQJSKnVto
X-Gm-Message-State: AOJu0YyAlS+AANPfOylG3lWIdaOQ7HXEVHxo76+sgql9w7FCF7/4K5PT
	m+MmwMsEvl0kQ8D4J1LCGbq/PJjoNOqwLKaU0tNhBrML/96ksGvyO2LRlD2ojJPU4BRMSiWMxR4
	=
X-Google-Smtp-Source: AGHT+IEPbagne90lUU47F3qzyAq+7slc1nFtSw2V9LCNz26S5lL/jc+WFnxOfycxcQ1zTKCaLKoeyQ==
X-Received: by 2002:a05:622a:202:b0:431:80cf:5281 with SMTP id b2-20020a05622a020200b0043180cf5281mr14632077qtx.43.1712092185695;
        Tue, 02 Apr 2024 14:09:45 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id cq5-20020a05622a424500b00430dcca3fb5sm5871239qtb.16.2024.04.02.14.09.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 14:09:44 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-431347c6c99so91351cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 14:09:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAXC7ogttFbPX7tDnZXdi7Tl0MTrWGw1V0NZTzjw94yre30qcy4C7Ab2ztGmenYsSymknWFZBq+H3RukEHjF88k/JOzV8xwjVzxtjz
X-Received: by 2002:a05:622a:407:b0:431:68e6:314c with SMTP id
 n7-20020a05622a040700b0043168e6314cmr12641qtx.29.1712092183245; Tue, 02 Apr
 2024 14:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315091434.10622-1-dmitrii.bundin.a@gmail.com>
 <CAADnVQ+o9WQNdY2iApYMN=KnKSxnKGb6NcYzYkDD9V36Di6bCw@mail.gmail.com>
 <CANXV_XwaPOOYuAsveVbfNU4tFbw30rkX3AKrBdKzrNNsUxer+Q@mail.gmail.com>
 <CACGdZYLn5pokOQN-uqeaVPSOtVUHy+CGmuBduhgtV+Vft8WxbQ@mail.gmail.com> <CANXV_XzktootzRkRSWVCgBTUOdS5eOxKZyGV3w+uMYO1uAavKg@mail.gmail.com>
In-Reply-To: <CANXV_XzktootzRkRSWVCgBTUOdS5eOxKZyGV3w+uMYO1uAavKg@mail.gmail.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Tue, 2 Apr 2024 14:09:30 -0700
X-Gmail-Original-Message-ID: <CACGdZYLZUA-iMbiRaGt3q5gnFH6jK-tsKzY2LLCnf2t1CJhd5Q@mail.gmail.com>
Message-ID: <CACGdZYLZUA-iMbiRaGt3q5gnFH6jK-tsKzY2LLCnf2t1CJhd5Q@mail.gmail.com>
Subject: Re: [PATCH] tools/resolve_btfids: Include linux/types.h
To: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Xu <dxu@dxuuu.xyz>, Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:51=E2=80=AFPM Dmitrii Bundin
<dmitrii.bundin.a@gmail.com> wrote:
>
> On Mon, Mar 18, 2024 at 7:56=E2=80=AFPM Khazhy Kumykov <khazhy@chromium.o=
rg> wrote:
> > I'm also seeing this, on clang.
>
> I think the error is more related to the libc version. I updated the
> libc6 to 2.35 and noticed that the <linux/types.h> header is included
> indirectly through <sys/stat.h>. The relevant sample of the include
> hierarchy for <sys/stat.h> with libc6 v2.35 looks as follows:
>
> . /usr/include/x86_64-linux-gnu/sys/stat.h
> .. /usr/include/x86_64-linux-gnu/bits/stat.h
> ... /usr/include/x86_64-linux-gnu/bits/struct_stat.h
> .. /usr/include/x86_64-linux-gnu/bits/statx.h
> ... /linux/tools/include/uapi/linux/stat.h
> .... /linux/tools/include/linux/types.h
>
> The <linux/types.h> is included on the latest line of the sample.
> Starting the version 2.28 there's an inclusion of <bits/statx.h> which
> was not presented in 2.27.
>
> When building the resolve_btfids with the libc6 version 2.27
> <linux/types.h> is not included through <sys/stat.h>. The include
> hierarchy for <sys/stat.h> with libc6 v2.27 looks as follows:
>
> . /usr/include/x86_64-linux-gnu/sys/stat.h
> .. /usr/include/x86_64-linux-gnu/bits/stat.h
> . /usr/include/fcntl.h
>
> To avoid being dependent on the inclusion of <linux/types.h> at some
> other place it looks reasonable to include it explicitly to bring all
> the necessary declarations before their usage.
I would agree - include what you use. The u32 type is defined in
linux/types.h, relying on indirect includes seems fragile (and in this
case, does seem to break folks).
>
> What do you think?

