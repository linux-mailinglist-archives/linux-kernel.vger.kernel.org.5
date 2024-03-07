Return-Path: <linux-kernel+bounces-96286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E788759C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801DA1F2511C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4BF13F44D;
	Thu,  7 Mar 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tl17FZS5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5A13A256
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847961; cv=none; b=FZXAW8tNXQkZ2PGdHjAoHSOGJUXn5HAcs+7zBiOxEqZSXAeGb6yCjFZ7k6BhzULgnVNHTiOLQlyLlTkFJYOYzq9hhLVR0Bt04osxUwVIQ/TMeTgJyO/H/fIj68yOKByXWj4YoulzFrbkL7DhrCCb6G1yKEaLLqta35s6VJgWOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847961; c=relaxed/simple;
	bh=Q7TIejCnJnHk/kR+IlLj7k3Lb+YR9ALkHoKnXOcCLzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/9FI0v3Ucw9ywA0l1EWzF2QJLYvXK9b5w0yD0Am+dCxgEQBAf314U7yyjFt4z3hNNhvRdOF8oLtpI/csPekVK1VXcY2AoskHeUBEDCl8eZZDFSV9QGr5K4jR9et8jsXxD8xc+jyWJfguemwEdEds6vWj5f2/PB4SwieevDxHGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tl17FZS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260ACC433C7;
	Thu,  7 Mar 2024 21:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709847960;
	bh=Q7TIejCnJnHk/kR+IlLj7k3Lb+YR9ALkHoKnXOcCLzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tl17FZS5IHQ8SXTpVw+96t0csQrPFtjDBJUJnOPVKsKxMpOka/8hkQuLojdr6RlL2
	 cgx57imeMVRQxh6MKMKK8oq4CaxpCFnicZxp+AVeFBVTx7LrrAPQol/ez/rcdoMba2
	 4tMqk1rx8pwZq7DivVekqQV6o43n8oyovvIXDuE8=
Date: Thu, 7 Mar 2024 21:45:58 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Jiri Slaby <jirislaby@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] tty: serial: amba-pl011: Fix removal of the QDF2xxx
 workarounds
Message-ID: <2024030741-numbness-unshaved-8c03@gregkh>
References: <CGME20240131213600eucas1p12ecf4d6fb101425fa35e50f45a241c84@eucas1p1.samsung.com>
 <20240131213543.958051-1-m.szyprowski@samsung.com>
 <CYTPHTGKM7FT.1DRXMURTS246L@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CYTPHTGKM7FT.1DRXMURTS246L@gmail.com>

On Thu, Feb 01, 2024 at 12:29:55PM +0100, Thierry Reding wrote:
> On Wed Jan 31, 2024 at 10:35 PM CET, Marek Szyprowski wrote:
> > Commit 196f34af2bf4 ("tty: serial: amba-pl011: Remove QDF2xxx
> > workarounds") removed some quirks specific to QDF2xxx SoC family.
> > Unfortunately it removed a bit too much code from the
> > pl011_console_match() function, what broke console operation on QEMU's
> > 'virt' ARM/ARM64 machines. Restore the "pl011" related string check as it
> > was originally introduced in the commit 10879ae5f12e ("serial: pl011: add
> > console matching function").
> >
> > Fixes: 196f34af2bf4 ("tty: serial: amba-pl011: Remove QDF2xxx workarounds")
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/tty/serial/amba-pl011.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> I was about to send out the same patch:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Oops, I applied this, but will drop it, as it's already fixed up in my
tree with a different commit.

thanks,

greg k-h

