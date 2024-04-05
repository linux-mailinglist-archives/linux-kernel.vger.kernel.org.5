Return-Path: <linux-kernel+bounces-132744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4EE899984
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E612827BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF3416078D;
	Fri,  5 Apr 2024 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f3KxCRgU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C54F142E73;
	Fri,  5 Apr 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309603; cv=none; b=e4LEbAAGjfRCjkYZE66EhCuqfoPS+IKmjJhZjBgsuMslqYIqHZwgh7Up6/Q47xXsMInnWME4KWKx5KSW/Z0UAWAO/vXvdGkSFTyOBdab+/q0NmHEA25fcdYLaLg2nVVAbVYYt3UdyJ68wROzSgJy4jwS7ISLREV6lwhp79qw+gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309603; c=relaxed/simple;
	bh=WTZoAjTOwh9BcVL0bHX8/oS3W4NlAY1M3zbmL2DAUDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0lhmq/EB4kbf3v2xDZ0JzS7M6Lv/Y4nRz4JZk0KdsFqChicJxacZIjjlvG1n8KWZ2WSfo18hRvqJ00EEZL7MSAu7kGoEU0mL7a5D7Q/8X2vKrAvy+531Oq0nsVOncY/5vqT/y3CoFEDeINQSQujBgI2v072aUsOUB/4apVfuwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f3KxCRgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99742C433F1;
	Fri,  5 Apr 2024 09:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712309603;
	bh=WTZoAjTOwh9BcVL0bHX8/oS3W4NlAY1M3zbmL2DAUDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3KxCRgUhWMWNdsWwsFPC+QAepS8hH1PU3YsLykzXkwKxNTdqG/pL64Oz8aTAb9/n
	 ByaPe+LWd64msgPjQu3Dt/GWeGLOrmQM0z8mzTMc8p0vLN8TOs8zCSzPwp4ZNo59Dd
	 R/0haKU/emEUIawYN/RFmQfeE/zFaIdorr28MR9A=
Date: Fri, 5 Apr 2024 11:33:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	ye.zhang@rock-chips.com, d-gole@ti.com, rafael@kernel.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [STABLE 5.15][PATCH] thermal: devfreq_cooling: Fix perf state
 when calculate dfc res_util
Message-ID: <2024040558-defection-shadily-1879@gregkh>
References: <20240404101329.1956664-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240404101329.1956664-1-lukasz.luba@arm.com>

On Thu, Apr 04, 2024 at 11:13:29AM +0100, Lukasz Luba wrote:
> From: Ye Zhang <ye.zhang@rock-chips.com>
> 
> The issue occurs when the devfreq cooling device uses the EM power model
> and the get_real_power() callback is provided by the driver.
> 
> The EM power table is sorted ascending，can't index the table by cooling
> device state，so convert cooling state to performance state by
> dfc->max_state - dfc->capped_state.
> 
> Fixes: 615510fe13bd ("thermal: devfreq_cooling: remove old power model and use EM")
> Cc: 5.11+ <stable@vger.kernel.org> # 5.11+
> Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> 
> Hi Greg,
> 
> I have solved small backporting conflict to that v5.15.
> The patch is based on tag v5.15.99 and it's for this
> failing backport:
> https://lore.kernel.org/stable/2024033050-imitation-unmixed-ef53@gregkh/

Thanks, next time all that I need is the git id of this in Linus's tree,
no need to point to a previous FAILED email.

now queued up.

greg k-h

