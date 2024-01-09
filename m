Return-Path: <linux-kernel+bounces-21387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86647828E77
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B191F2503F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F89F3D971;
	Tue,  9 Jan 2024 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkZxrLZg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C03D57E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 20:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC59C433F1;
	Tue,  9 Jan 2024 20:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704831655;
	bh=zNLo/Y/idoJX6WUQvS4qPeFbgVPUY8X1rT89iLSFhHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkZxrLZgnzdnsSNTzd4/bzsLG8aiSqaESKbZ6hAAnpUxnuv6q9+InSxGodrA4Ff/C
	 5h027+nOJ12dFxz62qJvvoyD4kjaILl/8EFjgkjVqJMJMhAGseY199ucn/MliBlXUf
	 DGluldcamMNIxaAxGgxLkcM5LAuXOyHiuV/QjumOd7GPfkJzPHZHnEQF0xYwv+tMbm
	 jOvq7J/lBmJaBSfqJO8XdCKye0bGYPsCEnCUcRLZYJ8RF97XGSieU+4+bx2tFjle9X
	 L1FfiSvOtTpJYnzLkqbleSZomShGQcRTtHkLGAqP1lKr5lAk1b78AXE27ntRgJa502
	 odgkfWbZBMM3g==
Date: Tue, 9 Jan 2024 12:20:53 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: Ingo Molnar <mingo@kernel.org>, peterz@infradead.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] objtool: Make objtool check actually fatal upon
 fatal errors
Message-ID: <20240109202053.ee26nc5kk5u5edrc@treble>
References: <20231213134303.2302285-1-dimitri.ledkov@canonical.com>
 <20231213134303.2302285-2-dimitri.ledkov@canonical.com>
 <ZZu9Nvkp3PdSeLHQ@gmail.com>
 <20240109192447.yhl37mwaw5jdkxjs@treble>
 <CADWks+YO7zdFoYfLn+qwD8FyZoU1EfYCq1sghFkrn-nXANYMhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADWks+YO7zdFoYfLn+qwD8FyZoU1EfYCq1sghFkrn-nXANYMhw@mail.gmail.com>

On Tue, Jan 09, 2024 at 07:48:30PM +0000, Dimitri John Ledkov wrote:
> > Note the latter may be problematic at the moment due to some outstanding
> > warnings reported by Arnd and randconfig build bots.  I try to fix those
> > when I can, but any help would be appreciated.
> 
> I guess we can override CONFIG_WERROR during dkms compilations, but
> then i still want to ensofrce OBJTOOL errors.
> 
> How abou introducing CONFIG_WERROR_OBJTOOL and make CONFIG_WERROR
> select CONFIG_WERROR_OBJTOOL? such that distributions can start to opt
> into CONFIG_WERROR_OBJTOOL for production builds, even if they cannot
> yet make the jump to CONFIG_WERROR?

Seems reasonable.

Though, keep in mind that even compiler warnings can cause boot failures
and security bugs.  So I wouldn't recommend sleeping at night unless
your distro also has CONFIG_WERROR=y.

-- 
Josh

