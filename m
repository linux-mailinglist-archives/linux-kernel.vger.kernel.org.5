Return-Path: <linux-kernel+bounces-91037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 278C08708C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595AC1C222C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB762141;
	Mon,  4 Mar 2024 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rri0PlnR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6426025B;
	Mon,  4 Mar 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574810; cv=none; b=nETVOtwff6HU69zi5XrYPOuoxyt+K8rPprX+xrz0qlidpsHvp3FFAMmJ4i4pwgPMc/EQqjl5fEL/lGFhcFa4zZsBBZhQ8bjJI7Y/hhXjIzq/zyQ6H0u7dXMhO77H9yI7NBa0dIPSWRjd41ezGUv9QwiVXxvDjBcIk0j4hrzQ+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574810; c=relaxed/simple;
	bh=MhiLXdgxGhVPx6IGPfPA0IR+hOJts0UyYWOARP4FWx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsTG3JYwEm3wHOvHSoEeEe/v2ZUD/rIN5E2e3GTV3W2VqdEzdEbFTy9D3WEQ0TX1KMFsSS93QR2zZg4S95fdgX3bL5CZ/01VnvYG1waLHyXiDmAqN1aGs1a8IV99uLarix+NdPK3sdYe5VtYNuHYS9GV1CAmqGSBgL2Rh0AZvQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rri0PlnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90A9C433C7;
	Mon,  4 Mar 2024 17:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709574809;
	bh=MhiLXdgxGhVPx6IGPfPA0IR+hOJts0UyYWOARP4FWx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rri0PlnR+vcH/64MP4mP1VFA+RMGPuybgQsOgtN4vuJKFfSgBaXxQ7pMfOkdN3d+9
	 IaSBoMh/4vs/DtcaqGVszfZkWMdNBt8dPQ7isAm9op2RDznvvgF7yRkj2cllb+a5o6
	 d+Q4QsWlwcRV1ZnmxE9l2MhqveYzLIo9g9P8jJl9Bqw3UMmM/majJI/UWLXZyosHeE
	 bKkkkWUEEjHdEq3QuWRmdFgXD0+CBqMAHPtKtnpmeePllWks0Usun0JpITRroA1moO
	 UTXZpnFD/JGChB6lzmtk/dIaeSOAaBN0d7lvEvsqoaMx49qVOxj0RiqIAlTofI1B22
	 5rVPJPJ6jfAzg==
Date: Mon, 4 Mar 2024 17:53:24 +0000
From: Simon Horman <horms@kernel.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ppp@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] nfc: core: make nfc_class constant
Message-ID: <20240304175324.GQ403078@kernel.org>
References: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
 <20240302-class_cleanup-net-next-v1-6-8fa378595b93@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302-class_cleanup-net-next-v1-6-8fa378595b93@marliere.net>

On Sat, Mar 02, 2024 at 02:06:02PM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the nfc_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Simon Horman <horms@kernel.org>


