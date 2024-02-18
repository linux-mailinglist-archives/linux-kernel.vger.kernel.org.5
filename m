Return-Path: <linux-kernel+bounces-70316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5908595F4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E208282400
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7E7107AA;
	Sun, 18 Feb 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nH9VwHIg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA4168A7;
	Sun, 18 Feb 2024 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708248404; cv=none; b=aW30HMjYuaMSoMf04JyYDpJUXcyPFJ6ITYtF1ARlkKNCwFerxYPet/t85x4TXXDj2ZpTJwjhIzQX5a5kvYdgnN5Omc+blo3dQWbMOPUj+pKaaT9m1gtpVqanI76csNG8d+PbJzCkliXRTBOF/RbMtlVI6Cx+ihNFXB/IPbGrryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708248404; c=relaxed/simple;
	bh=RUVEgf2DoDrFDxKX+7DXtVhhuI22XAgzgP1ULTEUNn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwJek3MrlP0wxmM7/vGDBYPZLlbY9Ebw+3c1zZKMz+vNgXi41JhHK3xoB28AkYICSPGSG3PSezMOTCXAR1u7UBNUy77isbe7hewUkHVSdd71nFk4rmMvBh5KTs9rIFs/6wTMeYSTpi0saB98G1F0O60wnKeYhY41nyf5Bgh4fmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nH9VwHIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1C3C433C7;
	Sun, 18 Feb 2024 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708248403;
	bh=RUVEgf2DoDrFDxKX+7DXtVhhuI22XAgzgP1ULTEUNn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nH9VwHIgIJZYUgp7QkkNWwS8kXUqs2Yjku76a54gHhZ255XdDra2sUmyo9GixOzBv
	 TPENR78X6holzWeqaGHuiSDOnlG9lo5oAKISh7EczvRIv9hRGGeb6liRQPbmkGvPXC
	 jTQnj0o4pBOrVDGEi96cHsuE67QqbHSUqFu5pr9M=
Date: Sun, 18 Feb 2024 10:26:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	Yang Shi <shy828301@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: please pick up 4ef9ad19e17676 ("mm: huge_memory: don't force
 huge page alignment on 32 bit") in linux-6.7.y
Message-ID: <2024021812-blazing-immortal-7b4b@gregkh>
References: <307eb8d1-2fde-4e12-b48f-9632510b469e@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <307eb8d1-2fde-4e12-b48f-9632510b469e@leemhuis.info>

On Sat, Feb 17, 2024 at 02:44:51PM +0100, Thorsten Leemhuis wrote:
> Hi Greg! It seems to me that two of my mails to you[1] fell through the
> cracks during the last two weeks, so I'm trying again with this main
> that is not a reply to the earlier thread:
> 
> Could you please pick up 4ef9ad19e17676 ("mm: huge_memory: don't force
> huge page alignment on 32 bit") in linux-6.7.y? The author ACKed that[2].
> 
> And btw: you might also want to pick up c4608d1bf7c653 ("mm: mmap:
> map MAP_STACK to VM_NOHUGEPAGE") as well. Its stable tag contains a
> typo, hence I guess your scripts have missed it (I only noticed that by
> chance).

Now queued up, thanks.

greg k-h

