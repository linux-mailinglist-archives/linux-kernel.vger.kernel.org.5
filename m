Return-Path: <linux-kernel+bounces-71880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3526E85AC2D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2551F22F84
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC3D51C4F;
	Mon, 19 Feb 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmqvKUaU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F23BB38;
	Mon, 19 Feb 2024 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371879; cv=none; b=YFy/JAp9QYuY/D61lam9HjLafcYXomXnO0h9tDpoWlPgsviOaAkn2tR6+hWQpgbBPZ8QyVizjoqYj39D9aAs42LCFVJDmCl2p91UrSYm4ju2zlPdpsmGfSP8DL8i7z8ZzWYDr/EUq/yobGIrgWjLIkHal6Lg96Md4/qBJ975AtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371879; c=relaxed/simple;
	bh=HhzPmP09U/1d8rZXRd2SC5bEMVxNbRPE2hAW1nJC6AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVw9zI8Qf28N1G/SkonKOIadXEWP2VsMnK5v4n29cqfUlRJW1LU971KTu5RJYyDy0EkakYXsk2W2lkKTQc3TJmVTTCWl1/alIOXHzylIM34O/KAmAjbzO0bVdoro6G8iUm6dIxzLKepsGWHWk/UaO0TCG50KOdk/2YUpZZK116s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmqvKUaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647E7C433C7;
	Mon, 19 Feb 2024 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371878;
	bh=HhzPmP09U/1d8rZXRd2SC5bEMVxNbRPE2hAW1nJC6AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmqvKUaUWVa6kpqJIjPCL3kBAiP/eY8mLFE1B+abI7dfbxAFZx4eXipmp9gS5l1Fx
	 xWmCbyPNZDTKRcZ5ig6CO6DpZLEJlrgB2Ej0S57xW7POSuQHmuq955Hi9cR3xxXX7I
	 57+c0R6VodtNz+tyMMWmGkjwh+z7gCvhAgWNTcjXtC3od5miHG+b4ZU3aqd8eTjyu+
	 6opxW4cIaAZq4S5Ih2gysLidfGkznztG7X6auEqVmZXYcvSpR6c1lusRqDfH2scMuR
	 iLAEnreVi4pdhoX5RBrkXzVd813rdmBtQ/pwIqkv+C4SVZ+rEYvx7qmrxNLXlZEQfe
	 G2QMvhnD0n1Eg==
Date: Mon, 19 Feb 2024 19:44:33 +0000
From: Simon Horman <horms@kernel.org>
To: Alex Elder <elder@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mka@chromium.org, andersson@kernel.org,
	quic_cpratapa@quicinc.com, quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com, quic_subashab@quicinc.com,
	elder@kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipa: don't overrun IPA suspend interrupt registers
Message-ID: <20240219194433.GN40273@kernel.org>
References: <20240218190450.331390-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218190450.331390-1-elder@linaro.org>

On Sun, Feb 18, 2024 at 01:04:50PM -0600, Alex Elder wrote:
> In newer hardware, IPA supports more than 32 endpoints.  Some
> registers--such as IPA interrupt registers--represent endpoints
> as bits in a 4-byte register, and such registers are repeated as
> needed to represent endpoints beyond the first 32.
> 
> In ipa_interrupt_suspend_clear_all(), we clear all pending IPA
> suspend interrupts by reading all status register(s) and writing
> corresponding registers to clear interrupt conditions.
> 
> Unfortunately the number of registers to read/write is calculated
> incorrectly, and as a result we access *many* more registers than
> intended.  This bug occurs only when the IPA hardware signals a
> SUSPEND interrupt, which happens when a packet is received for an
> endpoint (or its underlying GSI channel) that is suspended.  This
> situation is difficult to reproduce, but possible.

I see what you mean about *many* more :)

> Fix this by correctly computing the number of interrupt registers to
> read and write.  This is the only place in the code where registers
> that map endpoints or channels this way perform this calculation.
> 
> Fixes: f298ba785e2d ("net: ipa: add a parameter to suspend registers")
> Signed-off-by: Alex Elder <elder@linaro.org>

As noted by Alex elsewhere elsewhere in this thread, this is for net.

Reviewed-by: Simon Horman <horms@kernel.org>

