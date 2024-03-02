Return-Path: <linux-kernel+bounces-89355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769D286EF4C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 08:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5201F2353C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 07:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC44125D7;
	Sat,  2 Mar 2024 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDUBl1M5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3D11724
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709365736; cv=none; b=iuiH4dIpxSy7XEvHulhQTK4g1MU4zx9ItZocessl6cI4GYttRNHALao0YpjU4C/5TmjVcs1lQRTBdYZ23puRC0BhkuiQZYhHrFLxlp9To6gIhOli0nT+gPTgSvo9IMprAaEWGzL1jyWAn9LXKZMAVpKL/ZCuKeGmeF8AILk+5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709365736; c=relaxed/simple;
	bh=TOmAj42S1SC0gXibQSRZTpZCMLTUiIkWf0MokO/SOLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym1zG/lUlrraYYpJuMylrNChrg2GWVNkTQ2NIGPVFLdh4L8sp7+Bjmfu1H5EWYT0iclbnSUCg7V2Y7zKV+YyabsGKiLzjKz8DN0xVqN7pxcFLvIIYbaG4rkYX/w4ku1nktf3yBxJJx0TTI315Vs2TZ21ZJgWIx37ZLXNfWKSJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDUBl1M5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA88C433C7;
	Sat,  2 Mar 2024 07:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709365735;
	bh=TOmAj42S1SC0gXibQSRZTpZCMLTUiIkWf0MokO/SOLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDUBl1M5CS5nP6L+5fgC6r9oiINchHNLMCKTAG9h8Bmu17F8dHpflXVX5uBfV1iJg
	 /UXkuxx2xY23grUcJdGbcEHFtbkgGtr5if1J8i8RG+G7DnABSkVJhBW5JXm86N8PyM
	 qcLLOZ0eCnQgL4A1hsRCGKbW7vo67qUo7ut2TVViO9fyxGyeEH8cncABXj3yFV/HTj
	 Hl+jCO5pRnLmJnPvNxXccynxJzLrdw17RzksqgsZKx/w/2uQBSrJdz50JN/Y1zzp8G
	 Rexj5zBVCBYolDxDibuuE5grFXXZGC7lN7OjmCYBAmUWtvz5NcLuucCubd4H5uqolG
	 vyA1dsMIaFdlQ==
Date: Fri, 1 Mar 2024 23:48:53 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 4/5] misc: mlx5ctl: Add command rpc ioctl
Message-ID: <ZeLZ5UOVgVdVlFBD@x130>
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207072435.14182-5-saeed@kernel.org>
 <c8bc7435-518f-45a6-b2b8-8e7f4410438b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c8bc7435-518f-45a6-b2b8-8e7f4410438b@oracle.com>

On 29 Feb 12:49, Vegard Nossum wrote:
>
>On 07/02/2024 08:24, Saeed Mahameed wrote:
>>@@ -328,6 +420,11 @@ static int mlx5ctl_probe(struct auxiliary_device *adev,
>>  		goto abort;
>>  	}
>>+	err = sysfs_create_link_nowarn(&mcdev->miscdev.this_device->kobj,
>>+				       &mdev->device->kobj, "mdev");
>>+	if (err)
>>+		mlx5ctl_dbg(mcdev, "mlx5ctl: failed to create sysfs link err %d\n", err);
>>+
>
>Should this propagate the error to the caller?
>

this link is informational only and not necessary for the driver function,
it meant to help user-space apps to associate mlx5ctl driver with it parent 
mlx5_core device.

>What happens if/when mlx5ctl_remove()/sysfs_remove_link() gets called
>later for this kobj?
>

sysfs_remove_link() will eventually call kernfs_remove_by_name_ns()
and it will return -ENOENT; if not found, and it will be silently dropped.


