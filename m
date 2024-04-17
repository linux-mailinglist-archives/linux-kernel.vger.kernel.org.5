Return-Path: <linux-kernel+bounces-148868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E2D8A8855
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47E31F21A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D4014882C;
	Wed, 17 Apr 2024 15:59:20 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEDB14830C;
	Wed, 17 Apr 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369560; cv=none; b=BKgbpkgOL8HxXcVRTxHyi9Kl5EMJlZfLAE/eVcWzSRxLgpVJ4GLVXjcq0yk0dU37yO2yAcFmseuew+g9Qe2Mx+i+r96OBIbIKH4L+8TY/gmQoozC5yC6u4oVNcRDtF++oZUjkllZ/5ESbcILfwQ2XsjSu64kyqYm6bDXrDU72eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369560; c=relaxed/simple;
	bh=g8B/qc2nj/2LNEeHjA90kGiWc8nVUDO/Ixkq3MFkruQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL+H5eC6j9DGVfxAQ0gWSyqhsYE5/gJLIe4U4Euox/EMTSpVCrHjXFPQ4g5sy4nNgFVcS2i0DKu5nOq8mZgcKb/dPBJXI5HZHtHJ8EZF0s6/utfHNh+W4ugev95CYPb0A+TuJHbx8W9CaujaEKiF4IDoHQtJMZEQo4Z7pwmHe4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 12D6068CFE; Wed, 17 Apr 2024 17:59:14 +0200 (CEST)
Date: Wed, 17 Apr 2024 17:59:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: API break, sysfs "capability" file
Message-ID: <20240417155913.GA6447@lst.de>
References: <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info> <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com> <ZhRSVSmNmb_IjCCH@gardel-login> <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com> <ZhT5_fZ9SrM0053p@gardel-login> <20240409141531.GB21514@lst.de> <Zh6J75OrcMY3dAjY@gardel-login> <Zh6O5zTBs5JtV4D2@kbusch-mbp> <20240417151350.GB2167@lst.de> <Zh_vQG9EyVt34p16@gardel-login>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh_vQG9EyVt34p16@gardel-login>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 17, 2024 at 05:48:16PM +0200, Lennart Poettering wrote:
> Block devices with part scanning off are quite common after all,
> i.e. "losetup" creates them by default like that, and partition block
> devices themselves have no part scanning on and so on, hence we have
> to be ablet to operate sanely with them.

Maybe and ioctl to turn on partition scanning if it is currently disabled
or return an error otherwise would be the better thing?  It would
do the right thing for the most common loop case, and with a bit more
work could do the right thing for those that more or less disable it
graciously (ubiblock, drbd, zram) and would just fail for those who are
so grotty old code and slow devices that we never want to do a partition
scan (basically old floppy drivers and the Nintendo N64 cartridge driver)


