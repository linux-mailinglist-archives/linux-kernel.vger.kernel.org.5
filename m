Return-Path: <linux-kernel+bounces-19469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827FA826D6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D451F2282A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0E2420E;
	Mon,  8 Jan 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="akIgN35X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3292575B;
	Mon,  8 Jan 2024 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=cagyf7j04cToSXabvYW43dze5arP+lifLYmlhSYnUZ8=; b=akIgN35X1P9RGr00+WcbSHEpBA
	klW5ykJiJY05ljY+rZoWhILwOYxxB5r64OavHvm4Mje2AG/MKG48BzUAc+MPr+y8h5ThPd7K5s7ns
	wVBJ2PgIt7UT6nSxYuZx65QN6OVPQpYm+53lSlmUhkto9Gj4XtQLXy+OKwcFL//MWdWpTHOF1AtnZ
	kET5KB9UikjlWEuwPbZRQn4ro6TqGSxi8S4qttZW4qAVl/DbTlF9UDqpD9hM57PDFa3bq+S3P0L82
	deh4802xgtgzU2y3C67DKzHPgJJfJgEVR23qMs0jnspYyo+X5xA206XwzB9aOhJC2PXIaXEAVuT2S
	Wq+hliOs1vmiDVlzGD2Nqva6eedM/0/NIB1zYRFJM61FxEXLA1z83PIqINokjzDsSxU3HvwHBvK96
	C1kktiEoGfhm788/YST6bb5IW5hC9mNuIoCS00Ov0J9jtP2BCWPKdIep2zV+LktCw7Q2fKeJ/zg97
	mWJkHtXud5ApC9XPMfPGcSFf+panICrd6rQrgUHxCAuEcyiYNWZRDLCOxS3NinDc+VzBoaMEbOKIv
	i6KbywucrpnD+2lrY27plMaBE0AIcD37WhVnE/j7TKHUchJYfKaubZ8ZQh3pQW1TBL3W0lq5aKHMi
	hr7s7BZRrWVcM/8gK6nb41bF80Vo3NWbGJB/XNndY=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>, asmadeus@codewreck.org
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, rminnich@gmail.com,
 lucho@ionkov.net
Subject: Re: [PATCH] fs/9p: fix inode nlink accounting
Date: Mon, 08 Jan 2024 13:08:31 +0100
Message-ID: <8004884.rDQMAZhJ5Z@silver>
In-Reply-To: <ZZvaRt4T-RjOBoS2@codewreck.org>
References:
 <20240107-fix-nlink-handling-v1-1-8b1f65ebc9b2@kernel.org>
 <ZZvaRt4T-RjOBoS2@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, January 8, 2024 12:19:34 PM CET asmadeus@codewreck.org wrote:
> Eric Van Hensbergen wrote on Sun, Jan 07, 2024 at 07:07:52PM +0000:
> > I was running some regressions and noticed a (race-y) kernel warning that
> > happens when nlink becomes less than zero.  Looking through the code
> > it looks like we aren't good about protecting the inode lock when
> > manipulating nlink and some code that was added several years ago to
> > protect against bugs in underlying file systems nlink handling didn't
> > look quite right either.  I took a look at what NFS was doing and tried to
> > follow similar approaches in the 9p code.
> 
> I was about to say the set/inc/etc_nlink helpers could probably just be
> using atomic (there's an atomic_dec_if_postive that we could have used
> for the v9fs_dec_count warning), but this isn't our code so not much to
> do about that -- I agree it needs a lock.
> 
> I didn't take the time to check if you missed any, but it won't be worse
> than what we have right now:
> Acked-by: Dominique Martinet <asmadeus@codewreck.org>

That's actually a good point. For these tasks atomic inc/sub/etc are usually
used instead of locks.

I would at least add local wrapper functions that would do these spinlocks for
us.

However would it be too bold to change those inode functions to use atomic
operations directly on their end?

/Christian



