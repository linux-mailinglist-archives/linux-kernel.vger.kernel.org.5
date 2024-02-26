Return-Path: <linux-kernel+bounces-81129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD44886712C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BAF1B2B4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D49548FC;
	Mon, 26 Feb 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bDvrG+84"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5414280
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941995; cv=none; b=H0LROYt3W5y9G+hA7t5qbyqRp+8kp+aKHQrgXg6t3cq9KDXogzx8RwRSgWnljwvUxxPOfn+9Dg1feheaqEoozXf/Bw4rg1zkm7nQmkKIckM6CuJBlMBWjWu/fshOmorugNLpxtaNka+aApX3CQMurw6qoFKvmvrIlDfHoka8Bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941995; c=relaxed/simple;
	bh=4FGiGzilRkTG+e63TU+1uozLUC2zkmTtPncjOk7OVyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFforex/4nx+9eBJYHJbIdHmD0TE5xAPRTvWolzXXE+tCZShN/HEUISuxsjSetrzAerIQN6wvxsddDJ1wVfi1ymxP3CaSXvUCVJeHTasE/0dYvcPAVjZYbbI97DbllsdCBKyLSHWGDZijgpGidcMjPLYMPZ02EaTHrw6eXkucpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bDvrG+84; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4FGiGzilRkTG+e63TU+1uozLUC2zkmTtPncjOk7OVyE=; b=bDvrG+842glUw2vLfMK3GZ/1Nw
	6Xt3a50jpvP/1fzfxpQgLu+/SVsJjpfHWpw7yH5uPzxjmFMsln+ZG+/rgYtJjxQaH3BL4AOausG9q
	p6VwQSM+id59xxv1rsDVZON2ltRwWQVrcg4yRhT4/rwQzphyRvNpxiWTQh7QYxWqPuHSlYhuIi9os
	mzNx9aEiwSt4OmFQZSm+xkWRoKrP/QmgwC9I5dHE/B7Jmjik7q/v7Nsn++nzYAMdNVg9hJgl4oqoY
	GxZreljndQDmk65o8wBEhIf9UrxdSTe7AbbyaZURL6KFQtG5ZSGpS6Wj+3I2eXPO2Dg9RyhNQXSBx
	OEdQMLMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reXsW-0000000HXQy-3bPm;
	Mon, 26 Feb 2024 10:06:32 +0000
Date: Mon, 26 Feb 2024 02:06:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: chengming.zhou@linux.dev
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	vbabka@suse.cz, roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] freevxfs: remove SLAB_MEM_SPREAD flag usage
Message-ID: <ZdxiqJZY2qSRVvEU@infradead.org>
References: <20240224134835.829506-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224134835.829506-1-chengming.zhou@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Please just do a scripted removal after next -rc1 instead of spamming
everyone..


