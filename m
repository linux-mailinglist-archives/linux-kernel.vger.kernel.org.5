Return-Path: <linux-kernel+bounces-34950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7858389AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BFF282497
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08FB5A114;
	Tue, 23 Jan 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CuH9Oujn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0135A105;
	Tue, 23 Jan 2024 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999908; cv=none; b=Xvgcgu3RjvsRC8XuoLgg2g/XYTJaGcU8PtFfp+eP8e68r0HgWKpfsdeiorK6bWGEpUgChG4jbkXe69AgzyE0xQSWd1CkhyeggNYovF4smlAShI/QOgdHEwwvkYLmrmtQ9kgB/KcggIk2GFM73hYy2X8lDEM22FgzNe57esI62wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999908; c=relaxed/simple;
	bh=D8n0Zw3ohvgnCYeTHUvhwKyeOAxaCJP6rp1YJv6cts4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHpQSZnbza/FT7XlAWtD0ZHiq9FUdFBht1+qS1LYZqP9SuP4319YI9RDV4yL0GVSxyzQyy+Wl1TdntSMp5gyCTwud5/GzuCqZg5lAPOoUkk5fu/Hf7McwoTbpS30QoS/QrxwYJUro2u29jcwzzy+tFtyVDu2lU/HteTtoJ9eBi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CuH9Oujn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D8n0Zw3ohvgnCYeTHUvhwKyeOAxaCJP6rp1YJv6cts4=; b=CuH9OujnqjoMpduzZDaq0XCcjh
	Vlefr3pdoyh5/5uof6BQJpo/Z9CmVaurJtiE5+WTpHiNwINhp9J30U06gP9zjZjeG9uoMWfu9NNX+
	5XYLkOuv9K+A+HPo1/V6JbXY1ZqxJbkmqmL8HGPIwzr2rJDMvmkEvjRoKWAOIezjpJyua7fhRxgHm
	LFQkc671jPpPkqDAKbpSrzjMoCczGrpdy2mLqhJsAZzJ8pUE0yrw5y1NuK0L5tYBBYkrbb6/hv5R6
	sQmzoPwcXd93kk4ay7qe0cC1kiuanCLYiorvNWNqxT7T62ufahhKjYyIjZjt/IMHe/qKzn5iDvtop
	vVtdSCwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCVU-00FdsK-0O;
	Tue, 23 Jan 2024 08:51:44 +0000
Date: Tue, 23 Jan 2024 00:51:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com,
	syzbot+63dec323ac56c28e644f@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] block: Fix WARNING in _copy_from_iter
Message-ID: <Za9+ILj04gtI98oW@infradead.org>
References: <20240121202634.275068-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121202634.275068-1-lk@c--e.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(although I really wish we could kill the whole map-data crap..)


