Return-Path: <linux-kernel+bounces-53443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2200E84A42B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D3B283E5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A451384BE;
	Mon,  5 Feb 2024 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rSv1XxIn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B609132C37;
	Mon,  5 Feb 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159818; cv=none; b=i41mC+qrG8/MUMNjf9M4knn3xXjINJnfLK+w5RB5SdVqgqLnp56i5UBaNZwo64j+cdAuLn3FHBTu/XOMqOHqhGSm0urcgqg551Hd2Wk5p3/q2X1MKhnaFt6SBBeas7h3M2PVkM62u0KglC5wVZVvec6bCDqanJSZoZmFLNbfBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159818; c=relaxed/simple;
	bh=Ic8u8OdBrlVsb2wxHY3E0FseBeWYtpT+d7HwrfY/A10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHFv0KULjz9UTNIrC4A9BFnQP/pSI0xaOPmV/BCb2ZVcGaFNnwHEJxMGOh+MX8Or6WXYli+HeXzasUvpYmSL8JkRVvE+EWLG4F6OZMqH6KAverCxU0LmUZh86+XG16FaHFMzaGX8iA76m0VqW54r8FvblqWy/nLdXdaOiLycDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rSv1XxIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F082C433C7;
	Mon,  5 Feb 2024 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159818;
	bh=Ic8u8OdBrlVsb2wxHY3E0FseBeWYtpT+d7HwrfY/A10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSv1XxInIiHQ2tVEvsZNMjwILJLSyHnBgDZu9wg1hDLBWY1KGB14ENKUA1bdlOr5s
	 PKko96Q89plW+0PpFMTIsKtZLvZzm/AuMC1lpwz3/5V5V0rN479RBzYsm+foS3VCDf
	 syGZZSMKo9pRcqoVlSpUcT0+mN4Zvu3PAR7FX7K4=
Date: Mon, 5 Feb 2024 04:48:44 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memstick: core: make memstick_bus_type const
Message-ID: <2024020538-crunchy-jumbo-29cc@gregkh>
References: <20240204-bus_cleanup-memstick-v1-1-14809d4405d8@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-memstick-v1-1-14809d4405d8@marliere.net>

On Sun, Feb 04, 2024 at 05:05:58PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the memstick_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

