Return-Path: <linux-kernel+bounces-143309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148328A370C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C66284EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3581509AE;
	Fri, 12 Apr 2024 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXVtgXju"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC93D548
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953635; cv=none; b=o9EZilnR4fZct0RUy2K72l5NdkiO83n/DWg3THkROGai7/ZIeZryBX6/A2v/bMjQCE5Piu+twsSBx2+y3r1KDbw82K2iD1SdGk6QOo+4vzhHUdZyJckJRhtNCetYzoFsTcejkQePRL83RpWfkXwXZcNI5bRlCVCzlRwUWFB4qNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953635; c=relaxed/simple;
	bh=llio3CfIvuC0B+cljYFR8utRFQk/nLSyb8ElqunR1x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe7h5Fu5Vj0CsP8bMwjJDDrn35aOWqN8DgjokLMjvVzOdfJmBpkWkzKx83V1xXVpK2Gky48wrSmvIsYsVsIMc3Y9u5W6lUQoIpct6rxk8Hf78YqaxYsfzc7kU2jnTwuVSm7jH556QvrRpKVaTjE9KQbGEBMxpPAwnbI2n16OXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXVtgXju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8963FC113CC;
	Fri, 12 Apr 2024 20:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712953635;
	bh=llio3CfIvuC0B+cljYFR8utRFQk/nLSyb8ElqunR1x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXVtgXjuWg4Wx4RLGmAnpjoF0nw80GId6mczjyzsG4pq7L7YEUMYcx9Oj57mqLNpV
	 w+MNqS/1hr0fUJSAkzxl9q4qdgmDWzJzBs2CD3MvZxF6aGuJki2534JHLPmjw5CQs4
	 kBDlu/nj+5rY5xEAUX8nUGt1BraBTyFGEvawvqfB47WwIYI7mjqe2U4TkeUpu420vB
	 Ekoe7T2YzU6ddIt+pghWTN6DOcEIodSqmhn5pdC0nOV3kiUcj2vTXxQZwscb9h/zcp
	 0DHPL9O3CoKBFHhqm8OpXbJpBHAhPk7/MWanfwuxX1APhq4ighE8A7lp8VtQNc8zRl
	 2dnCV1i3nuzzw==
Date: Fri, 12 Apr 2024 13:27:13 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] scripts/faddr2line: Check only two symbols when
 calculating symbol size
Message-ID: <20240412202713.ntmhxrpjovbhafu2@treble>
References: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
 <20240311204019.1183634-8-bjohannesmeyer@gmail.com>
 <CAOZ5it1NaWyUM4GTJ+XrMet7aQXT27q1VZ4FeD8osbTccVpj9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOZ5it1NaWyUM4GTJ+XrMet7aQXT27q1VZ4FeD8osbTccVpj9w@mail.gmail.com>

On Thu, Apr 11, 2024 at 12:28:29PM -0700, Brian Johannesmeyer wrote:
> Hey Josh,
> 
> I just noticed that this patch does not correctly handle duplicate
> sym_names. To fix, the "--no-group-separator" option should be added
> as follows:
> 
> > -               done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
> > +               done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2 | ${GREP} -A1 --no-group-separator " ${sym_name}$")
> 
> Would you like me to re-submit the patch series with this fix?

Yes, that would be helpful.  Thanks!

-- 
Josh

