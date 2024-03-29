Return-Path: <linux-kernel+bounces-124481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80098918B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C161C22089
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368D4D110;
	Fri, 29 Mar 2024 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d1xEhmSz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70312DF9D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715211; cv=none; b=Ok1O2fHB4jP8whNL2H/RlvrEaGDbkDcme1/B3ybVz85fiDi+Q+eWilIIdJPO6Bojqq0372zb2NANicwr9thsxoEhHOkeH7DYqCMMcqYSJh1mUuE6Zjtt67blq2yD1+EgTb/cUMQ29Jc8aJmCHeBBzdmg4QkwxK7iOhUhVLfuwdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715211; c=relaxed/simple;
	bh=6GKVduxyKft6+aqo8OJZghbXgEyFPiqU0To2JY0hPLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0j+2gqHqRsanVDiEHCks9GEffBJ9IyDnOXZsMKh02S52xd3/ULCmSXciZpLWYzMjnfjuTLTxraqENs1y16xmPo5U7+pEe9tBViJ4DG7Ae58jR/01TDbPtcrEGbnIlhSmzXZd6serxoJ8IoVgX9c5vRe8/XhTVfM/JsHb4gkonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d1xEhmSz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZKa+ASXdo1cZjsSafEP2q+atVyr7ARDRo2pQvhN/Kj0=; b=d1xEhmSzYPQMlBB7Oof3HhACB1
	spkoUuyRBhnjM9/BbRPGJTaLRqMwsVxf7ZBMADJaQWAswuXN8klCNAAIx/Tv95NQuPg+4danNJMpB
	RZwqBdDFTJDJLE++WqaP+SDSGHiuIQjuDSWnjfqqsY9J5Jd28vVoiU0xXM3DR5w+dOYMFls6j5rLk
	1AswbXOAxluDebsTh2TxgAdgRPWCq4YYMAe2iaxTuZYBiS7TqZFr8ayWqntIc6mjhstgH6aQpnbJT
	cnqQfJuHv4K6uc9nCRG8zsXe6MnTR61rMEJOAJ+7Zz1zVJcpRyGEBhotZ92kIf0e4Mv0mNUMCHwoY
	1Z4LuMsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqBJm-00000009Ar6-1nL2;
	Fri, 29 Mar 2024 12:26:46 +0000
Date: Fri, 29 Mar 2024 12:26:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: York Jasper Niebuhr <yjnworkstation@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	willy@linux.intel.com, linux-mm@kvack.org
Subject: Re: [PATCH] mm: init_mlocked_on_free_v3
Message-ID: <ZgazhqoK2Icgahy9@casper.infradead.org>
References: <20240329115446.424923-1-yjnworkstation@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329115446.424923-1-yjnworkstation@gmail.com>

On Fri, Mar 29, 2024 at 12:54:46PM +0100, York Jasper Niebuhr wrote:
> +	if (want_init_mlocked_on_free() && folio_test_mlocked(folio)
> +		&& !delay_rmap && folio_test_anon(folio)) {
> +		kernel_init_pages(page, 1);

Confusing indentation.  One of these two options:

	if (want_init_mlocked_on_free() && folio_test_mlocked(folio) &&
	    !delay_rmap && folio_test_anon(folio)) {
		kernel_init_pages(page, 1);

	if (want_init_mlocked_on_free() && folio_test_mlocked(folio) &&
			!delay_rmap && folio_test_anon(folio)) {
		kernel_init_pages(page, 1);

Also, '1' is incorrect.  Should be folio_nr_pages(folio).

> @@ -2559,12 +2570,21 @@ static void __init mem_debugging_and_hardening_init(void)
>  	}
>  #endif
>  
> -	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
> +	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early
> +		|| _init_mlocked_on_free_enabled_early) &&
>  	    page_poisoning_requested) {

Wrong indentation again.  I'm not going to point these out every time,
just fix it throughout.


