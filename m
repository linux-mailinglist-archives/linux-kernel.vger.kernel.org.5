Return-Path: <linux-kernel+bounces-132740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E614B89997B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23BD81C20FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBE0160789;
	Fri,  5 Apr 2024 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aJsmsQWZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0D15FCF6;
	Fri,  5 Apr 2024 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309509; cv=none; b=nx9T5Ziodrp8xV/06XcdncLOlbPIsxpHTtI4DpkG8wgDQcxzcwmsEZPV3e0sXlVljMWTn+SLP5nDn7tc1xOMTXBk46O1Hx6xGgznW4w2d/M5tP/F8xQUxt1XILdUpS1Earu10SkqOENfyPYM1AXJeBvXq8qhPiD2sB7ffeh+GdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309509; c=relaxed/simple;
	bh=W+tQ7nF7wftBybZcYIpKWYyTxWY+uQlnce2bX+/IYAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyfC2evcB3h59fRWh71dgs42QpauIMsZlEd/kuSuwCJzQSCaMGhMoNGkijZ9IU5Psn5ElTT5Cf3KOP8U3Xs9IAHcGRqsk+XGZvPzqg6Wl1Ume5hcAh2uy7gQZp0UjuYVpEPVGDQftpv92+4K4YLLBJpaNIgeRpKDUI7SVWhMXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aJsmsQWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BCEC433F1;
	Fri,  5 Apr 2024 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712309509;
	bh=W+tQ7nF7wftBybZcYIpKWYyTxWY+uQlnce2bX+/IYAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJsmsQWZ64dFfZ6IzczgRYD4xAAciCrYVQNsMWIOktuGtASFhPoqkbIFjinL8ea2Q
	 4k7owPpTB7y1b0mY2m8nZJHxv7QMa1grmR01ZbZh9cqUzKYkc0QW5j3Bb9ixnPMBcm
	 uWUkNoMGVycPWjErfmMCdCygxFdQD/gVEkqvHuOI=
Date: Fri, 5 Apr 2024 11:31:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
Cc: stable@vger.kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Min Li <min15.li@samsung.com>, Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5.10] block: add check that partition length needs to be
 aligned with block size
Message-ID: <2024040539-bonsai-nugget-9e60@gregkh>
References: <20240402084955.82273-1-ashwin.kamat@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402084955.82273-1-ashwin.kamat@broadcom.com>

On Tue, Apr 02, 2024 at 02:19:55PM +0530, Ashwin Dayanand Kamat wrote:
> From: Min Li <min15.li@samsung.com>
> 
> [ Upstream commit 6f64f866aa1ae6975c95d805ed51d7e9433a0016]
> 
> Before calling add partition or resize partition, there is no check
> on whether the length is aligned with the logical block size.
> If the logical block size of the disk is larger than 512 bytes,
> then the partition size maybe not the multiple of the logical block size,
> and when the last sector is read, bio_truncate() will adjust the bio size,
> resulting in an IO error if the size of the read command is smaller than
> the logical block size.If integrity data is supported, this will also
> result in a null pointer dereference when calling bio_integrity_free.
> 
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Min Li <min15.li@samsung.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/r/20230629142517.121241-1-min15.li@samsung.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
> ---
>  block/ioctl.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Now queued up,t hanks.,

greg k-h

