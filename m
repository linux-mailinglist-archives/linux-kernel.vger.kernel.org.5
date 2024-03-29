Return-Path: <linux-kernel+bounces-125496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3087289276C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DCB1C209F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC81913E3F3;
	Fri, 29 Mar 2024 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="xH2DVphr"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889913E03C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753332; cv=none; b=B3LOCr+wLYrabsu3GHzr7KsAGIGkalDqwB2bTOlzaP9poXrZdFzv+u6eJI41CLYiDbd8E6Cr2lBIolx+MLbXVTD9GcaO6WktrrM0iapKrIGD0BnhyLf2MjpQiuk3e/G9XyveHi00cEAr8+afWzk7YmoHzrMxDgay/WbpkfSKOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753332; c=relaxed/simple;
	bh=LOlGtRD+I7SxnGyG4Qt3HDXxX82VHSKBErkCCIDULUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I79VwkvHiWCqRsyuy+cBb0GCBUz9b1hMfg2aU/WHElcq4rXrkn7pRr18WaYecWgHNcr7Qf8Uc7zySWPZk5uPPzrQdSyTaT/cLX6wtDLF6x7+tQdmGhQmdOCqDclDN9AR33TDcu1+UIY4iPd1rTGjm60Naqq6jp/4dI+PjIoWG9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xH2DVphr; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6145a4c79cfso6834547b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711753329; x=1712358129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Igo4IUryPSmylrRgjB3Hg+wV547xWuDnOMCE0dxBkog=;
        b=xH2DVphr1RMNlDIJ9mBeQGwyWsjq38aan7YKMGLjdGZmWLib+NUcXRhdWCuWcI5HNT
         ZGSu6qeN3z19TBtIG88HLzizhGEGS4PxQ51+JLM/YwwJXGouZnJyJuq4lvq7Z2MG5skq
         8PNjSfd64nLcFrrkoBdfFtXVMbGfTOwTKfe1LnHOlqZAbzh6Nr8FvBS7hA6sAQi+D9l6
         X7ypNHm6mByX1xw7L5Yp99s8BA02l8eXliPXtVq11Z9TReDOWJonEJ6yAlUJlnTj1aGq
         blbeUtROK2MV+hjJcQG6j7j5wjUqaC8iT8Fhdelvjs+2+cDwIzJaol8pS+VCnvtRqU8C
         ifcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711753329; x=1712358129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Igo4IUryPSmylrRgjB3Hg+wV547xWuDnOMCE0dxBkog=;
        b=UFAYY8fbMCvtV8egJN/2k1V2g6D7W3U1IwywSEegyLEZ1cG03+xco/4cvu1vel8uPu
         JsXtk2X9c/G+8tn+R+HypWSIL4rSM3YN+nmsLVIC7Ho/+o5SQ98YyM2FyUkCmREchSY2
         6XhhAZqFEL/RtjuWSGnLlIlm9kBc2ThmeQKl9O/qjYWAWh9auVhqrl6Huhava7KGUbvH
         GswaYTnwPXX1h5I3xwmHU3v+yPgffr9afMV38uhn+AEGe6DkUZFcZEkO/e6Y9C6f4tb/
         5Pq458KtuQ6IGjngat7KDzj2oe2vwAku5z1aBsyCzJiPHlaUb0rGYyWVicQS7IV7U/ZS
         pF4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfjzS8AcmMVPSQV9L0Xw8+DWmjo1BA3yESC/TgdN86evN432lUMuuVnUqKh8fNJSqAxAbWdMsQAFMqvh/FimuhYYAxiML5PIfrZu+x
X-Gm-Message-State: AOJu0YxRW6ODMAdg0Y+7SdATD8lKRJ5z3s5DG3TCI0CtYKO/grs6oh1H
	edCzni9xaRwoQqgUCgE3FV7qL3EpZXqcTOE8SOJBHWy6uX4OB50hon/Z8ejD7dGYZweSuvgWxEn
	yISqMbEj5Gh0HyE1APTOU3+ZElxqWmkUWKRgr
X-Google-Smtp-Source: AGHT+IEMWCPE7scOrb6eChbQBr0BQCWxKMukJUVs0Rndtpuxp6EowEceQGuHZdmJhEbFeclclOJgjloq4Q7FYUj0s8k=
X-Received: by 2002:a25:8b88:0:b0:dc7:140:8c0c with SMTP id
 j8-20020a258b88000000b00dc701408c0cmr3746406ybl.23.1711753329011; Fri, 29 Mar
 2024 16:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325123603.1bdd6588@canb.auug.org.au> <CAJuCfpH4Ee00hM9+B7=mi5Dwjrhov8vUK-KwPuoO3wsD7iJSAQ@mail.gmail.com>
 <5e1321ca-0d46-4e9d-a6e5-0560d99f65ff@infradead.org> <CAJuCfpFTOz8cNiJFiCU5tMM1u5L=wXRsXqxUhN9g-R0u77CyZw@mail.gmail.com>
 <20240328153947.3871cfdf@canb.auug.org.au> <20240328154427.3e926d21@canb.auug.org.au>
 <CAJuCfpHZGkL9urkZaVmO_o0ujpr-moDGYiBES1iRy2dh8g-t8w@mail.gmail.com> <20240330094919.61e7c7b8@canb.auug.org.au>
In-Reply-To: <20240330094919.61e7c7b8@canb.auug.org.au>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 29 Mar 2024 16:01:56 -0700
Message-ID: <CAJuCfpHVSn-wAogkYxuLTewFXKNpVwfDGAqshe1Ff5b7BNteqg@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Randy Dunlap <rdunlap@infradead.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 3:49=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi Suren,
>
> On Wed, 27 Mar 2024 22:35:56 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
> >
> > https://lore.kernel.org/all/20240327044649.9199-1-rdunlap@infradead.org=
/
> > which seems to not yet been pulled into mm-unstable should fix the
> > following warnings:
> >
> > include/linux/slab.h:730: warning: Function parameter or struct member
> > '_n' not described in 'kcalloc'
> > include/linux/slab.h:730: warning: Function parameter or struct member
> > '_size' not described in 'kcalloc'
> > include/linux/slab.h:730: warning: Function parameter or struct member
> > '_flags' not described in 'kcalloc'
> > include/linux/slab.h:730: warning: Excess function parameter 'n'
> > description in 'kcalloc'
> > include/linux/slab.h:730: warning: Excess function parameter 'size'
> > description in 'kcalloc'
> > include/linux/slab.h:730: warning: Excess function parameter 'flags'
> > description in 'kcalloc'
> >
> > And https://lore.kernel.org/all/20240326054149.2121-1-rdunlap@infradead=
org/
> > should handle the _noprof warnings. I can see this patch in
> > mm-unstable and running "make htmldocs" in mm-unstable does not show
> > the _noprof warnings anymore. Please let me know if I should try some
> > other command to reproduce these.
>
> Those patches entered the mm tree after I had merge it on Thursday.  It
> should all be good on Tuesday.

Perfect. I'll ignore similar reports with _noprof prototype warnings until =
then.
Thank you!

>
> --
> Cheers,
> Stephen Rothwell

