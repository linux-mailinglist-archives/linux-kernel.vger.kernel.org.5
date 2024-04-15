Return-Path: <linux-kernel+bounces-145911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C168A5CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE3A1F23A05
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6641E15746D;
	Mon, 15 Apr 2024 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="auh6ZTKh"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3587F156F2C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215310; cv=none; b=i3Nvdch4ZigQAeHowuMxJhB1dsanuho8daU0C9Vrnrwu+kiDDnIar7DUNanfoQv0/OahBrUgBbP1OR8ObvfhhY2Tl/MyhAv+u2+hPGwAGK/j0XoAUHQ2bZiSoJbwn0K4KcLbGuYsE5s1jK52uQYKoYm8K4ZjWqyee65XLmF91ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215310; c=relaxed/simple;
	bh=9zW25fHq1ZD5HHdi3TNMFeS3vITYxyMxTWLWlaElhF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6lyGSVQg7lfZKB68M3M/y4TYhqd3wOrdSjdvFfEjL1taRvVrKz3jAdijUEnuU1hWkCUQkmy1mX1082yboaQA6PmwT2nxRSIfGuyawSn3qjlvRLPzXVKSIx2Gapm+1qwBO7ENoDnEFWaYdcrZQKZlHLJ5sQGtJjysHa5wfQDmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=auh6ZTKh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QgpRX25WcBTadwRMQIY0mjh2vDCvBvK7RwDvhG8WPMY=; b=auh6ZTKhB8miyj5dBJcEPZNfSn
	06AE3PCeyrOEX1A7zSx2wBfefOd3GvJAb24Al7vZBKJekMrxLMmJECCRbA6g+zOh8J0FPzgdoH8Ui
	NJ/2YRqviFru6OSZyb+gCUNsJ8BD9qK5jU8+aFkKuHfz9+nEJLU7XPoMu/82w0jF5w+LfaOnLaW4W
	sgVUc9EDTdjR32ogzTsaMFf3haNUmTb7ugRF943H4PDXr4VowWIQx6lg1ER+zvOScFSHo3gRN4/cp
	XEKXSLNDuwi1bjiQRJtf8kFCvNePCbvAITZH6/yAsn0Pqq5voPRoSrPJ1ui5QHAp6b9z62A8i+QPg
	uILARhBA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rwTYx-00D1Au-1A;
	Mon, 15 Apr 2024 21:08:27 +0000
Date: Mon, 15 Apr 2024 22:08:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 002/437] fs: add generic read/write iterator helpers
Message-ID: <20240415210827.GX2118490@ZenIV>
References: <20240411153126.16201-1-axboe@kernel.dk>
 <20240411153126.16201-3-axboe@kernel.dk>
 <20240415195504.GU2118490@ZenIV>
 <898afc09-428f-4da2-a620-d7ca9f37133c@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898afc09-428f-4da2-a620-d7ca9f37133c@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 15, 2024 at 02:11:56PM -0600, Jens Axboe wrote:

> do_loop_{readv,writev} need to look like the one io_uring had, which was
> just an augmented version of the fs/ version. At least for handling
> anything that is IOVEC/UBUF/BVEC.

IOVEC and UBUF: pointer will be __user one; copy_from_user() works.
KVEC: kernel pointer.  Try copy_from_user() on that on x86 with SMAP (or
on e.g. sparc64, etc.) and you'll get an oops.
BVEC: page + offset, page quite possibly not mapped anywhere in kernel page
tables.  And "just kmap() around the call of your callback" is not a good
idea either, for even more reason that for KVEC.

