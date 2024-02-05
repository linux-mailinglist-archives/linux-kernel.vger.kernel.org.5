Return-Path: <linux-kernel+bounces-52111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD68849439
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC8E1C21522
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB16410A09;
	Mon,  5 Feb 2024 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pb3UwuB/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CDAD510
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117068; cv=none; b=iTY2E5m0Zb1r0Gql0ls3/Rgl+RduxAaeOejMpLhj3DqF6f3GKW6/L/HPAKScY5xkGqrJ+J58D7mveUB+kQTsagMUuhjUCofDLJ2g1hcm6o2CwLn2eynd7UvhPAjGwEtuTGY4OkeJNtzTqoFlkKq7QphUUhdc4OGNKIo42PXqMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117068; c=relaxed/simple;
	bh=jMAonctvz6OeYFCYBtnV+/EPPH2eNW684fokWBIZQoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsVKLQ46YLZgIi2/rLLclIP4xUTvjoRfWho5FeODjROV0Ex4p6f/FEC8EM7VJuBN6Jh88Ni/7W4PzYfEjJZNromL07s8dBTcG4im8Jbm5loyrPTvNys+cvOI8eMsN/z7Cuaj/61jWPxH5N5kpYYREQf8MTPbb4zQXrC09Bxlqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pb3UwuB/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+G40Mq07z/lZNVv//iPsxfFykB1vjRA2FCHujdNQ9To=; b=pb3UwuB/2mkokKDRBnjeZsITon
	1GLbOOMFRTq6LDeeILe3jSD1Kdgs2xxh4HkAObyn4f0Ror+OaIGoT2MYvr4Q8QQFD9guJp462Mmm0
	Fuo2JRpCk5lPm7FQpc8Hh/dTcCW1CZJUUbwq63yenK31De1Wvqlj2TJ7LAfs2Q/GZ/+xpm8UdEPOQ
	yJ60lZRVExsP1Rqygxn+Le+a1R8JY6pkf0iNPKugHQqpXcJkz88YPmSsVnbiXxPz4TaCbGrxA1RFB
	WyoC/10Ot9xse3U7BgXDp0W8lvo12TfBr5qRvRtrlP8T9ABkorO/5B6QVf72QLXrgXdK0gLA4ZWvg
	W33a19sA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWt88-00000008nsp-3BNu;
	Mon, 05 Feb 2024 07:11:00 +0000
Date: Mon, 5 Feb 2024 07:11:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hao Ge <gehao@kylinos.cn>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, gehao618@163.com
Subject: Re: [PATCH] mm/vmscan: Make too_many_isolated return bool
Message-ID: <ZcCKBEStSmIJ5D-f@casper.infradead.org>
References: <20240205042618.108140-1-gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205042618.108140-1-gehao@kylinos.cn>

On Mon, Feb 05, 2024 at 12:26:18PM +0800, Hao Ge wrote:
> too_many_isolated should return bool which with the same name and
> similar functions in mm/compaction.c already returned bool
> 
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

