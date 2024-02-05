Return-Path: <linux-kernel+bounces-53399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AEA84A3DA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD0A2859A9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E094312D152;
	Mon,  5 Feb 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJcOaWD+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC41292E8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159811; cv=none; b=pJWWnxQvbfxsmTShmUnRbCODW+xLqNKS3LBHK9Gj/jAn5pILDncRJEEb6Y3K/1vdgm/XJXePMveyDK12qBXrdbXZS2seaUE6DQp9POvqXcdh3QscEIlcpzS5J3LS4YMB9UduB34+Ei0ZlOyCOlNN3XYUFib0QLtCnDgG3iBLgc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159811; c=relaxed/simple;
	bh=UaPeS5mSvUaoCPnWbEINPK01Kr+ZY3YUWtrlVXmWEkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKWmKO60NS31N7eMXK4qHFvC3zbYKH5QzBG7svcR0EKN9kRmHGtCHDp6TlmwutlNP7z8KETMgNumWJ6Rtx1zzdkquNG8/elsS10z60KBYWBJokyAHfIUHrjjdMPvEt+0V9H/0I38DldaACgFkFEGzZXdpH5RAaCLfQm7jzspq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJcOaWD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEE9C433C7;
	Mon,  5 Feb 2024 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159810;
	bh=UaPeS5mSvUaoCPnWbEINPK01Kr+ZY3YUWtrlVXmWEkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJcOaWD+UdhvFlbQQVGAst5apjCW4R+BiH5UO602ISingapN71c1ANmFH+VAFdl8a
	 DYnl1YYIimubVqyzSg4r8Wnn2P5urD7sdEC1G8kgA8WrNjK3xmdIrDq5MVHRor34yM
	 aKkA7NwM2cRW+Uj2atX3oR/SvBSeKE9Gp5zgThTY=
Date: Mon, 5 Feb 2024 04:48:29 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] most: core: make mostbus const
Message-ID: <2024020525-playhouse-choking-7ed6@gregkh>
References: <20240204-bus_cleanup-most-v1-1-f5cd9a06e13f@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-most-v1-1-f5cd9a06e13f@marliere.net>

On Sun, Feb 04, 2024 at 05:13:16PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the mostbus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

