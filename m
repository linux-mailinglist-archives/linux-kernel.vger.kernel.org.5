Return-Path: <linux-kernel+bounces-53408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF12A84A3E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFC61C222BC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DD212FB3C;
	Mon,  5 Feb 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CICFVGmD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA512BF36
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159812; cv=none; b=IkDvj3vfiqJZt3x7CqpkWj3jd3tjcdlyfxiM1CsGGmIeetvLr49rrj5vorb/pECrkjfGPHvyj8Jpl1NFoKIF+S/BiFdQ8i7PX+ts6AktfsWL/qq6RPmkhS03Y2MHOuCpV+Q8x+A5YMZI5Bejjx+g4noZCCDBks4nWF4gbR6OzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159812; c=relaxed/simple;
	bh=UaPeS5mSvUaoCPnWbEINPK01Kr+ZY3YUWtrlVXmWEkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a43yguKDA0EI+yyiohpmmthh0qfWEXYowFqb/5unU+/Ao7DVm5jkofn5VNPkDIDcZUWuJS9NRHrwXuK7aVvz80DXLP27CdYKsF8HS2bc2tpnlXXtO9R91ZHG1CCM56xRQjQL3OS0YM2nrjtqaaNrhMRBK+dCmeA6JQjsnNCMnjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CICFVGmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A447CC43394;
	Mon,  5 Feb 2024 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159812;
	bh=UaPeS5mSvUaoCPnWbEINPK01Kr+ZY3YUWtrlVXmWEkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CICFVGmD6wpJse+9JvGA7XocO/RAFF4se7vGIPpI7M2UW4KrtOTKPKy/iuhq1p4BW
	 cyLZWJWbM9kxqxSQ5PDSA42WGxqH9RkHBzy7Imz+nlnn3G5L9/ePmWvA5LcgyogT4A
	 361Z5eKC4kx6kXiNtZnoYLvBqTZoFH+KK8TebqMU=
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

