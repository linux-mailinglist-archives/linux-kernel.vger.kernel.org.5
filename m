Return-Path: <linux-kernel+bounces-53475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6006C84A467
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9276F1C22774
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FB014AD20;
	Mon,  5 Feb 2024 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p9a7LHER"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAF1369AD;
	Mon,  5 Feb 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159823; cv=none; b=a0Hzqj/kT69u/Pnc+6hXGiuwBASIDS1p6TopB1ToReVHqKUjf89k5RDep04el7ZDh6mqCenRvfT0N3BrtQsE8sPxxriXlsuFZKLIyVKRzdckJtbvTWY2AEqlitsGCwy7iEDsvp+9g2Hmn6fdoYVPLMbMlfch4yI4CizZcAmUWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159823; c=relaxed/simple;
	bh=r76aFwVlhx0f6YcO/hvdE8UgF2/b55hZ9n+gn3+rVR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxYoCmlCYHxI3lR0x/nh7UaNxaqwQe2WzYnvBZ+xxls1Uerfkxrmj9yBWdGy+xaffGa6ZiJX1X3YUiyvCNEz+XcIVB29xvSK7UTjAsMrywVuTCJ/d/TvfVLQ4xJ96RO5Wijq7gh7gCyc7SQM8Dero8vS06MBmLK3VPsBKDrLN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p9a7LHER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AD1C43142;
	Mon,  5 Feb 2024 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159822;
	bh=r76aFwVlhx0f6YcO/hvdE8UgF2/b55hZ9n+gn3+rVR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9a7LHERAiyCtAIL3HMvi1hYqBXGtexL14bxhhccANy57OTwBBtKnlWJaXEDco/er
	 2ZeRQekiq0bKJo0aXdetJR+OPWaCmFFBhGF2Kl69uRQEm9T4ZBl/VffnH343cZyyj+
	 MsVS41/8dAe06JefiYGmCsL0erheMbE7ZRN3Lxd4=
Date: Mon, 5 Feb 2024 04:49:11 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: gameport: make gameport_bus const
Message-ID: <2024020506-update-hardiness-cfc6@gregkh>
References: <20240204-bus_cleanup-input-v1-1-74c2438801cf@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-input-v1-1-74c2438801cf@marliere.net>

On Sun, Feb 04, 2024 at 04:56:34PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the gameport_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

