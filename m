Return-Path: <linux-kernel+bounces-9982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760D81CE1E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB49CB210B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35582C194;
	Fri, 22 Dec 2023 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr2eYg5X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3730F28E0A;
	Fri, 22 Dec 2023 17:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A71C433B6;
	Fri, 22 Dec 2023 17:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703267492;
	bh=XYkTLXz5sCIMHIvk5gdWCMmheYIQY9KRL0JQbfxvslI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nr2eYg5XhFfecvofEEo9kZFq7DfnsBe+/6hFphrLrcFbiu7c7WohO4GUR/jhpV7Ts
	 Xs5eaKFHowaj6xgl+jE5q0jx0z/HNIQ1nct/VWhFEWzCDDp6Bm400mZA6T2psQRlOM
	 Zf/WwftRTXv+6CRkT0KjsGSFsB89ORKE6xcGE9MEKiHj3ICkyds4QP3TVOt4PUQG3R
	 nvZNHkj6BMBJKbx4RNR6UR5pVfiXQA/B+DL7UJgH3ngfbUW4p1AB5h4zzuPLDkbx6U
	 T61IC0JFKzF6b2WWUY33j6Oj/lU04ASLBu/XPn32PgQ8gnxQpekD+3SEfx+z4+zdID
	 0wDD5qg/jSHFw==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dbbef36fe0so827781a34.2;
        Fri, 22 Dec 2023 09:51:32 -0800 (PST)
X-Gm-Message-State: AOJu0YyaErOZanNI8PuuWe5WHBhJXv3vpjBukLu70xnVNGZ3H0Oj+PfP
	TjcWC6tFYx1vD5WSfqUCBkLnVkqpDGUaASO/RJA=
X-Google-Smtp-Source: AGHT+IEdTqRIJ7Gv05JO4Bo5uaKKyusxndbX6ra2AjsNcR1TKiHk5jtMvR8vQ+0RXHbnQwbv3GodgDg+2HqbVSvskA0=
X-Received: by 2002:a05:6870:b4a0:b0:204:5a14:c4c6 with SMTP id
 y32-20020a056870b4a000b002045a14c4c6mr340753oap.50.1703267491808; Fri, 22 Dec
 2023 09:51:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212020259.2451253-1-quic_johmoo@quicinc.com> <20231212020259.2451253-2-quic_johmoo@quicinc.com>
In-Reply-To: <20231212020259.2451253-2-quic_johmoo@quicinc.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 23 Dec 2023 02:50:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNASZzeJzZV0hiMrcKd6FUtQXqfuvUqux8Bf+WvBmjCwNCA@mail.gmail.com>
Message-ID: <CAK7LNASZzeJzZV0hiMrcKd6FUtQXqfuvUqux8Bf+WvBmjCwNCA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] check-uapi: Introduce check-uapi.sh
To: John Moon <quic_johmoo@quicinc.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, kernel@quicinc.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	"Carlos O'Donell" <carlos@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Todd Kjos <tkjos@google.com>, 
	Matthias Maennich <maennich@google.com>, Giuliano Procida <gprocida@google.com>, kernel-team@android.com, 
	libabigail@sourceware.org, Dodji Seketeli <dodji@redhat.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Jordan Crouse <jorcrous@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:04=E2=80=AFAM John Moon <quic_johmoo@quicinc.com=
> wrote:
>
> While the kernel community has been good at maintaining backwards
> compatibility with kernel UAPIs, it would be helpful to have a tool
> to check if a commit introduces changes that break backwards
> compatibility.
>
> To that end, introduce check-uapi.sh: a simple shell script that
> checks for changes to UAPI headers using libabigail.
>
> libabigail is "a framework which aims at helping developers and
> software distributors to spot some ABI-related issues like interface
> incompatibility in ELF shared libraries by performing a static
> analysis of the ELF binaries at hand."
>
> The script uses one of libabigail's tools, "abidiff", to compile the
> changed header before and after the commit to detect any changes.
>
> abidiff "compares the ABI of two shared libraries in ELF format. It
> emits a meaningful report describing the differences between the two
> ABIs."
>
> The script also includes the ability to check the compatibility of
> all UAPI headers across commits. This allows developers to inspect
> the stability of the UAPIs over time.
>
> Signed-off-by: John Moon <quic_johmoo@quicinc.com>
> ---
>     - Applied minor code style suggestions from v6 review.




The code looks OK. I think it should work as designed.

Line 197 is inconsistently indented by spaces instead of a space,
but I can fix it up locally.


I just thought requiring target commits as positional parameters
("check-uapi.sh treeA treeB" just like "git diff treeA treeB")
might be intuitive, but I guess everything is specified
by a short option is a design. I can live with that.



I will wait a few days, and if there is nothing more,
I will pick up 1/3 and 2/3.




--=20
Best Regards
Masahiro Yamada

