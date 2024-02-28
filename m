Return-Path: <linux-kernel+bounces-84409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D4A86A66F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E328F1C25848
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6D21947E;
	Wed, 28 Feb 2024 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl212AOm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8012063B3;
	Wed, 28 Feb 2024 02:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086631; cv=none; b=nItMUbPlzMcBN+nC9RCpRZRVm5sPkcFRCB97nFN3MK5tOze10hixTgxUv3w1yoBcP+IfzWXNqxPe8ZDLkYqRtV93UsxL4vnWGwx1jT4AsP+KtbBrUO0+KjjizzU2AQ/662HBp2D4ga0KEq9yNSIlRqZpul+SbzzeT0ujl4HR6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086631; c=relaxed/simple;
	bh=ks5mnjKC9lF0LUAQnlJGF+2i9bOqbfU8O+K3zemzvJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvkVwCzyu2vhMX4Nj421ooTxAk8MOoj1e/dB3rbVN6JbagGxv+7XFlUGeO4IodlGtJfLoHq4rTwNC2+jq1hMRitopVRCH76uJqyQerFy9hYuffqCgfNZs7faXk+hw4jMQizolNsTHXY4t5fh9ME2q32qf2dIyKTyvt+OEjCy47M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl212AOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98EDC433C7;
	Wed, 28 Feb 2024 02:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709086631;
	bh=ks5mnjKC9lF0LUAQnlJGF+2i9bOqbfU8O+K3zemzvJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rl212AOmTiAWXRGq6m9KtDJfubLQf8XcOYeUzflQGHV9enk7c3NBn9e4foLkGnOvD
	 kM+kcM1v+Y4tmR+jJzo117y5LzDs5EuIc+JTkgdLOGobkpdLSAv7oJKiIyYnSIGXTg
	 BvMI96gvqcATDPOcFNYPKLddT4ehvD+peNN5yw7BenmKe203eytImLWqvxLfZDUWRw
	 +m4gNQHo7XsUe2yrgBG6zwNXBoeIV61ILqghXLGnIm7ZDr8deFwP6HFwiE5Xa1ac5j
	 SYXDbVLcUUgXEvD/UW1oSoiPFmaoefT8FeB4hxJCWQMDKxjpSra5ZRquWjC6WTJpOD
	 rlhuzsvamGCCw==
Date: Tue, 27 Feb 2024 18:17:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>
Cc: Peter Korsgaard <peter@korsgaard.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: dm9601: fix wrong return value in
 dm9601_mdio_read
Message-ID: <20240227181709.7159d60f@kernel.org>
In-Reply-To: <20240225-dm9601_ret_err-v1-1-02c1d959ea59@gmail.com>
References: <20240225-dm9601_ret_err-v1-1-02c1d959ea59@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 00:20:06 +0100 Javier Carrasco wrote:
> The MII code does not check the return value of mdio_read (among
> others), and therefore no error code should be sent. A previous fix to
> the use of an uninitialized variable propagates negative error codes,
> that might lead to wrong operations by the MII library.
> 
> An example of such issues is the use of mii_nway_restart by the dm9601
> driver. The mii_nway_restart function does not check the value returned
> by mdio_read, which in this case might be a negative number which could
> contain the exact bit the function checks (BMCR_ANENABLE = 0x1000).
> 
> Return zero in case of error, as it is common practice in users of
> mdio_read to avoid wrong uses of the return value.

A bit odd but appears to be true, so I'll apply, thank you!

Andrew, 
mii.h files seem to fall under PHYLIB in MAINTAINERS, but mii.c does
not. Is this intentional?

