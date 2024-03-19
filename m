Return-Path: <linux-kernel+bounces-108232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0580F880825
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E561C20A29
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32905FDA8;
	Tue, 19 Mar 2024 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fVe21I7/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D395FDA1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710890672; cv=none; b=s6IUhzPBqdavJJk5YQlt2K4qt7qnTJNEp/x9cb2DfpI2JDqxj7nDZrJYVGO/3Rr6VlVFIAdzE+dkL8aCwFfYaFEdAzcxNjsssN+hLB10Rvn8s0deiUFGFVOXPIr4/zwV4bTNCmYJ6gmofb565dzdmmmhHzjaqhoYSww5E1qUzEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710890672; c=relaxed/simple;
	bh=W0aPdR/diOGHsmOKFCEcwEf5899ewqDXOmarYwURMdE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FDphNEbBDhhMG7VogoYU/+855uKyNHpbFK2I5MOh9cirOwqFB+KH7zqhHEBbjVmUPEIufjBaW8ZV8wQiqQwyCLbglsEoz7YKheh4BM7HIV2lMJDyjGIbkJYYxC/rnHK/yYKgRq36JX6y8QYaj++3pjaCPcjLgDqHE1EuSz4F0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fVe21I7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFA5C433F1;
	Tue, 19 Mar 2024 23:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1710890671;
	bh=W0aPdR/diOGHsmOKFCEcwEf5899ewqDXOmarYwURMdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fVe21I7/rxcH7jmAQgQcOZN9JifKbY3RhgUPXm/lz/KA/zjy+uEAh3fju4mUOrgcS
	 y4jA5pJT/g1cyjQMBVE81tcMGRsihZGT63XwsSYaAI7CTgrDm2Jxjh+zDDH1vOcOQm
	 IP4d9VWN63ZvSxUUaiEtOxla4t+XzDi6Q46MsiI4=
Date: Tue, 19 Mar 2024 16:24:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Michal Hocko
 <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Marco Elver
 <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Alexander
 Potapenko <glider@google.com>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>,
 syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] mm,page_owner: Fix refcount imbalance
Message-Id: <20240319162430.3e76504d06f12edc107029a4@linux-foundation.org>
In-Reply-To: <20240319183212.17156-2-osalvador@suse.de>
References: <20240319183212.17156-1-osalvador@suse.de>
	<20240319183212.17156-2-osalvador@suse.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 19:32:11 +0100 Oscar Salvador <osalvador@suse.de> wrote:

> Current code does not contemplate scenarios were an allocation and
> free operation on the same pages do not handle it in the same amount
> at once.
> To give an example, page_alloc_exact(), where we will allocate a page
> of enough order to stafisfy the size request, but we will free the
> remainings right away.
> 
> In the above example, we will increment the stack_record refcount
> only once, but we will decrease it the same number of times as number
> of unused pages we have to free.
> This will lead to a warning because of refcount imbalance.
> 
> Fix this by recording the number of base pages in the refcount field.
> 
> ...
>
> -static void dec_stack_record_count(depot_stack_handle_t handle)
> +static void dec_stack_record_count(depot_stack_handle_t handle,
> +				   int nr_base_pages)
>  {
>  	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
>  
>  	if (stack_record)
> -		refcount_dec(&stack_record->count);
> +		refcount_sub_and_test(nr_base_pages, &stack_record->count);
>  }

mm/page_owner.c: In function 'dec_stack_record_count':
mm/page_owner.c:226:17: error: ignoring return value of 'refcount_sub_and_test' declared with attribute 'warn_unused_result' [-Werror=unused-result]
  226 |                 refcount_sub_and_test(nr_base_pages, &stack_record->count);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


