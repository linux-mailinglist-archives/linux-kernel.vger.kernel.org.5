Return-Path: <linux-kernel+bounces-69064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F269858402
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EFE2B20D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D7113174B;
	Fri, 16 Feb 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DmQvSnrJ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC312FB1E;
	Fri, 16 Feb 2024 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104107; cv=none; b=jgfEy9Eg+R/eQ39IOK6ll2Gu/Y8n3uwiPqEXYH1pDRA+g19OtLJvcsG7TaBwZMZ5wamL6SavRkRKJHl8XVJF10b9oqVFZeaKmlu3/5BMLi0uQRj0HiUwQwt0EjKBNkrtcog0udTGGp2RiUtPMGJ+iXuIEop12nc+DOClRcZKP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104107; c=relaxed/simple;
	bh=oZeRHJftRcXIPRMRWgsAE5DzyVWjn7Rzy5pxYXTYzMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BD+Rvjlowg7ZT4ebTUfgqfmB0YhnNkvZt1McXn2XfUIhpo1DFUtSnCTd2K8bKuVLC5zrHobKGz1clKlJMdmITwds4SHajz3ogoOh3amXQifSmY1xIeRpO6bVUx6tCtnNAww3MyhreGHXPCC0VL9VJ9U34o5yK4aSCLwX+eBPvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DmQvSnrJ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8EB8F45ACA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1708104104; bh=aNfLYadEKHx+SL9kFO60R4a0MD3kWy7oxdB7GLLKR10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DmQvSnrJh8pC98E3y/Az0E7/FIQcF6lBhH6H9RYJ72Sw7vMfJz4qZf55MPy7kIieK
	 +2969T7Uui5YWx298SOTzUX7shUTNA6c+J6E3IDoNS+P/oGTxqm4VhpH44hOzNSZWF
	 2pwnu3URWk4Su2Oc3l0ydhl8fcwJRIao58D146eCXU+9BxRLXTOa0FRcaNJ3Rvo/8q
	 54RhOFOjwR9bbDmm7Bk3z3mbWAKnDi/yGGkpAFkeLmmIwz0cwdD25597Jw0bHDZgbK
	 Q2EExcyrAStd/8D6a0FF1fDYVJLKxqXzKayZ9q9CxRtHSG+dXXDDvZ0gk2gvJd5+9h
	 fid9Y+jTaJdhg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8EB8F45ACA;
	Fri, 16 Feb 2024 17:21:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>, Dave Hansen
 <dave.hansen@intel.com>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "maintainer:X86
 ARCHITECTURE (32-BIT AND
 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Kees Cook <keescook@chromium.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Pengfei Xu
 <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao
 <zegao2021@gmail.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Brian Gerst <brgerst@gmail.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, David Howells
 <dhowells@redhat.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [RFC 0/8] PGP key parser using SandBox Mode
In-Reply-To: <20240216170805.0d0decd5@meshulam.tesarici.cz>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
 <20240216152435.1575-1-petrtesarik@huaweicloud.com>
 <c65eb8f1-2903-4043-a3ab-945d880043b5@intel.com>
 <20240216170805.0d0decd5@meshulam.tesarici.cz>
Date: Fri, 16 Feb 2024 10:21:43 -0700
Message-ID: <87y1bktjdk.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> writes:

> On Fri, 16 Feb 2024 07:38:30 -0800
> Dave Hansen <dave.hansen@intel.com> wrote:
>> I'm confused by this.  The kernel doesn't (appear to) have a PGP parser
>> today.  So are you saying that it *should* have one and it's only
>> feasible if its confined in a sandbox?
>
> I'm sorry if this is confusing. Yes, your understanding is correct.
> This patch series demonstrates that SBM (even in the initial version
> that was submitted) allows to write a PGP parser which can survive
> memory safety bugs withoug compromising the rest of the kernel.

So I have a different question: some years ago we added the "usermode
blob" feature for just this kind of use case - parsing firewall rules at
the time.  It has never been used for that, but it's still there in
kernel/usermode_driver.c.  Is there a reason why this existing
functionality can't be used for tasks like PGP parsing as well?

Thanks,

jon

