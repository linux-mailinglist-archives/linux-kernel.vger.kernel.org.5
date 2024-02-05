Return-Path: <linux-kernel+bounces-53496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FE684A4A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D1628E0C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5D1552E6;
	Mon,  5 Feb 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pzp5iMs2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0413B79A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159826; cv=none; b=Oy/TI5SiqMJdfSux/rjO4Elau0s2E3uV9jDDN0dQD6eeNLpmjLDcE2AwGiY7xmxdW1eXny0Nvu4Cl6ymrd8Dxu2sg2HK651zFWlYlxLRELXDZUrwefcz9ug5sCWjYs706G/oyhKRok9h7WHjakjqmHnSyRIwhV2aiXITy8PG8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159826; c=relaxed/simple;
	bh=GXjD/rRoFrhMHi5VOUmupIgP5YWbLXkneuejfG8wT2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7UGAqeYn1GgbvfJPgaJ1j3mhx87R9k+3/xKPjPj2MeQTQUcEbIHNcpJpjQKs7WyI6EgKCLm4qgGYTaBVeCOChKQYPGKxwTl2nNgKsDA35JXmt4+3eVSx30jpEiQWuuxuC0ZqWyac0xQUAVy2/42JVmRyBWjQFUzIyC8KDz1u8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pzp5iMs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A407C433A6;
	Mon,  5 Feb 2024 19:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159825;
	bh=GXjD/rRoFrhMHi5VOUmupIgP5YWbLXkneuejfG8wT2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pzp5iMs2KqdUObWfpjZDisXPnshAsKebopJB8cgkbIxuLd9mwax/Gu+s3wvWbuAzz
	 dgGdGOCFMbgb0DPf0hqMVKsmUY1rdFraI+W+L/EirGNT8xgLANFnUOEf1yj/Qnqlgz
	 d/A1JVji/lV8svQx7LMv7+muEZkmORTignxBaAJM=
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

