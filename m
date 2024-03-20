Return-Path: <linux-kernel+bounces-108333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98D88094F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4697E1C20C30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518B0846F;
	Wed, 20 Mar 2024 01:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DVhx/D8Q"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8B7464;
	Wed, 20 Mar 2024 01:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710899829; cv=none; b=qF5bdCZ226s/dvuMDtqWtSIqF/iCSMnS0EtXcicyt4yGICJfnvN9eSqkGW5MdaV5yRarenGq8yoDjXzNACOaYdJKP2UghpMCxRBZC/W0QxKJGXqmXw8hw4eRsR0M4I+N0u2BkppT+2zvHNVl8PVVuEr9IVcdhdMBZ0ABSqUN+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710899829; c=relaxed/simple;
	bh=XquRaUIAS0JjjCqmDwqYRxEjThd2HstdNp2LDSDJgHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMfuVfaTxc3z8e//KPBn9PkHbDx012I8a3qNz6w1e7pXNk43tRGMpzMK+gBnYn1df0U3DF/9mvt9Gb7kRIeRqpzHtzd1PjECVLQT5VBmJO2gAcc/gYKTw67R8nNlSY81T7xE3eMSi0zjRp6gI/4lgnuRvPdkuXDBv0+6omhYDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DVhx/D8Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cwil56zbTxFwL2LPEeCyDWZZ3L2Yga7AQv0iusdXD8o=; b=DVhx/D8QKsz5jAE/7m6SGqpkvd
	oh5RLmT6mKAaLxqxbr1q4q7lgd6bgs0KnVHUQL0cmpeF0hD4/XgGnaupim4aAj0uHKmCzvrjG0b8b
	Xs4P5OXSxePl0W0hq8hVy1GwbJvIrA4WdHnM7aVCCJ0hgCdkjGzfrEmB2AQUpfxYUDXOADnpOTu60
	shuyfgsMjWfSLAYxiWUay5uwfpMEhWGFbJIW7rEAh96x+QOZmNA2Ull+h/Mi+fmtlF3j2Ce83V7xC
	WQ9jZtQmNnYJ6o6fGBRJRXd/o/miOh+D05FlqKBCsoR6kYYeQ8POjnZCxr4F6cG+ioijZG2Et5vYD
	4lJX2o+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmlCU-0000000EygN-3n7R;
	Wed, 20 Mar 2024 01:57:06 +0000
Date: Tue, 19 Mar 2024 18:57:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, brauner@kernel.org,
	david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/9] xfs: make xfs_bmapi_convert_delalloc() to
 allocate the target offset
Message-ID: <ZfpCcjTUYqzGum_u@infradead.org>
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
 <20240319011102.2929635-4-yi.zhang@huaweicloud.com>
 <20240319204552.GG1927156@frogsfrogsfrogs>
 <054ac072-4ccf-b83c-cc9c-cbb5d6f5dbdb@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <054ac072-4ccf-b83c-cc9c-cbb5d6f5dbdb@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 20, 2024 at 09:51:26AM +0800, Zhang Yi wrote:
> Thanks for your suggestions, all subsequent improvements in this series are
> also looks fine by me, I will revise them in my next iteration. Christoph,
> I will keep your review tag, please let me know if you have different
> opinion.

Yes, please keep them.  All changes so far remain pretty trivial.


