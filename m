Return-Path: <linux-kernel+bounces-118690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F64E88BE16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619111C3BA7F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E526B823C2;
	Tue, 26 Mar 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sr2mHc5+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315514CB3D;
	Tue, 26 Mar 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445679; cv=none; b=PhGH8g+5C2XHTol7azUFg5wCXFKzuvWIPy8bFDFjWI1RYmMyVx/KowTFc54K/dkxVPtRUZNKxIg+F0VooBGeLgcO5y2ZezQlb83pTHYMdM2DjEIJ72rv879bODREIJN2bJ7SbEb6/Zz82zahdEBa3BxRggG8SUSOz5oeDLCnUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445679; c=relaxed/simple;
	bh=BL4wWvvNYVXrWBDw/289gfPssapLTh5QOAwqZAfBDQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz4eIn+Agmwr/Gnu5jmuZTkBXxYXfBGE7rliDTLxU0WIvNLWsMlTwVBV7kEqfz8Zd/m6Lwz6Pg6ABemc+9Oi6SB9Xc+EfMTyLb7QJ3B0VmxXEAp1Y2StWYbcDboPzLEaGysJBmwBC8JN68YXmgNKhqV3zv8XXz2bQ+Vd5ASyzqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sr2mHc5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF55C43390;
	Tue, 26 Mar 2024 09:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711445678;
	bh=BL4wWvvNYVXrWBDw/289gfPssapLTh5QOAwqZAfBDQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sr2mHc5+K7ta5wpODqNPROLFS0sH0t7R1prronrJX3u99zWakRDNfDirKWLpsBQrx
	 k/5ajTTvjGzBsuu3DuLNPHj5i3NzJPX1xM+wTn17SQ8r47Mt99N5gClytO6oHOwu/m
	 /31hbbTammyFFdP5QNflb0SWEmHqxtOCedaSQi+0=
Date: Tue, 26 Mar 2024 10:34:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Surong Pang <surong.pang@unisoc.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Orson.Zhai@unisoc.com, Zhiyong.liu@unisoc.com,
	Surong.Pang@gmail.com
Subject: Re: [PATCH] usb: gadget: rndis: add multi packages support for rndis
Message-ID: <2024032615-smog-pardon-4d5f@gregkh>
References: <20240306054949.324172-1-surong.pang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306054949.324172-1-surong.pang@unisoc.com>

On Wed, Mar 06, 2024 at 01:49:49PM +0800, Surong Pang wrote:
> As ncm, aggergate multi skb packages and transfer them at one URB.
> In USB2.0, the network throughput can be improved from about 18MB/S
> to 35MB/S.

Why is rndis still being used?  It's an insecure and obsolete protocol
that should not be used at all anywhere.  I keep trying to delete it
entirely, but need to go and write an active exploit to prove to people
just how bad it really is before I can do so...

Adding more functionality to it is not a good idea, what is wrong with
the other, built-in, networking protocols instead?  Why are you using
this old one still when there are so many better options out there?

thanks,

greg k-h

