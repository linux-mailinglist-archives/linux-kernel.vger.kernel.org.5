Return-Path: <linux-kernel+bounces-60705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A61AA8508BB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3F0B20F66
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8478C5A4D1;
	Sun, 11 Feb 2024 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n2pZSYS4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5EB59178;
	Sun, 11 Feb 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707649471; cv=none; b=uFNmQtPq3C0PbSCfm4QW2Otqd66YTpx7gulKi/p1eyJO+bHtJZjlTuIq7MjR9r5Fh96Z1MsLsxGorW7WrGqqT/BMaQiO1BVrgG4qfqSSSiCIq9CxfskcePJC5WdcV047DusjZm6a0mQAsIXklEwBogkppz0LRXKEOhWVDuuGIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707649471; c=relaxed/simple;
	bh=s5boU9FKIQ22eVdo/qDVnSYtboOPrqTlhDiAI6ozGfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM7l+OQ4L+RfuXWYXRncZicqNdXh4dr+5EOT1FVoZ2UegDLppb2s4aOGVqGUJLjdn3EUUQxGdPQAH8mbI+c6eXwfYs9Cf/7LRNp/PMYgi/5tUBYrv9l6FxniYf143cxgZwNm1aTZ2vJlwwP/jeN3DZly8qQEJT3bgeRsl2xKLos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n2pZSYS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9012C433F1;
	Sun, 11 Feb 2024 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707649471;
	bh=s5boU9FKIQ22eVdo/qDVnSYtboOPrqTlhDiAI6ozGfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2pZSYS4Z1R3WCYy5Pz3D+iRKSScXtcsVvldRUS4d0QHPkbY32hS40GaSkKPmA76K
	 ylX7SMSQLIXV5zzoj8WIEc6dR4rbHxXozpgQaNkZQ5OG1XILEUS1vFRtrHwbokj4Rz
	 xRu3hFBaqlZSz0iUcVG1hR+yjmgFbPdIyUcId8Z0=
Date: Sun, 11 Feb 2024 11:04:28 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: bt8xx: make bttv_sub_bus_type const
Message-ID: <2024021120-clear-delicacy-e30b@gregkh>
References: <20240209-bus_cleanup-media2-v1-1-8037c73bf688@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-bus_cleanup-media2-v1-1-8037c73bf688@marliere.net>

On Fri, Feb 09, 2024 at 08:27:48PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the bttv_sub_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

