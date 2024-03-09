Return-Path: <linux-kernel+bounces-98013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFA1877352
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC313282041
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD90545974;
	Sat,  9 Mar 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InsMuuly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE2ABA4D;
	Sat,  9 Mar 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009531; cv=none; b=u6kcn3kjai58GuSIezfyXh57jOtphn7ry0v7nEvBGpFG7rBo+ncRm/is6jPw31QSXTVVm7pyST3jjDl2oOH/+s5L5tFaTg3SstBnZO/SGW7OE164EXc+gyo5oAHMVTPO76AUP80SQ+tXNnE2GtLDx2JFfSm53cUxcWeNYaJkhC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009531; c=relaxed/simple;
	bh=4ntHYRxfbVXWtvp7sm4y9pGUhPND6R1s74zi0Qyr1gM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opc8InRX+XgolWIMiu8BLYfTJ88h9Lqy2g5NiYzsqqswjMwBkVxPpyf9JJJlJjQ+/3Iota4jVgCSSIVwooFvxiXq/gdfZEZ9OzXCDqYjDZ1UeFwaav0GEYUWP5zX7uHmWWTQa9+Jhy+cIVQwaA4QJy5ddPgVybK17ivYwJkOwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InsMuuly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F8FC433F1;
	Sat,  9 Mar 2024 18:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710009530;
	bh=4ntHYRxfbVXWtvp7sm4y9pGUhPND6R1s74zi0Qyr1gM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=InsMuulyiAekko8mFliFdpIZVPM6feY9vzIP/VFHAnnv5m/kiLIYAYAPYw+57NdpA
	 72ujc8irB2iYdNn05Wd++MAg/j8OCjZp0qYWa/6vdkks5FgypkC0KmfjWAOIIpKmtY
	 3x4MotK5uQtkJQeMFABJi42ucZ3gYJNaMezt7cQjG2xJHB6gHzdibAd2u2QpRpM/pf
	 1gpljMskF9KHAKLr1jSgdKDLIz2fNDB/jjuQxbGxLi08cVDCMEm/XDVqgR1r7cnyYx
	 LKpCKhJpfy8+gKWdODHfzfSBwGelbP3152NJFpB/H2D2hBsFvDGryVzIngMBzJFsEj
	 3KVOdPNa5CuVw==
Date: Sat, 9 Mar 2024 18:38:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH v1 0/2] iio: core: Fix and cleanup to iio_device_alloc()
Message-ID: <20240309183839.4953914a@jic23-huawei>
In-Reply-To: <20240304140650.977784-1-andriy.shevchenko@linux.intel.com>
References: <20240304140650.977784-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 16:04:31 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This is an exctract of the two patches from 
> https://lore.kernel.org/r/20240228204919.3680786-1-andriy.shevchenko@linux.intel.com
> 
> In v1 (extract):
> - removed unneeded 'else' branch (David)
> - fixed typo in allocation cleanup (David)
> 
> Andy Shevchenko (2):
>   iio: core: Leave private pointer NULL when no private data supplied
>   iio: core: Calculate alloc_size only once in iio_device_alloc()
> 
>  drivers/iio/industrialio-core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 

Applied to the togreg-normal branch of iio.git which I'll rebase on rc1
once available and push out as togreg.

Thanks,

Jonathan

