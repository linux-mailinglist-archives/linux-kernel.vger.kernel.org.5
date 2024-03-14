Return-Path: <linux-kernel+bounces-103680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B4187C2E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DCF1C21003
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEB474BFD;
	Thu, 14 Mar 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+9AzhMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DA073161
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441749; cv=none; b=lBGpdVeUSee14Al0aakzAQpOl1oHiDAk2EVBzTM4CNZ6LPpeZWL0oMhT+Y7HUbwyamReMGs7/0ITF/mBeC5ME7ylkQfZvZDxZ43T61232RQoIKDF+UJ4tITiOPUK8VruDIYC9Y6UjRsU5FFdvNmDqr6RgZbnuQO/9RPJJkBi9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441749; c=relaxed/simple;
	bh=LpfTV5XjBJ9sHwYJz26O9mfseXwEJhoub09jqnezpfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8rfYr5k58b7sjR5I82Eyjh06kjBFeVoG8p8R5U+nSeGTVWJX87NvcwFh5pPT9KUR8IKsFtS5q4kOu4YCHVSBF+oh5I5KGuwtnXqG57HD/7X6dAcl1IjNODValv8RyDhlJK55gcrcv194NzzlmOgmsH3a4glhmw883JgX9ADCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+9AzhMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413FAC433F1;
	Thu, 14 Mar 2024 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710441748;
	bh=LpfTV5XjBJ9sHwYJz26O9mfseXwEJhoub09jqnezpfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+9AzhMGcaS24aNopJoJlsfbdwwg44ev1LpYW/Lx5T8jPjFS9zRDXRpEMWpr4SWsZ
	 MXupfq18PfGPsut0SzMOUFFmENeLtIfPJGA2FDk7RSHPMGUM93orOg6Ez1dJ/dv5w7
	 Q5AmK4wfhdfdYaIAfpyMEBCBrcYYA1z8Lxd+1cpn1QlQ6Bmy8q6t85pQl7jdpHBVBv
	 AonSTTX2wzmqzcJEGAHqj5Q0eLWpH5uDRuCBDNu2qCRiHbTXtx0agGIx6dfpAD6AN+
	 hNmj+nnomBMAMiPEUOejQL4oFPQegzpk96Ho71Qp3St2OzNcXj01PIoNXwninOE/WW
	 aCAdoH/QSNPuA==
Date: Thu, 14 Mar 2024 12:42:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nvme: fix reconnection fail due to reserved tag
 allocation
Message-ID: <ZfNFEjPgL2udEEE6@kbusch-mbp>
References: <20240311020927.85482-1-brookxu.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311020927.85482-1-brookxu.cn@gmail.com>

I've replaced your v3 with this one in nvme-6.9. Thanks.

