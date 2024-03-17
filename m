Return-Path: <linux-kernel+bounces-105560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE7A87E02F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0E41F218D7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C13208B8;
	Sun, 17 Mar 2024 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y+s2Jfnv"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B361E525;
	Sun, 17 Mar 2024 21:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710710058; cv=none; b=BpelAJoSMPF0Cittl/FJJAd911Zh8oJ0R+AzMnVhR4uvxx2sdGFdQVF6NgcbdrkqzOAmLQ6C5GXxVe5LgPraRt7K005xJvjLXQbg7f6hOF6U+0v4YisGz+R/GZQHJ3VLb6+c25QpnKyGMsAcGr8EMWSQMka0MlyCbxgZMU3W6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710710058; c=relaxed/simple;
	bh=/hoO7QwdP4DgNBUhw0wieNFBS6Wc4NbIBy8G9TdddUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2caFU3uDtELEsf4tr07gHIm7whYrnKPyEMklxXh8hg+egRtYG7gK2UMXZfSg3MVI5hfEHQLscN49aZZ56EkxOsI6uQx/uil9KEfrveKU6BpQ+sJhVMFEMVuhF95Hy1AanQ44lpEL3BGhhm49OhGc/EMEJf2TKMA51Jm/3oUno0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y+s2Jfnv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TCCmjmMAc3H/rSZhFRq2kqhRinVJ/Se0iD+aRpD6GuU=; b=Y+s2Jfnvr1GLntBNxWu27Jxf7r
	Wl9Ub4lVpPOUypbTjnBC+PBWROjTPqYdu9guU+7sjnvvPKPAmHlVWrGd/JvTxIsfnP5nkKc7nZk2D
	JvND9qqmwDaL5NFzTKsQ+uH9fPkT7X6FlhiNpDrBX7xPyv3BfYA+G7j7W5JUFihtKZdPf0ly+dhtr
	3BE2QeOkdrUjKSi9FLjBDX83/mbLQuwsyvlw6kodbTOfJEncYgRdSVrq9EHtC1ny6UQx1auhY7IFU
	398h8AA7lT8A6PXWAhQVo/0tDvO8WLde6MlcnelOSsTLKMxD9w6HejJOFWYHrU9Pc+FqlHiJoJOxO
	avXmaxgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlxpg-00000006SyX-3HQ5;
	Sun, 17 Mar 2024 21:14:16 +0000
Date: Sun, 17 Mar 2024 14:14:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, fstests <fstests@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: [RFC PATCH] xfs_io: add linux madvise advice codes
Message-ID: <ZfddKAS2GUOG41wb@infradead.org>
References: <20240314161300.382526-1-david@redhat.com>
 <20240317165157.GE1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317165157.GE1927156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +#
> +# Check if asm/mman.h can be included
> +#
> +AC_DEFUN([AC_HAVE_KERNEL_MADVISE_FLAGS],
> +  [ AC_MSG_CHECKING([for kernel madvise flags in asm/mman.h ])
> +    AC_COMPILE_IFELSE(
> +    [	AC_LANG_PROGRAM([[
> +#include <asm/mman.h>
> +	]], [[
> +int moo = MADV_COLLAPSE;
> +	]])
> +    ], have_kernel_madvise=yes
> +       AC_MSG_RESULT(yes),
> +       AC_MSG_RESULT(no))
> +    AC_SUBST(have_kernel_madvise)
> +  ])
> +

I don't think we really need this check, as madvise and asm/mman.h
have been around forever.  We can probably also drop most of the
actual flag idefs, probably for everything older than MADV_WIPEONFORK.

The rest looks good to me.

