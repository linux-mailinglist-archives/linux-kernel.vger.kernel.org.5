Return-Path: <linux-kernel+bounces-83357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0762186947C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5240283826
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F44713B2B8;
	Tue, 27 Feb 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ko142coj"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BDA13F01E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042009; cv=none; b=oFyKoPrOcgF34F8nDbj35UkWyCgAfIFAqal3W1sxGML8J0TWmAYG7Kjyr6LR0Gir9K8WnHVjzLs0x5Ybv/jjdz31meBnzQtiihEjhiZs/aZD6UuP+Y0UkJmGLS7igoTQGxi13QcAUA2crIGYCnhv4BlX6ezZ854XOHXzMqXse0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042009; c=relaxed/simple;
	bh=vJM3oeY3a5yuw5ESJpSpXM/CF6QkURMLP9v+vlakGJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d188i/zwVPJMfMA1j3IbhjgyYqMRCFUME7Y7XKezZrsxvQUUzoVFyowfdCZFZji9jSsp7ctz8WpNjufHvqvJkQL5b+sozObx8lShl4k0Wr+WV/wcnO//kmBPYIE5J48oGghm7NAYHHueE198rqGGIAmbRaWh39yanYoxSwdj5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ko142coj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UXzdUvtckRRGJh6Ckk2kLzCUVP4nNZ4s72FUmAMgy6Q=; b=Ko142cojDS6uOO7eNC6t2VmVE8
	5zZ6t3f7JVCccQfTAfIbmFQufjnDhBJ9w2+jRiaU4YgxXCOrRW+MJAvet2R2Od3QkCwnlM5DFZ7ah
	0iSfL8OtMuGQmD2qmGWJFPScgsmh8SNe53FfUTvk8MLGRlyfODfpHoSvnvPt3z79RnMhg+w/3cIaD
	dXwJEBTDva2fK7ZmZnPaexhSvgaHY0ijHE+fuBpmRuQTt+FywGxuqQIu8T/51idBS4EDf++ISwrcg
	ecqyuXTUB4qZmpFI9xugCfYuKf2MPdDex9U6afa1sNdhBN8NXDjS0ejixuZ9dGzS5Xe1ybC6ks8sR
	0KXamdnQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rextf-00000005TF0-2YnP;
	Tue, 27 Feb 2024 13:53:27 +0000
Date: Tue, 27 Feb 2024 05:53:27 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
Message-ID: <Zd3pV7HJEhTjBRz_@bombadil.infradead.org>
References: <20240222145819.96646-1-john.g.garry@oracle.com>
 <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
 <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
 <Zdy9gKO5Q6K4IE8J@bombadil.infradead.org>
 <ZdzGF9bxLn3Slbgi@bombadil.infradead.org>
 <cb0c185c-54f8-4b43-856f-685cc5ed3fc4@oracle.com>
 <Zd3cz7yYezir-P7e@bombadil.infradead.org>
 <e88b76c5-1b13-4ad7-a97d-c34722cfde19@oracle.com>
 <Zd3oke0pAL2G05Rj@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd3oke0pAL2G05Rj@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Feb 27, 2024 at 05:50:09AM -0800, Luis Chamberlain wrote:
> On Tue, Feb 27, 2024 at 01:02:26PM +0000, John Garry wrote:
> > On 27/02/2024 12:59, Luis Chamberlain wrote:
> > > What kernel are you seeing this issue on?
> > 
> > I was testing v6.8-rc5 last week
> 
> I cannot reproduce a hung task there either on that kernel.
> 
> I see this:
> 
> sysfs: cannot create duplicate filename '/devices/virtual/misc/test_firmware/nope-test-firmware.bin'
> 
> But these are expected as the selftests tries silly things to ensure
> they are not allowed.
> 
> If you can reproduce it there, it would be appreciated if you look underneath
> the hood a bit, or share anything glaring and obvious which may help
> reproduce this.

I should also mention, kdevops [0] has the linux-firmware selftests and that
has our kernel config used too [1], you can easily build the selftests
and re-retst then manually on the guest. Soon we hope to leverage this
for automation with 0-day so to ensure keep tabs on all of linus'
kernels and linux-next.

If there is anything we should add to our general config it would be
good to add it there.

[0] https://github.com/linux-kdevops/kdevops
[1] https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/bootlinux/templates/config-next-202401080

  Luis

