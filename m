Return-Path: <linux-kernel+bounces-67940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398ED857358
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCADE287324
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3E0CA64;
	Fri, 16 Feb 2024 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lVHz3Hgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D274944E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046554; cv=none; b=n9vssuxY6gF5djw9S5nKq1C6HtyXY1OPLwWr+Vc8iB55YdMA6s2qI5mL/a+vjTYjBsDZdrmmPvIDiEF317BXksA2P+4bmB4bLM/JtZDO09Eu8cevj9rTXGfhoAiV1cG9PX6Dmqa46YGJkRvqnAjWSksX1xLfT830805v1WxlgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046554; c=relaxed/simple;
	bh=Pz16fPbB321QlIKfusx5bR8U5uF4607UAfv7dS0oWA8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jWBH4FL/IhWnQPSPkLYnaYfkXaMhgHB2AfKMMYMz0E7aQbTcC+gjeKGH5dX7QlnVsjv2kf74VEtL85arzPhGvfIjNXUuXCVqgrMT/SgHdCahKz8mNgNB7r8viKtItlsgkhtSTIKgCIgCBodEdeSs/X78C3D16mVir5CXVarawdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lVHz3Hgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC54DC433F1;
	Fri, 16 Feb 2024 01:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708046553;
	bh=Pz16fPbB321QlIKfusx5bR8U5uF4607UAfv7dS0oWA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lVHz3HgkrXAtaw8RscTCSPyB2BRdNgdI4jWqmHIzJJiOTZSiDr7Ee0hG4WB2u2mlQ
	 a42sioIrCEJjlXFrvRgJpkLABl91Po0J5OnfD++E34/tgR+GEjenpsH33GooicPlsg
	 UZV4bjqCtfkJBYEmlSPPb6Ehmz4V0OrNw3ZW3s9w=
Date: Thu, 15 Feb 2024 17:22:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/hugetlb: Ensure adequate CMA areas available for
 hugetlb_cma[]
Message-Id: <20240215172233.06e9515adf7de9c58d1b5d91@linux-foundation.org>
In-Reply-To: <20240215043405.2379295-1-anshuman.khandual@arm.com>
References: <20240215043405.2379295-1-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 10:04:05 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> HugeTLB CMA area array is being created for possible MAX_NUMNODES without
> ensuring corresponding MAX_CMA_AREAS support in CMA. This fails the build
> for such scenarios indicating need for CONFIG_CMA_AREAS adjustment.
> 
> ...
>
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7743,6 +7743,13 @@ void __init hugetlb_cma_reserve(int order)
>  	}
>  
>  	reserved = 0;
> +
> +	/*
> +	 * There needs to be enough MAX_CMA_AREAS to accommodate
> +	 * MAX_NUMNODES heap areas being created here. Otherwise
> +	 * adjust CONFIG_CMA_AREAS as required.
> +	 */
> +	BUILD_BUG_ON(MAX_CMA_AREAS < MAX_NUMNODES);
>  	for_each_online_node(nid) {
>  		int res;

This blew up my x86_64 allmodconfig build.  I didn't check whether this
is because x86_64 kconfig is broken or because the test is bogus.

I won't be releasing a kernel which fails x86_64 allmodconfig.

So before adding a new assertion can we please first make a best effort
to implement the fixes which are required to prevent the new assertion
from triggering?


