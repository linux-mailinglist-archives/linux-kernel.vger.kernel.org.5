Return-Path: <linux-kernel+bounces-83347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D315D869422
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87051288A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FFF145B32;
	Tue, 27 Feb 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XkJJBI+n"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421F13B2BA
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041812; cv=none; b=uq3m9eEIkfxoNVluZ1T7P+YfrJlX4KxhQV99Xw7aJOiQ/DWid7lkzrC+/+iEw6/DXY63LUn7D/XxYx5E/5PAWZIoZf8lMXLXUu76CkMLrMTZHvvvxoPFZuPQDqlxo92D1qnfWsnpRBA3xdZuuMy8SMThJso+YOAuE4tMyp2BkX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041812; c=relaxed/simple;
	bh=FssauYjLB9dKTZJiqjGG1N3fH5I5oAYipea2Zvc/7B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7Cl+PIo6/HAo1aQHro9yisSXT3nOD4ceysnSGGLF3TyofALBhSFZDbaTpNHHiOtXUz+ppRd1vS1D1rijxGiQfOfKpwoPvvHnVJBTUJji9bdvA4GgbYomCgUQi3y1pBbuUYHwNktjAqRHxpOrKxR085ciPOskzwtJt1TsYudWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XkJJBI+n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V89YttMzF7GfHZnp7dBKJwU1XvvYwOCRmIBdLBD+tow=; b=XkJJBI+n38xVDB8ZfjNw8wdq96
	5OUkDkqG9WKZ6dOnOmRfSHMep939vdTgegZV44Wi1sqLjO1jnW7bHhpVPlEOpYxjlwi6WPkQO3+oi
	phFxJii0agwx4K9b0TxjJ9D8k2HOUfUWZsXyNtLIHpXOw/CC8v2CHIzzZff+Mhhljy/FioJbmXWaL
	+RC03+abBVQcJy9to+88hp63DCOv05hx2kX6yS9LpUo53CGg15nv/IqgIEilkuRtifh/DbL6lAdOK
	cuBcR/XnKZqHtNps7wkZ4S8gTvzxFpgvM2D2dLW6AeHKPdzkU3Wp6DfAV5Wp0M9rfLdj9yhcClxYG
	5l7knQ+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rexqT-00000005SSP-31qG;
	Tue, 27 Feb 2024 13:50:09 +0000
Date: Tue, 27 Feb 2024 05:50:09 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
Message-ID: <Zd3oke0pAL2G05Rj@bombadil.infradead.org>
References: <20240222145819.96646-1-john.g.garry@oracle.com>
 <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
 <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
 <Zdy9gKO5Q6K4IE8J@bombadil.infradead.org>
 <ZdzGF9bxLn3Slbgi@bombadil.infradead.org>
 <cb0c185c-54f8-4b43-856f-685cc5ed3fc4@oracle.com>
 <Zd3cz7yYezir-P7e@bombadil.infradead.org>
 <e88b76c5-1b13-4ad7-a97d-c34722cfde19@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e88b76c5-1b13-4ad7-a97d-c34722cfde19@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Feb 27, 2024 at 01:02:26PM +0000, John Garry wrote:
> On 27/02/2024 12:59, Luis Chamberlain wrote:
> > What kernel are you seeing this issue on?
> 
> I was testing v6.8-rc5 last week

I cannot reproduce a hung task there either on that kernel.

I see this:

sysfs: cannot create duplicate filename '/devices/virtual/misc/test_firmware/nope-test-firmware.bin'

But these are expected as the selftests tries silly things to ensure
they are not allowed.

If you can reproduce it there, it would be appreciated if you look underneath
the hood a bit, or share anything glaring and obvious which may help
reproduce this.

  Luis

