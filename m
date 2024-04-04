Return-Path: <linux-kernel+bounces-132088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96B898F80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470571F214AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A8A134434;
	Thu,  4 Apr 2024 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KrPXV2nU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CD7134733
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261856; cv=none; b=PDB9vAi69h/H1gfDnn9gXNAZdVz01f/4M0GbaHEe4c9Ae0l1LtxCrkC2WqztLKcL+SzQWa26nJMszLD/s1lbGm1cnpzVK0J6j4wPGbv0/RVKhgFWc2gSNAZY/GcMTTVDvVRNIHuJ24CJJwIqzuxhi5Q3CxOh7LMYuPqlcnheolk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261856; c=relaxed/simple;
	bh=uykSneamCfF91Z/ip8svHyKAw+MkquNPh7Vi9yNGe64=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=or3lV45k5tjn4Tf/9mLDkFfJalXsRIceAzykeNumFOi3EYqhY5flvUbjRWN9Zg1ZSHEuAXNtJ7B5mtDkYTHtEf+81NBBm7wBjG74wZgQ1gBAZ3xTyET2AKfDnK77tdyD68LlCqiCuzjUFNYcXXWOUDjeUHcslXSCapyxmGzbpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KrPXV2nU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4357AC433F1;
	Thu,  4 Apr 2024 20:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712261855;
	bh=uykSneamCfF91Z/ip8svHyKAw+MkquNPh7Vi9yNGe64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KrPXV2nUuxnINYnVsDC2scz8wmTQL9G6CTPHM3m4EQ7Ut6kdqjU80M3ndXjnpHer/
	 no17YZbPA6u2uvY/cct0dtcjule66QChVpLLA30Dc0BTmdyYy6kZWF2+STTMWwOJkr
	 CV913q0bfcZ6OHJYi1Dnv6JwvBNxDS2mdpEUIwNE=
Date: Thu, 4 Apr 2024 13:17:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, linux-kernel@vger.kernel.org,
 Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to
 cma_declare_contiguous_nid
Message-Id: <20240404131734.5fdd7380202cafcdc44a4d2a@linux-foundation.org>
In-Reply-To: <20240404162515.527802-2-fvdl@google.com>
References: <20240404162515.527802-1-fvdl@google.com>
	<20240404162515.527802-2-fvdl@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Apr 2024 16:25:15 +0000 Frank van der Linden <fvdl@google.com> wrote:

> The hugetlb_cma code passes 0 in the order_per_bit argument to
> cma_declare_contiguous_nid (the alignment, computed using the
> page order, is correctly passed in).
> 
> This causes a bit in the cma allocation bitmap to always represent
> a 4k page, making the bitmaps potentially very large, and slower.
> 
> So, correctly pass in the order instead.

Ditto.  Should we backport this?   Can we somewhat quantify "potentially very",
and understand under what circumstances this might occur?

