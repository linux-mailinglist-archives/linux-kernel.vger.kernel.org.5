Return-Path: <linux-kernel+bounces-53579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167F484A5B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4350D1C25581
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465017E4BB;
	Mon,  5 Feb 2024 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C0B9EegB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4331353F9;
	Mon,  5 Feb 2024 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159836; cv=none; b=lezQWkDrCT84mbaIGiFk0y0HEznmPT0Al3wchOmcel0a8R8adv7xtQClcaRQkglPE2PhQ8Tn9RLldTmwGzi1Lhp3wPLbmt0R+YWpzs26D9hPCuChj/EfAFnquRJGAVZUeOVOY4cNv4a78s+lzBYWmX7RiHcPma0buJf9Z6ARXpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159836; c=relaxed/simple;
	bh=LTQwioxrjD+95dxA1seXx/obCk9ewflk8P0ahzeHFF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJQ4Itppt2Qw3ttn9vhjiBnC9Ory/r7kR1PseG7T3pOx0lKWFwxlWMufov/OTsykBSoM9afROzHX8fB5WW+HStRjVQScN+FHtmHBBpb9q6KeQD/3EuhS7ogNVgPkez+LqNnyoEtlyj4rfsvnsXuyBuSyQXiG3F8HRRrLwCWVSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C0B9EegB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC9EC41639;
	Mon,  5 Feb 2024 19:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159836;
	bh=LTQwioxrjD+95dxA1seXx/obCk9ewflk8P0ahzeHFF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0B9EegBVdxtHZcjtN8x6Z7drmGREKuBr8TTsyA/BWd6KK8cKSXPHmtv9GeFg44lz
	 a55M6FmSoPhZhgE0MOAVoAbtDdVV7F4FtEabD/1wKxKjltS2K0Cg3oU1Yknu+bmVSo
	 hQq3I28sfHMVePqyFedyqPBix3YM4uOAl0ZVl05E=
Date: Mon, 5 Feb 2024 04:50:05 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: make dfl_bus_type const
Message-ID: <2024020559-floss-appear-5f4d@gregkh>
References: <20240204-bus_cleanup-fpga-v1-1-dae8b5bf7220@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-fpga-v1-1-dae8b5bf7220@marliere.net>

On Sun, Feb 04, 2024 at 01:14:05PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the dfl_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

