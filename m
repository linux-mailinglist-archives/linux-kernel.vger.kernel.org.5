Return-Path: <linux-kernel+bounces-101700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E967C87AAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF6E1C2176C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B31C47F54;
	Wed, 13 Mar 2024 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IE1pXpb7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596F45028
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345106; cv=none; b=qj1Y6f/AGhbewzWvVooG3TdEU74iPvZjkzEIi+DujHJOPCAyZDeB6zA5OGvJXfXonX+yYmlpcEa0QyI6gk0P7yzrAdYfTxuA9EC6ShwT62K46/2AbIOAThu9Rol6LhJdUSEq+wGPJ3byNnO4v2lUS/1J2Cq8U4ldZltkfwpgQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345106; c=relaxed/simple;
	bh=mI7fSNRhjdc1x/5jXUqFrblmXVZD1jsPOX+je1rOPJs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W2aPRrDqyNztlOA3r6YbHqvIHN6aEzAIuEOPzUGUVi80rmp0+3cdMu1z+pZ2m3GaqyseKxZHxUoAqz+4NVDrt8L1+daNyfUw40iPUyfKNqErpGwUnzOroHHwtkCpNNxwNpqWUzldO0gB5Lo8289U/q+t8qMqw84KP0jWaikcmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IE1pXpb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14731C433C7;
	Wed, 13 Mar 2024 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1710345105;
	bh=mI7fSNRhjdc1x/5jXUqFrblmXVZD1jsPOX+je1rOPJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IE1pXpb7tEtDPJb1XPIB8Qu0S2GzmepwH2QCl5imqd4uVrjQ6FOIaKUEilPkEvxvf
	 8xkpZBwuPD2joCO0YlGF61cyqD55UJYIV8W9ya1CD5oXdVR7zS/ZCbPF3+6GNnNTGc
	 pey9QOPoFuxqaAqcT4v1qyyDZDa+7k3k4RllX9m0=
Date: Wed, 13 Mar 2024 08:51:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Donet Tom <donettom@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Aneesh Kumar <aneesh.kumar@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Feng Tang
 <feng.tang@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Rik van
 Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>, Matthew
 Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Dan
 Williams <dan.j.williams@intel.com>, Hugh Dickins <hughd@google.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Suren Baghdasaryan
 <surenb@google.com>
Subject: Re: [PATCH v2 2/2] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
Message-Id: <20240313085144.13b37a79c688b6126af0bd07@linux-foundation.org>
In-Reply-To: <874jdd5z1b.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <cover.1709909210.git.donettom@linux.ibm.com>
	<369d6a58758396335fd1176d97bbca4e7730d75a.1709909210.git.donettom@linux.ibm.com>
	<874jdd5z1b.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 09:37:36 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

> > @@ -2515,15 +2516,26 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
> >  		break;
> >  
> >  	case MPOL_BIND:
> > -		/* Optimize placement among multiple nodes via NUMA balancing */
> > +	case MPOL_PREFERRED_MANY:
> > +		/*
> > +		 * Even though MPOL_PREFERRED_MANY can allocate pages outside
> > +		 * policy nodemask we don't allow numa migration to nodes
> > +		 * outside policy nodemask for now. This is done so that if we
> > +		 * want demotion to slow memory to happen, before allocating
> > +		 * from some DRAM node say 'x', we will end up using a
> > +		 * MPOL_PREFERRED_MANY mask excluding node 'x'. In such scenario
> > +		 * we should not promote to node 'x' from slow memory node.
> > +		 */
> 
> This is a little hard to digest for me.  And, I don't think that we need
> to put this policy choice in code comments.  It's better to put it in
> patch description.  Where we can give more background, for example, to
> avoid cross-socket traffic, etc.

Oh.  I like the comment.  We could perhaps put additional detail in the
changelog, but using changelogs to understand the code is so darned
inconvenient.

