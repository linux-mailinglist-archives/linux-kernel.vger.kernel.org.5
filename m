Return-Path: <linux-kernel+bounces-53350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C6D84A386
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21442845FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5890077F13;
	Mon,  5 Feb 2024 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DLuMqKd9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8374E00
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159800; cv=none; b=ILYCxXF6fIX1nulmaIsL9c8kRfETpXprZYxB8pTleKfGjp37rR2dOM+vBgGp5cXtYoRS97AFBmOx7Jd0lHj81md66B3G+qzxi11HgxaBMj4gHFTt3xwVZci/agyPH+PeIT32T6A4IdCFA9+gLovwbGRBHm1D3/GtwBJTqbfNS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159800; c=relaxed/simple;
	bh=SaE5fyHUUm1NkAMFFfv91SoNo9DgaZQmpck7+KsBLoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXGYSVjDNHxv5/VpY9k9SwPxw5FuK53+Tudij+X6LVD0RKFL7jym5E1WsxYq4gJ+v60fkI4bOO2PFFIUaTVVlvPDnAK6QrqPXmAh6OXmSyd9DWoy1+MT1e9eE49HabMHNXYb2s+NVjTotjs/d951ghoEaDRxqMSOSmhsbpbCXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DLuMqKd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1A2C43390;
	Mon,  5 Feb 2024 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159799;
	bh=SaE5fyHUUm1NkAMFFfv91SoNo9DgaZQmpck7+KsBLoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLuMqKd9pcGi1Q3f8wvAmuxjwgmCHDw89wjeJYHeMNCUnQVqVES2GZ6wtxwiwijzV
	 M8d18C/mQknQaLYTHCvP2ke81BsnJguz8x5h2XOxKdJyI0zGwhv9XCJdKfovmbLMnb
	 IeXdbbynABxLSodatOHUTssFKatTUzeLs64MZfHs=
Date: Mon, 5 Feb 2024 04:47:16 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parport: make parport_bus_type const
Message-ID: <2024020510-october-lividly-83fa@gregkh>
References: <20240204-bus_cleanup-parport-v1-1-e6a0f756bbb8@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-parport-v1-1-e6a0f756bbb8@marliere.net>

On Sun, Feb 04, 2024 at 05:25:51PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the parport_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

