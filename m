Return-Path: <linux-kernel+bounces-134931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0A589B8FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFFC283E8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA8F3FB81;
	Mon,  8 Apr 2024 07:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnGEn2r6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14C44C71;
	Mon,  8 Apr 2024 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562238; cv=none; b=UrspQwYc5R3Plzc5WkorjnQBFxmIbq28mcHrIGP7TE3/rmXrvCyJWCHWunu/KE6v4kdAVB1/y+XxJtUjdfTz5RgSuhvjFLgtFHHWsWAqswxxVHFJV9U8QnV4AbHSbjHji4SmyhfEqhZuSfhyyKKDdnIUb2OUakDzHO2ipmnHYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562238; c=relaxed/simple;
	bh=UtcdCMkPCpBNj87XfIejQin+4GfBWMf0J39189pE9XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdPT6l33HyXDGMWIbyyrQrekfFgsb70CPoa1VIr+DKBBZSztxwtj2byDOscn9FvOno8rqK8e51xmkGKSaIc+POf0O2W/APAZrQVY7lgmWoLMkOccAuL8XgcEmYkTfrzJs5XLFwAxlKZq7uS5f/VYY2ivkZL2FErTjCrGeoB3oWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnGEn2r6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C4CC433F1;
	Mon,  8 Apr 2024 07:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712562238;
	bh=UtcdCMkPCpBNj87XfIejQin+4GfBWMf0J39189pE9XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnGEn2r6FJO9E+j0JcXC84uJNjDS4I7r0Zbbw0TWDqzabGYsMTGXslYlGFawh9S+j
	 5MFUnvTsz2VsaRd3PLMpuSgjd/sWvtDxZKeC+5OiQH6/ZtqYLyEFapCzcDx1X8KiuC
	 tzE52AhjUWzAU6OcYg6795WL+u5+gZHm5DsW1ssAFIvU8LFKLqUP8w5mue2gkoPkay
	 4WhialH/Z5q2jrz/145WAYksy7Rfs86o00UY0S96n5Lt8AE8wYrHe7H9NUJyAmNTpx
	 VaZvOdNEeZJC3phY2w+u4ITmILhwDrjcJEDrHLo2mKPRlPqj9k6tt3CdBSerUARBAC
	 v1jIpS3aC0utg==
Date: Mon, 8 Apr 2024 08:43:52 +0100
From: Simon Horman <horms@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, m.felsch@pengutronix.de,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH net-next v3] net: phy: dp8382x: keep WOL settings across
 suspends
Message-ID: <20240408074352.GZ26556@kernel.org>
References: <20240404130516.2897310-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404130516.2897310-1-catalin.popescu@leica-geosystems.com>

On Thu, Apr 04, 2024 at 03:05:16PM +0200, Catalin Popescu wrote:
> Unlike other ethernet PHYs from TI, PHY dp8382x has WOL enabled
> at reset. The driver explicitly disables WOL in config_init callback
> which is called during init and during resume from suspend. Hence,
> WOL is unconditionally disabled during resume, even if it was enabled
> before the suspend. We make sure that WOL configuration is persistent
> across suspends.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
> Changes in v3:
>  - rename function _dp83822_set_wol to dp83822_config_wol

Reviewed-by: Simon Horman <horms@kernel.org>


