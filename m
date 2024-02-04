Return-Path: <linux-kernel+bounces-51711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CFF848E82
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8041F217C4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573F8224C7;
	Sun,  4 Feb 2024 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tLEyj8pG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9422C1DDE7;
	Sun,  4 Feb 2024 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057501; cv=none; b=JHIdVLrFa1bpB7BnSW7UdS+sSpPaSJFtowokJnNwL0gW/Q1nri5V13XCSey3jdbmRPuXsztBk88+rwogTDSt0NpIRRN2xrE8esds52kzMhPkb9MVZVpZgTU3XmuLjXzCqMWpb25VLqh+WDrZw6wcHjXGVjLd4Dt9cW0Zc6J0qco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057501; c=relaxed/simple;
	bh=PzskSpeis0StahY4wD3hOIASm2DYkfe9BKeGA/KilVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyPjYr0q8XTh90V3ZOI2OIvhpellybJBvoGcUccHdt8BmukKKGuniwTRD9YrxiWv0ygkS5eFmXNipfeu458BRCLlGPQRTCXQXDJiC+dcKfn8RsBiFgTzDQi1CRbZy1SlVTop7R4RmVwuhp8MwfusoSigqaUYefk+5zd16CI67TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tLEyj8pG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0062CC433F1;
	Sun,  4 Feb 2024 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707057501;
	bh=PzskSpeis0StahY4wD3hOIASm2DYkfe9BKeGA/KilVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLEyj8pGYxp6AxL6kHZP/XcCyVuviRazHx/YTpsofURN2sLsOGVoB1buEin6DESOq
	 NHcbLNaXTf85viJBD/XdQPpEaoPOLY+g90XFJ4dnlyGbYMChViRlhBCCCXJJCbXmJA
	 RY/vdzF83sNuJ56wDqGTBOQe4BBTfayXy6fvHNjI=
Date: Sun, 4 Feb 2024 06:38:20 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: time: make stp_subsys const
Message-ID: <2024020414-unpadded-snowplow-57ff@gregkh>
References: <20240204-bus_cleanup-s390_time-v1-1-d2120156982a@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-s390_time-v1-1-d2120156982a@marliere.net>

On Sun, Feb 04, 2024 at 11:25:45AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the stp_subsys variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  arch/s390/kernel/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

