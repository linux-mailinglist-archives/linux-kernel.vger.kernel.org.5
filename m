Return-Path: <linux-kernel+bounces-85249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CF486B2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30611C2342F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B8515B990;
	Wed, 28 Feb 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KusPzsI2"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479315B0FD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709133515; cv=none; b=PFBr0T4m+BVjRWmqLWdP4NAz5pM+C8P6wKSxSPxmfmKoC+3A9YGKidCbvQ4bYyunSO24vMLY53KIPfgfj/e2lvhlCbP30s09E410skqdimlNUJsXJX3BYcx5vFGTuNo9GC/4HOeHjUkF6i3JxpiqYj6BZbampLa/2Wdvrj9bmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709133515; c=relaxed/simple;
	bh=6s8OHUquxGrH4EcHy+RjyOCr9ajq3Tj+zbTZZwX7wNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdfH6M4OVitoTNKNuZrPBeIEhPrndyeMdNdTLS94ICMG1md/NWxQb+BS1Jadio6dyR7prtGUrvyK5i1yGgOnfy0qswu3gSgR4rimDbZwhEcS7QovGUt1Xlc6kiR5LqWBxNdA6QZ2HcwM5T46UFhQ9ODy0CEYNuKYGpnCkfDubyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KusPzsI2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hpsjIaNwbZUEDCtmuBlkk6Ipl9L9Eve/Vjy0IMis2+I=; b=KusPzsI2gV02szt6TfKdDtQLv7
	XZjaLn2Mh35zSumxfoXILJEv/VifsxJO8pVEOBdvNAwdJAJmKa4/4UGgxHsqfC5+AzogxlqBOkSeH
	7HDGJfHVnK2U5vnzEAqwvxut2CYsUQzwg5gF1LfT+aQGz3qPOl5Ek5vzu0FLjDDw0NPk4sdCwYnX4
	pmCdxC5QMkXmKUGYufYCBYYu2LW0z8GIpg867HrbaJhhBnMhnZ2t/tc7FFLdO2HFZCgKYCw/dROan
	kiIaN3FzL40pts52VTXi7AKmHRcBxzkKpDM0Wx3riYaMPIk3hy3z5P18G852h0UEdIKbezv35JUwR
	YiEHzQ8w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfLhY-00000009reW-3gd3;
	Wed, 28 Feb 2024 15:18:32 +0000
Date: Wed, 28 Feb 2024 07:18:32 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
Message-ID: <Zd9OyMTgtYcFSEq3@bombadil.infradead.org>
References: <20240222145819.96646-1-john.g.garry@oracle.com>
 <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
 <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
 <Zdy9gKO5Q6K4IE8J@bombadil.infradead.org>
 <ZdzGF9bxLn3Slbgi@bombadil.infradead.org>
 <cb0c185c-54f8-4b43-856f-685cc5ed3fc4@oracle.com>
 <Zd3cz7yYezir-P7e@bombadil.infradead.org>
 <e88b76c5-1b13-4ad7-a97d-c34722cfde19@oracle.com>
 <Zd3oke0pAL2G05Rj@bombadil.infradead.org>
 <a07db8f8-39f8-44ad-b466-10ac02f3da13@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07db8f8-39f8-44ad-b466-10ac02f3da13@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Feb 28, 2024 at 12:31:42PM +0000, John Garry wrote:
> On 27/02/2024 13:50, Luis Chamberlain wrote:
> > On Tue, Feb 27, 2024 at 01:02:26PM +0000, John Garry wrote:
> > > On 27/02/2024 12:59, Luis Chamberlain wrote:
> > > > What kernel are you seeing this issue on?
> > > I was testing v6.8-rc5 last week
> > I cannot reproduce a hung task there either on that kernel.
> > 
> > I see this:
> > 
> > sysfs: cannot create duplicate filename '/devices/virtual/misc/test_firmware/nope-test-firmware.bin'
> > 
> > But these are expected as the selftests tries silly things to ensure
> > they are not allowed.
> > 
> > If you can reproduce it there, it would be appreciated if you look underneath
> > the hood a bit, or share anything glaring and obvious which may help
> > reproduce this.
> 
> Update: commenting-out /lib/udev/rules.d/50-firmware.rules seems to make the
> test reliably pass for v6.8-rc5,

Great, note that if you had a hung task even with the udev rule that is
not expected and is indicative of a bug I cannot reproduce.

> but not with my patch on top - I still get
> a hang there. I'll investigate that hang with my patch.

So your hang is with the udev rule on vanilla v6.8-rc5 ? Because for the
life of me, I don't see it.

  Luis

