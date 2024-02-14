Return-Path: <linux-kernel+bounces-65937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE231855406
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0EB1C26FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211F7433D1;
	Wed, 14 Feb 2024 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7FM46Ti"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353D18E0C;
	Wed, 14 Feb 2024 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942691; cv=none; b=qxnxYrAGIJJiBNxuPwIsy/29EWfirX1GyBcq+bNpwQNhFGJpICGZJw/23VzQrrsqiSONHzbVZt1ZzzDXEtQleNpurd2Z84JLZb73ciaI6Dhx+v9M5kQ+iVDuyNdponA51K8D48qBC8HZETHIGmhfCPL+RioOHZqVtuWa6WfE42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942691; c=relaxed/simple;
	bh=pKXGXg37t5AZ3wpBT4EKvFu9rFHUojjY1rpSd8vUaP4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=erIS6BMKizkcc/BCfOndAO2BCnu5BIcFw4qx9914ixGmb4gsoEv512nhVXSfIbzCUT4fTP8nx6soNXhQA3xmdn4R8bc0CXPKoi8QQYaTVV1M1BTJrm5YRi5tKOqk+jhdA8wex/k3k3SRiaaQZjnOXhLqy76W4Wb9nlUtzShWDRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7FM46Ti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39418C433C7;
	Wed, 14 Feb 2024 20:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707942690;
	bh=pKXGXg37t5AZ3wpBT4EKvFu9rFHUojjY1rpSd8vUaP4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=O7FM46TiMYmxpWdUBQJy04jbMWRFfTfstTvW3nWqZLicSR7Yir/VEwdiIj6ItZrWp
	 ib/C5Sb4u+oWBJ5T+eT/8iEMAFsGCtC91isQDWH3M8xoggoSDUFeHJzfgeYXp4bRvA
	 RE5MToo8sqlASmGty1RczCW8ENOS0+a5+gQnlkpd3zALDDcXAajpPKDjCXZac/scjB
	 YgaErLaGI4tbiQbeOl8GzP5iLwKTJUP/bUId0s96F7eQMFxqGVT0+X9+nEIZ8WsmZN
	 naxo58tfvapuUZx+zTNNYrqMHi+h+TASDKSRwmEAP7QiGzC/SW3tOEmjYs0CCnRl8J
	 lQUmV+RPUNGQA==
Message-ID: <0daa6f37-8c50-4051-873a-4e8cd4e6cc58@kernel.org>
Date: Wed, 14 Feb 2024 13:31:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
 Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, andrew.gospodarek@broadcom.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207070342.21ad3e51@kernel.org> <ZcRgp76yWcDfEbMy@x130>
 <20240208181555.22d35b61@kernel.org>
 <2bdc5510-801a-4601-87a3-56eb941d661a@kernel.org>
 <20240209145828.30e1d000@kernel.org>
 <df5d7538-52c6-465c-b250-13532b90c6ae@kernel.org>
In-Reply-To: <df5d7538-52c6-465c-b250-13532b90c6ae@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 10:01 PM, David Ahern wrote:
> Maybe my bigger question is should drivers that can do different
> physical layers, or can operate without a netdev, should they be split
> into different drivers? drivers/misc for the PCI interface, drivers/net
> for ethernet interfaces and its APIs and drivers/infiniband for IB and
> its APIs? Generic capabilities like this debugging interface belong to
> the PCI device since it is generic to the device hence drivers/misc.
> 

I do not recall seeing a response to this line of questions. We are
considering splitting our driver along these lines to upstream it given
the independent nature of the capabilities and need to interact with
different S/W APIs and hence different maintainers. Any reason new
drivers should not be split along these lines?

If the answer is no, then where is the best home for the PCI device
driver piece of it? drivers/misc or drivers/accel or create a new
drivers/multifcn/?

