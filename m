Return-Path: <linux-kernel+bounces-133074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A91899E6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0BB287BFC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECBA16DEA8;
	Fri,  5 Apr 2024 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WPouFyde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870132E401;
	Fri,  5 Apr 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324074; cv=none; b=P99BbPmPg6L77dQU7Aq2rDybSz0Ud3oKXErdo+e24rpEF+Y9RIBryF3RHcLNoitpuGGwueq/cF+4hsb76zsH2qe0RlRL9lsjVVttDNtX5nXGoML0/FB1BYM5MAHzj+PErvPW3o8pYNQIbQqK1yjr3rGvm9gU+ZnR5nwTwJyDBsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324074; c=relaxed/simple;
	bh=SHjwBnomV+gF9BLymsPmd0cih8P9zBHkIagsuETR9I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CniwXBu3DPC1pZNretUZNpxqlogJ1d4bJlhXxrGiWsKTW7OsvD3pqOctZUoHDIJfU2UUfDGuBhZOyrNDMuSgZFNEwQFb/5aROnCpwJM+QwccBM5i8N1mASUcw6yBZWboX+d8PnCvcTOvleqHa6omwPb5vlZceWpVeDTK75xYABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WPouFyde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89E2C433C7;
	Fri,  5 Apr 2024 13:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712324074;
	bh=SHjwBnomV+gF9BLymsPmd0cih8P9zBHkIagsuETR9I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPouFydeq4lV+Y0xFxUhvTsLfA8DLxUGy5BJZ137GlWxh5WGH5cUqjTkSlKyrQTxn
	 4fDzrljELByplixrq++TRfx4p25kZVe1RgtxcrsqfOkd5ClOOlz7QMGVcaMn7FJBvS
	 oPi/USSpWR6GYkypD/fe5yLtiAjkx8tjfSHgtMk8=
Date: Fri, 5 Apr 2024 15:34:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [regression] 6.8.1 and 6.7.12: fails to hibernate with
 pm_runtime_force_suspend+0x0/0x120 returns -16
Message-ID: <2024040512-defective-wreckage-f202@gregkh>
References: <2325246.ElGaqSPkdT@lichtvoll.de>
 <6034738.lOV4Wx5bFT@lichtvoll.de>
 <12413606.O9o76ZdvQC@lichtvoll.de>
 <12414153.O9o76ZdvQC@lichtvoll.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12414153.O9o76ZdvQC@lichtvoll.de>

On Fri, Apr 05, 2024 at 02:11:11PM +0200, Martin Steigerwald wrote:
> Martin Steigerwald - 05.04.24, 13:54:34 CEST:
> > > Not doing it today or probably the weekend, but now I have some
> > > actionable git bisect plan without bisecting between major kernel
> > > releases which as I have been told between 6.7 an 6.8-rc1 can lead to
> > > non working modeset graphics on AMD Ryzen in between.
> > > 
> > > It seems now I only need to git bisect between 6.7.11 and 6.7.12 to
> > > find the patch that breaks hibernation on 6.8.1 as well. However
> > > first I will briefly check whether 6.8.4 hibernates okay.
> > 
> > 6.8.4 is still affected and fails hibernation with the same error
> > message.
> 
> Both kernels also fail to reboot the machine. Runit says:
> 
> - runit: system reboot
> 
> And then nothing anymore.
> 
> It is not just hibernation.
> 
> I think ThinkPad T14 AMD Gen 1 or similar systems with Linux are not that 
> rare. I am surprised this is not hitting more people. Well maybe it does 
> and no one reported it here.
> 
> Well let's see what happens when 6.7.12 hits distribution kernels.
> 
> Anyway, I have an actionable git bisect between 6.7.11 and 6.7.12, just 
> not today. Maybe beginning of next week.

6.7.y is end-of-life, I wouldn't worry too much about it, there's
nothing we can do about it anymore, sorry.

greg k-h

