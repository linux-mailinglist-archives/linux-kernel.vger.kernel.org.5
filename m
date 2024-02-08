Return-Path: <linux-kernel+bounces-58492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EDA84E721
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C82FB2E94C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC7283CD1;
	Thu,  8 Feb 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLCHoYZu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788FB7B3C2;
	Thu,  8 Feb 2024 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414560; cv=none; b=uueJL2vDInCBX+J25cgyOKdRT5OZUlP8qvORbEkw/FhAGy8Qjyx8lVu0lGZFPEuXVAukWXpEq2D0ai3zfmzGkaFYDmCbGaU/4TyEYXIl29zkiFsYypgT15YugOZrFEwGTXMiLAU5NDZImEXM9m0aEl1QlvZGaSZRjtoclR9AgOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414560; c=relaxed/simple;
	bh=cUlzWJZIGqNIKI5dwygE++YzgRhCS9mE4C/8W+hc7no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IH6atazC00QCeb1UObIguDRDk25hWlcSCZVl9YiV81TnNfyg4SZGSHUopp7+sh+YO6BD01Y4+DDfo7dEU6bRYwwXKk2eBMROsdcCbXqkplY4s4G6YdDUgRoN1ApaUp/9jwibi8eOWlSIBABN17s1CvPeYYJUrK9YyTwcc2iVoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLCHoYZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A38C433F1;
	Thu,  8 Feb 2024 17:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707414560;
	bh=cUlzWJZIGqNIKI5dwygE++YzgRhCS9mE4C/8W+hc7no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLCHoYZuLz/ZxYoFOli5AfVt6L6NAnEQ4hUKl6INUpMysLLhpAre0tt/mOAHV/p/e
	 j6brqfNgPy5HSnrk0e8sSOsYfNif7vS/nUdTja81IihfnJZ/eGK1QCbmzxuhgE3Ovc
	 fNdONplRH+8ICQc2cTt7X2gJdqsPqfDG1ovdLRmeCd7ZiuqIdwotqdYMi+d6JXwTnE
	 8A+geo+EgJku3OA9irYAZkhTmpOVLpZj3Rh4Oyk81L1VzIORM6qfwbqQGbbDjaxLkF
	 zm6LdpP/7lA9vGtXEpayDPD0YP3NK+PT8ejR2bEMQ9Hc3y3Hv4dIIEaLBCPmy7YP+G
	 zNkFr8ldPRSBA==
Date: Thu, 8 Feb 2024 17:49:12 +0000
From: Lee Jones <lee@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Adam Radford <aradford@gmail.com>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	Andre Hedrick <andre@suse.com>, de Melo <acme@conectiva.com.br>,
	drew@colorado.edu, Finn Thain <fthain@linux-m68k.org>,
	Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Joel Jacobson <linux@3ware.com>,
	John Garry <john.g.garry@oracle.com>, linux-scsi@vger.kernel.org,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	"PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
	Richard Hirst <rhirst@linuxcare.com>, support@areca.com.tw,
	Tnx to <Thomas_Roesch@m2.maus.de>
Subject: Re: [PATCH 00/10] scsi: Replace {v}snprintf() variants with safer
 alternatives
Message-ID: <20240208174912.GZ689448@google.com>
References: <20240208084512.3803250-1-lee@kernel.org>
 <c9129b08-50fb-4371-aa05-6f6c7cd7acfa@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9129b08-50fb-4371-aa05-6f6c7cd7acfa@acm.org>

On Thu, 08 Feb 2024, Bart Van Assche wrote:

> On 2/8/24 00:44, Lee Jones wrote:
> > Cc: Andre Hedrick <andre@suse.com>
> 
> Please take a look at https://lwn.net/Articles/508222/.

get_maintainer.pl pulled it from here:

https://github.com/torvalds/linux/blob/master/drivers/scsi/3w-xxxx.c#L11

I like to involve the people who take the time to list themselves as
authors.  I guess these are likely to go out of date at one point or
another, especially in such a long standing subsystem such as SCSI.  Not
as big of an issue in NFC!

-- 
Lee Jones [李琼斯]

