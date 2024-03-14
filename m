Return-Path: <linux-kernel+bounces-103517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F6C87C080
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44511C21439
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B720F71B5E;
	Thu, 14 Mar 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yp5kedXY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65471B3C;
	Thu, 14 Mar 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430729; cv=none; b=H7CnK1EPKoiyodkXb1p0qHpE1u9zhS81cTdoJJvA0fp/RxSS0K8YMGqyCac8fXZfBA0ySqhfvw7q7T1If08e1bDfjPPL8dUG4KYYg1H49KdeOfLVyrhGWCz8Z9OcRmnN4oa18ttnJsqdSdDGWuk4JegqHDpTNmJv/Y8ZIHX5c3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430729; c=relaxed/simple;
	bh=25+oSLohufS1F0hk5bKd4qAm5WyyDeaKDIKZc6a6dso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvR+6taQT+39n/dQtpxA3JLSpzuvCAlEKGxl7pOM+CZrL9fT/FvZbKUq/hiQxdwv+iC3X/r8Ub3s0VGIiE16t3dwJmvfJHPcIE8t8u/u0IRr3Pj5dvQArEFPqvyM9ifcJHnKU9CDZ36HnNV/ozQQQOjKC5UYYzR3ze83fDaqHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yp5kedXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A57C43394;
	Thu, 14 Mar 2024 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710430728;
	bh=25+oSLohufS1F0hk5bKd4qAm5WyyDeaKDIKZc6a6dso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yp5kedXYYCIMShry1VN9jsQW/CFeU+w1qtrlziM5ZKyHxwSjEuuCvt6hwBF1JENVo
	 dZZTTGwj3sbXmZMiYNNoPRGKOQOw+OgavxWafov5UUWk9c8rfOgvoOzujzjI7YaGB5
	 Tr6L6STszeeFgcYOZMuWdN8E6iGFvb5R1nUlLMXTqylPee3tTL8qFkR52TmP1T9ZVD
	 nsgzxyULjLWBluX8aMubceiUFbR/yYvSOL70nFj1QniC/zWhrjIpWCWJZp01yU5upl
	 Tugmlmv6LZHqEv05fz2U+Y/uIvhvUVrOG9MyrTnL9Ietm1i10D3FlOe96KxihiUgM3
	 RwKTCz39BeOiw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rknAW-0000000050R-1nFB;
	Thu, 14 Mar 2024 16:38:57 +0100
Date: Thu, 14 Mar 2024 16:38:56 +0100
From: Johan Hovold <johan@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	dri-devel@lists.freedesktop.org, swboyd@chromium.org,
	quic_jesszhan@quicinc.com, quic_parellan@quicinc.com,
	quic_bjorande@quicinc.com, Rob Clark <robdclark@chromium.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: move link_ready out of HPD event thread
Message-ID: <ZfMaEIzv3Z3ny3y0@hovoldconsulting.com>
References: <20240308214532.1404038-1-quic_abhinavk@quicinc.com>
 <ZfApxyVAJMK4bL8O@hovoldconsulting.com>
 <ZfCFsmNv62-KMkA6@hovoldconsulting.com>
 <ZfCKDGq9n9WG3Quj@hovoldconsulting.com>
 <8e125a99-543d-8328-a2a9-100e223e4faf@quicinc.com>
 <ZfFhXG5yd6O29spS@hovoldconsulting.com>
 <ec2cba17-5644-6cf6-f6c9-d37d7ca56204@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2cba17-5644-6cf6-f6c9-d37d7ca56204@quicinc.com>

On Wed, Mar 13, 2024 at 10:24:08AM -0700, Abhinav Kumar wrote:
> On 3/13/2024 1:18 AM, Johan Hovold wrote:

> > Right, but your proposed fix would not actually fix anything and judging
> > from the sparse commit message and diff itself it is clearly only meant
> > to mitigate the case where user space is involved, which is *not* the
> > case here.

> There can be a race condition between the time the DP driver gets the 
> hpd disconnect event and when the hpd thread processes that event 
> allowing the commit to sneak in. This is something which has always been 
> there even without pm_runtime series and remains even today.
> 
> In this race condition, the setting of "link_ready" to false can be a 
> bit delayed if we go through the HPD event processing increasing the 
> race condition window.
> 
> If link_ready is false, atomic_check() fails, thereby failing any 
> commits and hence not allowing the atomic_disable() / atomic_enable() 
> cycle and hence avoiding this reset.
> 
> The patch is moving the setting of link_ready to false earlier by not 
> putting it through the HPD event thread and hence trying to reduce the 
> window of the issue.

Perhaps I'm missing something in the race that you are trying to
describe (and which I've asked you to describe in more detail so that I
don't have to spend more time trying to come up with a reproducer
myself).

I do understand how your patch works, but my point is that it does
not fix the race that we are hitting on sc8280xp and, unless I'm missing
something, it is not even sufficient to fix the race you are talking
about as user space can still trigger that ioctl() before you clear the
link_ready flag.

That's why I said that it is only papering over the issue by making the
race window smaller (and this should also be highlighted in the commit
message).

For some reason it also made things worse on sc8280xp, but I did not
spend time on tracking down exactly why.

Johan

