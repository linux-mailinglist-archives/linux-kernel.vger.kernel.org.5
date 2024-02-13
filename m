Return-Path: <linux-kernel+bounces-64029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A225F853921
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB52283ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827C660EF9;
	Tue, 13 Feb 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L7xE+02+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE6460EEB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846896; cv=none; b=Znh/QIMV6v9HkxOy2jvW2kTZ03xJKe6PKnvnfS2+20RTov7DIgd3SRhO0Lz624a9Zb00hMIogi1mMRUImyOdRndy9Yr7Rk8jfHcl3gFkg0E3oewhWKC/heiAN2SZqqbbps4WDC7O3K+mCUxj2gMEsQOGm04UYyVS8rjnQLEOQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846896; c=relaxed/simple;
	bh=O+uwyHXSZkJGTM6D+Jts/tuT9zkZbdhkWBI4Soow+ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVYtiiKcTPlbVV6DF+sdPBoqYAWplGWnqcELICGfp3MByoHCuVEh4h1KgXO9YO/QWLfrf9FWjZui4gbqyTTKNW7L0jCpLgkw1uaSMpmypy4j2NWRMu+qjdwq0mcmVj8c8tB4LMC9BEmA1lSYpik/+MOJVWW7GrZUQfUXxSIyNzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L7xE+02+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ECAC433F1;
	Tue, 13 Feb 2024 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846896;
	bh=O+uwyHXSZkJGTM6D+Jts/tuT9zkZbdhkWBI4Soow+ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7xE+02+bTSYThELti/fEvgcRkoW/5iH7T8cFS0j6c3qY3T+01xG2Pb/7Cp7OkLxR
	 iS1mhBg+Er2OiE2DLutFPOIwnBCADDtqD65Y7dhyG+M0AIGHKxG+qH6+0TtHf6DPHF
	 sFyBMh7CRTsCq2D34dHg44ZhOs9IZIkxFwg5KeCs=
Date: Tue, 13 Feb 2024 18:29:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: Make i3c_bus_type const
Message-ID: <2024021344-broaden-underwire-b511@gregkh>
References: <20240213-bus_cleanup-i3c-v1-1-403aea18f05a@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-i3c-v1-1-403aea18f05a@marliere.net>

On Tue, Feb 13, 2024 at 11:37:31AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the i3c_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

