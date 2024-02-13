Return-Path: <linux-kernel+bounces-64024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD612853915
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4ED01C26238
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F460891;
	Tue, 13 Feb 2024 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WHE6kJlA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08260B94;
	Tue, 13 Feb 2024 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846880; cv=none; b=kBul14Zkd+Xn6ZdxmcV6MuDcoHGJ+1ASUfXPlu5nn2fQllozSY/g9BgK81m0wnd2waDxyr3rTDdHi03vSu8BHF+Mn/VB75fEri99qwUBTQfRq0B+AM9jd2wew5+wu86r84IHzOo28rS2uoZXBBI5vfp0jqFpX8uYkvADpKF/geM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846880; c=relaxed/simple;
	bh=eG84xnjwB6Bm8Fm8QqP5QJAetMF0V2eWI2ywMUmYJjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecBISfcqlxObl94bNlZ8mloglQRH8GjgJp6Ks0Jgg7v+GNEHnBw3AvWjgAQtfgWPjxbXZp26prb7XwXqHslw2ojEL9DBeNiNkqywIoEVkipziEtNE1VLf1QRifPIEGN7TBJbG27RHDuWd21oUV5MKpwUugZCbuBQRhXutFe7PW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WHE6kJlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FC5C43390;
	Tue, 13 Feb 2024 17:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846879;
	bh=eG84xnjwB6Bm8Fm8QqP5QJAetMF0V2eWI2ywMUmYJjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHE6kJlAo/gET24zqzSE5kRVj3rpRBFfY72dTrAUhAuChGu9wCeicw3dleOrvVunu
	 a34DyFvr4BLhmrazZg+kJZX3xfk2Ig1tnaar1ydsUvHGQ14y+SrkzJochDZjimsdzX
	 pGILfSOR+fVBHRou0gOzF1nMz9AzX1IRyNiOdSZk=
Date: Tue, 13 Feb 2024 18:28:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: bus: make host1x_bus_type const
Message-ID: <2024021332-unmoving-thud-02fd@gregkh>
References: <20240213-bus_cleanup-host1x-v1-1-54ec51b5d14f@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-host1x-v1-1-54ec51b5d14f@marliere.net>

On Tue, Feb 13, 2024 at 11:44:40AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the host1x_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

