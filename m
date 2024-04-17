Return-Path: <linux-kernel+bounces-148885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF548A888F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C8628665C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB0015E7FE;
	Wed, 17 Apr 2024 16:10:26 +0000 (UTC)
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE52114EC79;
	Wed, 17 Apr 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370226; cv=none; b=c7Ll6oRj7NjruDlNb54Z+6qQOe1wdzpQr4bE+fSH+o6P/f7CsbOSMldH2xizsl5xCdmvXGBFboLdpvQgBY8kL7IsrhQaeykYT42VjXOQb6eWC58p6aABaCCjkRaqwSx+ej+DhsU+gGtxmkelbrW2/4HK/n2x+mU0UYr7yy6F8aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370226; c=relaxed/simple;
	bh=gSfe2mh9bkp+vU+sT4Snqq3+U6upnEe1SHDBCsuBkkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e15exCaT8DqaXmuNjmJyZzyPFW7tWlfPnP2WiBhA15aNX5R+hSN2EtE1tOvuTk3f2JfsrDfMnNxtf/5oDb+RPmeuXVB8cRBvgtDmfj+uhlbQn4Br/+k7FqDJ5zf+QZ8hP+YmHWliKxWy9/wTNdfz1KiRkP+gFsVRQ9UU/tFerhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 8987CE803C0;
	Wed, 17 Apr 2024 18:10:21 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 430131602F7; Wed, 17 Apr 2024 18:10:21 +0200 (CEST)
Date: Wed, 17 Apr 2024 18:10:21 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <Zh_0bfqBsJFyJKgT@gardel-login>
References: <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
 <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
 <ZhT5_fZ9SrM0053p@gardel-login>
 <20240409141531.GB21514@lst.de>
 <Zh6J75OrcMY3dAjY@gardel-login>
 <Zh6O5zTBs5JtV4D2@kbusch-mbp>
 <20240417151350.GB2167@lst.de>
 <Zh_vQG9EyVt34p16@gardel-login>
 <20240417155913.GA6447@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417155913.GA6447@lst.de>

On Mi, 17.04.24 17:59, Christoph Hellwig (hch@lst.de) wrote:

> On Wed, Apr 17, 2024 at 05:48:16PM +0200, Lennart Poettering wrote:
> > Block devices with part scanning off are quite common after all,
> > i.e. "losetup" creates them by default like that, and partition block
> > devices themselves have no part scanning on and so on, hence we have
> > to be ablet to operate sanely with them.
>
> Maybe and ioctl to turn on partition scanning if it is currently disabled
> or return an error otherwise would be the better thing?  It would
> do the right thing for the most common loop case, and with a bit more
> work could do the right thing for those that more or less disable it
> graciously (ubiblock, drbd, zram) and would just fail for those who are
> so grotty old code and slow devices that we never want to do a partition
> scan (basically old floppy drivers and the Nintendo N64 cartridge driver)

Well, there are plenty of other block devices with part scanning off,
such as DM, including dm-crypt, dm-integrity and so on. And that's
certainly stuff we want to cover for this.

Lennart

--
Lennart Poettering, Berlin

