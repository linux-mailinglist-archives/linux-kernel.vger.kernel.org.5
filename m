Return-Path: <linux-kernel+bounces-53318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1C684A34F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAFB1C248B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212C5FF04;
	Mon,  5 Feb 2024 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T5AhlBkX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF745F86B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159790; cv=none; b=b6ve+jxMeFn9Hgr0p2cDsbJ8OGnCm8KIoJ8n6Ibb9U4LsTeOq/wuGIcelFOWoebxoL3uawmnXXp2SQx6XZECaXPFD8TRRs8cKZdPutoLC9YjG/SfGgZTRu2jNzeUH0hIF5mL6h1wz9apd9pEClHG2m246+TmkIcW39N6D6T5jQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159790; c=relaxed/simple;
	bh=9JYun6OKHv+kvMP09/1pbBtaCNVt/H2fMIxp02ZsbXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S51snCSK9t1ntYE5dRKVT7S7qXZCzQriOqJPJytEcqdV0a0ASHDhCtqtJu36lKC8wOnd+1mPo6OUpvH+h1gUBedcCg6qW5P5y7bPGnInA3tSyeiDPALkL8JXGOOWlDDZmn5kUEYMXkcmQ7SwykjLjNnJftY32S9kmHVpSBUBKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T5AhlBkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634B5C43394;
	Mon,  5 Feb 2024 19:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159790;
	bh=9JYun6OKHv+kvMP09/1pbBtaCNVt/H2fMIxp02ZsbXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T5AhlBkXqaf+EhHruqHRY01TwWyH18XGwr1BP460v5/ng+6RbRDr2WaHHAPDgeK2J
	 Z0QlX6594tcx5K3nE/RUedn0rQKHdHcIzKC3zLbtJeqZuIWqauS2xonVuStVQYR74y
	 4YKaTK83dtfRMS4+JLnMwBwTKrrEcBXBDyRzP1J4=
Date: Mon, 5 Feb 2024 04:46:53 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spmi: make spmi_bus_type const
Message-ID: <2024020549-lapel-swipe-2c91@gregkh>
References: <20240204-bus_cleanup-spmi-v1-1-ef7f278f1987@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-spmi-v1-1-ef7f278f1987@marliere.net>

On Sun, Feb 04, 2024 at 05:38:38PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the spmi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

