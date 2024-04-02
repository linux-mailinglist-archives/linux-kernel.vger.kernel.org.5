Return-Path: <linux-kernel+bounces-127939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A055895306
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1529E2845F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9CE77F1B;
	Tue,  2 Apr 2024 12:32:52 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00DBE5E;
	Tue,  2 Apr 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061172; cv=none; b=fRuPe5B2HwExyqrhCddhpEcPUVeOqolB/SgBMYEG4/MtuuWUtt0mWCxkjl75BaoqicdXrBBV3DW0BZwu6G1A2ZZkmJdzC91+NbMxb10j0n4qh6t4WaGrpgfpZ3qMbQsmFOA4DEFg0sN137V6Sz8KQaOJjXS4sYbWMgtGgCVzFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061172; c=relaxed/simple;
	bh=EF+pfA2s6/ljbgmB3ahm9kK8A//PomYrR0CeWBdwCL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI2jPcrEEDJTHKxZijG8PFpgIb7WJrEbz4/J6NY84nk1H3ssJckUBoWvd1WYDg9uSmutOYUE4ILK//21aaxjpJ0xKcf81WJMfRj0zBFskg0ma6HRBfMbptdkpP7kMlwarkhTj9bAApC1heOKKhwdhTZZr64mHrsZpIRBwvs4gl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D69168C7B; Tue,  2 Apr 2024 14:32:45 +0200 (CEST)
Date: Tue, 2 Apr 2024 14:32:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: linan666@huaweicloud.com
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] block: fix overflow in blk_ioctl_discard()
Message-ID: <20240402123245.GA30793@lst.de>
References: <20240329012319.2034550-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329012319.2034550-1-linan666@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 29, 2024 at 09:23:19AM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> There is no check for overflow of 'start + len' in blk_ioctl_discard().
> Hung task occurs if submit an discard ioctl with the following param:
>   start = 0x80000000000ff000, len = 0x8000000000fff000;
> Add the overflow validation now.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you wire up a testcase in blktests for this condition?


