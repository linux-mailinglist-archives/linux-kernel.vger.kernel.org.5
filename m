Return-Path: <linux-kernel+bounces-53303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8341184A336
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5DA41C254EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9633259B75;
	Mon,  5 Feb 2024 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IWj4IyWK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51B058AC5;
	Mon,  5 Feb 2024 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159785; cv=none; b=fGC590uhjQOqT4fzhpmWBtYnnXdH37Y7jGcWwqhnTWgnv0CHBF8xdZNo8xDCkh6ohJeItdrvOQv6IwsInK7m9tWCZrPJgkOeQuALFxr2C8EUeV5G6LNtKymLR2DtyctnSyBHxom1VgP6ZE6Lz4Fn+7LTFU1nIpePnTYQmGQnPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159785; c=relaxed/simple;
	bh=mMsgTGDgH2EjVae8ropBazsxehXluLS59BuMK2VgrxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yay/gAUHsOm0cwBL+R2vhem7TbuGBTRePRdTEO1/7QWuaajuODhTijJ1/LIhfynkSuDLOQOvkXZnLY4Kg8f5e79BYk8hS8a192mbu4meDZ8+F97V4e93t9NZhGW8FBXBrlNykvXMgDycyl8Bz0kqq7D5FUQXCmM9mhne/1DSC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IWj4IyWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A5AC43394;
	Mon,  5 Feb 2024 19:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159785;
	bh=mMsgTGDgH2EjVae8ropBazsxehXluLS59BuMK2VgrxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWj4IyWKUv8FypyJeLJcvS1Lo9MgVQ/cicBlte5f4KLNTa7ZMIxmrsSfWA5cblXLf
	 iE5n3MrdmROImMvlVkO5t8oWw533/2ArPm8BpjHVTmy9Hrcr/fiIUVCDpPcaQRDXzH
	 6ur0lD8VVPuASOrveL6UUFbuqhCorLOqaqOMkGDc=
Date: Mon, 5 Feb 2024 04:46:40 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: tcm_loop: make tcm_loop_lld_bus const
Message-ID: <2024020535-straining-marital-0334@gregkh>
References: <20240204-bus_cleanup-target-v1-1-96106936c4ab@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-target-v1-1-96106936c4ab@marliere.net>

On Sun, Feb 04, 2024 at 05:48:26PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the tcm_loop_lld_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

