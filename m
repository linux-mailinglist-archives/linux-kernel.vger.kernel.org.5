Return-Path: <linux-kernel+bounces-108152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F018806B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF2F282B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4483FB9F;
	Tue, 19 Mar 2024 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETLrkllJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4E3FBAF;
	Tue, 19 Mar 2024 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883660; cv=none; b=YwdcXAbA5dy/F64weP0uF2onX+rbaJIsjbV2sC5Z9hLC34TeYmipQcvdHs8knadkKj1TzyoDVrwXC6CWlzVGZirg0WZ2wC4rm/zJHKm4Ouze4okonsSoa4Ip1vnKy34jh18xvazPhIT8weFoS2IA4E3puvoV3nVJXoRoNpRnlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883660; c=relaxed/simple;
	bh=J4v9ZApewR4KTKdeCzuYPBqN731W4qTgXU6ViPQQrRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGPW82fDMmH7/uRfbb+b6uZky5Du/atP7QmWMseVqqFsv5yGITohqlIeQRGZI50bIEc7HyZhkh9kxo7NdYME21VginBEtQIkqLLGnn4XQ2iZQ0JO8iCfmNtp/ZlBJO8oiWcLtVMsSsSoKd4KqpIXqwII8W8AmtM0SEmqDOHAeCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETLrkllJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4590C433F1;
	Tue, 19 Mar 2024 21:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710883659;
	bh=J4v9ZApewR4KTKdeCzuYPBqN731W4qTgXU6ViPQQrRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETLrkllJMkEObpmvmNGtcL88GJEHAhQlDubQhs7HJdxnlzDAViZ17evutL6QGKaxW
	 gbUUREPTX890MeUpaOrRTI73rs1I31whS9cfqon3hOZvrWRSaRjXFjKimTKB5hOc/p
	 HA6ZdYEQ0n1iyglYWc3btbyzCAARo4uMvQKLAvmkL0PMJneZV/yM8QDCMAAxItlMoT
	 dpAazCExgxV18UUOFrw6mT9wkYrvZvNSFVmF9MlrcRj6hIRZ1FcJqTylxEe/adyPrC
	 IZ9jzg3602EuqluGYbjvuMpz2hqnmRiFZip95Na1sDdGJUjAjhyGb96KuUsIzAbSmb
	 tBeuvsClUzpkg==
Date: Tue, 19 Mar 2024 14:27:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Huang Yiwei <quic_hyiwei@quicinc.com>,
	John Garry <john.g.garry@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	linke li <lilinke99@qq.com>, llvm@lists.linux.dev
Subject: Re: [GIT PULL v2] tracing: Updates for v6.9
Message-ID: <20240319212737.GA2894766@dev-arch.thelio-3990X>
References: <20240318113053.7f87ce7f@gandalf.local.home>
 <CAHk-=wjxX16kWd=uxG5wzqt=aXoYDf1BgWOKk+qVmAO0zh7sjA@mail.gmail.com>
 <20240319130653.0cfdaf6e@gandalf.local.home>
 <20240319131333.504c93fc@gandalf.local.home>
 <20240319210329.GA742040@dev-arch.thelio-3990X>
 <CAHk-=wjJH_k5+h=3TOvLsGN-FOBNfLh_Ln_bZRLQV-oe9Gc5tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjJH_k5+h=3TOvLsGN-FOBNfLh_Ln_bZRLQV-oe9Gc5tw@mail.gmail.com>

On Tue, Mar 19, 2024 at 02:22:27PM -0700, Linus Torvalds wrote:
> On Tue, 19 Mar 2024 at 14:03, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > For what it's worth, I applied that change and built ARCH=x86_64
> > defconfig with LLVM 18.1.1 from [1] but it does not appear to help the
> > instances of -Wstring-compare; in fact, it adds some additional warnings
> > that I have not seen before. I have attached the full build log.
> 
> Hmm. I'm no longer seeing any problems with commit 24f5bb9f24ad
> ("tracing: Just use strcmp() for testing __string() and __assign_str()
> match").
> 
> But that's clang 17.0.6.
> 
> The patch that Steven sent out (and that I applied) is a bit different
> from his "I'll change it to this" email, though. A couple of casts and
> parentheses different.
> 
> So maybe current -git works for you?

Ah, I did not notice your tree was updated, I was working off of
b3603fcb79b1. Works for me here, thanks for letting me know.

Cheers,
Nathan

