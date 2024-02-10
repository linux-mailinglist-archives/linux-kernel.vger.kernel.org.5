Return-Path: <linux-kernel+bounces-60446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED5985050B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD721F21E57
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3F65C5E2;
	Sat, 10 Feb 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKZCwunw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71936AFB;
	Sat, 10 Feb 2024 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707581490; cv=none; b=HSW5gHpGi55W6gOhWyHHxDvRixyoexyProHc4P8EzSvLRHwNVjyjdAGuycFrgZ8W2i87didZfxXhXjKK8v63jTo9gspaAAth+B7TICDozJgEc+wMZB3/IHrr2qhKTQrpZj3BbTA1x3lyh0+6I1M4gK0Q09Z1C++P5DBIu+Qn0PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707581490; c=relaxed/simple;
	bh=54etm7OxNpF3pRXei+kIb6Yk6RYbXbxS/ugDHuCmZoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6/IQsVcyxB7vMkTO7TY4c9y3IPQkmhAxmIU/ecObgFQL+q4m5wSmhp1KbBAHUZrvUQyXFUnY99uGfxH6HBdVOaRnAyv2TciPUn6LqE4hVMa8rpFHxVHJ8O5WaePME1uhPssGY5/rhxNSN+i0yCZYSsYsvdBR7OpsM9u9xBfv4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKZCwunw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E63C433F1;
	Sat, 10 Feb 2024 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707581489;
	bh=54etm7OxNpF3pRXei+kIb6Yk6RYbXbxS/ugDHuCmZoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CKZCwunw2bFQPUOHKK4gMoee1PtbuhuPd/+hRKGkyQdgRpNA+rxImBqaXRu6B24Uj
	 xiDQN5re3AtXmS3FFf3XFJ3DzmGuPt83kOaaKUIHu4wtwWVXtGMDj5Z8gwyhrDNJcS
	 k+bwf74gXwwzdhJ+CqF9XSW3TQT+Z/glHt4pgdt1gaYI239Xw3n5l9xZt+rdUeBpzM
	 V0ely5wqeHWAzxOyxINc/kOuA/yzYyDUDkPt7tc7oEZDhDtw6jb+Z9ZokxJgPFIDWJ
	 eSj8/F4QrAwZQM1UPkcwVf4FU8DCivhDUCXZNP9liTr00YRRNmUd7Rvt0JtqO2m/wW
	 yn/0eW7en1nHA==
Date: Sat, 10 Feb 2024 16:11:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Li peiyu <579lpy@gmail.com>, Lars-Peter
 Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: humidity: hdc3020: add threshold events support
Message-ID: <20240210161117.1bb3dd7f@jic23-huawei>
In-Reply-To: <20240205095323.GA2323766@debian>
References: <20240204103710.19212-1-dima.fedrau@gmail.com>
	<20240204144347.7f0eb822@jic23-huawei>
	<20240205070421.GA2264419@debian>
	<20240205093349.00003e10@Huawei.com>
	<20240205095323.GA2323766@debian>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > >   
> > > > As I mention below, I'm unconvinced that it makes sense to handle
> > > > these as pairs.
> > > >    
> > > For the threshold I could convert it as it is for the heater registers:
> > > 
> > > #define HDC3020_S_T_RH_THRESH_MSB	0x61
> > > #define HDC3020_S_T_RH_THRESH_LOW	0x00
> > > #define HDC3020_S_T_RH_THRESH_LOW_CLR	0x0B
> > > #define HDC3020_S_T_RH_THRESH_HIGH_CLR	0x16
> > > #define HDC3020_S_T_RH_THRESH_HIGH	0x1D
> > > 
> > > #define HDC3020_R_T_RH_THRESH_MSB	0xE1
> > > #define HDC3020_R_T_RH_THRESH_LOW	0x02
> > > #define HDC3020_R_T_RH_THRESH_LOW_CLR	0x09
> > > #define HDC3020_R_T_RH_THRESH_HIGH_CLR	0x14
> > > #define HDC3020_R_T_RH_THRESH_HIGH	0x1F
> > > 
> > > or:
> > > 
> > > #define HDC3020_S_T_RH_THRESH_LOW       0x6100
> > > #define HDC3020_S_T_RH_THRESH_LOW_CLR   0x610B
> > > #define HDC3020_S_T_RH_THRESH_HIGH_CLR  0x6116
> > > #define HDC3020_S_T_RH_THRESH_HIGH      0x611D
> > > 
> > > #define HDC3020_R_T_RH_THRESH_LOW       0x6102
> > > #define HDC3020_R_T_RH_THRESH_LOW_CLR   0x6109
> > > #define HDC3020_R_T_RH_THRESH_HIGH_CLR  0x6114
> > > #define HDC3020_R_T_RH_THRESH_HIGH      0x611F
> > > 
> > > I don't know if it's a good idea, as we would need to make sure it is
> > > big endian in the buffer. Probably with a function that handles this.  
> > I think this is the best plan with a
> > put_unaligned_be16() to deal with the endianness.
> > The compiler should be able to optimize that heavily.
> >  
> I think that would require some refactoring. I would add patches that
> are fixing this. Have there been reasons for using the pairs ? I'm just
> curious.

Not that I can think of. Maybe how they are represented on the
dataheet?  Often people just copy that stuff without thinking
about it (I know I've been guilty of this ;)

Jonathan



