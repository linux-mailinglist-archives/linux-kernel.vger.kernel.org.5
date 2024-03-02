Return-Path: <linux-kernel+bounces-89564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6F86F21B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E603E283CD6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF313FE58;
	Sat,  2 Mar 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IB1Hd8+I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1A3FE2A;
	Sat,  2 Mar 2024 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709407264; cv=none; b=ivP7AS/GjnvK9t+RM6ewPR8QDgoovuy07PzDVsOo1Rq1Rj+7v0kQyiyzpRi3PhjSL4remVDfnWyU0z3POUDIgAi9pgm0VUTYMSz+ys2V+Hp8nFOspF0yMSTbg6OXyyL8Mv2l2eClWDuS2cnokZHuQBDnMoxDL6uED43vyXzHNfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709407264; c=relaxed/simple;
	bh=F6C/vOXruB8cfX2Q18DNt9YTQNOaDqVyPd385kp4dAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3KY+sJvoIvWfrJKVqk4wFgQe3vwOkMYdXeIbrEwgvHnE60tdyh5NBotvLkf0OfkUIb3wAYIT1TdF0uG+qda7tYSPnmEXpd1Y7KdF2cqHZaIsSsGMvkOxDy8yvQ5feg2+/rRiRG31+F2xk442geOmecseuased/VofOQ1u8BInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IB1Hd8+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D0EC433F1;
	Sat,  2 Mar 2024 19:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709407263;
	bh=F6C/vOXruB8cfX2Q18DNt9YTQNOaDqVyPd385kp4dAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IB1Hd8+I7MRGuvly+jgywSeQrujQh10L7BGwecqNZFPKjs2ZD+hbo4tNtFxPs9UFh
	 jC7aQC8YjxDNnd+vwxDtScMPanb2Jl/wyQ+K4+LQ2FpAIBds8xuU6gTyODDUfw9gUt
	 LWU6219e6biB/Tfsy08SlleTxXFtE32FyT3burNc=
Date: Sat, 2 Mar 2024 20:21:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: no opencoding FIELD_GET
Message-ID: <2024030253-snack-uncapped-cbdf@gregkh>
References: <20240229132401.3270-1-oneukum@suse.com>
 <20240229162425.GJ8454@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229162425.GJ8454@black.fi.intel.com>

On Thu, Feb 29, 2024 at 06:24:25PM +0200, Mika Westerberg wrote:
> On Thu, Feb 29, 2024 at 02:23:57PM +0100, Oliver Neukum wrote:
> > We have a macro. It should be used.
> > 
> > Signed-off-by: Oliver Neukum <oneukum@suse.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Although I think the $subject should probably be something like "usb:
> typec" or so since this does not relate to USB4/Thunderbolt subsystem in
> any way.

I've fixed this up when applying it, thanks.

greg k-h

