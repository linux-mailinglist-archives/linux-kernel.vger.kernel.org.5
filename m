Return-Path: <linux-kernel+bounces-76822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ABA85FD1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B566B26C72
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB4214E2F8;
	Thu, 22 Feb 2024 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bx4vBdkY"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6835E39FC7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617213; cv=none; b=svE5gHw4O3xv0/I3NrFMtAFpsfykecsnUwmwsCqllOQAXQK2HbQX2fT5LhZxCpXiDgl3c2L0HntshnxtSVHNZEaRETqShfUwBMBrEq30E9TJ1jZJgVx8GO3OABjpSFfFSBtYAnbs+eTci6WUrXeJJEbjhbiyZ9wNTP7+5V19XEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617213; c=relaxed/simple;
	bh=znXRav4EOtwUP146tj8FypftEj5H9s85kFTrdZUpLZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQsts5fUT7OyeNFb5l5s8aghjUb7Swu0nY/fI3Ww96/BTMnJ93fq72kRiz6v/DutPl9QSSjCtIA409pXCE+MEQoSN3+W0FdA897KNMJprAL8a66rsvOIyZzT6QLTz4usUg77P7mPhhkFH+zeG9N7P59upQUMWEnytP02ElP3n24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bx4vBdkY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J2Y3tqaKMZpVqV845yEux8O3jprRDR0DhU5Ki1G96aI=; b=bx4vBdkYznXzGGFEnY5ZYXeqDW
	8wosxDMw/aOBZMv01tUb0tlSTvGeN/snwb9tGRs1GKPnwKg86iw7WTtNYEqYY2WCRV618vjpQj2RC
	YDmcXkCXRZwR3R9QfOHZdaDh/16npw7qkj8rNJCQ7L3ypoVfetkMffSyFHGlFSimW1VLNDJFXEhJ3
	4kNBn3PnewnBYXtlWkb3VpYi7ol4mA9UjvkCwvz5gn3kCkCYMH1bBGhf0cLqrrYL+aHb/99ugGvT4
	nMI/qNcNSAb857tx9DNn9WgKMwzblBxrcv7Dadsax221NuWzqYNx2sD/AwizMXte4e5wIZqCBnl9+
	XrgKJ5mA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdBO5-00000005UyN-3BUp;
	Thu, 22 Feb 2024 15:53:29 +0000
Date: Thu, 22 Feb 2024 07:53:29 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
Message-ID: <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
References: <20240222145819.96646-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222145819.96646-1-john.g.garry@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Feb 22, 2024 at 02:58:19PM +0000, John Garry wrote:
> Instead of using UTS_RELEASE, use init_utsname()->release, which means
> that we don't need to rebuild the code just for the git head commit
> changing.
> 
> Since UTS_RELEASE is used for fw_path[] and this points to const data,
> append init_utsname()->release dynamically to an intermediate string.
> 
> The check for appending uts release is if the string in fw_path[] ends
> in '/'. Since fw_path[] may include a path from the kernel command line
> in fw_path_para, and it would be valid for this string to end in '/',
> check for fw_path_para when appending uts release. 
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> Note: As mentioned by Masahiro in [0], when CONFIG_MODVERSIONS=y it
> could be possible for a driver to be built as a module with a different
> kernel baseline and so use a different UTS_RELEASE from the baseline. So
> now using init_utsname()->release could lead to a change in behaviour
> in this driver. However, considering the nature of this driver and how it
> would not make sense to build as module against a different tree, this

would not make sense to build it as an external module against against a
different tree, so this change should not have any effect to users.

> change should be ok.
> 
> [0] https://lore.kernel.org/lkml/CAK7LNAQ_r5yUjNpOppLkDBQ12sDxBYQTvRZGn1ng8D1POfZr_A@mail.gmail.com/

Thanks for doing this, could you send a v2 with the "Note:" removed but
instead include that blurb as part of the commit log as it is important
information to retain.

Could you also test the selftests to ensure nothing is broken ?

/tools/testing/selftests/firmware/fw_run_tests.sh

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

