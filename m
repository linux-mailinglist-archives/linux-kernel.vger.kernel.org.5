Return-Path: <linux-kernel+bounces-53484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE4C84A482
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007DC1F24BF1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF14E151452;
	Mon,  5 Feb 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BGnecQxk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D1913A869
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159824; cv=none; b=mlGnLoCfvKptRTqw4mRPi0tiNn0oOcN06XcysakwEXan8sj+/gtz8XquSLMVmYtEeyBfbH94KF98xEONuiiaNaLsZqNoRiKHdDCvpC+tJrJJY5H7PYN36cP5u5mu3HsoHWj0QmRmNJWvi9+OgOgf8HPLzyr+HlWvg0uuDIrJiJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159824; c=relaxed/simple;
	bh=GXjD/rRoFrhMHi5VOUmupIgP5YWbLXkneuejfG8wT2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edX/NJ7D8Tf/MuC6R4WBAXBVXRRdm7nRdlnhY25wW/OgCn3Hf4qCmB9ABtoe06/JFmOlRV8N/uH2wNBGJ1zn0/14RE40fUdDfNqJKX2HvzY3uyxdWSrag2r6nJQNezxvZGoKRVgIK0dCikPLE+K7HKPQW6G06rSXO5T1Rqa+ewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BGnecQxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37060C433C7;
	Mon,  5 Feb 2024 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159824;
	bh=GXjD/rRoFrhMHi5VOUmupIgP5YWbLXkneuejfG8wT2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGnecQxk1QZ5VbpnDXnljVr+7g8SuNMRvaariwj2HONd74wA1oqyyyCj1/gr5OHLP
	 UnTx6bn4pXi5fT+ncraRZgWkGQhVImX6WU4Tkiw9zRSPIccDO4xD2/6zoXKUgxEQgz
	 PmbgA6BG6bmLMKqNWZgDVWC+t1srTfnlhmxGpndE=
Date: Mon, 5 Feb 2024 04:49:19 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] intel_th: make intel_th_bus const
Message-ID: <2024020515-refinery-audacity-1d5d@gregkh>
References: <20240204-bus_cleanup-hwtracing-v1-1-23adbf4e6bb5@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-hwtracing-v1-1-23adbf4e6bb5@marliere.net>

On Sun, Feb 04, 2024 at 04:52:18PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the intel_th_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

