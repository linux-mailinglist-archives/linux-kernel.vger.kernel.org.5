Return-Path: <linux-kernel+bounces-99121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69358783AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827B42850FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5A64AECC;
	Mon, 11 Mar 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skhuymnT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1DD3FB8F;
	Mon, 11 Mar 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170197; cv=none; b=LBj13DNsBEbHRcIBre9hLSm9hCTPGYlM/7Gks2Re4nSfOFj0kQ8WqcZPmByAJfR1gNaYYugVUzJT7NO4Qw7DE+pggRR24K9u3KWmjpTcmHaa+JG4aXkQ5lH4htBGKvkDhFbQalmD5jXuYMMpuFiXsEnlHCzR6tfRJbeiQY8BDrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170197; c=relaxed/simple;
	bh=wKdCzd6BnmptS+QJnboMGafnedP7woLGUI8aYnsac7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnBTV34TL+IlvqAlhdkeMkRZksHu/OttDizcdpo5uLNQKRMNPnZZyCYeZtiV4x+9rcavGzWBdI9Yd72sFHyBu0xrrcA3JhFKcGVjIS+FNAnqem3gLPgXzXer+4oe9DqxhtCqVUm7DRgpg6Z1yz2ricd6hlMaR2sebuPPT0TXB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skhuymnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E6DC43390;
	Mon, 11 Mar 2024 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170197;
	bh=wKdCzd6BnmptS+QJnboMGafnedP7woLGUI8aYnsac7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skhuymnT6wj0znfcfZZjkDOn+WslqtCW0qO5oNlgmTe0NuIz2Ak8RXXdmmUWD0dpQ
	 mlXO4OJe2n0e9c2PsgHiGa1ZkK+FcVhzT4SdRcuTnVjsgpkdBFV7GRXyPq/YQM+kCG
	 OpAH/PdbM5pYT3/1emuYP0y5VuyWLFhY4gbAUcN/dmIxkSXUFVGCkf2W0d0wjIpM/Y
	 IGVSDq1VYhiEqkwaYw2GrVK9FU/JrdKamPiF48Fe6O/nCIDGLgwkP0yPvVfYBqVljg
	 klMql6cJ4UlYQuECxe2mAV0/BMJ6iHihVFufryZJr2diUfcmtI5p9CnM9/nL5lYNpP
	 JvZKQgcO8Mlrg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rjhOK-0000000056X-3qz4;
	Mon, 11 Mar 2024 16:16:40 +0100
Date: Mon, 11 Mar 2024 16:16:40 +0100
From: Johan Hovold <johan@kernel.org>
To: regressions@lists.linux.dev
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: drm/msm: DisplayPort hard-reset on hotplug regression in 6.8-rc1
Message-ID: <Ze8gWHK2ipXIHRAP@hovoldconsulting.com>
References: <Zd3kvD02Qvsh2Sid@hovoldconsulting.com>
 <ZesH21DcfOldRD9g@hovoldconsulting.com>
 <56de6cfb-fe0f-de30-d4d0-03c0fbb0afbb@quicinc.com>
 <ZeyOmJLlBbwnmaJN@hovoldconsulting.com>
 <Ze8Ke_M2xHyPYCu-@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze8Ke_M2xHyPYCu-@hovoldconsulting.com>

On Mon, Mar 11, 2024 at 02:43:24PM +0100, Johan Hovold wrote:

> So, while it may still be theoretically possible to hit the resets after
> the revert, the HPD notify revert effectively "fixed" the regression in
> 6.8-rc1 by removing the preconditions that now made us hit it (i.e. the
> half-initialised bridge).
> 
> It seems the hotplug state machine needs to be reworked completely, but
> at least we're roughly back where we were with 6.7 (including that the
> bus clocks will never be turned of because of the rpm leaks on
> disconnect).

#regzbot introduced: e467e0bde881
#regzbot fix: 664bad6af3cb

