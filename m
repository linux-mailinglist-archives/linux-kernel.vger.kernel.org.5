Return-Path: <linux-kernel+bounces-93934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F287372A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171F61F25FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4BD12F5B6;
	Wed,  6 Mar 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="juwiqUy/"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D113E48E;
	Wed,  6 Mar 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729983; cv=none; b=c2Tbyne0cu0NGBM7W+BQJdIh4sEy14lZTGxoZ3C1KkYJ0BhFHlHIufDHSu+C7VwCK6V2Bu+zFzNdYXOwHMPLrriMbZL+I0uZzes3ALecdemeHuxXVq755FlTQAQuVLr1iAL/WF9JPfo2LpY2CnzEnjWnMGrblKXKJPFy5VeXNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729983; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETXJHEh+H3LcDdk9rAhWAF9aVb/WuUDhYtQwW6WOpZdqc5hmdgX/1HUke4yO3hVUlpTaBveK50HDdrpPyyXcG0BfL8CfFr7mgeUtHDVkEoJ5Lg8qwMa5xPi6t9Q2rnX0hFcPMZ/kCdM8LFoR67HL9TckaosMHzTl80DebV0d6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=juwiqUy/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=juwiqUy/ZNb9h4HpA3OgKzNpRW
	nVf5v5EZQS4W3e3ZVdf0CbenJiH8xq4RahQyWTRq2oiJ4dZ3mk4mdjhlbIWKIUXLmoxUqFe4mcTZG
	SWbUxW2UIgU4TttJZrmMCNUzQSf6seGaYReHK5UMCBsYs/WFNAeArHs1+58a6F7MFnnhEtz+qlD8L
	+p0hZlUj7zv1LOjQAePjfX9yqA+68efbHGa8D0h4oRCTESrysxZlR/bOc3k6b9IZBkYDno4Gc3oTX
	7NJYHTTFOfIAomBWw8ykKgFL1NaVLbNX/jCCCWG+7I7MsQ/HvLhH0OCufthbkMLxZ6Tlm7UAFpn4G
	tYL/Qq9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhqs1-00000000IZp-0Tzc;
	Wed, 06 Mar 2024 12:59:41 +0000
Date: Wed, 6 Mar 2024 04:59:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: make block_class constant
Message-ID: <ZehovUwMXDaz59b1@infradead.org>
References: <20240305-class_cleanup-block-v1-1-130bb27b9c72@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-class_cleanup-block-v1-1-130bb27b9c72@marliere.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

