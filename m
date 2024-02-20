Return-Path: <linux-kernel+bounces-72513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4FD85B493
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D136D282249
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30F75C600;
	Tue, 20 Feb 2024 08:09:24 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CCB5C5E5;
	Tue, 20 Feb 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416564; cv=none; b=Skn/oMLc84mKXtOZFi0zAo2asTQw9bWX1YfU2pPQkKM2GQJ0TZmEIEO1CLTj/0/6YHWlgInMmA1W7kwwTJd9mtWKFsgypD0Y0ppdiRs+0iyQerZj/S7GE2emd/haxKs3Yf7/VgPPHwI++uDGb2xZ2Ec6GLxhSPHm65bVcG0q3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416564; c=relaxed/simple;
	bh=nX2AD5Yn46v4roqbEyYbgRuT5aKw1JyhcTzpsdhhXNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8yccynMa+97w5PNJXTj5wvXg+T2YN4yHGM8wcEM3JiQDI+Mga3718rRc7WUbgSEv0XhaLLQK3bZETqR/DEIR0+N69YHoBGIu/4s/Xb5zhvDM//2tYV+yOjBJsLIs3J5JkvGLZnqpS0saK8Zx3XOfXuSeURbxNF8olmXgQEkvRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D5EB168CFE; Tue, 20 Feb 2024 09:09:17 +0100 (CET)
Date: Tue, 20 Feb 2024 09:09:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linan666@huaweicloud.com, axboe@kernel.dk,
	Christoph Hellwig <hch@lst.de>, "yukuai (C)" <yukuai3@huawei.com>,
	linux-raid@vger.kernel.org, song@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] block: fix deadlock between bd_link_disk_holder and
 partition scan
Message-ID: <20240220080917.GA13056@lst.de>
References: <20240207092756.2087888-1-linan666@huaweicloud.com> <d7456326-ebb1-fc4a-9071-bf7083191211@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7456326-ebb1-fc4a-9071-bf7083191211@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 19, 2024 at 04:53:36PM +0800, Yu Kuai wrote:
> Can you take a look at this patch? I think for raid(perhaps and dm and
> other drivers), it's reasonable to suspend IO while hot adding new
> underlying disks. And I think add new slaves to holder is not related to
> open the holder disk, because caller should already open the holder disk
> to hot add slaves, hence 'open_mutex' for holder is not necessary here.
>
> Actually bd_link_disk_holder() is protected by 'reconfig_mutex' for
> raid, and 'table_devices_lock' for dm(I'm not sure yet if other drivers
> have similiar lock).
>
> For raid, we do can fix this problem in raid by delay
> bd_link_disk_holder() while the array is not suspended, however, we'll
> consider this fix later if you think this patch is not acceptable.

Yes, not taking open_lock here seems reasonable, open_lock or it's
previous name has always been a bit of a catchall without very well
defined semantics.  I'd give the symbol a blk_ prefix, though.


