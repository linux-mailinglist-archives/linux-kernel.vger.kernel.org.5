Return-Path: <linux-kernel+bounces-60084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F2884FFAB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83111C21D39
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5CB383AE;
	Fri,  9 Feb 2024 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2l966Jw7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0650923B1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516999; cv=none; b=esrJ4x7mO5HWEczbcPGx4iafJtc9JQQlDAQ2XEeTi9DLJeoVMGZ2/SSC7kLEtxH2xl16eGhmMFc5caB18PHGuofl2k2kkGLhj5RlFKDFVOe1OX224vDt4JL+t5YAFSoOIDthmredr8q79RQPLBisEeR3/9RVG9/0gFP0uKznjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516999; c=relaxed/simple;
	bh=u27ysSO49hF4SYPfEeRGZ1NoCOVbBXK8slETCK3CYUo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TySSn1HChHLki8usfOcKAzYaqJcxuej8q3QOYndyGITWqdwR9CLhoO7LjIU1O3M1D7O49JMBj1KLykN9VliIYML9xATm3Dny8Nn3lIpBHmWy8IPNmNnekA3kfdx5TngywvelDmqhErLf3lvbOvFT66VlIzU3hpGZRdVFIunzptc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2l966Jw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E195C433F1;
	Fri,  9 Feb 2024 22:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707516998;
	bh=u27ysSO49hF4SYPfEeRGZ1NoCOVbBXK8slETCK3CYUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2l966Jw7LqLUa7lGzWxyNFHrachqqwLh470CzhPua2TSEVGVOCpOdpyGMJmSsgQqe
	 5bfzHdQ3CwpUHouXA+Qgp+r6Q34jaDtZQAnjZCM1Tv3gmWv88LXdm9a3Zp5blhEzae
	 n2lOvvpRsfJjnwNQQ0u+pBSQB2gtpO6dd8Xezohc=
Date: Fri, 9 Feb 2024 14:16:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: Ensure adequate CMA areas available for
 hugetlb_cma[]
Message-Id: <20240209141637.129e417747ef130255db620d@linux-foundation.org>
In-Reply-To: <20240209065036.1412670-1-anshuman.khandual@arm.com>
References: <20240209065036.1412670-1-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 12:20:36 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> HugeTLB CMA area array is being created for possible MAX_NUMNODES without
> ensuring corresponding MAX_CMA_AREAS support in CMA. Let's just warn for
> such scenarios indicating need for CONFIG_CMA_AREAS adjustment.
> 
> ...
>
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7750,6 +7750,13 @@ void __init hugetlb_cma_reserve(int order)
>  	}
>  
>  	reserved = 0;
> +
> +	/*
> +	 * There needs to be enough MAX_CMA_AREAS to accommodate
> +	 * MAX_NUMNODES heap areas being created here. Otherwise
> +	 * adjust CONFIG_CMA_AREAS as required.
> +	 */
> +	VM_WARN_ON(MAX_CMA_AREAS < MAX_NUMNODES);

Could this simply be fixed up in Kconfig logic?

And I think this could be detected at compile-time?  BUILD_BUG_ON()?

>  	for_each_online_node(nid) {
>  		int res;
>  		char name[CMA_MAX_NAME];
> -- 
> 2.25.1

