Return-Path: <linux-kernel+bounces-53517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72F584A4D8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748391F26FE7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A6B164171;
	Mon,  5 Feb 2024 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tFz6pWME"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B26140777;
	Mon,  5 Feb 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159829; cv=none; b=JOwZTCgmcvBF0odFbkKldGemrLOmgMnoPh5TFHx9Jq8+6VW9ZRlLnYz1NLlSCt8bFGSQ1pFDK4M5n47RsjttShg1cIPJwssAUzsYhhlqWxcWrMBleN3ZOPBp3lsKzP1qypD//YsMLTQ8ZJEGKmEL5s/p1h20JpUW7p9NnhVziRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159829; c=relaxed/simple;
	bh=cBdQybg3QvOmh0T+8TRo03v1EOMi2jdUNh9UnbpZkXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD63jPAkXpxpeCETXSJbigldD1T5ScVCASfPXkMnjwxDFL3eX19SM+eqbrCos8k0KiGTj9ngW7eIrEcD+sB7bk4MUexZ/bfqZzBjJBGAKBCTkOranZN5204ityM9cqckClSFlkfJWLFvpph02ulLG3c1OHcg4XCzMVA3ZMSBB3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tFz6pWME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CA8C43390;
	Mon,  5 Feb 2024 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159828;
	bh=cBdQybg3QvOmh0T+8TRo03v1EOMi2jdUNh9UnbpZkXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFz6pWMEFpVM6yfWekiM+FiDrxSUYi9hy1a7rv06AGRf4Ej9tC8Sh8nHH+KirWoMn
	 lv8ELdhSMTZDPHgVv51IJcreAECuoD5Zt0Cp1HhSbXPjAryEpAa5TFa8uoY19IN7mi
	 +TLCArTsinYDp9Hy3pEbrtnYY7xvzJuelhaMvv3o=
Date: Mon, 5 Feb 2024 04:49:30 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv: vmbus: make hv_bus const
Message-ID: <2024020526-playlist-december-b3f4@gregkh>
References: <20240204-bus_cleanup-hv-v1-1-521bd4140673@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-hv-v1-1-521bd4140673@marliere.net>

On Sun, Feb 04, 2024 at 01:38:02PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the hv_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

