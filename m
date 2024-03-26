Return-Path: <linux-kernel+bounces-119421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3B088C87D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5031F807C2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1925513C9C4;
	Tue, 26 Mar 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pOSCaBFg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1C13C9A8;
	Tue, 26 Mar 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469133; cv=none; b=qKps+/X1gglCZDroEVoNjGcrBw9/9zOBjWLka9zXD0xuNyEAH56hogbWSHPoswLJz1uJVS9ThxM4IASGgPWy0pKpSeZazVgFHtSsSBwvB/vnJONEocAlCHlMejlfFKY5app9f6mTBJkmMUMGIXHb2ABXSCIUPQAkUSgV4OXcdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469133; c=relaxed/simple;
	bh=xW73iKiHOHXhv+5X21cNPWJHx/XrMn1+Wb25gCynJ0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPl3tNcyDd2Y8keZQUv/d1tEqA6/RCRLCJUNmko8ZFmiC0J8b3wCmMVLChqvmvc/d/K/Uu9WJtKAa5tW7WqOkV7M77StYPr5GXHz7jUEb5i5//sogxviuSh5xpWDgYPnTUhJ5reGE31OLyQsxLr5TCRYOcV1ft0ujoofqTNFXQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pOSCaBFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AB1C433A6;
	Tue, 26 Mar 2024 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711469132;
	bh=xW73iKiHOHXhv+5X21cNPWJHx/XrMn1+Wb25gCynJ0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOSCaBFgxlzYRC1QHj+M0Xcwy1p0tdXhfP8ICOp18R3591t9EG++ZiLluaOaabmII
	 9WzJQgasDq4DGjawm01W9hwmIHB2QztOyW8SXvpDBw5vyA/ujZ+1n5qE32JAHvIwG7
	 tDttpucnG8wYeLoS5mv5Ejdr5kGfn6xFR3cvKhys=
Date: Tue, 26 Mar 2024 17:05:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2] staging: wlan-ng: Remove broken driver prism2_usb
Message-ID: <2024032616-hangnail-petunia-4b07@gregkh>
References: <20240326084742.GA16228@matrix-ESPRIMO-P710>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326084742.GA16228@matrix-ESPRIMO-P710>

On Tue, Mar 26, 2024 at 09:47:42AM +0100, Philipp Hortmann wrote:
> Driver has a throughput of 200 to 800kByte/s in non encrypted
> transmission. All encrypted modes are not working. WLAN without WPA2 is
> useless these days. Driver is unused since April 2021 as a bug broke the
> function. Find fix for bug in link below. Remove driver because of its
> low performance and unusability.
> 
> Link: https://lore.kernel.org/linux-staging/5fa18cb8-3c51-4ac6-811e-63ae74f82f17@gmail.com/
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> v2: rebase and improved description
> 
> Checked for artifacts of wlan-ng and prism2_usb in MAINTAINERS.
> Removed artifacts in Makefile.
> Used the following hardware for tests: D-Link DWL-122 and Sinus 111
> Tested with build and make clean to ensure that all is OK.

Nice, always glad to remove code, now queued up!

greg k-h

