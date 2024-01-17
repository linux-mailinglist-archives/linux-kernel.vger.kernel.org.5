Return-Path: <linux-kernel+bounces-28994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4AA83062B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E6E1C23B71
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1AF1EA84;
	Wed, 17 Jan 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZN4LXGT0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D881EB21;
	Wed, 17 Jan 2024 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496044; cv=none; b=ixBj+lqm6auPEJdAweS2leNtZaRwyFpT4aQXXzLPQ+TkxwljiI+XcudUhvdUSDHFHyQMFYQEssz8bfAd1RXoDAW6SQfaFQJd2YalSFMxdVTfWru5jBqfRA136w6xJqrmCgcwCp1l4h8XmtcmXnLgwH6rv44eMd5KLK9aBIpbMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496044; c=relaxed/simple;
	bh=Te8NTGw84sq6fD3KbNxfL2JPnc0/l3/OI5enP65sT0A=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=Fx05w1KrqwSryy8CK1tJiAcFjC0Xj8ZyTVFzxXCvUFzaIkMw8Ey6zyNBadQFoxMdYuYtvPluDgOQqwNW6rONX2aoxZaHFCz+WUO29tKM1lEvgKztGgVV89WIrWyU9tM42+ZtLg/dm41dJoKwjPzgbpiHp89c677eFoKqpNb1Pqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZN4LXGT0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705496040;
	bh=Te8NTGw84sq6fD3KbNxfL2JPnc0/l3/OI5enP65sT0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZN4LXGT0WP7ooNM12xFITUbxvx4BmsSa/HItkaFNLZ0O7MDWcxIdwV85dbPzFCQ4e
	 Ih2vk6+jLCCBcB5fqKCCv5P2+1FU8+o0gmR6AOsV6lywD1lu+kIibQc37R74kw9e7n
	 CazY9P/SmlrrEYHJGb6PR1U2FHN9DKdWjA610OZDg0JGsOITJTZLhgtD0Pc4bQIEoA
	 EMDihzrTGq2xN/ZWGhU0uWkvP6hUPMlkoNkg9yKFVwEc9Bf4bDLdqtZYddpWg9I3fF
	 ujhT8FTiwLi8TsI83uROliSbK1oWGq+G6+jIA9iFtWEt9tPaty9Zc7S7K8mOmfQ87I
	 pMecTRJFlx2dQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DE242378202D;
	Wed, 17 Jan 2024 12:53:55 +0000 (UTC)
Date: Wed, 17 Jan 2024 09:53:23 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] firmware: coreboot: Generate aliases for coreboot
 modules
Message-ID: <49b42da1-a74b-433c-b018-0742f850f680@notapiano>
References: <20240111151226.842603-1-nfraprado@collabora.com>
 <20240111151226.842603-3-nfraprado@collabora.com>
 <ZaQU_QqGXwkSgU_Y@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaQU_QqGXwkSgU_Y@smile.fi.intel.com>

On Sun, Jan 14, 2024 at 07:08:13PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 11, 2024 at 12:11:47PM -0300, Nícolas F. R. A. Prado wrote:
> > Generate aliases for coreboot modules to allow automatic module probing.
> 
> ...
> 
> > +/**
> > + * struct coreboot_device_id - Identifies a coreboot table entry
> > + * @tag: tag ID
> > + */
> > +struct coreboot_device_id {
> > +	__u32 tag;
> > +};
> 
> Don't you want to have a driver data or so associated with this?

There's no need for it currently in any driver. This struct is being created
simply to allow auto modprobe. So it seems reasonable to leave it out and add it
later when/if needed.

Thanks,
Nícolas

