Return-Path: <linux-kernel+bounces-51736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A756848EB4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A27E1F220AB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12CB225AF;
	Sun,  4 Feb 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlQP9Y6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91322331;
	Sun,  4 Feb 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058346; cv=none; b=T5dJtQmCpO0OKeDbsiporqhTWHt5INxlTMmY7pD8AFDLNJlt2BKYDLPoi+QxT8hSlC/sy0lkQatUGIxTs6Rn794alaHrOjz6PGfijv9E2L0eeRsMbIZ+LF10WxtDhGw4J3uBhUPkHZB2lXStHjZ3aQT/XJkudkz0FqMcqxHIgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058346; c=relaxed/simple;
	bh=KdPMVA/tpoCduXsQtZ/I8yAo4zxlR9r2MabVpaGpz2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvsQEG8WL7Mg0pb5gJDT/4dZ8X5n5fQVDFTJIIAv6Tn8h++rBtleMOlmLgYqsJZbDCoMcQGn5sRCPKVKAMnNFnAJEsCil9bNpXta6+VB/TRLoRBHc5f/JUOBCRJ4tIEONRnj3R1FwIMwXrMCcKVSbnn4MH6JH7CV2+czJSb+OJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlQP9Y6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFF0C433F1;
	Sun,  4 Feb 2024 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707058345;
	bh=KdPMVA/tpoCduXsQtZ/I8yAo4zxlR9r2MabVpaGpz2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlQP9Y6npTcUk8ABInK6eGD5dtVH4VyJ7xUM51g7yCOd5twmsbrSPj6wi6s1KJPQM
	 j38GjhVCzIKBKY3LuVhEMU9BSB7sT84W692xL/LgonSMYZTLAp7mswEc19xCzyvwiC
	 WcHYB/R3LMo93JydrZbRC7Z8jh4/KY/Bxyv6BpgQ=
Date: Sun, 4 Feb 2024 06:52:24 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Russell King <linux@armlinux.org.uk>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: s3c64xx: make s3c64xx_subsys const
Message-ID: <2024020419-vertebrae-twistable-2995@gregkh>
References: <20240204-bus_cleanup-arm-v1-1-41d651dd8411@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-arm-v1-1-41d651dd8411@marliere.net>

On Sun, Feb 04, 2024 at 11:46:21AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the s3c64xx_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  arch/arm/mach-s3c/s3c64xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

