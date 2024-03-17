Return-Path: <linux-kernel+bounces-105561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC4987E032
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C337AB215C8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDAD21344;
	Sun, 17 Mar 2024 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FPD2ZHLo"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175C210E4;
	Sun, 17 Mar 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710710090; cv=none; b=eqzil2TgRAP3iAtKwCQi5B6V2gOZ0kWDZ9Ts5wgtWfATHBWQMNjqW7qtjWwDDApVSAz7+4xJ4Hsqt3HTZX3enMVTl7ju7Yeq18t6MjoIJb5h862zR87Mn/fCQiNYCRT0pu0Ms1v4PTw0REMkZjKzP1ecug1PWPnbtBNfoYgCHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710710090; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhYtNxwcYrZT4lP75ZQgeHS/X5kQJNyJAIbFfTrvdOzvg6MhjhrlhoYyMUsY3AuLIHjDoeUlGj8EBI3dXXszWDwH9mKbZcCWsSg96p3mJBp1iwbva98IfGRJHV3stIi740ZRYfxZKaCQ9tp0y/3hb3AGm1t/sTRJAK5Wejm/kLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FPD2ZHLo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=FPD2ZHLoy3vmrDsRpiZ7pwldIG
	QhLXHGHenVBjZ7LmS5mjFhwSnzKCn0a3++VYVOWlAg5jGimuiqesp9aZUdpVBZ6dwZsB+4fuSlYAM
	nQFjCfoeDIJFoowOch/tdSePv8Hhvb0mRxGfK7nGBETbO/M/RV1aKhBqIV821MKYx/es0jbB+WJ8o
	3GVUhP4FHWbx5bZzL+DH6ETBjUfCRCOUfQmJUdRfwdpViZZ94O7TBoSWdhseXNIYS4iec2yHoiS/A
	TQTde5dystPfBEKRp3gAARet+L9F3ZayatgM0uilzpepw8lnO82MbbgY2KWlFW4I+dcHOYb+C4JaU
	CrzOpO8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlxqC-00000006T7R-1gjp;
	Sun, 17 Mar 2024 21:14:48 +0000
Date: Sun, 17 Mar 2024 14:14:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, fstests <fstests@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: [RFC PATCH] fstests: test MADV_POPULATE_READ with IO errors
Message-ID: <ZfddSKENlkHU1W3T@infradead.org>
References: <20240314161300.382526-1-david@redhat.com>
 <20240317165157.GE1927156@frogsfrogsfrogs>
 <20240317165333.GF1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317165333.GF1927156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

