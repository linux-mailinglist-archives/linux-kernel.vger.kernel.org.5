Return-Path: <linux-kernel+bounces-107685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA788002F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805E0B20C96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A66651AB;
	Tue, 19 Mar 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6gwKuW9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481AF1E861
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860563; cv=none; b=dzt2zOzuH+IfZwr4EQHTQjN2XwO/6AurJO88Kss/b7Kwd3yyIUAOku6x8GTcAkarh1ocUXFY8dvtqUirYtMmFqGa7afNAtjNm5pEhdtO5BjZcINkoK6xNxJUGxTt/BlddMQB22j8e6iR9Ik79w6OAIdldC9De/9Uo0ridJR6IaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860563; c=relaxed/simple;
	bh=MYu5vnyyk8UpGW+9H8Fp2Ao2jTIqftepbqNMgiMx9X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg6RMsVxZPK7GSV5Tvqu4kwp+v05OzDPY47iWc2eKst3tTJ7pr2n+d0q78NC8wUA2cJhSrAgHhpNxjd+Qc7pPJocZLvn6JC9a/DPuw9YTP981Jp5QOD3Q5ihSfwqb81sfEvpz8C7+6e8AAgKr/3leGHfTEBuxTEbzzbvdcyM4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6gwKuW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE679C433F1;
	Tue, 19 Mar 2024 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710860562;
	bh=MYu5vnyyk8UpGW+9H8Fp2Ao2jTIqftepbqNMgiMx9X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6gwKuW9oAhpz28awT7tOzD1n+MdimdEW3hnK6HX/Pwk1+XgTg4Xlyt9eLHil2iBD
	 4c4GMOc9uCmKBJoVBbGAhl8tT3jNjpIReAZlqCW9mG/769Wu+AEYJITs9WCHQIjOtT
	 NZzoEU1DRVtvYrtNNr+5zYPqiJjBUDq3U6BIn7d4Rav3nAQPORh8Qn/UtRPV41GL3k
	 a/2CeQUuh2MwDRLdcwiwcSubSLxBy8kYjD764Me4P3zvEp9Jw1BD0jbGAczXb/Kb8D
	 Lyo/1fw1T+p1rkXOpELP2sfKsH3uV35OFK8QmMgV1YVLCsCwDzb+xFE9iOIjgi0wUu
	 sVa+dmWkkF/wQ==
Date: Tue, 19 Mar 2024 17:01:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] mm/mm_init.c: eliminate a local variable in
 mem_debugging_and_hardening_init()
Message-ID: <Zfmo0jPNsU6TdsNt@kernel.org>
References: <20240318135715.312-1-thunder.leizhen@huaweicloud.com>
 <Zfhs5LD-1RQt3aw4@kernel.org>
 <5fd9144b-fb1c-08fc-8124-1972f86253a4@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd9144b-fb1c-08fc-8124-1972f86253a4@huaweicloud.com>

On Tue, Mar 19, 2024 at 09:22:03AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2024/3/19 0:33, Mike Rapoport wrote:
> > On Mon, Mar 18, 2024 at 09:57:14PM +0800, thunder.leizhen@huaweicloud.com wrote:
> >> From: Zhen Lei <thunder.leizhen@huawei.com>
> >>
> >> The local variable 'page_poisoning_requested' is assigned true at only
> >> one point. It can be eliminated by moving the code that depends on it
> >> to the location where it is assigned true. This also make the moved
> >> code to be compiled only if CONFIG_PAGE_POISONING is set.
> > 
> > I don't see it as much of an improvement and code readability becomes worse
> > IMO.
> 
> Yes, the moved branch will be optimized by the compiler if CONFIG_PAGE_POISONING is
> not set. But for a reader, he can simply skip over that moved branch when
> CONFIG_PAGE_POISONING is not set.

Saving one branch at init does not justify the churn and reduced
readability. 
  
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  mm/mm_init.c | 17 +++++++----------
> >>  1 file changed, 7 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/mm/mm_init.c b/mm/mm_init.c
> >> index 549e76af8f82a8e..3eb217130bcb2b5 100644
> >> --- a/mm/mm_init.c
> >> +++ b/mm/mm_init.c
> >> @@ -2614,7 +2614,6 @@ DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
> >>   */
> >>  static void __init mem_debugging_and_hardening_init(void)
> >>  {
> >> -	bool page_poisoning_requested = false;
> >>  	bool want_check_pages = false;
> >>  
> >>  #ifdef CONFIG_PAGE_POISONING
> >> @@ -2626,18 +2625,16 @@ static void __init mem_debugging_and_hardening_init(void)
> >>  	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
> >>  	      debug_pagealloc_enabled())) {
> >>  		static_branch_enable(&_page_poisoning_enabled);
> >> -		page_poisoning_requested = true;
> >>  		want_check_pages = true;
> >> -	}
> >> -#endif
> >>  
> >> -	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
> >> -	    page_poisoning_requested) {
> >> -		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> >> -			"will take precedence over init_on_alloc and init_on_free\n");
> >> -		_init_on_alloc_enabled_early = false;
> >> -		_init_on_free_enabled_early = false;
> >> +		if (_init_on_alloc_enabled_early || _init_on_free_enabled_early) {
> >> +			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
> >> +				"will take precedence over init_on_alloc and init_on_free\n");
> >> +			_init_on_alloc_enabled_early = false;
> >> +			_init_on_free_enabled_early = false;
> >> +		}
> >>  	}
> >> +#endif
> >>  
> >>  	if (_init_on_alloc_enabled_early) {
> >>  		want_check_pages = true;
> >> -- 
> >> 2.34.1
> >>
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

-- 
Sincerely yours,
Mike.

