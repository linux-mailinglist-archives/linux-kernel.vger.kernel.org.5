Return-Path: <linux-kernel+bounces-51296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A082A8488F0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38BD1C2154E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D5168BC;
	Sat,  3 Feb 2024 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T6M+E7aH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA21642F;
	Sat,  3 Feb 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706995409; cv=none; b=JLhdWtN/X+DGfq7vkdte2ElpYZyvZdt97ChC4POUr2z0uh7JDpvhPl5WfnmCRuhnILNQmKI5nGK1aVlDacGldObirm9RnNj6w8J9Acw3mAW6ws7O/6+2m7iye9DcrOxNNmGCOV3V/tIYX1/melrB10nul1TtFkz46KhLUfGVs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706995409; c=relaxed/simple;
	bh=x63xIfjT0iFPTj91fLmZkhkaMq3qzxXUAYKqEqhvzlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMZHybCtNwwFm1V7RrDbrtOzMtvRKMdfri4cmSPHUlYuB0c2g6vW56v4sxTgsBBrKJaAwPUCnn1EXFI3DV6yjdUJdC/rnGWOZDndfSpWa8ES3brAq+nkXsqHD1I6q0mwyrEcuVeXhXITSuJLUYM94JunP0FOOZGsBTPj5z0fPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T6M+E7aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173B6C433F1;
	Sat,  3 Feb 2024 21:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706995409;
	bh=x63xIfjT0iFPTj91fLmZkhkaMq3qzxXUAYKqEqhvzlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6M+E7aH1f6C3E4A3E1Xm/R87xbDSm3g1X9Gmhp/kqbyOAuI1grJcLSqFMNRe7zyQ
	 hX/QqSKoFGlmKfKvVy19woZ42cKQRcNEguKsgstBfCeQzTvyrIIgmrpEji2GYNHTRJ
	 hZ53thdSLNbw/egUR4eHQzUuhaMaoQHAlXFqX61k=
Date: Sat, 3 Feb 2024 13:23:28 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drivers: mmc: struct bus_type cleanup
Message-ID: <2024020320-colossal-plow-5c76@gregkh>
References: <20240203-bus_cleanup-mmc-v1-0-ad054dce8dc3@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203-bus_cleanup-mmc-v1-0-ad054dce8dc3@marliere.net>

On Sat, Feb 03, 2024 at 04:01:59PM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

