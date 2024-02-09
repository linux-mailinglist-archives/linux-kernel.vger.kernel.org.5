Return-Path: <linux-kernel+bounces-59243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596D084F3B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A44A1F2A2D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5D328DB3;
	Fri,  9 Feb 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3P4CcDY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7D28DA7;
	Fri,  9 Feb 2024 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475637; cv=none; b=SmET74jywskQiETcF4bv/Za+PABrczMz+AUsdNfWbfyWp9XMS1fD0Evy3mq3GHLLG+yfr74zBoRTdp6VE5TasYs9te0492fKacITjEOxTvRsz2v6TQGv7Kf92Zzb6gN0Hhi/acD8U72JPx6sgNx+GsjXfQgjXxtBhQKbMW8DN08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475637; c=relaxed/simple;
	bh=rzOHTWzV5bEENtegQ2v+SGNGr6b2yUduNdh+QR5S9i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ5fcdiS3zEdjx2qJDI6c4ipMs6kwnSyB4fuW7dFDIzyJg3uM5YnO0mULK3lgac+yylyylSrsYdpDyabps0Obra2gh/J6rvhn/r+J7FSCR3h5TlCBX3AoP08UecehPjMb4RwKkBRdDUzgWEnaGLZSelNyGui1mlwccb03iRSoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3P4CcDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963DCC433C7;
	Fri,  9 Feb 2024 10:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707475637;
	bh=rzOHTWzV5bEENtegQ2v+SGNGr6b2yUduNdh+QR5S9i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3P4CcDYZxsJT7hk8aUYQCEc/HbKIdOVSoMw/3SNsfLd8CUjoKMR6HExhrGsVW761
	 szYpLdaAkkdxkyhG/p171UnFetcypKSwpPFrl3hVM3BomFU7Ui3djK+tLDeekXfadS
	 XC+84MXWgEnaJ/ZEv2dgfqpcmSRJ0ReSt1p/B2LE=
Date: Fri, 9 Feb 2024 10:47:14 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: niko.mauno@vaisala.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	vesa.jaaskelainen@vaisala.com, geert@linux-m68k.org
Subject: Re: [PATCH v3 1/2] usb: core: Amend initial authorized_default value
Message-ID: <2024020903-october-placidly-20cc@gregkh>
References: <20240209094651.5379-1-niko.mauno@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209094651.5379-1-niko.mauno@vaisala.com>

On Fri, Feb 09, 2024 at 11:46:50AM +0200, niko.mauno@vaisala.com wrote:
> From: Niko Mauno <niko.mauno@vaisala.com>
> 
> Since the wireless USB implementation has been removed and since the
> behavior with authorized_default values -1 and 1 is now effectively
> same, change the initial value to latter in order to stop using the
> leftover value. The former value can still be passed as a module
> parameter to retain backwards compatibility.
> 
> Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
> ---
>  drivers/usb/core/hcd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Isn't this series already in my tree?

confused,

greg k-h

