Return-Path: <linux-kernel+bounces-29088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA26E830840
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955C3287E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C89E208C5;
	Wed, 17 Jan 2024 14:40:07 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579220334
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705502407; cv=none; b=SCrynLLhcLoBez5tU9Vmu/zmy+ZBO1qjCSMOoSjOYR+Ow25Oa/T4dwQnXQ7+Deqnp3F5ejqocjpVnkecZE/u8ihKnoYpdvp+/orYDX3sbz2rVajkoIF9pJEHx7Yv4jwvWl0honr3F4twKTCZiJTu2HGN7ZvvHoB6iMgQzFzAGYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705502407; c=relaxed/simple;
	bh=bTVdI825Tkl/OlYsGpiZED35R2B24kkizDdJnyf/b34=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent; b=vEiXgLNFb6LThJaxfzFjR2Wr/CeqyPNHY9EGSUxur2JUMjwIb0fAYm8owNn5z+p0eIEGrFvbGbDvmGlATcs2YSBx2by7pH0IYHrUe0Vu9UY37uyPzRjrrMCUnLOS2onwiOlYOb5mP09r9p3DSMT/2hBPdS/l+da8nNh0Wu/zIPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 36CD268CFE; Wed, 17 Jan 2024 15:39:52 +0100 (CET)
Date: Wed, 17 Jan 2024 15:39:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: mengfanhui <mengfanhui@kylinos.cn>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: fix bogus request queue reference put
Message-ID: <20240117143952.GA27918@lst.de>
References: <20240117065043.79192-1-mengfanhui@kylinos.cn> <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 17, 2024 at 04:04:12PM +0200, Sagi Grimberg wrote:
> How did you see this? disk->queue is allocated in blk_alloc_disk called
> in nvme_mpath_alloc_disk... I don't understand how you saw the same
> dereference that was addressed by this commit.

This looks like a backport of an old patch of yours to a geriatric
kernel to me..

