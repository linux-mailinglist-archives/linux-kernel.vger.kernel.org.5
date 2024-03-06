Return-Path: <linux-kernel+bounces-94496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940FC8740AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53DA1C21464
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A007140384;
	Wed,  6 Mar 2024 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/tmS/3+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F7487AE;
	Wed,  6 Mar 2024 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754211; cv=none; b=gzbNtAKHWawKnceV/DNZGoX2beAo9OE1JPl+q/QMDhl9NHEa417iBhzVXmjEL0dU/E7h05HxseGX6+OAY339gZezafHh/K0yLrYAqEHmG3fnFc+xftOKpJLjkK0aNrNTrnbRgrvB/YHT4MrDctwCtQNzh/EEFPp7lvKYRk1bU3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754211; c=relaxed/simple;
	bh=xtEDxEHvvvxyVXTyfp7trVYl/30Kq4/Ns4l1f2QW3W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3DlRlIhB0HL9LbIhdR1SweI5DrP9aCSaHY+m1M5PprFdU7amGPWTDbF0ZMgYp9pMryVF4EZD95YSCR2sC70fXG+x/nRHMdYEOnjV0BRjEx0xv9XXXcUuu3UamgthxKkqkmLS43dTNvyNobRLRQ6Od45DU09Ns+pAHCg9AGNurI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/tmS/3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BDAC433C7;
	Wed,  6 Mar 2024 19:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709754211;
	bh=xtEDxEHvvvxyVXTyfp7trVYl/30Kq4/Ns4l1f2QW3W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/tmS/3+oeDJnWr09mojyuk75EE0hGzxhYO8HuuKuTK32JURSB6KBTnuyZPYj152F
	 DRv01rFWLtnJI0i6gxTcWlg6DywqVJcaQ82187zTI+sUg0D5pkJsqqWfbrmaVdLPIM
	 XbDlce4L1LWH9ml/IMt2vwhnQEsI7/PiaYk0E3uZcr1jyJYH8zxVelCGttgoj0dq2+
	 +7GiD+/GCLwncahbWF9JD+9JtCxbomgYVfXbSQrElLCtUh+HR6y++hOdGMkMKgRKnz
	 ItTsNW0+LeO8s0QOC22r+/RiIzdkHGf3DT63VmNqgsZ64jsPdhLyiknqKBfBkWjbKe
	 W0pa+vlU58ZPg==
Date: Wed, 6 Mar 2024 19:43:27 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH net-next 1/2] net: geneve: Leverage core stats allocator
Message-ID: <20240306194327.GA281974@kernel.org>
References: <20240305172911.502058-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305172911.502058-1-leitao@debian.org>

On Tue, Mar 05, 2024 at 09:29:09AM -0800, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the geneve driver and leverage the network
> core allocation instead.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


