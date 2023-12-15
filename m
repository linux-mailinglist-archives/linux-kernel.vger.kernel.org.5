Return-Path: <linux-kernel+bounces-1348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 653DF814DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22ED0286061
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40BB3EA89;
	Fri, 15 Dec 2023 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8njkoym"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75E3EA7C;
	Fri, 15 Dec 2023 17:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F145C433CD;
	Fri, 15 Dec 2023 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702659787;
	bh=ajf26pir6fXq20CplEJMXiFdwNUfaixnT+N6tmJkitw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L8njkoymU68soJsWcs0umSxZd8F8wVyIF44uHMIBxOUEUo+UUCwo1z/U3p8h6/qpT
	 iWOoXvXUFpvE5U1nHRzhQbI2bkfGtV5dlI/Dt8Ttjfux6T89RMq7d8V8KnwcEmDNji
	 9qgWjUMt66f7hG7gDCHcITJviZGhQGH4EA81fRAKr36LI05zmHDtxf38QwzXYR4LMv
	 jkNKcwv/UeCUA0w/5TGM7DQq5KQhs0SqABI23rpk7I7HO9TjzQR93MYs5oKMSsf5rr
	 uHT1rm6al/+LEQ1/poUMJEBzZHHaOBMRJ9mgSWFhw/XTUuJSHqyUHprkSeo/0zVIrw
	 RkPycjKtarHqQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-20379a7a926so208503fac.3;
        Fri, 15 Dec 2023 09:03:07 -0800 (PST)
X-Gm-Message-State: AOJu0Yw2rGtP9N4ALA+4D8XcCXL7KoZZiltkoXvQWZ2Wv0E8io4/Wgnm
	aIPGfAewA9m0elOYyT8i1ML3xMQ/S97L/YUKBSc=
X-Google-Smtp-Source: AGHT+IFSdu/F7vwdNFiRRFkJzwflbFSMH3nCh+pN8oX/a2dGXQaDLR/33PZz2VqwQ/n7qpPj+780mMDcb6GA1hrvNng=
X-Received: by 2002:a05:6870:7a2:b0:1fa:2620:6c4e with SMTP id
 en34-20020a05687007a200b001fa26206c4emr8111187oab.4.1702659786858; Fri, 15
 Dec 2023 09:03:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208181802.88528-3-leobras@redhat.com> <ZXgMa57Ere6FJCJB@infradead.org>
 <CAK7LNAQiJW0eFYQZN0wuURhrdc-8y7=TcEazpxhLf=+mRbKHHQ@mail.gmail.com>
 <ZXhbUmxzH6nWAzaw@infradead.org> <ZXiT1zyADQVXOEqw@LeoBras>
In-Reply-To: <ZXiT1zyADQVXOEqw@LeoBras>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 16 Dec 2023 02:02:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARhah+P+wESAYxVUzRkD81EacR_J+muDcP7HLZpCRkd8g@mail.gmail.com>
Message-ID: <CAK7LNARhah+P+wESAYxVUzRkD81EacR_J+muDcP7HLZpCRkd8g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/1] scripts: Introduce a default git.orderFile
To: Leonardo Bras <leobras@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 2:10=E2=80=AFAM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Tue, Dec 12, 2023 at 05:08:34AM -0800, Christoph Hellwig wrote:
> > On Tue, Dec 12, 2023 at 05:09:21PM +0900, Masahiro Yamada wrote:
> > > Unlike .gitignore, this feature is opt-in rather than enforced.
> > >
> > > To use this, you need to run
> > >
> > > 'git config diff.orderFile scripts/git.orderFile'
> > >
> > > or
> > >
> > > 'git diff -C scripts/git.orderFile'
> >
> > Oh, ok.  That greatly reduces my concern.
>
> Yes, it's an opt-in, so no user should be directly impacted.


Applied to linux-kbuild.
Thanks.








> >
> > >
> > > Indeed, the file order is subjective, leaving
> > > us a question "do we need it in upstream"?
>
> The main idea is patch generation.
> This file's order is supposed to be the best order for reading a raw patc=
h
> and understanding the code changes.
>
> > >
> > > At least, it is harmless for people who have no interest.
> >
> > .. but this is still a good question.  I'm not really sure there is
> > much of a need for it, but as long as it doesn't harm everyone else
> > I'm at least neutral on it.
>
> diff.orderfile was introduced in git to help order the git diff, and thus
> the patch generation, in a way that it's easier to understand what the
> commit / patch intends on doing.
>
> Take this example introducing a feature foo, you should see:
> - Documentation on foo, if introduced
> - How is foo enabled in build system, if needed
> - The types / stucts / fields introduced by foo, if any
> - The interface for using foo, if any
> - The actual foo implementation.
>
> Of course the actual order is open to discussion, and I encourage everyon=
e
> to suggest any other items or order.
>
> Thanks!
> Leo
>
>


--=20
Best Regards
Masahiro Yamada

