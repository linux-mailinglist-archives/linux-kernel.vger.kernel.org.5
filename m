Return-Path: <linux-kernel+bounces-51240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2270848831
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD4F28555A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9221D5FDA6;
	Sat,  3 Feb 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Au4bc899"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE05A5F867
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706985396; cv=none; b=WB0iw3tcYpU9vk15AEIZoJRLtw8AJUmslmRATx7PkdMJ+mtg13TPB4Uiq4zQ2pO2jdtyX6Kf825IHu5T4sqmqeOABRnnSd6KqrTwuCas5R+9ewUtAAsrudB8XRYcyfP8Nk/Jgo1ycKd4a+wYVlhI/oQfRQ3/BYti7ivUbGrHl8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706985396; c=relaxed/simple;
	bh=eW8B/FcrP4XZWZ8pOQRMNScKBSEyTAeF0xJeqzlg4aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpQSmKkCf7tFbRF+yM46GBMISwoNAuMZBmriX5NTCeA+UyCkuDpX3LOL7W7LizR2awjM2gZPFcLObZeS5efjFsIKxBQSTAId6R/fuitkmb1rMpx8KMC4vzPK/6XlzvhSbUItn3MKm5w6NzjZ7ZnaUN8FrZwRdK/Asamz64+Mg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Au4bc899; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F787C433F1;
	Sat,  3 Feb 2024 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706985396;
	bh=eW8B/FcrP4XZWZ8pOQRMNScKBSEyTAeF0xJeqzlg4aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Au4bc899f79vIGsKRxgeLJTtKdAznJlamPASYVAsifgVzW+8z90pRRih4++VM/SNN
	 gfYrQaIwLT1xhXGKcLVo90ovj0v+/FolZCFcOLEWsRjlEtO6yhGW3jJD0czca1t9As
	 tKWaahoIn4U/sScgWdn/qggxRUwym2PhU5f0pOSc=
Date: Sat, 3 Feb 2024 10:36:35 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drivers: drm: struct bus_type cleanup
Message-ID: <2024020321-quicksand-disliking-6068@gregkh>
References: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203-bus_cleanup-gpu-v1-0-1b6ecdb5f941@marliere.net>

On Sat, Feb 03, 2024 at 03:25:02PM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa
> 
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Daniel Vetter <daniel@ffwll.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc:  <dri-devel@lists.freedesktop.org>
> Cc:  <linux-kernel@vger.kernel.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> ---
> Ricardo B. Marliere (2):
>       drm: display: make dp_aux_bus_type const
>       drm: mipi-dsi: make mipi_dsi_bus_type const
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

