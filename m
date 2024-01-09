Return-Path: <linux-kernel+bounces-21304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD1828D52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9153F28687C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B9B3D397;
	Tue,  9 Jan 2024 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ8+UsGX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5F3D386
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0D7C433C7;
	Tue,  9 Jan 2024 19:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704828290;
	bh=/e9LxDb1CBh13mkApPvc0HzMekgrbaSLhIJ+IzmwCr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJ8+UsGXQ6cna6NfLoEciCG+JmeOweL+lgMYkfYYfscf31yDcwY1Rz0scgfortsVU
	 aPsoCqOcNJULN+cjtkofcqwZUsRGCkRo2FLKrX1EXNEm6O+eQ+D6J/lwegVW3AycV7
	 4rvUthtxd0zFZNwsfguIRIJ84MR/tuX0IAiaiA85v/soaoT9naKeGqld84XJF+NDRK
	 I/GvJkDfrxQV9KnpthMcqEObXARl8OVMMA08H9FSAmEx0qmCII+Ic3XQK8M0X6kiwY
	 aRhbAj0OgbXGRyCD2sQcZmOCC/eMieATf8sfhH2rDVT7XnSHU60Muh0HTZtkOPidwq
	 3h6ewk2OvlbHQ==
Date: Tue, 9 Jan 2024 11:24:47 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
	peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] objtool: Make objtool check actually fatal upon
 fatal errors
Message-ID: <20240109192447.yhl37mwaw5jdkxjs@treble>
References: <20231213134303.2302285-1-dimitri.ledkov@canonical.com>
 <20231213134303.2302285-2-dimitri.ledkov@canonical.com>
 <ZZu9Nvkp3PdSeLHQ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZu9Nvkp3PdSeLHQ@gmail.com>

On Mon, Jan 08, 2024 at 10:15:34AM +0100, Ingo Molnar wrote:
> 
> * Dimitri John Ledkov <dimitri.ledkov@canonical.com> wrote:
> 
> > Currently function calls within check() are sensitive to fatal errors
> > (negative return codes) and abort execution prematurely. However, in
> > all such cases the check() function still returns 0, and thus
> > resulting in a successful kernel build.
> > 
> > The only correct code paths were the ones that escpae the control flow
> > with `return ret`.
> > 
> > Make the check() function return `ret` status code, and make all
> > negative return codes goto that instruction. This makes fatal errors
> > (not warnings) from various function calls actually fail the
> > build. E.g. if create_retpoline_sites_sections() fails to create elf
> > section pair retpoline_sites the tool now exits with an error code.
> > 
> > Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> 
> So, is this not expected to be the case anymore:
> 
> >  out:
> > -	/*
> > -	 *  For now, don't fail the kernel build on fatal warnings.  These
> > -	 *  errors are still fairly common due to the growing matrix of
> > -	 *  supported toolchains and their recent pace of change.
> > -	 */
> > -	return 0;
> 
> ?
> 
> How about making it only fatal if CONFIG_WERROR=y, ie. an analogue to our 
> treatment of compiler warnings?

Objtool has two classes of warnings:

1) "fatal"

   - allocation failures
   - CFG recreation failures
   - annotation parsing errors
   - other objtool bugs

2) non-"fatal":

  - missing security features (retpolines, IBT, SLS INT3)
  - unreachable instructions (note this warning may indicate more
    serious issues like an incomplete or buggy objtool CFG)

The first class of "warning" is actually an error.  It means objtool
couldn't reasonably continue, so it exited early.  I'm thinking this
should always fail the build so it can be reported and fixed ASAP.

We tried doing that before, but ending up reverting it (for raisins).
We should try again (as per the above patch).

The second class of warning, though it doesn't abort objtool, can still
be quite serious.  Ignoring it can fail the boot, or can expose the user
to certain attacks.

My proposal would be to always fail for #1, and to make #2 dependent on
CONFIG_WERROR.

Note the latter may be problematic at the moment due to some outstanding
warnings reported by Arnd and randconfig build bots.  I try to fix those
when I can, but any help would be appreciated.

-- 
Josh

