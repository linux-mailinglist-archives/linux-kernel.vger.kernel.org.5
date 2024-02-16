Return-Path: <linux-kernel+bounces-68585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F272A857CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3D0B234F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4712883C;
	Fri, 16 Feb 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPrTM/h+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205CB2E641;
	Fri, 16 Feb 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708087079; cv=none; b=kGph4YGgJxQKSAvdYvDI2xoSF0hcPH7lGKGCbtXFO4xHc5eXUcJBRyA8RyMQHXsIdZ+kTrIsGLdafAkVbseT1MMV0Ax20KVcZV43eV7vFlM1ltdU4IJ1vhK1R5WFREgNKTB4/ClHIiSRAlMHS9GLpu4MRtUYE1RyNP/Jb/aRwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708087079; c=relaxed/simple;
	bh=z1sBY58BDg/3llEaa4HysrUIoaHtRN+Da+kU9maVq48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmlPG4RDObaPlet77EoU+Sw1ZQI4OAjm0FpFg0YFZMd8RbpUGvBBU6omrrpefNvyykHhcCeAelKXm/OCfGAMnpdUmEEaoRhJQbb2QqqYbPM9ELfXBiZn/Xdo+MUGxYoCz51+/HieSOxYEktoVEzC4EYkg2e1GXSWPmovuTW9V1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPrTM/h+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AACC433F1;
	Fri, 16 Feb 2024 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708087079;
	bh=z1sBY58BDg/3llEaa4HysrUIoaHtRN+Da+kU9maVq48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPrTM/h+yr8xHtfln0FuJIAOEyKLdIc8Pf6BJzUa7cQooTPgF0aJEFzC6XSjxVPlb
	 mHuQmcq0xfvHyR+XEEaYrxlfzssxTD7a/ZKH4l5E2+EHGe85jItdgc6JDGqzuifSCG
	 D8bcspXsoxuyXEK3qqs7/nIEe0i85QGO/T1bqDBp/58WujNP45Wi5/dD+xs0N2HGuR
	 pOTEqfa6kwSB3VUQfTxDcPw5IOAaNY3eQ7wGndWUEaXiulaZdWgoRqGNfjVDBNk9hf
	 Dq2zMJMXEsungzU2tUGcyzxRDD7WSVfSQcgmxQ7eS+vOsOZgcUm3UDEDVf0hZSLRp7
	 8X22tPYqaK9Cw==
Date: Fri, 16 Feb 2024 13:37:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Tycho Andersen <tycho@tycho.pizza>, 
	coverity-bot <keescook@chromium.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peng Zhang <zhangpeng.00@bytedance.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Mateusz Guzik <mjguzik@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Tycho Andersen <tandersen@netflix.com>, Mike Christie <michael.christie@oracle.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org, 
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: __do_sys_pidfd_send_signal(): UNINIT
Message-ID: <20240216-polster-stopfen-7fafe753180f@brauner>
References: <202402131559.B76A34B@keescook>
 <ZcwGua3a9Z8nJXVq@tycho.pizza>
 <20240214090332.GA14017@redhat.com>
 <20240214090640.GB14017@redhat.com>
 <ZczLyDCN+zG6imTd@tycho.pizza>
 <20240214175555.GC16265@redhat.com>
 <Zc0Ca5te+QFBZ1U6@tycho.pizza>
 <20240214191801.GA27799@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214191801.GA27799@redhat.com>

On Wed, Feb 14, 2024 at 08:18:01PM +0100, Oleg Nesterov wrote:
> On 02/14, Tycho Andersen wrote:
> >
> > On Wed, Feb 14, 2024 at 06:55:55PM +0100, Oleg Nesterov wrote:
> > >
> > > We want to check the "flags" argument at the start, we do not want to
> > > delay the "case 0:" check until we have f.file (so that we can check
> > > f.file->f_flags).
> >
> > Fair point. I was thinking delaying it would make it simpler, but then
> > you have to free the file and it's less fast in the EINVAL case.
> 
> plus we do not want to return, say, -EBADF if the "flags" argument is wrong.
> 
> > I also don't have a strong opinion here.
> 
> Neither me.

Or you know, we just don't care about this. ;)
In any case since tis is a false positive it's not urgent in any way. If
either of you cares enough about this then please just send me patch that
reorders the checks to please that tool. The specific way doesn't matter
to me as well as long as we don't pointlessly fdget()/fdput().

