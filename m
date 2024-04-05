Return-Path: <linux-kernel+bounces-132795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE54899A5D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547B01F23702
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583A916190F;
	Fri,  5 Apr 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GiHp6HYk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8555F15FCE0;
	Fri,  5 Apr 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311801; cv=none; b=scppUemjeOEAlXKcm68SAH1TU5F80knb48Kej/DBVDXhbw2sJ+ALkEFEG8C7I1HcK1UYao0IcrC9qlfAG8XAtTcyxL8GOlSGVdKLaOAnPX3Nttyg3GlnS4+ViKbfQPRXgqi/cIPUgbGX/ud0WXogUoBtvu0PlXbytpaM5unMDq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311801; c=relaxed/simple;
	bh=ix0s/bluTe6gLu0m77aaguOcqppxByEHmYUIwuPl+Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jewPfMlP/bRGzGCH0m09gZ749TCq5nplCiThdMGbuCc1S8GRb3LP+9vSuiooU3nFq/zHUlIwWNVeUVHbtnoCDc6eT0eA9yPBWkdYz7Q8EliHWWz8tL//fW4VeQUvOTNL1lg9MceLIZzuiMYHUQ08MyKXe9+eCvNVMXRhyvuOZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GiHp6HYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0D4C433F1;
	Fri,  5 Apr 2024 10:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712311801;
	bh=ix0s/bluTe6gLu0m77aaguOcqppxByEHmYUIwuPl+Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GiHp6HYku6CxT/MWuytSUrypoWCMit0na8GMfPqJKZeD4O+/wZBIFOhL3vXQxVjeW
	 xLdeYF2RGmTWOZKj7OaJSsGDcNsL1CPU0wNq/95hmjkB3kMFZmfzms/tNA2wZw1GDI
	 L1F+MvH7GZM9j4brRjKbNWtl5+fUssEcfakizY54=
Date: Fri, 5 Apr 2024 12:09:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Shahar Avidar <ikobh7@gmail.com>, linux-staging@lists.linux.dev,
	kernel-janitors@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Felix N. Kimbu" <felixkimbu1@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v3 5/7] staging: pi433: Remove duplicated code using the
 "goto" error recovery scheme.
Message-ID: <2024040546-crudely-demanding-c13a@gregkh>
References: <20240405074000.3481217-6-ikobh7@gmail.com>
 <12a5180c-fbac-41dc-b1bf-9eded9d8c5ed@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12a5180c-fbac-41dc-b1bf-9eded9d8c5ed@web.de>

On Fri, Apr 05, 2024 at 12:05:56PM +0200, Markus Elfring wrote:
> I suggest to use the summary phrase “Use common error handling code
> in pi433_init()” instead.
> 
> 
> > pi433_init had "unregister_chrdev" called twice.
> > Remove it using goto statements.
> 
> How do you think about to use the following change description?
> 
>    unregister_chrdev() was called in two if branches.
>    Thus add jump targets so that a bit of exception handling can be better
>    reused at the end of this function implementation.
> 
> 
> …
> v2->v3:
> …
>           a seperate patch.
> …
> 
> Would you like to avoid a typo here?
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

