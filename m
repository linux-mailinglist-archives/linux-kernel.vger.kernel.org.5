Return-Path: <linux-kernel+bounces-50483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14B28479B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30FC1C25B37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B4080603;
	Fri,  2 Feb 2024 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSwZfUaY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F953D3BC;
	Fri,  2 Feb 2024 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706902395; cv=none; b=hizcPO5sD2eBk3D/49qq5xhZiwCUNipnMOeEXVtNo53IsZ1ekhMVFLP6gYCuEb4yQfCWPCBrVdoKvKJTAibMwlA8tHXz+1DGf6bQ1bQW8FuTcRtQBroHQWbLv2SIiiHZiRu37o+qHph3plnvQVb2/l0xZWDhXWkVpBeu9+q0oGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706902395; c=relaxed/simple;
	bh=5fX28k3jBg8AF6wuBErGgmwNBI5qB8oapTjKGw2klLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZMh5TLxEWKiFFpfRqkgiCO75larLY7F9DT4zj52/8MfDjZaKyvGYA/sjd63UsEP2hyj14eTfpYSjdYgBfgVjDEHYvxeoxpkslx3H4faxa2GZHYi2rYT4Spfj8IjGz/7bCLQy2g2+e2pCstHqIpnirTxDCNYLVnECrgYftw0RIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSwZfUaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FE8C433C7;
	Fri,  2 Feb 2024 19:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706902395;
	bh=5fX28k3jBg8AF6wuBErGgmwNBI5qB8oapTjKGw2klLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fSwZfUaYriZSw2g/i0aVBoJi+X28rETNBt7iN9Qv/JADxiikJNxTzbFABqcklfsJe
	 Q1+tSI7YPPGRAUPS3xrzIrQPpoknlXh93bFiFP8YtfCvALE8k9gtvAE6ZInmvoYFEG
	 BMOSXx2/isYuYYTySvQXnEs6aznflCfMOMTvlCKrUNLmqIY72xxgeoR6SXtdDtMcpK
	 UeqsgzPKpUdiIYgFzJefEBWW6j1KaNtbXjjAZSFC2g0kN8AX+1BFEqkUpXDYCIhDxV
	 vvKi1HXBB9mbkKn1poycMz4ZLp2rRGSr9W+g7mpwRMzfAR4BPmEZ+wfEfyBJvFAACP
	 mHuArwCM2/F0A==
Date: Fri, 2 Feb 2024 11:33:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RESEND] nfc: hci: Save a few bytes of memory when
 registering a 'nfc_llc' engine
Message-ID: <20240202113314.4c5f09ce@kernel.org>
In-Reply-To: <30e5c9c2-b13a-4b7e-a266-1e03e654f1d3@wanadoo.fr>
References: <6d2b8c390907dcac2e4dc6e71f1b2db2ef8abef1.1705744530.git.christophe.jaillet@wanadoo.fr>
	<20240131150803.2fec5a5c@kernel.org>
	<30e5c9c2-b13a-4b7e-a266-1e03e654f1d3@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 20:11:56 +0100 Christophe JAILLET wrote:
> It would be slower, but it would reduce code duplication as well.
> This is just an _exit() function, so it shouldn't be called that often 
> anyway, if called at all.
> 
> Or, add another function with the list_del()+kfree_const()+kfree(), that 
> would be called from nfc_llc_exit() and nfc_llc_unregister(), to have 
> the best of the 2 worlds?

My vote is the latter - factor out the 3 calls into a new helper, call
it where appropriate.

