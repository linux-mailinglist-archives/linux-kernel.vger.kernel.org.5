Return-Path: <linux-kernel+bounces-31787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543938333F8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E892F1F21FF4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CDE555;
	Sat, 20 Jan 2024 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdJlOK+e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42F5320F;
	Sat, 20 Jan 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705752017; cv=none; b=L4GguXBUzCcK0JkqkVMBmCZMf/Hon1CYUT30UXEqDyO6iBjhDFv07Ic4Xf4FqExmSeoIJgJ211IywJmn3E7DVRRl/QWsd+1JKLvY/evRys0aygiWi5WXD8uaZkmCbeAZo0LRUPjd0PJaCdXTtqzyjEd6gQzhEURe58yTR+q1hgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705752017; c=relaxed/simple;
	bh=PkF6YXZLhKQe2Faar9K9DRgJJuZs87C57DbxFN/Fdao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/PNGbdMnJwqq94GX6dRFqcdDOmbj+rhZm/Me4XnmB6dz3mJyy3hlnYMHDt/6t4hypsVM6BHuyaXnJWvsbh9ej753ccYeiUuRtA5X9tfVdIzYoEy89nKI7UZsW9/fr2u0jGMbH+RGckOQ2OhRj5Kk//vOxrYtSSC4pMdCbA3/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdJlOK+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A8BC433F1;
	Sat, 20 Jan 2024 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705752017;
	bh=PkF6YXZLhKQe2Faar9K9DRgJJuZs87C57DbxFN/Fdao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdJlOK+e7nkCmuY8GEpBC71Qhb90oU70LQVNzV+NPSZrsZytGT6pG9bjC+vtn2Pu5
	 Ihv9gnsPzTGdG1FYVLZZzC3do0sdTNtyfkEIiakLKY+M4sYO4kCD+IwODtpXcoO6i2
	 OaPHogdjT6dSpkjnl7nV3GlTIXv+NS92gjmaH7/7+OiPoTfP4hBWipgnY7mtEZ18e0
	 YD861k8GB9xZSmjd5ToB0LlfZ8QBp/kw1jdfXn1XOAbFHbC0Iw8THJwKuwZnno0/RY
	 ADWTIjC7CCDGai/FnbpfXlte7ztP1yAxAB4NrGumKG4nYWUjgn22dyzZkJn30To7OK
	 LIJpMmfCGNQfg==
Date: Sat, 20 Jan 2024 12:00:12 +0000
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] nfc: hci: Save a few bytes of memory when registering a
 'nfc_llc' engine
Message-ID: <20240120120012.GA118262@kernel.org>
References: <6d2b8c390907dcac2e4dc6e71f1b2db2ef8abef1.1705744530.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d2b8c390907dcac2e4dc6e71f1b2db2ef8abef1.1705744530.git.christophe.jaillet@wanadoo.fr>

On Sat, Jan 20, 2024 at 10:56:06AM +0100, Christophe JAILLET wrote:
> nfc_llc_register() calls pass a string literal as the 'name' parameter.
> 
> So kstrdup_const() can be used instead of kfree() to avoid a memory
> allocation in such cases.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

## Form letter - net-next-closed

[adapted from text by Jakub]

The merge window for v6.8 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens on or after 22nd January.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

