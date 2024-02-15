Return-Path: <linux-kernel+bounces-66385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAED855BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0050B2931E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252B811713;
	Thu, 15 Feb 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iHl+L19V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4D33CF;
	Thu, 15 Feb 2024 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984424; cv=none; b=eYNOGw57wS2nhyFFSJHpA1Vapooud/kkcQXGjXMXp3cQwwen0fYcNWO+9iVs4i1/BiIisyZVcAN83d292FSm7+18qWcjOolEM/ByRo8zGJDeu6+WNh+9D0fKVWHq1aXIpL+fXZHBiXMML97xYx8l4qesR5hshAf6ILHaNb76cd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984424; c=relaxed/simple;
	bh=1f7rP1QogMvRWMxoLXoMIvoz1PjKs9oP2HNlZ1xGuQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD90Gou9ZhJiOdhcdyAojpHywTgAgF/6yCFnKzgVsa3kog2AUDPkTZ+TQKSleOXbfn/47GTt7vecHWc5ggY8CepLvVjYEAJ3XNERMB90EB2vqPFMqXqHfHV/YXCSz+fT7cIez6e58ivv3M6h0cK4Qfnc3We9J7csgcwmRjx+oE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iHl+L19V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1F0C433F1;
	Thu, 15 Feb 2024 08:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707984423;
	bh=1f7rP1QogMvRWMxoLXoMIvoz1PjKs9oP2HNlZ1xGuQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHl+L19VPMG0RTdD3H3BE5efs0RMB8LlYat3dMwouUbN9EnrJXigfAP77qWj2iN/F
	 BYAEfEiZaKWK53faL0ecFVwkPW1COsczdnVgFmWfB7v/0pPYrlERk267a5eoqh+IKl
	 IMDK6bWkVS1X6WAn5/cBsKmp+9eJ5NxF1NymXTWg=
Date: Thu, 15 Feb 2024 09:07:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>
Cc: 'Ulf Hansson' <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, avri.altman@wdc.com,
	grant.jung@samsung.com, jt77.jang@samsung.com,
	dh0421.hwang@samsung.com, junwoo80.lee@samsung.com,
	jangsub.yi@samsung.com, cw9316.lee@samsung.com,
	sh8267.baek@samsung.com, wkon.kim@samsung.com
Subject: Re: [PATCH] mmc: sd: Add a variable to check a faulty device
Message-ID: <2024021528-fretted-sustainer-2ebc@gregkh>
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
 <20240213051716.6596-1-sh043.lee@samsung.com>
 <CAPDyKFrjZ4jRHAfXsvrEvezuHTxbA3SAniF8CuObyLuW=AUoeA@mail.gmail.com>
 <000001da5faa$d34e1600$79ea4200$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000001da5faa$d34e1600$79ea4200$@samsung.com>

On Thu, Feb 15, 2024 at 10:03:45AM +0900, 이승희 wrote:
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Wednesday, February 14, 2024 8:27 PM
> > To: Seunghui Lee <sh043.lee@samsung.com>
> > Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > gregkh@linuxfoundation.org; avri.altman@wdc.com; grant.jung@samsung.com;
> > jt77.jang@samsung.com; dh0421.hwang@samsung.com; junwoo80.lee@samsung.com;
> > jangsub.yi@samsung.com; cw9316.lee@samsung.com; sh8267.baek@samsung.com;
> > wkon.kim@samsung.com
> > Subject: Re: [PATCH] mmc: sd: Add a variable to check a faulty device
> > 
> > On Tue, 13 Feb 2024 at 06:13, Seunghui Lee <sh043.lee@samsung.com> wrote:
> > >
> > > In mobile devices, suspend/resume situations are frequent.
> > > In the case of a defective SD card in which initialization fails,
> > > unnecessary initialization time is consumed for each resume.
> > > A field is needed to check that SD card initialization has failed on
> > > the host. It could be used to remove unnecessary initialization.
> > 
> > It's not clear to me, under what circumstance you want to optimize for.
> > 
> > Is the SD card ever getting properly initialized during boot?
> > 
> > Kind regards
> > Uffe
> > 
> We receive a lot of reports about SD card issues in the market.
> There was no problem with the first time at the time of use, and there are many cases where people recognize that it is not recognized later on. In most cases, this is a problem with the SD card itself.
> 
> SD card users cannot determine whether or not an SD card is a problem, so they should be guided in this regard.
> It is necessary to distinguish whether the SD card is inserted but unrecognized or the SD card itself is not inserted, and if there is a field that can check for initialization failure, it will facilitate guidance, so we considered the patch.
> 
> The variable's usage is expected to be used through the sysfs node in the vendor module.

What "vendor module"?  You need to include all of the needed code here
please.

thanks,

greg k-h

