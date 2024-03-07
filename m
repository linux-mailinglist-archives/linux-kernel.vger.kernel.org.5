Return-Path: <linux-kernel+bounces-95159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AD7874A0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB67A1C2203B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86F682D70;
	Thu,  7 Mar 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IBzj6REx"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BB45C15
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801195; cv=none; b=GVDztoQTZyQXsvnpfKsCqw2k0MookIk7APM/O5U1KIEaqkxHuaUl27bdGz3n8b0aUZ/KWMg0M++Lr8f3cSJpePd9hg8RIUTDlUsvTjXgIW505qLs42srbBghaOFgKOLqmeRmjkZ/9DI/IaAHwsLUnJuOm4kXCRQCnCDE+ZELv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801195; c=relaxed/simple;
	bh=B8rF0Jgt083BrIFJTK3vo/LR/Bq3wibnwWkiw619ZH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF52ri8JfrywSJl+6Gv0p1yOxGxRztpkCKpmhphI+8vRCX2HkTCXj7nHOd47b8ZW2lziSebxwVn0MjbcJbmN6OPv49Yxy7fT47TtgdAGNi8j5GsQeW7GNyONf/auhcdHQ6wr4XOB+exA2jymTJLsG9Rhtf8C9uudMgaY/XSFyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IBzj6REx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oieFStbvkFT9rV4WJJTmWpFLLGbMeU8DfdLJw5moAO4=; b=IBzj6REx7hZVeSsZnjVykFhDBj
	EFlWxMO2SWBcKgMNNLnfEcmqFBMtKbWlbhEdWrUNlgsESlSvwa0hHQoqxTvrOE9s9hod6lp4WHdmH
	382pU3oEAH+9CFHmrRo2vqEWoAE9P9qGzpfYcM6jZacC2c7/bJZEReeQW2A7zNde08Qm5RFBKWZLt
	80W7svy6sJjflWQqFc67lJAQzn6jjc2BVFqXkLYkE78tCePMr8r4IDMTZmMFLnzDWJyFrRJhWn4cO
	mZqlq5Ca9Wlrrm2RYxMbI0qfsP3P/GrSSje3xOYyX20akrp5lu1OAt8doPxEkOb8rOB/iZ9zxtxzf
	CQDjQihw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ri9OC-003Hj7-1h;
	Thu, 07 Mar 2024 08:46:08 +0000
Date: Thu, 7 Mar 2024 08:46:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
	huyue2@coolpad.com, jefflexu@linux.alibaba.com,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	houtao1@huawei.com, yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Message-ID: <20240307084608.GD538574@ZenIV>
References: <20240307024459.883044-1-libaokun1@huawei.com>
 <20240307050717.GB538574@ZenIV>
 <7e9746db-033e-64d0-a3d5-9d341c66cec7@huawei.com>
 <20240307072112.GC538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307072112.GC538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Mar 07, 2024 at 07:21:12AM +0000, Al Viro wrote:
> On Thu, Mar 07, 2024 at 03:06:49PM +0800, Baokun Li wrote:
> > > > +int erofs_anon_register_fs(void)
> > > > +{
> > > > +	return register_filesystem(&erofs_anon_fs_type);
> > > > +}
> > > What for?  The only thing it gives you is an ability to look it up by
> > > name.  Which is completely pointless, IMO,
> > The helper function here is to avoid extern erofs_anon_fs_type(), because
> > we define it in fscache.c, but also use it in super.c. Moreover, we don't
> > need
> > to register it when CONFIG_EROFS_FS_ONDEMAND is not enabled, so we
> 
> You don't need to register it at all.
> 
> The one and only effect of register_filesystem() is making file_system_type
> instance visible to get_fs_type() (and making it show up in /proc/filesystems).
> 
> That's it.  If you want to have it looked up by name (e.g. for userland
> mounts), you need to register.  If not, you do not need to do that.
> 
> Note that kern_mount() take a pointer to struct file_system_type,
> not its (string) name.  So all you get from registration is an extra line
> in /proc/filesystems.  What's the point?

PS: at one point I considered renaming it to something that would sound
less vague, but the best variant I'd been able to come up with was
"publish_filesystem()", which is not much better and has an extra problem -
how do you describe the reverse of that?  "withdraw_filesystem()"?
Decided that it wasn't worth the amount of noise and headache...

