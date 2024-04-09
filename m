Return-Path: <linux-kernel+bounces-136987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4AD89DAC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A8BB2706E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDE512F585;
	Tue,  9 Apr 2024 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aHN3YgGU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8D823AF;
	Tue,  9 Apr 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669976; cv=none; b=fljZStjLBNxVapql9gKkNzDaM+AtlccSPywsh3VqzabmDo+IiMwEhtgF7jbQuGn4Nb0iiD/vffXHvP5xz4fuFyLLol9WE4PRjiYIZVwvn1wbTyZvs6laiJg0nK9RVcRVLJXmmtDfUxp8Y9JH3WFRhIPjwLa+xrqfi+WLMNLjD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669976; c=relaxed/simple;
	bh=2YcExfwfmFcMQf2qTKgSgUElDupQLly3vq9xsEeAdjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWebvSujuzVbhsxKN4tLTtMG7DdhX6O98VcG+jEry9R/Idb19p83l7q5Jx5WreusdXuYJWUj5ryPqOoFAQFDqJSpQrHHEijVXGvRBv8voGHhdWnBBejX7RNQ0DqTEQEPZzhUy/weCYIeG63IN3OdBtrWjiIW7R7TaMSsWIdgePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aHN3YgGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A2EC433F1;
	Tue,  9 Apr 2024 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712669975;
	bh=2YcExfwfmFcMQf2qTKgSgUElDupQLly3vq9xsEeAdjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHN3YgGUCyw9SdSxB70ylWVPV77jFH13sLX+9Tiq+cTohCaUL7zaE+CnqDvUGqT29
	 hBMCxDPrp4HD1s0MjYhFX4H/kXZWcGlxECFeUw/D3uYESbHyXt2ydLqLU3IoxvrWZh
	 kqVbIwja6wjTtbpF9QKD4YUKaA4kdne7EK22TxuU=
Date: Tue, 9 Apr 2024 15:39:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: wangkaiyuan <wangkaiyuan@inspur.com>
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com,
	andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: serial: max310x: convert to use maple tree
 register cache
Message-ID: <2024040904-agreeably-deferral-f2f8@gregkh>
References: <20240318064036.1656-1-wangkaiyuan@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318064036.1656-1-wangkaiyuan@inspur.com>

On Mon, Mar 18, 2024 at 02:40:36PM +0800, wangkaiyuan wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: wangkaiyuan <wangkaiyuan@inspur.com>
> ---
>  drivers/tty/serial/max310x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Where is patch 2/2 of this series?  I don't see it anywhere on
lore.kernel.org.

Please fix up and resend the patch properly.

thanks,

greg k-h

