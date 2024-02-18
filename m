Return-Path: <linux-kernel+bounces-70477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B36885986F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073E0281A7D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18866F070;
	Sun, 18 Feb 2024 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wJrEdVch"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6B6BB4B;
	Sun, 18 Feb 2024 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708279652; cv=none; b=rYJCr2Y+Io+/qkz0ZWAcgdTaZFbUKJaZ9qPz4PWjnfmqci4+Glp4oLnnRicZC22vQVFK9IZNweetyZkNw0ChXbnCSx5wDLdG4b0PMGrrEd36kYJoZqKvu6uiCmaCCj6jGwFwumhisp3R7TJoeXGPpJKDVcassMd7QzUB7dE2hHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708279652; c=relaxed/simple;
	bh=jGgx3XYerwESqbJmwaEqnKiJ4QqQCMl076he249Ejj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hArrboev5lcfJrPnjkYqK6FGMYaa8R/ruog3UD8+OugpqDiVypBaWJJWHjvPmg3We/eEUj8QpKi40EIYvkV41PNBdzg38XNUd2gZ4ToIyjts+jcAyIFk5guAkGd4ItITMlr5UYu+5lQtn8Dv1hyoid/DIqxV0ncxdAfFnrthzok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wJrEdVch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DEAC433C7;
	Sun, 18 Feb 2024 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708279651;
	bh=jGgx3XYerwESqbJmwaEqnKiJ4QqQCMl076he249Ejj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wJrEdVchWg4yUsR32PNN2bpRzp9LgL20yw+8UIoPiNWhwaGiO4M7j13DKaReKsdBx
	 EzFBzLqtTENZkGrK35ymFSbKu5hiGOgIAuMR/l7YQuAlPQDLBT+YJmM4JAxuF06fJT
	 kVTtQWfKGpTUGx3zlEC++j4QX/fNbaYQWKu6sikE=
Date: Sun, 18 Feb 2024 19:07:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.pizza>,
	Guixiong Wei <guixiongwei@gmail.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leaking_addresses: Provide mechanism to scan binary files
Message-ID: <2024021819-sacrament-violator-428d@gregkh>
References: <20240218173809.work.286-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218173809.work.286-kees@kernel.org>

On Sun, Feb 18, 2024 at 09:38:12AM -0800, Kees Cook wrote:
> Introduce --kallsyms argument for scanning binary files for known symbol
> addresses. This would have found the exposure in /sys/kernel/notes:
> 
> $ scripts/leaking_addresses.pl --kallsyms=<(sudo cat /proc/kallsyms)
> /sys/kernel/notes: hypercall_page @ 156
> /sys/kernel/notes: xen_hypercall_set_trap_table @ 156
> /sys/kernel/notes: startup_xen @ 132
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: "Tobin C. Harding" <me@tobin.cc>
> Cc: Tycho Andersen <tycho@tycho.pizza>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Guixiong Wei <guixiongwei@gmail.com>
> Cc: linux-hardening@vger.kernel.org
> ---
>  scripts/leaking_addresses.pl | 53 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)

Nice!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

