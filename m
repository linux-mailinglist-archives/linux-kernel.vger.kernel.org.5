Return-Path: <linux-kernel+bounces-119163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E988C4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D52D1C61F83
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A322D12D772;
	Tue, 26 Mar 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5C+HdgV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFC412D74D;
	Tue, 26 Mar 2024 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462762; cv=none; b=nXsbHG4HINX+6U3EHl+MPgZ5kpd87MNQFwEfggTwyMgnvjpKW84Ggi54SuX0Ax2OZBW+L1UXptwYaURsfDTjbTw4nxz31eM6wfU37j1x9NpT5nsYmhNHYcmBGkV0hxjWI+LdzKLrTWH4edo2il7B3R7CW4/z3H+14kL8hoXGvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462762; c=relaxed/simple;
	bh=cUG492G07dhJ295J2s6Bln1s6TgRP0M3K3HaWg8Wrcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGtOb57Y9K8clIm4o7PApk4F6ZMX/z17Ty9q5EVfIcfzT4nzYDoFXm3MQVrY2TqRbf4y+rVmqeIGTJ8biSgD22Wie5HUx0R8oLSs4YzYxxATHeSPLcq/Reg9JjTRjnzcVmbaixw1+QR9HOu4Kt8+49AyMjcRj6///RLBJI+jsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5C+HdgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E926BC43390;
	Tue, 26 Mar 2024 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711462761;
	bh=cUG492G07dhJ295J2s6Bln1s6TgRP0M3K3HaWg8Wrcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5C+HdgVS4qy/7M7L6NSr7ER7ibxLccniWf/xtu2V/w87sozoVQVerjOkd9t2JJY3
	 d75k6Ihfs1arrkeh+3lnTOAK7N5XKkMIYBkSdD8lffC2ISSWbW0kqxHP0VY7C23tuB
	 knTNN8sbqvf/fw28+Z3AjtpNa49qDOU54KsmDQojVP2cEoggPP3HZSbVnTW5ooTpfo
	 ZWVTx3v+iHTOlLdbJ5+kw8QXdrKQCuyJ14yQMfj810WQ6Qjr0lTfw4x8dWlg6mdUMe
	 lIXywLcq9ihEPp9biq9VHITu0JqClQQSYK6/cwm2Wagrd7qP2HC6q2fQmGKnbXXkOQ
	 HiCoF9shtzGcQ==
Date: Tue, 26 Mar 2024 14:19:16 +0000
From: Simon Horman <horms@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, saikrishnag@marvell.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] octeontx2-pf: check negative error code in
 otx2_open()
Message-ID: <20240326141916.GW403975@kernel.org>
References: <20240326061233.4133148-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326061233.4133148-1-suhui@nfschina.com>

On Tue, Mar 26, 2024 at 02:12:34PM +0800, Su Hui wrote:
> otx2_rxtx_enable() return negative error code such as -EIO,
> check -EIO rather than EIO to fix this problem.
> 
> Fixes: c926252205c4 ("octeontx2-pf: Disable packet I/O for graceful exit")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

