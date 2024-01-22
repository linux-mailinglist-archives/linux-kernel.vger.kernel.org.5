Return-Path: <linux-kernel+bounces-33583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B06836BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DEB1C226F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FBD41228;
	Mon, 22 Jan 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2s87Plc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48ED41210;
	Mon, 22 Jan 2024 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937107; cv=none; b=mJ1kjrvoMTECDpuUWNLYP1V1EJfuCo/6ZWUIsfa05cceywaqlvfKbt5Q12UoSziVrNc25MmXsrtGZtN7YE3byL1ZKEYl6+Z0LfDiWsCu61oqdJf1KlM7pDNCmEbH06CWVjF1IgND3Vka2/EkDfA/+/ujK4ySthu0CdbKUH5eblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937107; c=relaxed/simple;
	bh=uQjaKfpOsy59BldaTOx7UUJOln9p/JBZ5qFpOPOj//g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHg6ZY8gX7E4NppqvzKzlNrEdJVGWDMdzx9VjmInqc3KugzTs6bFte3mPdDRguvTfHMuF29XrFaCknXWlh92B/1H6ad7iUXcJMbyeU8YjXnXy3J4JwCRiQ4TdzTPOngeEvbQcy88hJXYw8zN5LpvFOvxey7fVKhMHvePiMwiznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2s87Plc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1454BC433F1;
	Mon, 22 Jan 2024 15:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705937107;
	bh=uQjaKfpOsy59BldaTOx7UUJOln9p/JBZ5qFpOPOj//g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2s87PlcBBQgG38hGiE77fLDeUK2SsJuqEWSUpS7anXa0zvPd0YfhQBtaAq9q4LnD
	 wpynDeqFv62dNga4fTQDpPubw+eDwBstZQ4qEmY66rZAdoAGgQwOloK6C7f4jchD5X
	 sdwaSgS8IanBaY9XlpnLZxxnlb/DP6gM0KlrzMLCrExWtEhkrdwiTiRqNX3sjNJytb
	 BHd6aA296DPnt1VHJz5aa9SI0W9MNtaHCVt4yrbYauP2GggMC9kXndxsvHbT2DiTBt
	 pnlzF+XxECAToHUsXPO5+2iCWvjrbKvZwV9sV5DirJKc6waVVnGfDPXJRJ2/2cMco+
	 m16PaOlAoJICg==
Date: Mon, 22 Jan 2024 16:25:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org, 
	edumazet@google.com, davem@davemloft.net, alexander.duyck@gmail.com, 
	sridhar.samudrala@intel.com, kuba@kernel.org
Subject: Re: [RFC 1/1] eventpoll: support busy poll per epoll instance
Message-ID: <20240122-erwidern-erleichtern-8a04080a4db3@brauner>
References: <20240120004247.42036-1-jdamato@fastly.com>
 <20240120004247.42036-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240120004247.42036-2-jdamato@fastly.com>

On Sat, Jan 20, 2024 at 12:42:47AM +0000, Joe Damato wrote:
> Add F_EPOLL_{S,G}ET_BUSY_POLL_USECS to allow setting a busy poll timeout
> per epoll instance so that individual applications can enable (or
> disable) epoll based busy poll as needed.
> 
> Prior to this change, epoll-based busy poll could only be enabled
> system-wide, which limits the usefulness of busy poll.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

This should be an ioctl on the epoll fd, not a fcntl(). fcntl()s
should aim to be generic which this isn't. We've recently rejected a
memfd addition as a fcntl() as well for the same reason.

