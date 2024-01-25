Return-Path: <linux-kernel+bounces-38078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB4583BABA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 255C8B23AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EF712B61;
	Thu, 25 Jan 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+a7svVH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EBD125C2;
	Thu, 25 Jan 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168155; cv=none; b=OTeM8BZ4WeuZ4sgILoME3E5uybSDFzRmtbfcB/Rv+6yIzVfs1s8pZj5ys8c/1sK50BobB5jZ4Z1M7RZ1dKxDR6Ztm2iUHOqjdedymfbBB5H/Uy9Lm8n9VFtc9maDeMKKYCpxdJlLHA1t9dgtBahtmY86ch+FzaYoT7emE4nAU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168155; c=relaxed/simple;
	bh=zHVsONx4KcOBxgGm9yVtdcWnYuuQg2lDfSnAQLPVhHg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bPobLuKPnt9RmSy3iVmXYRVmIchDMf9RG48Qm5JkwtyyNdmzChtL7g7oYpgUSZLzIzncxNCZE0D0bnCFyIHletV4ZXCvYVsGZM8/DyEts47nG2cTP+WiiEN3f3/Ft/dAd49zACOleJPs0+pjLo5zIS1OIE6NUdOBNmMIMLNGEME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+a7svVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D80C433C7;
	Thu, 25 Jan 2024 07:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706168155;
	bh=zHVsONx4KcOBxgGm9yVtdcWnYuuQg2lDfSnAQLPVhHg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=c+a7svVHLRMoQtYwbDDUroi+Mo/iXrsJP8O86Mh5iZhygqFCB3ORQ9OdmiCHhwq10
	 FMnD/5zDrEN9MiBUhEILwTZjKcI4j7lGR8KKLpGQVfTwoFk8v/afz3iJoxLAeCfOVI
	 YlTzAMOoNur3F1xYemVnvwIwIaIOKoJRnzRcw/1ioNPXnGH2k5WEmg1Gny2O3///CA
	 SH7WDkQvEBhowBcg+jqPsFq8fC7IqCR9VhVpZ8u/NLb3Eus1V/xagDF72bxB+0wIMV
	 bkFb9EYohfSfFa1kg8szc/DOfSIsGjrKtRlc1F9vvPHUt+bXsXHFvbGetQvNwU/2uL
	 oNiewCrIgF51A==
Date: Thu, 25 Jan 2024 08:35:55 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Su Hui <suhui@nfschina.com>
cc: benjamin.tissoires@redhat.com, mail@karthek.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] HID: hidraw: fix a problem of memory leak in
 hidraw_release()
In-Reply-To: <20240125063225.2796234-1-suhui@nfschina.com>
Message-ID: <nycvar.YFH.7.76.2401250835450.29548@cbobk.fhfr.pm>
References: <20240125063225.2796234-1-suhui@nfschina.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 25 Jan 2024, Su Hui wrote:

> 'struct hidraw_list' is a circular queue whose head can be smaller than
> tail. Using 'list->tail != list->head' to release all memory that should
> be released.
> 
> Fixes: a5623a203cff ("HID: hidraw: fix memory leak in hidraw_release()")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Good catch, thanks. Applied.

-- 
Jiri Kosina
SUSE Labs


