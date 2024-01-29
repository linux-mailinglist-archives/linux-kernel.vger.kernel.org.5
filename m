Return-Path: <linux-kernel+bounces-43239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D49841154
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03FF288AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0B93F9D7;
	Mon, 29 Jan 2024 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mO45akmq"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5421D76C87;
	Mon, 29 Jan 2024 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550841; cv=none; b=kt/PicdgIptqiiPy0t7MupyrUoD2Z5pGD+XE/XRUbhGgn/7xV2i3xAcNPZy7XNSJ85zlzkO4bbLd4zqgJZ20EzN/9mbZ0eiA3iPWpqDNz4TRf5x2RHSTdlHcVD3AKACBX1jQKGC6LHs3MC1J9nHlSsBMNIvstByrCpnh/a0P6Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550841; c=relaxed/simple;
	bh=cFhxzTUGZUjLGXc4jgk26wSlW6J36EcjbQ0FN1zFJdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvZuGl1huUr4X1t2BKwV/RiTS+zpUnOEBCQ56z2+cxBl753GPdkGtQwAihhD1ZN5PKyGsFaA9NCuIVOnzw1BuBkVn8TkTvLk+JSUIo/CcX4tlTFdmWgvJ1gBdIppotuJExQh9EZTXacm2hh5GXZCqkiaWWYYoDhbpieuy6DzFYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mO45akmq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hn8e0rCKXynZRayBOuybeU9OQdp57Kiz//hwQN/PKpo=; b=mO45akmq24ReWpNREFP+ZZolxm
	6kiczh5UFoSpioku8eHhnrC7Ifz0bV4A9XEBDHl9Y5PY44arOygIisJ7V4XZyqeM+5mFty6Xl0JRi
	O5TrKaJHlhGywkR4W+lwXGmEjUEL5bD4hJ+saIlW2ypn499FtnwkI6yoB7+2n5vII2MYSte7CFnZX
	KY0ToAqSrmq/6JMADBKLophvkugaS/ku8yAb+0KyLT1+uwW2AAoLsOhAjgwL5Y/z9b+Xdt7lWY0z6
	zCfQwPlvdLh2WtXw7JiRDOgu6SGr2P383cX4q6aucvdop0hzk437/yzJ4A2C/Y03e7vaTGwhTjCKJ
	uXiAKr+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUVpW-0000000DozE-0IZP;
	Mon, 29 Jan 2024 17:53:58 +0000
Date: Mon, 29 Jan 2024 09:53:58 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Changbin Du <changbin.du@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiaoyi Su <suxiaoyi@huawei.com>
Subject: Re: [RESEND PATCH v2] modules: wait do_free_init correctly
Message-ID: <ZbfmNiY52KdAet7_@bombadil.infradead.org>
References: <20240129020304.1981372-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129020304.1981372-1-changbin.du@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Jan 29, 2024 at 10:03:04AM +0800, Changbin Du wrote:
> The commit 1a7b7d922081 ("modules: Use vmalloc special flag") moves
> do_free_init() into a global workqueue instead of call_rcu(). So now
> rcu_barrier() can not ensure that do_free_init has completed. We should
> wait it via flush_work().
> 
> Without this fix, we still could encounter false positive reports in
> W+X checking, and rcu synchronization is unnecessary.

You didn't answer my question, which should be documented in the commit log.

Does this mean we never freed modules init because of this? If so then
your commit log should clearly explain that. It should also explain that
if true (you have to verify) then it means we were no longer saving
the memory we wished to save, and that is important for distributions
which do want to save anything on memory. You may want to do a general
estimate on how much that means these days on any desktop / server.

  Luis

