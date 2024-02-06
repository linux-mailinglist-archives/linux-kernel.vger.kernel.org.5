Return-Path: <linux-kernel+bounces-55593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AF384BEA0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5F31F29A05
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0121C1B279;
	Tue,  6 Feb 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WqRutX0z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405D1AACF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251026; cv=none; b=dG8+nX6oz/1VI3tkvlLH/DH3fCou8tSCca3/aQM/obCk8SxcZELuj7JGfB5cquB3Q3QmV3pr9mAz3xf2JaUxtqbEKUzbSauby2MYv8riIFysqbzN3+77l8qPkGBbNdlr4tWEC1Cxes1ajctteziVYhZfoHVIS/NtLtzSLe9Lwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251026; c=relaxed/simple;
	bh=R3Gvp712DLBLHZrUWRKpfJXFpWCymIU4evTbHKyLl8w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p2NYMwApCiAL8u2m8ZlW28aNrXwN8pOttjvGRZkxo80W4yV0c97k2mWwBc56Zc6a1OS/xjsmi2meJKXC4JLcC7lcOsEklTopDgdarRfQmVRI9jDHNqDQz7PB4T4HuEh6tcQbqbjzrqfuovq8JleN5gA2xsba4T+jRvjbdcHlPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WqRutX0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F09C433C7;
	Tue,  6 Feb 2024 20:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707251025;
	bh=R3Gvp712DLBLHZrUWRKpfJXFpWCymIU4evTbHKyLl8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WqRutX0z7G4glv+gctBfnfBw81mKOeIYgGNtrpvvn1O8Np/rV9zimnIH30YuEmrZJ
	 RCozwJf130thBphzjwKFkJaCetuHAZhyUCmyN7dA9ma9CA5iV0y+dodnJ+6Sdayvuy
	 MVIabme+wrBOkzqAVNPqTO0pRZxK6DzEB3/jtNOk=
Date: Tue, 6 Feb 2024 12:23:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Huang, Ying"
 <ying.huang@intel.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2] mm/demotion: print demotion targets
Message-Id: <20240206122344.4cd39c6ebb37871912c459fe@linux-foundation.org>
In-Reply-To: <20240206020151.605516-1-lizhijian@fujitsu.com>
References: <20240206020151.605516-1-lizhijian@fujitsu.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Feb 2024 10:01:51 +0800 Li Zhijian <lizhijian@fujitsu.com> wrote:

> Currently, when a demotion occurs, it will prioritize selecting a node
> from the preferred targets as the destination node for the demotion. If
> the preferred node does not meet the requirements, it will try from all
> the lower memory tier nodes until it finds a suitable demotion destination
> node or ultimately fails.
> 
> However, the demotion target information isn't exposed to the users,
> especially the preferred target information, which relies on more factors.
> This makes users hard to understand the exact demotion behavior.
> 
> Rather than having a new sys interface to expose this information,
> printing directly to kernel messages, just like the current page
> allocation fallback order does.
>
> ...
>
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -359,6 +359,26 @@ static void disable_all_demotion_targets(void)
>  	synchronize_rcu();
>  }
>  
> +static void dump_demotion_targets(void)

Unrelated, but...  establish_demotion_targets() should be __meminit, so
dump_demotion_targets() could also be __meminit.



