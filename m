Return-Path: <linux-kernel+bounces-53766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A07984A68B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A6328CEE4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BB41A429D;
	Mon,  5 Feb 2024 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hW4dW6CC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBD17C784;
	Mon,  5 Feb 2024 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159857; cv=none; b=KGcf9bKbtrsCVskM74gy/+mDQj/KpGUoMfivBz64jpeC4QVkpqsVCyq/8fFv6sKodfz2ckXnstAjzPH2yWGy9aP+R0VrhEGnCsEsDFl7CCN4g2XH5Tg0Qxc9q+4Yd2EOY/ZN0ulZWDG6oaf2Kwhg4/6Gcq/qXyr0OOmhqisjnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159857; c=relaxed/simple;
	bh=zl2f4VHKhS40Jsjh4iTApKIdZqzlAf4+ENj/mrFKKE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpegPMSUziU2NQpj51ltiMWYpOc3DU1Wh74bT218jQgpZwT7V99ANoj/aSdnZ45ggNiIh0n+Uj2cQteEPvyT4NvBJv5EtylTSFs/aXG+rvpXtG0aZyjXJ+D7PXz1Ahi1/jARRVLZPD/GioMIPH1PCEEikUE3YOeh179mqPUY8M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hW4dW6CC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0182CC43390;
	Mon,  5 Feb 2024 19:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159857;
	bh=zl2f4VHKhS40Jsjh4iTApKIdZqzlAf4+ENj/mrFKKE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hW4dW6CCcwr5BH1T5oYTQyRbHgSP8+S8DMnL06O9Lqeo8CmqOMx+PojbycYBqjX9c
	 fH1PKwofvMh/xI2lsN8AYpaAcWP0cbkr7+L/1ZTh6H7iC9scFE+1FxL85HbYeetqk/
	 k7yzIHePvwpueBwCT/rxv1DNEp2yvX7m2OUikKO8=
Date: Mon, 5 Feb 2024 04:51:40 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: dma-sysfs: make dma_subsys const
Message-ID: <2024020537-camping-unaligned-7582@gregkh>
References: <20240204-bus_cleanup-sh-v1-1-44ced951bb16@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-sh-v1-1-44ced951bb16@marliere.net>

On Sun, Feb 04, 2024 at 12:15:09PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the dma_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

