Return-Path: <linux-kernel+bounces-108410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0FF880A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79961F23898
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940E911721;
	Wed, 20 Mar 2024 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D5ZzB6z5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E611182;
	Wed, 20 Mar 2024 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710905668; cv=none; b=LN6HyfyPjUJ0TrVyocfGiPFFQu+oPUToUqLGLdxmS6KBSxxU1rTSc4VzDD+5as7XOCaUDaxcjY6j10RQcEgiAMdJs20u53r7oM/RNFuXPL+/8lJCl10oCDykPIn7rtP16+yQ6qrgn5lKDHm7AVcR4jVQU5HzwvCd8kzgiGxCxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710905668; c=relaxed/simple;
	bh=kYMcDwEZnVkO/THqgvcJxPhR1j9VPcws4SHdZLgIYnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovy/bQY3eh1BiHjHB5Wdxi9AyHSW1kjHJylkJCL4MdltVMQ6Rv+dv1ynDNU/Mr+frMxoqfmgmRIcBwy5IooWUwPNp4MIZ9MjeNnmXU4YvLTHwnnqlQC+0d6eqVthLORc0Omsr5V+1NMjhaz/CuJIDwe2aum0m59/wbAp5rv6r5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D5ZzB6z5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Fmjl44mehHCSaJsJ049BqzU8nsY14MeWPP13ami+abI=; b=D5ZzB6z5MbJoI6zMuis4f/WsCg
	88iH+1ueCQbgpQr1TiFTtRm81M1EIO4/+au/WGmzJpcmSqCFo9EfmHgugNfocoGInkiU0gpH9FpfK
	uPNaelLOrKVwvSXQDEvisa4gVDqHo5rE1vW4SNU8sy9BLELCk3CFf9OPLzrOeG6nsOu1fvoYl98BV
	c0iUFXzA9e7fo23DqdYvGWQI8exh8hbKV0n+OvhVIQGMTs9U5pzYwqnyIgr7xy9Fd1wfRSF+ddyJL
	6lQNhq97mBnpvm4Dmu0IRPcwSz2ZDu7ofFfE+dsi3MCQgjTpEEBhV+VYDoaRJwg0gZUhvTpB70Op6
	K9BDf3rg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmmiK-00000003PYS-3S7o;
	Wed, 20 Mar 2024 03:34:04 +0000
Date: Wed, 20 Mar 2024 03:34:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc: Kees Cook <keescook@chromium.org>, linux@armlinux.org.uk, arnd@arndb.de,
	rmk+kernel@armlinux.org.uk, haibo.li@mediatek.com,
	angelogioacchino.delregno@collabora.com, amergnat@baylibre.com,
	akpm@linux-foundation.org, dave.hansen@linux.intel.com,
	douzhaolei@huawei.com, gustavoars@kernel.org, jpoimboe@kernel.org,
	kepler.chenxin@huawei.com, kirill.shutemov@linux.intel.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	nixiaoming@huawei.com, peterz@infradead.org, wangbing6@huawei.com,
	wangfangpeng1@huawei.com, jannh@google.com, David.Laight@aculab.com
Subject: Re: [PATCH] ARM: unwind: improve unwinders for noreturn case
Message-ID: <ZfpZLJ3F3efXUwQf@casper.infradead.org>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710901169-22763-1-git-send-email-xiaojiangfeng@huawei.com>
 <202403191945.661DBCE8@keescook>
 <fb8c6e8f-de47-8cbc-e30a-60961f5ce7ad@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8c6e8f-de47-8cbc-e30a-60961f5ce7ad@huawei.com>

On Wed, Mar 20, 2024 at 11:30:13AM +0800, Jiangfeng Xiao wrote:
> The checkpatch.pl script reports the "WARNING: printk() should
> include KERN_<LEVEL> facility level" warning.
> 
> That's why I changed printk to pr_warn.
> I should change printk to printk(KERN_DEFAULT).

No, you should ignore checkpatch.  For bonus points, figure out why you
should ignore it specifically in this case.

