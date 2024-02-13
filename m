Return-Path: <linux-kernel+bounces-64028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB36853920
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1CAB29A01
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74E5605C2;
	Tue, 13 Feb 2024 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oYjewlFK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F81605DB;
	Tue, 13 Feb 2024 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846893; cv=none; b=B61ZrHPqPfQPOU96auYN/xeQH9MJV7tsVfB0JmVIlbMDwjiJTLvDyENNekGyGge849JL8nrvcNl7c2K+21KO6kw3rTu7GLdp3IwxOCEy0WeUCBzWiP+Lh1Z3shPiwlPMjrEuOag6h/cUn4H1uELOOgxrRw7/UZutX8nsRtgcjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846893; c=relaxed/simple;
	bh=+gtSCUulzFrkN3dsG7audbsZ+E1zRQmRvpsWzy9+UCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4AoXAMCE5ST5RGCUcPNFk6WHXqXUpt7aGYpxp0r+55B4Lc1H1Lez7W5kqRxAr+twOseFjyYzinZNswmZtf1fjHvwBnl3TKUK2EHTzc1KjH4PB1Xufe3ueQ1JsY7R72BOrP3MSxteX7184TR8FrfEmPEmyMjvF1mkv15zyWfnjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oYjewlFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60412C433C7;
	Tue, 13 Feb 2024 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846892;
	bh=+gtSCUulzFrkN3dsG7audbsZ+E1zRQmRvpsWzy9+UCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oYjewlFKlpt0arGfq3giSSvIb3NPf0CuwhKz9ydL+Wh9zvPdNyRRKGw6vqyxa/NN3
	 GWr2muUAwy0Oo+8HX65LUE8e649iB/nYoq2qBR9WBmSCls4VBMzgoINCnvPfofk9sa
	 YcLJv8FfZWOZd010ZKHh0cBiafzDlub7ABXoB6zo=
Date: Tue, 13 Feb 2024 18:29:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: make parisc_bus_type const
Message-ID: <2024021335-correct-repossess-1d91@gregkh>
References: <20240213-bus_cleanup-parisc-v1-1-2e61c77e66c6@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-parisc-v1-1-2e61c77e66c6@marliere.net>

On Tue, Feb 13, 2024 at 11:38:02AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the parisc_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

