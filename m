Return-Path: <linux-kernel+bounces-80566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB08D8669AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BCF1C214BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80E1B947;
	Mon, 26 Feb 2024 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KdG1311Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8681B295
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708925959; cv=none; b=N64o9jZz+N5rGSwjNqKMD+/VsKF6b8cVjdMvdkz8cwlmkGiZo2w7In52j5dS0QVY1hpFezxAZRb3X1iK1VhKbrHoDDF0B/E6xmAPjriizp3iWj+SPjqv58CwBxYGKxfWQyOHehLo9GEEc/crjCi7GxhZRN5EDGv2Bn5xycAdA1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708925959; c=relaxed/simple;
	bh=eDp83MYzsgFt84CqxaITxG0g4Dkw+7gxS7TyT0QGtdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6OgfBZWtK8r2dtgx+BLhUTJi8kZufjMMFzqFI9g5B6xsSjmYI7d3ZVMnAFYdd+6copDWdT4R9b9XS0L9D8wNfkHFNzfVMRRK1938PDq8heIeSX4YdzIydqyoJ2WsW3hU/eA9KVGWpvepjXjmHphtcjyCvLi2F650rubGxT2Onw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KdG1311Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AC9C433C7;
	Mon, 26 Feb 2024 05:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708925958;
	bh=eDp83MYzsgFt84CqxaITxG0g4Dkw+7gxS7TyT0QGtdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KdG1311Q2oF/3tOSJMyL7lOc3wB4vznT7EJNJZw352rbep0AKDuNni+/ooT24cgHB
	 fXfT1Vqt4KqSK4ORnk1jSt1qIDR+AgPzdkjMRzlaJdvy/dD1d90QiTSiYTTRQ0Yt2l
	 Ix3Fhn4tX5ZGzqS+cdWdi5Nn1hVe+WZsFzfDBBoU=
Date: Mon, 26 Feb 2024 06:39:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: CVE-2023-52471: ice: Fix some null pointer dereference issues in
 ice_ptp.c
Message-ID: <2024022654-designer-rack-c644@gregkh>
References: <2024022546-CVE-2023-52471-ab29@gregkh>
 <ad071ad2-693f-4689-a324-37e80495635a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad071ad2-693f-4689-a324-37e80495635a@oracle.com>

On Mon, Feb 26, 2024 at 12:21:40AM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 25/02/24 13:46, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > ice: Fix some null pointer dereference issues in ice_ptp.c
> > 
> > devm_kasprintf() returns a pointer to dynamically allocated memory
> > which can be NULL upon failure.
> > 
> 
> I have a question about this and couple of other CVEs:
> 
> CVE-2023-52465: -- devm_kzalloc() and devm_kasprintf() failures
> CVE-2023-52467: -- kasprintf() failure
> CVE-2023-52471: -- devm_kasprintf() failure
> CVE-2023-52472: -- allocation failure
> 
> As it's widely believed that small kmallocs cannot fail, is it worth having
> CVEs for the above bug fixes ?

If you believe that, then sure, don't worry about these individual
commits.  But if you don't believe it (after all, why would we add
checks if the code could never fail?), then perhaps you should take
them.

In other words, why would you NOT take a known fix for a weakess in the
codebase?

thanks,

greg k-h

