Return-Path: <linux-kernel+bounces-125056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7681C891F59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166401F30C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBCD1411D8;
	Fri, 29 Mar 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qqdRo9+f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B185C62;
	Fri, 29 Mar 2024 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718243; cv=none; b=sVUMU+E5EQWGlVZoAXgxp2mU3ClibGCi7I+/MrLbr8xYSwMS52zzsfQVYxAaqTL02CFZaAPDEstfEloiNorCDmKOmhiTpmzKa6vZ8T+WWtPxHRspqnVHFjt0mnuQmumKGJ/VspyM1Jgh2fzWlZz2FzJanLfaTJeImXv+YkyT7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718243; c=relaxed/simple;
	bh=RPa9dMNYyA+KCy+cdAl56vwS+FL89emEjUPN4t52wlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtSPuUNJAA1lPcxMC1oIQWwQ+bfyXQL9h2JtSWLlqtJz8EUXplAH3uwRpmOiAZcjMfSw9e80790IwDkAfTHr5yUvmgs0aFUOW2QtU3VXlXULdv3xjbqXpboQL5NPBKcaL2CMaAliDjcRErwb4nkG+KzOQGHPTOM8ZIcfxjHsZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qqdRo9+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419D5C433C7;
	Fri, 29 Mar 2024 13:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711718242;
	bh=RPa9dMNYyA+KCy+cdAl56vwS+FL89emEjUPN4t52wlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqdRo9+f5u+15nFt0NUMNJ8ee6H9q4Y7cVMe6NtmkRImXRc44vNtyH9lVqP8Xgp81
	 i8POScFdpsjS13+ATrNG3l0eYSeaGk6jOJRA7svxJvzcc1EzbwiSqQ8rlkGfHhVOeV
	 Gv9mMvc8RcfpaFZKWJ+Y1f7M8R1b52BA04BRjseA=
Date: Fri, 29 Mar 2024 14:17:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Greg Edwards <gedwards@ddn.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "block: Fix page refcounts for unaligned buffers
 in __bio_release_pages()" failed to apply to 6.1-stable tree
Message-ID: <2024032913-yoyo-residue-ba22@gregkh>
References: <20240327121329.2830355-1-sashal@kernel.org>
 <45ea3c6a-18d3-469a-b368-d657b739edd2@cybernetics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45ea3c6a-18d3-469a-b368-d657b739edd2@cybernetics.com>

On Wed, Mar 27, 2024 at 09:54:01AM -0400, Tony Battersby wrote:
> On 3/27/24 08:13, Sasha Levin wrote:
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > Thanks,
> > Sasha
> 
> I already sent a backport for 6.1 on March 13.  5.15 and older kernels
> do not need the patch.
> 
> https://lore.kernel.org/stable/a764cc80-5b7c-4186-a66d-5957de5beee4@cybernetics.com/

Thanks, now queued up.

greg k-h

