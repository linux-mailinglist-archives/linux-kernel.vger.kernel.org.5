Return-Path: <linux-kernel+bounces-36982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E000D83A9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974931F25943
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1F7691F;
	Wed, 24 Jan 2024 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HsMsFxQv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010576918;
	Wed, 24 Jan 2024 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099536; cv=none; b=sXd0UaH1ER/Nhg3Gozib6jiOzKcldv1aWizge1HcRWrQNXuTZMqorLHbbbvxzBcr06mq4qQcubCL0QKKXJMm+NEyfin38Q8P039XJN00yGxJNJ/KYbLhKPcMOVqW15q5j+4s0THg1PPW0gR7UXPHlpqMx/OrZaHSoOCNClw72j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099536; c=relaxed/simple;
	bh=GD414r5uUfQKTl7+Hf0W3x6sPSQMHCgSnh3nUJhrXYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+e13Aig0vqOP9ObEIZsmkO7wWPQGyTHi+iPcgJwOgHuabE+i7XTp/pqfeGhNntXRb6CpKDZs1L17Du28r4xhUlMf0dusiYS2f2h7GMLkfSCrwldTndl+upqh+U7661oDIiSSiMMdbcI9XjOfk89M/49LYpUpL7j9Jp8Uc3hyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HsMsFxQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44392C433C7;
	Wed, 24 Jan 2024 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706099535;
	bh=GD414r5uUfQKTl7+Hf0W3x6sPSQMHCgSnh3nUJhrXYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsMsFxQvYgqF/Nv7icAxBXrrdGaKv9+JWouJ+YFp0z1+A/tURCyu6VSW3kZNLiDR7
	 942VuXoSIPVa2hsTj2P/WzCRrun9XNtQudqe503xDFqrGM6yqqIVg6b2iQ2XeZOAsi
	 20YoFp+69COLxtwHyucg+E0Q7m4kIpm3BnFN/OMg=
Date: Wed, 24 Jan 2024 04:32:13 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/9] ntsync: Reserve a minor device number and ioctl
 range.
Message-ID: <2024012454-cosmos-sprint-7db7@gregkh>
References: <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-3-zfigura@codeweavers.com>
 <2024012356-dove-duke-f7f6@gregkh>
 <1875326.tdWV9SEqCh@terabithia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1875326.tdWV9SEqCh@terabithia>

On Tue, Jan 23, 2024 at 09:43:09PM -0600, Elizabeth Figura wrote:
> > Why do you need a fixed minor number?  Can't your userspace handle
> > dynamic numbers?  What systems require a static value?
> 
> I believe I added this because it's necessary for MODULE_ALIAS (and, more 
> broadly, because I was following the example of vaguely comparable devices 
> like /dev/loop-control). I suppose I could instead just remove MODULE_ALIAS 
> (or even remove the ability to compile ntsync as a module entirely).

Do you really need MODULE_ALIAS()?  Having it for char devices to be
auto-loaded is not generally considered a good idea anymore as systems
should have the module loaded before userspace goes and asks for it.

It also reduces suprises when any random userspace program can cause
kernel modules to be loaded for no real reason.

> It's a bit difficult to figure out what's the preferred way to organize things 
> like this (there not being a lot of precedent for this kind of driver) so I'd 
> appreciate any direction.

For now, I'd just stick to a dynamic id, no module alias, and if it's
ever needed in the future, it can be added.  But if you add it now, we
can't ever remove it as it's user-visible functionality.

thanks,

greg k-h

