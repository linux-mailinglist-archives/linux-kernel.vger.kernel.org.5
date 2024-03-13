Return-Path: <linux-kernel+bounces-102539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C078887B393
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBC3284448
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4166353E2B;
	Wed, 13 Mar 2024 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="GiBhUP0A"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3431A38DC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710365853; cv=none; b=bR9RNNt4GLYqSuY07MmS6V3hL2pFLs2ROOmbPgA3l56fp93Mo9niBKQudKyI4SbPVYVXIhZbXY5Tv0J0sdP/UEnO6/4VNkHeGMYOhyq5uNjFvRrJ8gvUfNnbRH0ctU3ekKWoSIQJKqWulsZc9XGLoOE4nUeie9JCwV4cJlPucGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710365853; c=relaxed/simple;
	bh=5yHraXVDQFk+w5OJkjMBnM5b16oeNXRmUoLOQD+vJ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL1ESdMaWePcr/GNctIOs3irOxglz9T32p1ufRLsiX4Z2DS9Cy7bDAH/bBK1glCpvj/AnNk/fXuY1lE++lkQwnMphWDB0r6qtWR3E8+XhP7AwnsnG0sYjaPWlHxNj6YElS6ozAMtxjAZ8cluqLsK3k/HAOGa6Bhwt2n5qMnr6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=GiBhUP0A reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oUWr+l/7P22mnFeHOehcZrsbMwGybiUWqyX8/H/bx60=; b=GiBhUP0AA7Oa7ZLMa+/XHji2jy
	N2Cy2rUYTUIS098VKTjXvdDuLmXt971V8YDd491TFNLqrnMpRHAIQFpSjhjORY0/wii5bRdTBPGWG
	c5ocTLE196iRz8lxnTWA5LkcoQ1J/fRY4IojUcnk9J2u5ajr2TrA3QZe0c/5dUDgSYKUMfo6+ceBd
	hV0Uy7JX3lkHYZGXdwXxF8EuU3wJkUULmV3hHMwx4XkfKS0zT6bc6nmXc/76Gx6e2B3OcsF5vP4Rp
	EzeuUp5+Z52RcIZQcgcOw4DnCThfddlBiV0q1vfopb49OmujSO84OHpSMy32fPqpB9tMOxAalk9Ax
	lP6zokOA==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rkWHo-008ThA-2F;
	Wed, 13 Mar 2024 21:37:20 +0000
Date: Wed, 13 Mar 2024 14:37:17 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 12/14] fs/configfs: Add a callback to determine
 attribute visibility
Message-ID: <ZfIcjeIWaB5RzNye@google.com>
Mail-Followup-To: Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Christoph Hellwig <hch@lst.de>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <b851e5f74398141bda2f5e6e1f0308cd13b39aa1.1709922929.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b851e5f74398141bda2f5e6e1f0308cd13b39aa1.1709922929.git.thomas.lendacky@amd.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>

On Fri, Mar 08, 2024 at 12:35:27PM -0600, Tom Lendacky wrote:
> In order to support dynamic decisions as to whether an attribute should be
> created, add a callback that returns a bool to indicate whether the
> attribute should be display. If no callback is registered, the attribute
> is displayed by default.

I'm curious what the strong value is in this extra callback.  As opposed
to not generating the attribute in the absence of a TPM (why create a
config_item at all?), merely having an empty response from the attribute,
or having `->show()` return -ENODEV or similar.

> 
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  fs/configfs/file.c       |  13 +++++
>  include/linux/configfs.h | 114 +++++++++++++++++++++++++++------------
>  2 files changed, 93 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> index 0ad32150611e..c758bcc11235 100644
> --- a/fs/configfs/file.c
> +++ b/fs/configfs/file.c
> @@ -451,6 +451,12 @@ int configfs_create_file(struct config_item * item, const struct configfs_attrib
>  	umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
>  	int error = 0;
>  
> +	if (attr->ca_is_visible) {
> +		mode = attr->ca_is_visible(item, attr);
> +		if (!mode)
> +			return 0;

What value do we get from carrying the mode through here?  The API
proposed is "visible or not", which is a boolean.  Overloading that with
"also set the mode" is confusing, and it also can lead to the divergent
codepath problem you mentioned in your response, where
`->ca_is_visible()` fails to return the mode correctly.  If this was simpl
a boolean hook, the code could read like so:


```
	umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
	int error = 0;

	if (attr->ca_is_visible && !attr->ca_is_visible(item, attr))
   		return 0;
```

> diff --git a/include/linux/configfs.h b/include/linux/configfs.h
> index 2606711adb18..18011f78ffde 100644
> --- a/include/linux/configfs.h
> +++ b/include/linux/configfs.h
> @@ -112,39 +112,64 @@ static inline void configfs_add_default_group(struct config_group *new_group,
>  	list_add_tail(&new_group->group_entry, &group->default_groups);
>  }
>  
> +typedef umode_t (*configfs_is_visible_t)(const struct config_item *item,
> +					 const struct configfs_attribute *attr);
> +

We don't use typedefs of op functions anywhere else in configfs or
frankly the entire filesystem API.  Adding one here would just introduce
confusion.

>  struct configfs_attribute {
>  	const char		*ca_name;
>  	struct module 		*ca_owner;
>  	umode_t			ca_mode;
> +	configfs_is_visible_t	ca_is_visible;
>  	ssize_t (*show)(struct config_item *, char *);
>  	ssize_t (*store)(struct config_item *, const char *, size_t);
>  };
>  

Thanks,
Joel


-- 

Life's Little Instruction Book #306

	"Take a nap on Sunday afternoons."

			http://www.jlbec.org/
			jlbec@evilplan.org

