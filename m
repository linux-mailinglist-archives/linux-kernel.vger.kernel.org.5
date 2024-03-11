Return-Path: <linux-kernel+bounces-99653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF26878B72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8B31C20CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7428958ABC;
	Mon, 11 Mar 2024 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvoOm3mY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B816F5B1EE;
	Mon, 11 Mar 2024 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199175; cv=none; b=WMlPQQ82xB8TsUl8CvyGiY25HCIpPbqqhDdu6tbfoGjHWwA4y9kqnDOVPZJkLiv4JLzfFVg+IBM6Z+6N7meOYxqOaRINHWkL0DwhSSjvtEM06sPgqsIYp1IIh7/RKXBUl9g1or20AKr3O/nZKgaJvhWWIP6HbNUiSfeQnP2xkY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199175; c=relaxed/simple;
	bh=ao1qU99xMqRjKkn54WMjqMkh4JDfooM7PjAuxBwuxX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzCpa2AspddTEf2YR9C3hUfYS9Hgo9pARP5iSrOLNs73/DIqJ26RyYejDwr5qOtT8Mop8hKhs0X015HmglFJm1DvXmWnlFgkXCGkHPvQf0iwbjUfIoqfONx2XmY3W0EykPmUlGJ7mFRWyK7yt4CORfZIRjD6BD/PZIYcB0r9utQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvoOm3mY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580C0C433F1;
	Mon, 11 Mar 2024 23:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710199175;
	bh=ao1qU99xMqRjKkn54WMjqMkh4JDfooM7PjAuxBwuxX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FvoOm3mYATihJvuer6OdqR15Lg0SdNaNQqZuf1BX/PHXYcTSyOEPbqb4D15oBOLDE
	 1GcIh/bJzWoGeKTfTqTXQOqJSWrlUank6UA6jLHDKziPkwWWppJksFr27Dr5Bvd0u0
	 txaI6G7+b8QXw4q6/w8Ixn/P++vNBj2uABDS6OkapfF2FEjjkgsHa19yIY+S/4yrDV
	 Y3fWNmvDiLXWTCf9aNqvF+YNBBwfqVUTb88BkFhGPM5CQ+kRvXO6+Z4zY+h7TCH740
	 ZrGsTeeGHSi6hCd4zLYZK2FyPJb+Ut9WTJ0PANRm9TUgyKs2TjSdeT/bPCNoYjZ56Q
	 WsOI4cRy7uB1w==
Date: Mon, 11 Mar 2024 23:19:29 +0000
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 0/6] Fix double allocation in swiotlb_alloc()
Message-ID: <20240311231929.GA28478@willie-the-truck>
References: <20240308152829.25754-1-will@kernel.org>
 <20240311133617.GA1349@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311133617.GA1349@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Mar 11, 2024 at 02:36:17PM +0100, Christoph Hellwig wrote:
> 
> Thanks, I've applied this to the dma-mapping tree and plan to send it
> onto Linus after a bit of soaking time.

Cheers, Christoph. I'm suspecting we'll have a few extra fixes as we
collectively get a better understanding of this code (and also as Petr
develops the selftests), but we can send those on top of this series.

Will

