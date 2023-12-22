Return-Path: <linux-kernel+bounces-9990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA10381CE34
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6800EB21852
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1C2C186;
	Fri, 22 Dec 2023 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtbQqxlU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F104D2C188;
	Fri, 22 Dec 2023 17:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858E1C433C8;
	Fri, 22 Dec 2023 17:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703267857;
	bh=m4PmBJoc2QgJBZKQaB/vYcP8WBPPEuhKuwezCH8Kcrw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rtbQqxlUpwiNlXB65dGhn+BSi0lyJ6K4d26pR5L7WRilWt9ADVrB5Jfv26QgNKACp
	 bOTJFDLgjG7+0frVS7XBHSETrNu6Q3tUJFtNdu2XAPOUVt0FgnnyiKk3f6ss7hxG62
	 yERCXVb6wWDY1El7z1Slpcd7bFXj4SFPquph1gi1y8G9k/4Zd6UfgffpLnhgSTCKdA
	 1BOxukP+hA7fw3TzfOgRPItsTCVwyh8F2muxPCLuUfzVscz5RXeDh7cbJ3txKZ5Vzi
	 82fS+Iz9dj1qs3eANeWJ5Vyi7oCTvFdj9DLewfGzuRLHZH6F8HcPy7NgijTdI7AJYl
	 My4u/m4P0jGBA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-203fed05a31so1357199fac.0;
        Fri, 22 Dec 2023 09:57:37 -0800 (PST)
X-Gm-Message-State: AOJu0YwbhghmYtnvsh1ncXBqOZLuWw4osEYhXWko7wYzuJ1N3qGPe2sB
	ZqoVjnT/9loDf8QQkzzms+Uym9Vt53sJY4QRnSw=
X-Google-Smtp-Source: AGHT+IE3vXI8QLgM4TOkSSY7LCRj8PTha6F6b0XPpJWv+vhSS5keg8e+tn9GSrBNWa9DXTATrIftUFm+PiAfqJtIisM=
X-Received: by 2002:a05:6871:a690:b0:1fa:1f3e:b8a7 with SMTP id
 wh16-20020a056871a69000b001fa1f3eb8a7mr1939357oab.20.1703267856913; Fri, 22
 Dec 2023 09:57:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212020259.2451253-1-quic_johmoo@quicinc.com>
 <20231212020259.2451253-4-quic_johmoo@quicinc.com> <ZXgOpRzNYGtiE35T@infradead.org>
 <93ee22bc-b357-4291-b3d9-07ff2cd6c87b@quicinc.com>
In-Reply-To: <93ee22bc-b357-4291-b3d9-07ff2cd6c87b@quicinc.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 23 Dec 2023 02:57:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQfzxiMoiLXvksUWtPiRhXQ7zypUzQpYER_7B=00XBr=A@mail.gmail.com>
Message-ID: <CAK7LNAQfzxiMoiLXvksUWtPiRhXQ7zypUzQpYER_7B=00XBr=A@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] check-module-params: Introduce check-module-params.sh
To: John Moon <quic_johmoo@quicinc.com>
Cc: Christoph Hellwig <hch@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	kernel@quicinc.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Todd Kjos <tkjos@google.com>, 
	Matthias Maennich <maennich@google.com>, Giuliano Procida <gprocida@google.com>, kernel-team@android.com, 
	libabigail@sourceware.org, Dodji Seketeli <dodji@redhat.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Jordan Crouse <jorcrous@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 1:58=E2=80=AFAM John Moon <quic_johmoo@quicinc.com>=
 wrote:
>
> On 12/11/2023 11:41 PM, Christoph Hellwig wrote:
> > On Mon, Dec 11, 2023 at 06:02:59PM -0800, John Moon wrote:
> >> One part of maintaining backwards compatibility with older
> >> userspace programs is avoiding changes to module parameters.
> >
> > Really?  I don't think module parameters are a UAPI in the traditional
> > sense.
>
> Agreed, they're not UAPI in the traditional sense. But, we're trying to
> establish tooling to help the community stabilize all interfaces that
> cross the kernel <-> userspace boundary and module params do fall into
> that bucket.
>
> > Now if you break a heavily used one you got to fix it, but
> > applying strict stability guarantees on module options which are not
> > availble to normal users or even normal programs doesn't make a whole
> > lot of sense.
> >
>
> True, but unfortunately we don't have any heuristic to determine if a
> param is "heavily used". However, in this rev, we added the ability to
> parse the permissions of a module param, so we could add a filter which
> does not flag change/removal of params with 0{0,4,6}000 permissions.
>
> It's also obviously fine if the community has no interest in the script.
> We just wanted to share it as we find it to be a useful supplement to
> our code reviews and thought maintainers may find it useful as well.
>
> Cheers,
> John


I am with Christoph.

This tool detects some changes and removals, but I think
the community intentionally changed them.

To merge this tool in the mainline,
I need more people who are interested in this.




--=20
Best Regards
Masahiro Yamada

