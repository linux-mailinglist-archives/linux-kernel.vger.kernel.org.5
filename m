Return-Path: <linux-kernel+bounces-156015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF748AFCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6011C225C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F206043AB9;
	Tue, 23 Apr 2024 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bdg4VDgd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EF3E479;
	Tue, 23 Apr 2024 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915250; cv=none; b=hhNg8sSzZ9qb4Afnqf9EBsJfiyPqOt2uEORed2OTPDrCFnyiYo4waIe3984NpIkgr8nWXQBdOAS4pGLyjKW4Nm04A7l956LB2pNd7uk/OAsPeaqsg5DRzE+TiCjKR6Bf+g/xnJ8NBBYn7Nb+U1Xl3DnjV3PPRd23MuNyx2SHS4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915250; c=relaxed/simple;
	bh=G6wulhtlN9oOlGmAXtPwe7t72W62kGiwhmORu/QuOGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/WccJJKK5smn4141VR+aBJAz2gKLL8w4lvIetD9RKGo+bWEKtaAhl2oUG0qgbPDNkB+vjba2ahAs5cK60huWXIE5/6uzOz/49HwXewCmN0MUkiqaGr9TuXo4p5iVP9Zyar71K2iW+03A/URbYvGXT2Pbdh/UplR8S5NzPK9VKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bdg4VDgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52586C116B1;
	Tue, 23 Apr 2024 23:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713915249;
	bh=G6wulhtlN9oOlGmAXtPwe7t72W62kGiwhmORu/QuOGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdg4VDgd1Gdh2ihFjEzz6KFeGFQw97H7Um3A9pCcnlxTNQsaNgQ6ahQNwXrodmjwC
	 DzGnzxyWi76DxOL+ClSHLUENxEstGUxYL7DbAX1GFGDWMXsuZFV3gqaX+eY8XzgrGq
	 CFlM6plZRqdvDZg23tbjtErkA/SpkO2SstMBsVqM=
Date: Tue, 23 Apr 2024 16:33:59 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: neil.armstrong@linaro.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: msm: Unify TX and RX DMA paths
Message-ID: <2024042342-unmade-surely-da1c@gregkh>
References: <CGME20240423120821eucas1p2e8eb7aa059e00ee2bc6272cda24d1457@eucas1p2.samsung.com>
 <20240423120809.2678030-1-m.szyprowski@samsung.com>
 <4813aa76-6ce7-403d-8bff-1fb6e1d3f0a2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4813aa76-6ce7-403d-8bff-1fb6e1d3f0a2@linaro.org>

On Tue, Apr 23, 2024 at 04:08:04PM +0200, neil.armstrong@linaro.org wrote:
> Hi Marek,
> 
> On 23/04/2024 14:08, Marek Szyprowski wrote:
> > Use scatterlist-based API also for RX mode to unify TX and RX DMA paths
> > as well as simplify the whole driver code a bit.
> 
> Thanks for the patch, I have no idea if this is right or wrong.
> 
> Greg, I think we should wait until this change is fully tested on multiple
> platforms including DMA usage (bluetooth) before aplying it.

Great, who is going to test that without me adding it to linux-next?

thanks,

greg k-h

