Return-Path: <linux-kernel+bounces-94982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40EF874787
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D802A1C22825
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3DB1B299;
	Thu,  7 Mar 2024 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X3+nzqBK"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCAF1C36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 05:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709788070; cv=none; b=DHqk4B2CE88RiHqA/5/SlzPUe02u1oFNsDFuq+omoVMHPpIkYDy4pPxKNlnHjNsnbCn7vDJS3BhJMOcPZr9+iqtpG2E+c5Vha8LNrUenG2jS6QJIbdOLT4YteSzI6hy0eH3jc/5JUz8NeIGfvOAPKZHrdQ3AFNCkVhGuLYxGbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709788070; c=relaxed/simple;
	bh=oYE+nijeiM+2idL6blAp+yPOeQw2sqO9NzzJO5bF9Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjP+exIHUocMV9nQ8/cl/UDSba/5PvLuupThbP01TI17pQAZA0CjGSQ1hFZElZ/5vhrztFuc27DqDAAZnYvMUwBnrmo/IASoLmoX9mdM/3C/T7k4FmzzrdYLJyVWDhG7kP/h0ph3RnMjq6BaSYkB762fIJTxlHvJU8dulHZIHYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X3+nzqBK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uyw322A03RBS5tbmGT647PAFtATngAMN6Haf+EFXJ4w=; b=X3+nzqBKmPLMoRnNLworhQCBjI
	/POHGz/irBPUC6/tQ+RC7hAnb0TDjMdaPgT1wQ3NI+4M3RHDyXSSaoHooaJfdvqK4SIg9c3palj5R
	1FHa3Bam8Zw4E9SKFhm+iFHkjyjkt/n6DnIJ1Zvd3KmsUHQub1h4XddPOPJpgxHYJuvOeqZwGYbaG
	2CcD3tKIT6yugEKnWscSJYkK9R2Ar7dUk3S1fcR+Wk9F2CqOcavJrkDqyd8QNga1fZoiGWJ+jCB6e
	mOLRcKdwS3v7DR0sf6cFlcdr3grq7MexW8tHWqwnVm0YM+E1aZhetqP+rJwnKBN9fuQrWih+mSNq+
	193xzFOw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1ri5yP-003Byp-1g;
	Thu, 07 Mar 2024 05:07:17 +0000
Date: Thu, 7 Mar 2024 05:07:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
	huyue2@coolpad.com, jefflexu@linux.alibaba.com,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	houtao1@huawei.com, yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH] erofs: fix lockdep false positives on initializing
 erofs_pseudo_mnt
Message-ID: <20240307050717.GB538574@ZenIV>
References: <20240307024459.883044-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307024459.883044-1-libaokun1@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Mar 07, 2024 at 10:44:59AM +0800, Baokun Li wrote:

> +static int erofs_anon_init_fs_context(struct fs_context *fc)
> +{
> +	fc->ops = &erofs_anon_context_ops;
> +	return 0;
> +}


ITYM
        struct pseudo_fs_context *ctx = init_pseudo(fc, EROFS_SUPER_MAGIC);
	return ctx ? 0 : -ENOMEM;

and to hell with erofs_anon_context_ops, along with its fill_super, calls
of simple_fill_super(), etc.  Unless I'm missing something, you are not
even creating dentries here, let alone making them possible to look up.

> +static void erofs_kill_pseudo_sb(struct super_block *sb)
> +{
> +	kill_anon_super(sb);
> +}

*blink*

What's wrong with simply using kill_anon_super as ->kill_sb?

> +int erofs_anon_register_fs(void)
> +{
> +	return register_filesystem(&erofs_anon_fs_type);
> +}

What for?  The only thing it gives you is an ability to look it up by
name.  Which is completely pointless, IMO,

>  	if (!erofs_pseudo_mnt) {
> -		struct vfsmount *mnt = kern_mount(&erofs_fs_type);
> +		struct vfsmount *mnt = kern_mount(&erofs_anon_fs_type);

.. since you are getting to it by direct reference to file_system_type
anyway.  Same unregistering, of course...

