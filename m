Return-Path: <linux-kernel+bounces-95046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CDC874891
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CDB1C20EBB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEDE1D54D;
	Thu,  7 Mar 2024 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I3u7exF8"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679F21FDD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796105; cv=none; b=DqZhU/yPvPCsc0miWFOJoaVNMKAxQditxJeEKR0f61Na2mVyPzg/DKzZKQIixiAc1crXKB7gxUU/s+EL1YWae06oHcbTpU0LLf1ayl2YafVD8sf+Cip7dypBlTx5Ho3ZMuVVTnR69a7MJ9ZgwRcD8j5PXHyphqTN0GqksofzvOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796105; c=relaxed/simple;
	bh=MqVBXUoVntZHD125v6N35fVG05A3BHyjL4XSvBEiedY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG/rRSMO3XgoQ68XxGH9qsvp+Pc8zGMhQrk1inOVBZ4dgl5WxpOHKxuNASVY0AP1q/G0DwWQg3RiNhIZIdFfqyhudnu47Zg9j1eGmOE4UWgkBQuj+TNq0mKlXa0uq7BlU9t5+3mq9DXAOmd9iMH6RugkLlYRrrOUZteqDYoHFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I3u7exF8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8w8rejYB9PBmKB0DYtImdRxvM7rQ/tJG4QSkTuHYLXw=; b=I3u7exF8LYo6EnYsylcAmUSP+Z
	R0i7G9s8p9OgKJN6jlZEfFTBNB+jIFnUR2Lfe+LMXnV1DiqReY6K+WzE/3TFxRtOWELmj2CYfDslt
	2gyw22XfQUJ+JtsoAg63qUO7FmSMcl6Hp+1CuLtV1n5KaUrc+IPZKYeSMBrnW1ra+nuJY8k1VSx4Z
	lDGuSBayME4GraArPrhR2obfaG+oUcwaJU4FKq0Rl2Q8b68HSjbdBfK3y267PwUK24ePKDf0osb9T
	LVY5we2/bTF4Tp3weeVUVNxuH3EGW+4c7PmAi/fC0hYmQrR11bKHhVw1fb/O0IRUGsioIkaRPhQzt
	Z+CFRwkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ri841-003FW0-06;
	Thu, 07 Mar 2024 07:21:13 +0000
Date: Thu, 7 Mar 2024 07:21:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
	huyue2@coolpad.com, jefflexu@linux.alibaba.com,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	houtao1@huawei.com, yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Message-ID: <20240307072112.GC538574@ZenIV>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <20240307050717.GB538574@ZenIV>
 <7e9746db-033e-64d0-a3d5-9d341c66cec7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e9746db-033e-64d0-a3d5-9d341c66cec7@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Mar 07, 2024 at 03:06:49PM +0800, Baokun Li wrote:
> > > +int erofs_anon_register_fs(void)
> > > +{
> > > +	return register_filesystem(&erofs_anon_fs_type);
> > > +}
> > What for?  The only thing it gives you is an ability to look it up by
> > name.  Which is completely pointless, IMO,
> The helper function here is to avoid extern erofs_anon_fs_type(), because
> we define it in fscache.c, but also use it in super.c. Moreover, we don't
> need
> to register it when CONFIG_EROFS_FS_ONDEMAND is not enabled, so we

You don't need to register it at all.

The one and only effect of register_filesystem() is making file_system_type
instance visible to get_fs_type() (and making it show up in /proc/filesystems).

That's it.  If you want to have it looked up by name (e.g. for userland
mounts), you need to register.  If not, you do not need to do that.

Note that kern_mount() take a pointer to struct file_system_type,
not its (string) name.  So all you get from registration is an extra line
in /proc/filesystems.  What's the point?

