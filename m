Return-Path: <linux-kernel+bounces-1226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74B814C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF81D1C21288
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC81381B2;
	Fri, 15 Dec 2023 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FduCbGYA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0FD36AF3;
	Fri, 15 Dec 2023 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 67DD146A;
	Fri, 15 Dec 2023 15:36:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 67DD146A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702654567; bh=0z7tbYu86nQ9SX1OTqU2DL4AXEXhHB+guJ/OzNfBsgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FduCbGYAwm9ZD8xBLalG4d6x8noYSA2T+QJHE4CzhwmF+Qp0vbp3IOeqom0tkJYiQ
	 kEfm9kCetJM8xfZc5aGSkCTRWGMlJdNTgqcY6ARsS6Xg4AVV9+7bczTwjLq2PE4XUs
	 nfww1DGPd0LWG3+0V2rqRYtaacVxdLIRk8G6CHfKCbx8FpRgdjtttmY8rOcKXOKC2L
	 Tjgz8FQDKJVu5fhU/3OXRfo5AsXHtk5CGw6E+kZzofg8hvgJ0K3YTQNSybis+K/tc/
	 fYuS6HF+8eSmeN/hjmqeB82tPbUoZWU4Sh93SiQz0YjKBPhNFSm00jS+3nObPmyDJ3
	 QIW7lyc3F9ndw==
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v2] docs: Raise the minimum Sphinx requirement to 2.4.4
In-Reply-To: <50830030-dca7-4c43-bcc8-449c7cfa9fbb@gmail.com>
References: <874jgs47fq.fsf@meer.lwn.net>
 <50830030-dca7-4c43-bcc8-449c7cfa9fbb@gmail.com>
Date: Fri, 15 Dec 2023 08:36:06 -0700
Message-ID: <87sf43qxzt.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

> With this patch applied, I get a confusing looking warning from
> "make htmldocs" on a machine where the Sphinx version is 2.4.5:
>
> --------
> Warning: It is recommended at least Sphinx version 3.4.3.
> To upgrade Sphinx, use:
>
> 	/home/akira/sphinx-2.4.5/bin/python3 -m venv sphinx_2.4.4
> 	. sphinx_2.4.4/bin/activate
> 	pip install -r ./Documentation/sphinx/requirements.txt
>
>     If you want to exit the virtualenv, you can use:
> 	deactivate
> --------
>
> Looks like we need to update requirements.txt as well so that it
> installs Sphinx 3.4.3.  Appended below is a fixup patch to that
> effect.

So I can apply this, certainly, but it makes me feel like perhaps we
need to reconsider our approach a bit.  It's kind of weird that we have
a minimum supported version, then a semi-random "recommended" version
that is still pretty old.

Is there a reason to suggest to people that they should run something
other than current sphinx, especially if they are updating it anyway?
So our "recommended version" is really "recommended *minimum* version"? 


> ----8<----
> From: Akira Yokosawa <akiyks@gmail.com>
> Subject: [PATCH] docs: sphinx/requirement.txt: Reflect recommended Sphinx version
>
> sphinx_pre_install parses the version of Sphinx in requirements.txt
> and emits messages based on it.
> Update requirements.txt so that it installs Sphinx 3.4.3, as well as
> the examples in documentation.
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
>  Documentation/doc-guide/sphinx.rst    | 14 +++++++-------
>  Documentation/sphinx/requirements.txt |  4 +++-
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index 3d125fb4139d..5227a2611026 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -48,13 +48,13 @@ or ``virtualenv``, depending on how your distribution packaged Python 3.
>        on the Sphinx version, it should be installed separately,
>        with ``pip install sphinx_rtd_theme``.
>  
> -In summary, if you want to install Sphinx version 2.4.4, you should do::
> +In summary, if you want to install Sphinx version 3.4.3, you should do::
>  
> -       $ virtualenv sphinx_2.4.4
> -       $ . sphinx_2.4.4/bin/activate
> -       (sphinx_2.4.4) $ pip install -r Documentation/sphinx/requirements.txt
> +       $ virtualenv sphinx_3.4.3
> +       $ . sphinx_3.4.3/bin/activate
> +       (sphinx_3.4.3) $ pip install -r Documentation/sphinx/requirements.txt

Here we could take version numbers out entirely; otherwise we'll always
be updating this.

> -After running ``. sphinx_2.4.4/bin/activate``, the prompt will change,
> +After running ``. sphinx_3.4.3/bin/activate``, the prompt will change,
>  in order to indicate that you're using the new environment. If you
>  open a new shell, you need to rerun this command to enter again at
>  the virtual environment before building the documentation.
> @@ -118,8 +118,8 @@ command line options for your distro::
>  	You should run:
>  
>  		sudo dnf install -y texlive-luatex85
> -		/usr/bin/virtualenv sphinx_2.4.4
> -		. sphinx_2.4.4/bin/activate
> +		/usr/bin/virtualenv sphinx_3.4.3
> +		. sphinx_3.4.3/bin/activate
>  		pip install -r Documentation/sphinx/requirements.txt
>  
>  	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
> diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
> index 335b53df35e2..89329e67e788 100644
> --- a/Documentation/sphinx/requirements.txt
> +++ b/Documentation/sphinx/requirements.txt
> @@ -1,3 +1,5 @@
>  # jinja2>=3.1 is not compatible with Sphinx<4.0
>  jinja2<3.1
> -Sphinx==2.4.4
> +# docutils>=0.18 is not compatible with 3.0 <= Sphinx < 4.0
> +docutils<0.18
> +Sphinx==3.4.3

I'd forgotten about the docutils fun.  I wonder of our recommended
minimum should actually be 4.0, then here we could put simply:

  Sphinx>4.0

?

Thanks,

jon

