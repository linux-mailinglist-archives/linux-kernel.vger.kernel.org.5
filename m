Return-Path: <linux-kernel+bounces-119911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA7A88CEE6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CA22C60B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539DF13E03B;
	Tue, 26 Mar 2024 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NpetpB26"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274113D240
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484847; cv=none; b=ZEXX9hYmV1g+ZUjLTxnT7iOG/U0OVJhJyy6fSB6KpePi25qJKeHGazAqR4lPRIz1rhQQaoateFbfhj8vdsuCKddm9CoUePtuDByUTk3hfCmSaxhwfln+8BCoSUc9RvRzULmAWN8iaxVdHAGYihkd5KIB/Hf1igH4E2Y+PMnCbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484847; c=relaxed/simple;
	bh=RMc55HDt1Iu9wEhlfvQPgk2yHzSGgjRT7fuSwVCTZQ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eUYml4XdazKjju/Pab9YLSJGYvujW0gJVTnYBO65ZnR29PVJsn15dO8f560/m512d/LMGWnA9Qmoef8MRB16+Xk3ammTjAxCpdTwniZQFLwE6kJ70R+iFOsUK3lKA6goXyOhIKDM8ru6uk9c5pfA9dDxPNUtCh4ihq0MdAIi8WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NpetpB26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F54C433C7;
	Tue, 26 Mar 2024 20:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711484847;
	bh=RMc55HDt1Iu9wEhlfvQPgk2yHzSGgjRT7fuSwVCTZQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NpetpB26CHhvYKzvBW/oKi5wtOnub6rL5aP+YF9Y6dCvsmN12zKb5dHIZ5CfCYKcn
	 mhpXZyqvSxsBryWoD/L3dVJ01wZpPDe2ffb+0OvtOWbu8EvYvgn6fD5h7/2417uMPL
	 RI0ydEygACM/q2kOjDEnIbOri4aJ/Y/b5mxPbfOs=
Date: Tue, 26 Mar 2024 13:27:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: peterx@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, SeongJae Park
 <sj@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport
 <rppt@kernel.org>, Matthew Wilcox <willy@infradead.org>, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH] mm/arch: Provide pud_pfn() fallback
Message-Id: <20240326132726.67e82559a928ac1636c8050c@linux-foundation.org>
In-Reply-To: <20240323151643.1047281-1-peterx@redhat.com>
References: <20240323151643.1047281-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Mar 2024 11:16:43 -0400 peterx@redhat.com wrote:

> From: Peter Xu <peterx@redhat.com>
> 
> The comment in the code explains the reasons.  We took a different approach
> comparing to pmd_pfn() by providing a fallback function.
> 
> Another option is to provide some lower level config options (compare to
> HUGETLB_PAGE or THP) to identify which layer an arch can support for such
> huge mappings.  However that can be an overkill.
> 
> ...
>
> If we care about per-commit build errors (and if it is ever feasible to
> reorder), we can move this patch to be before the patch "mm/gup: handle
> huge pud for follow_pud_mask()" in mm-unstable to unbreak build on that
> commit.

I temporarily disabled that whole series a few days ago.  Because of
multiple build issues, iirc.

Let's make that permanent.  Please redo the whole series against
mm-unstable and resend?


