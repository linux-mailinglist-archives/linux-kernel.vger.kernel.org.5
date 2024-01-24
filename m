Return-Path: <linux-kernel+bounces-36690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DEF83A511
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4841F27612
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308051802A;
	Wed, 24 Jan 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pL9CZFrO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37AF18027;
	Wed, 24 Jan 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087897; cv=none; b=dZqpVc9yFBNn0gByl/sEhFnsFrMJJmiZmpNm8PJwLXhoFcxsALS3TaUdUUcWpgqkpSFl+IiSH9254u7jfivjWV/ShuXcaOJ2lQnff7du5KSy4m0wQqul8uwszwASUhTWxNxBQJnqXfSDCsoc32b4YVdmMtV3VsHpjn/UVi1Q4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087897; c=relaxed/simple;
	bh=Lp5MIAa5xlvcbfT4woCjNP+7nWdzAg+m0NqHgeOkoqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I72EV9sZeY8MhBICfR+Txleql+XQbRHb0wSagJLbkkL7lEqzoOq/GdtlrybA79CPmz/v88SgDw3QfwsESv3+DTppCWqDUXin6mmX3MUlUiYRFRrSSpO/JHCsvRCcMZfb//9GQglOwT9tA90SuAoxOleCMMTyfBLNBcw7jKEL5Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pL9CZFrO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Lp5MIAa5xlvcbfT4woCjNP+7nWdzAg+m0NqHgeOkoqk=; b=pL9CZFrOEBUs44L8PG2Z9dHQJU
	Xx7NZVS1SSYf/sTjnG1wlo+m/KAds0pQdXsY+Bhiw8jSx0cb0acGxRJcl0VVsxjrJyKxsdILIhhfm
	NTx8+e2dbV0ls4cyzSnzjza6EDBAyg2T9fp5HD1rRW9VpdBqkykC8D+ylAifMBzGQ49A7Ux01L6nq
	pjGD9epQGvU3p1yIY+0KaI75NkAE56bmXJ5igVXhbXPQZ0f5u3wl5zXxjJAp5rzU9c+nxSj98FYoc
	sjIAqLS0b1cik+AFM9p9Mcb+9CM8C6FLSnJFvPgKYB1uFtcO92o8QYWGU2Wwy+o+R3e8rYvXbhbc7
	tUXMgvPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZOf-002AqO-1k;
	Wed, 24 Jan 2024 09:18:13 +0000
Date: Wed, 24 Jan 2024 01:18:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] aoe: avoid potential deadlock at set_capacity
Message-ID: <ZbDV1RcDGnRjVqI7@infradead.org>
References: <20240124072436.3745720-1-bigunclemax@gmail.com>
 <20240124072436.3745720-2-bigunclemax@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124072436.3745720-2-bigunclemax@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Just curious: what is your rason for using aeo over nbd?

