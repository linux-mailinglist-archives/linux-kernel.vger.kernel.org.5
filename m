Return-Path: <linux-kernel+bounces-92416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F3871FDF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94709B2333B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C718186644;
	Tue,  5 Mar 2024 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kStBfToD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6DA86625;
	Tue,  5 Mar 2024 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709644579; cv=none; b=gz0OGx8DtzPntBfMVyTSVx1QQCLLOtkyY7Zldr+m1ixDddO1Zgrm63/8faEwt3fgvNdYA8p15Mi+o/DZcBWr3BslphDF4yuINXABC4PvX1ocWPJh5i0b23RQuv56O95gcNed3JPq+59Xge5YppgCx7MIlRcrQ2LWf8aBFuqurOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709644579; c=relaxed/simple;
	bh=5sElae9tQ+FI4lIl70w7P9zchWqrOrXz+Biq7MEh7cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va7KjgQlOZGPpv4jDXIeq7RNS6WQU05CcO8zQL8pyh87+KVWz3Ntd2s3nHuEALVgg6iaI1ikmETavFBaTZwbI1a0A8q33xyWEkNkXTr366qkXj6qlZgjDuM2370kpxkRCCVokQJeCP050n50ygDM3ksywL+zGBA8itIGJPy1qZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kStBfToD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AC3C433C7;
	Tue,  5 Mar 2024 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709644578;
	bh=5sElae9tQ+FI4lIl70w7P9zchWqrOrXz+Biq7MEh7cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kStBfToDIR1Mgg2FIJStala23fjYmg+oFH240bxJQrv+9J76hPm/qRD6Chica7QE9
	 0satWFmaWY7FYr+hsdyyODGHETMmDHImibhRa3H7J6WPti/znSV1Gu3s1JOyF0RwYY
	 L7BwZ3P28xzb7apy5yI04YNx4fR4Y4gxOFsoV9Yc=
Date: Tue, 5 Mar 2024 13:16:14 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: rui.silva@linaro.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, Xiongwei.Song@windriver.com
Subject: Re: [PATCH] usb: isp1760: remove SLAB_MEM_SPREAD flag usage
Message-ID: <2024030555-turbojet-headscarf-e26e@gregkh>
References: <20240224135256.830413-1-chengming.zhou@linux.dev>
 <e7f00fbe-a676-4d47-b1bb-cc69cc391172@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f00fbe-a676-4d47-b1bb-cc69cc391172@linux.dev>

On Mon, Feb 26, 2024 at 11:02:24AM +0800, Chengming Zhou wrote:
> On 2024/2/24 21:52, chengming.zhou@linux.dev wrote:
> > From: Chengming Zhou <zhouchengming@bytedance.com>
> > 
> > The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> > its usage so we can delete it from slab. No functional change.
> 
> Update changelog to make it clearer:
> 
> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
> removed as of v6.8-rc1, so it became a dead flag since the commit
> 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
> series[1] went on to mark it obsolete to avoid confusion for users.
> Here we can just remove all its users, which has no functional change.

Please submit a version 2 with this updated changelog.

thanks,

greg k-h

