Return-Path: <linux-kernel+bounces-129048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F346D8963CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE96B286556
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED144AEE3;
	Wed,  3 Apr 2024 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eRX/w4u/"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726EF645;
	Wed,  3 Apr 2024 05:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712120848; cv=none; b=odNUf5n3gBMrgWB0t38dSBtRUezQ6pkHciHavquxEnvUlCzIT4ScIEHolfGnKdNEXsYVu6fLvY4201TSFI3rlFmvDstNJPRVISRshzs5s4L/DmG9g917VZ9D+3bW+zzruTFS+uHeRVa6UEQENiTgF2rcaGmhYTvwBYYMb6mexE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712120848; c=relaxed/simple;
	bh=jV09/5ieSCqmtJktUOtVuVXwJq6vg6jtDsX9u/+Xd4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9Jv1KRjHJJdG/zkPrUzeDen4B4eFVQrlTiP8vJxf6AGWk6/Pom9jf8840b6W32PuktMTAZEXdgDeKc3ObX7djfRDJS5f+BDc0moTtOGsIJOm0V6MvD4rC6BsMbFKwSlLy6MarTtQdR7URXgOPO75vJv3Wcvl3HhNe2S//DiOms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eRX/w4u/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vtrqKPy1AN4YZzM/yPk/wfPp6zfZTqwK5u/dFIselaA=; b=eRX/w4u/OIEjzDAjwD1T63GSrI
	BHME+/OjL6XtHw1c9CvU8VUXnmx6mOaapFoiq55NGUP3nWloiGxEEVl19QgTnIrMK0nen+SJ0IgWx
	geXtd0sc/aX2vdSF/htloZnI2RhxUdMaeSPK3NUqmaJUDTo5fao8eicA/mi/4YoVG+18eWWIviF21
	KGAXmAx3e7nFHtXW+CsAdSS5cL/7QmsUE9lR9cSt66+CZxNhiuR/X/ioTfEe2ViyOSDAcwvyfTpf0
	SVtxxSN378OTt8lRo93pbNBaG/m/TwZQ3loJpIONQB4NN7EYYkoR14aSmWRq28Zwuwj7t51Telw1K
	UkgVvXAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrsqM-0000000E28a-3Gop;
	Wed, 03 Apr 2024 05:07:26 +0000
Date: Tue, 2 Apr 2024 22:07:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] xfs: cleanup deprecated uses of strncpy
Message-ID: <ZgzkDv0mBVmzxoRJ@infradead.org>
References: <20240401-strncpy-fs-xfs-xfs_ioctl-c-v1-1-02b9feb1989b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-strncpy-fs-xfs-xfs_ioctl-c-v1-1-02b9feb1989b@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 01, 2024 at 11:01:38PM +0000, Justin Stitt wrote:
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1755,10 +1755,8 @@ xfs_ioc_getlabel(
>  	/* Paranoia */
>  	BUILD_BUG_ON(sizeof(sbp->sb_fname) > FSLABEL_MAX);
>  
> -	/* 1 larger than sb_fname, so this ensures a trailing NUL char */
> -	memset(label, 0, sizeof(label));
>  	spin_lock(&mp->m_sb_lock);
> -	strncpy(label, sbp->sb_fname, XFSLABEL_MAX);
> +	strscpy_pad(label, sbp->sb_fname);

The change looks fine, but the 1 larger information is useful and
should be kept.  Maybe move it up to where the label variable s
defined?

>  	spin_unlock(&mp->m_sb_lock);
>  
>  	if (copy_to_user(user_label, label, sizeof(label)))
> diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
> index 364104e1b38a..b9256988830f 100644
> --- a/fs/xfs/xfs_xattr.c
> +++ b/fs/xfs/xfs_xattr.c
> @@ -220,11 +220,7 @@ __xfs_xattr_put_listent(
>  		return;
>  	}
>  	offset = context->buffer + context->count;
> -	memcpy(offset, prefix, prefix_len);
> -	offset += prefix_len;
> -	strncpy(offset, (char *)name, namelen);			/* real name */
> -	offset += namelen;
> -	*offset = '\0';
> +	scnprintf(offset, prefix_len + namelen + 1, "%s%s", prefix, name);

If we're using scnprintf we should probably also check that it doesn't
get truncated while we're at it.

Also please split the label and ioctl and the xatte changes as they
aren't related at all.

