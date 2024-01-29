Return-Path: <linux-kernel+bounces-43447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9278413FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63A21F2252A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B741D7603F;
	Mon, 29 Jan 2024 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X37HBjAl"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8BB48790;
	Mon, 29 Jan 2024 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558496; cv=none; b=jKzh7XLDkKPY61CBeDqziNsULSYkbInci2nleDVv6k7IF83W5beqwZUXtb5VPg2FbjBk6tfCNQSEu0DqzVfnQsBKygCj7XW2+UJTI3RX4KfQlKjqncs4HdZqdnxMN1PpLsWCwlu/8JXIW7HZqdg5Gh+KczuSuxQ9OgJ/XSWdIAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558496; c=relaxed/simple;
	bh=ISg0qWcsic3NhSTT26Ik0LHaKUMiqMelriiZGFHLbPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP6+gmzkJwKUSIKQpj2n0uVZQCxDEJ65yJKEUWwzAWr1B28erC+5SFWU9O7RKmD4CTX3Q54cRDJBbwCR79YySZ5mDdSr8bOaeBV93z/5I0SZqMSbpraJxz+0qnmDsslhuEdNz0Fop+ueHNm+cs2ZkjenRMO9nx2wTEscR1PBbos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X37HBjAl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IkjdIBKoiOcpY02ZoVDX9S0wFvKlvTpVElGZtMaUhdk=; b=X37HBjAlM/ZTVyv4M+Ru3y1KCO
	C6lhWPaBK270WH1qmBnFhd/oyk8xgfveopnpjnJZGxcz8Vf9NtUsiEtSx1FLfBXMiEjRkDivFbkN4
	4ZdaWE6ueAlWYVSDxGkd5rF7BFDKmH0DPFm/FS5ocfYe1P/NbrZbPklkeBpNWm6CTgLsQJDkN9xM1
	vG2spEQNGsBVFP/KtCe8Xs+m2MOPvZchqnEpAJls51agfmn5ODO7VCouatGuR1oF/a6OF/NHQaObO
	ah5h7NOO4RmDHijLwtKXnR+TTKQprLT1hvRHV1Yx8HtceS5aIKZTzmwkXKvHY8MG0gwkG6sZh/r5/
	pcIK1Asg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXoz-0000000EBhU-2uy5;
	Mon, 29 Jan 2024 20:01:33 +0000
Date: Mon, 29 Jan 2024 12:01:33 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] module: Use set_memory_rox()
Message-ID: <ZbgEHYe6f4WiIKoU@bombadil.infradead.org>
References: <98d4db94f19737fe05fd811a4188ff277b83a334.1703143382.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d4db94f19737fe05fd811a4188ff277b83a334.1703143382.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Dec 21, 2023 at 08:24:23AM +0100, Christophe Leroy wrote:
> A couple of architectures seem concerned about calling set_memory_ro()
> and set_memory_x() too frequently and have implemented a version of
> set_memory_rox(), see commit 60463628c9e0 ("x86/mm: Implement native
> set_memory_rox()") and commit 22e99fa56443 ("s390/mm: implement
> set_memory_rox()")
> 
> Use set_memory_rox() in modules when STRICT_MODULES_RWX is set.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Nice simplification. I applied all 3 patches and pushed!

  Luis

