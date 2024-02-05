Return-Path: <linux-kernel+bounces-53387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD9284A3C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326331F21335
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D5E127B71;
	Mon,  5 Feb 2024 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+VGvmIt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753285C5F;
	Mon,  5 Feb 2024 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159808; cv=none; b=cwzCbzb/eThB2NuT0Xw+h+Xu6vhMP4xtNyVn3/WVGj8CrPjC6KvQbYPaHg00A/P7wE4DcH/pz0RfdJzq38pnPNoZuRrA0mSPlhYQ45SZUAQ8xddMVns2dghBGiTW/YrlKqdNuvtEGNpAculscXcpWSvtx5k3yP5LZiTd/JtTePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159808; c=relaxed/simple;
	bh=H8f1M8b6apfQrDwjE9TiNKtV/aNKPCj66fgR1fgv7Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbbqmeEfZG+C+hHsEWJ2uhnnJEayiNH4zWe6EwxwUZSFD9BAQtpF3gJhkpdutYpivEZKenzZZxN7Z7LgQcQ/2L5w2jTrBoXtCngMbYM4mKnNIcvjtSx1RNy0ICNStt41DPjzYkVuvxAn2z7PyJLHm5PAe/yYJCOmX8NQ/bMPNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+VGvmIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC269C433C7;
	Mon,  5 Feb 2024 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159808;
	bh=H8f1M8b6apfQrDwjE9TiNKtV/aNKPCj66fgR1fgv7Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+VGvmItD5yfAwZTpbgpHgOBcWxVR7wRfY+/tc+ME9unt//2Lxhq9AMo4waqGRikJ
	 bCq4QVa9FhvzD6AG3EfmrNGWTwBaJ7OJsmmmhU4ZJG5YPPqsAdnMRIV+lCTtQsSJLh
	 XmI1qzEbKESuhGewo8tuIXs2a6Nt4s3QCzkQZLqc=
Date: Mon, 5 Feb 2024 04:48:23 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdevsim: make nsim_bus const
Message-ID: <2024020518-reattach-linguist-c212@gregkh>
References: <20240204-bus_cleanup-net-v1-1-704b36d75901@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-net-v1-1-704b36d75901@marliere.net>

On Sun, Feb 04, 2024 at 05:16:34PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the nsim_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

