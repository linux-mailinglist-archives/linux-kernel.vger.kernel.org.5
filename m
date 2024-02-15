Return-Path: <linux-kernel+bounces-67581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 134BC856DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52A1B260B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAC813959B;
	Thu, 15 Feb 2024 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y3zDz+4e"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C013699A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025417; cv=none; b=SqxQLGTyuBEUyeMXwSLbrm1iGZ0iFHI63CaDuv+ntO+CI2Sd4eE6OAV32uHZ9yWD0ZpNI+K5cT7ecDm2e+htgORjIyW+aRiw87SfKhCMMye0APj/q4kkoyn8Nl5K98/IRAhMp1XOjr7NEc3Rd3txjZM8gqWf7vY47Da4Q1eTTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025417; c=relaxed/simple;
	bh=o5j7fSV/e4VUS7Do/bpLgcV6nqwSVZCzpWznzFhYw8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRGtAW6DbjSJGfhOwvWhltth/mGicreWF9qMaDx2vgtNY3j7hwEkHBZYFVoGqypC3/jo1CR6UZTgNntAgzgNbyQFTGFUoFT20A5Lyoz41d69zpdxEq74JDXeL7r80AnyYALFG9RKy9I6rITIoQ7qOm5VZ8Lmb/cWGy5LoV5zraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y3zDz+4e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o5j7fSV/e4VUS7Do/bpLgcV6nqwSVZCzpWznzFhYw8U=; b=Y3zDz+4ettUPs4cQpSxigYrjzP
	V5VBj+KyRFl+W5cGnxbP72EGv40rLYjmcJ5ydANDcUYWtrlNB86/yxfj1ACK60etR8NBkjkfLLN4G
	rraZnnl6ojS2Jjhqh3JGcWfd8lNPr1BXjGVI/IN8QSrmALeTExXzUqpEvkK+CYaYKFwSS7wOlSz32
	jB6GNGUjBbkHxBdQjPGZzTrvFUci4DL1TYnbcWQyBtEaJJRFlblNqQ45Ly1yX47ytyeqrrD+LgpPl
	OofC4tO+TKWBNmiEG/HmXww3RUBItSNdydoXyaXENcowf7rRAGWvj5y/pW91TPHCAv9NCe9YhUk+c
	j9e83BRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rahQz-00000002fig-1nvF;
	Thu, 15 Feb 2024 19:30:13 +0000
Date: Thu, 15 Feb 2024 19:30:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/14] linux/mm.h: move usage count functions to
 mm/page_usage.h
Message-ID: <Zc5mRRhhU7flXB2f@casper.infradead.org>
References: <20240215145602.1371274-1-max.kellermann@ionos.com>
 <20240215145602.1371274-10-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215145602.1371274-10-max.kellermann@ionos.com>

On Thu, Feb 15, 2024 at 03:55:57PM +0100, Max Kellermann wrote:
> Prepare to reduce dependencies in linux/mm.h.

Why does this want to be its own header instead of being part of
page_ref.h?


